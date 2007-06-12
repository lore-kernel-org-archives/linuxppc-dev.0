Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.67.118]) by ozlabs.org (Postfix) with ESMTP id BAF19DDE1C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jun 2007 09:26:45 +1000 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: Peter Korsgaard <jacmet@sunsite.dk>, linux-usb-devel@lists.sourceforge.net,
	linuxppc-embedded@ozlabs.org
Subject: [PATCH 6/6] [C67x00] Merge c67x00-hub.c into c67x00-hcd.c
Date: Tue, 12 Jun 2007 17:02:21 -0600
Message-Id: <11816893511659-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11816893503814-git-send-email-grant.likely@secretlab.ca>
References: <11816893411272-git-send-email-grant.likely@secretlab.ca>
	<11816893494143-git-send-email-grant.likely@secretlab.ca>
	<11816893492706-git-send-email-grant.likely@secretlab.ca>
	<11816893493783-git-send-email-grant.likely@secretlab.ca>
	<1181689350166-git-send-email-grant.likely@secretlab.ca>
	<11816893503814-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Rather than c67x00-hub.c being compiled seperately, the original code had
c67x00-hub.c *included* by c67x00-hcd.c.  This is a very bad idea.
Simplest solution is to merge the two files into one and be done with it.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/usb/c67x00/c67x00-hcd.c |  183 ++++++++++++++++++++++++++++++++++-
 drivers/usb/c67x00/c67x00-hub.c |  206 ---------------------------------------
 2 files changed, 182 insertions(+), 207 deletions(-)

diff --git a/drivers/usb/c67x00/c67x00-hcd.c b/drivers/usb/c67x00/c67x00-hcd.c
index d5458ea..4e6810d 100644
--- a/drivers/usb/c67x00/c67x00-hcd.c
+++ b/drivers/usb/c67x00/c67x00-hcd.c
@@ -89,8 +89,189 @@ static int c67x00_get_frame(struct usb_hcd *hcd)
 }
 
 /* -------------------------------------------------------------------------- */
+/* Root Hub Support */
 
-#include "c67x00-hub.c"
+static __u8 root_hub_hub_des[] = {
+	0x09,			/*  __u8  bLength; */
+	0x29,			/*  __u8  bDescriptorType; Hub-descriptor */
+	0x02,			/*  __u8  bNbrPorts; */
+	0x00,			/* __u16  wHubCharacteristics; */
+	0x00,			/*   (per-port OC, no power switching) */
+	0x32,			/*  __u8  bPwrOn2pwrGood; 2ms */
+	0x00,			/*  __u8  bHubContrCurrent; 0 mA */
+	0x00,			/*  __u8  DeviceRemovable; ** 7 Ports max ** */
+	0xff,			/*  __u8  PortPwrCtrlMask; ** 7 ports max ** */
+};
+
+#define OK(x)			len = (x); break
+
+/* -------------------------------------------------------------------------- */
+
+static void c67x00_hub_reset_host_port(struct c67x00_sie *sie, int port)
+{
+	struct c67x00_hcd *c67x00 = sie->private_data;
+	unsigned long flags;
+
+	c67x00_ll_husb_reset(sie, port);
+
+	spin_lock_irqsave(&c67x00->lock, flags);
+	c67x00_ll_husb_reset_port(sie, port);
+	spin_unlock_irqrestore(&c67x00->lock, flags);
+
+	c67x00_ll_set_husb_eot(sie->dev, DEFAULT_EOT);
+}
+
+/* -------------------------------------------------------------------------- */
+
+static int c67x00_hub_status_data(struct usb_hcd *hcd, char *buf)
+{
+	struct c67x00_hcd *c67x00 = hcd_to_c67x00_hcd(hcd);
+	struct c67x00_sie *sie = c67x00->sie;
+	u16 status;
+	int i;
+
+	*buf = 0;
+	status = c67x00_ll_husb_get_status(sie);
+	for (i=0; i<C67X00_PORTS; i++)
+		if (status & PORT_CONNECT_CHANGE(i))
+			*buf |= (1 << i);
+
+	/* bit 0 denotes hub change, b1..n port change */
+	*buf <<= 1;
+
+	return !!*buf;
+}
+
+static int c67x00_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
+			      u16 wIndex, char *buf, u16 wLength)
+{
+	struct c67x00_hcd *c67x00 = hcd_to_c67x00_hcd(hcd);
+	struct c67x00_sie *sie = c67x00->sie;
+	u16 status, usb_status;
+	int retval = 0, len = 0;
+	unsigned int port = wIndex-1;
+	u16 wPortChange, wPortStatus;
+
+	switch (typeReq) {
+
+	case GetHubStatus:
+		*(__le32 *) buf = cpu_to_le32(0);
+		OK(4);		/* hub power */
+	case GetPortStatus:
+		if (wIndex > C67X00_PORTS)
+			goto err;
+
+		status = c67x00_ll_husb_get_status(sie);
+		usb_status = c67x00_ll_get_usb_ctl(sie);
+
+		wPortChange = 0;
+		if (status & PORT_CONNECT_CHANGE(port))
+			wPortChange |= USB_PORT_STAT_C_CONNECTION;
+
+		wPortStatus = USB_PORT_STAT_POWER;
+		if (!(status & PORT_SE0_STATUS(port)))
+			wPortStatus |= USB_PORT_STAT_CONNECTION;
+		if (usb_status & LOW_SPEED_PORT(port)) {
+			wPortStatus |= USB_PORT_STAT_LOW_SPEED;
+			c67x00->low_speed_ports |= (1 << port);
+		} else
+			c67x00->low_speed_ports &= ~(1 << port);
+
+		if (usb_status & SOF_EOP_EN(port))
+			wPortStatus |= USB_PORT_STAT_ENABLE;
+
+		*(__le16 *) buf = cpu_to_le16(wPortStatus);
+		*(__le16 *) (buf + 2) = cpu_to_le16(wPortChange);
+		OK(4);
+	case SetHubFeature:	/* We don't implement these */
+	case ClearHubFeature:
+		switch (wValue) {
+		case C_HUB_OVER_CURRENT:
+		case C_HUB_LOCAL_POWER:
+			OK(0);
+		default:
+			goto err;
+		}
+		break;
+	case SetPortFeature:
+		if (wIndex > C67X00_PORTS)
+			goto err;
+
+		switch (wValue) {
+		case USB_PORT_FEAT_SUSPEND:
+			dev_dbg(c67x00_dev(c67x00),
+				"SetPortFeature %d (SUSPEND)\n", port);
+			OK(0);
+		case USB_PORT_FEAT_RESET:
+			c67x00_hub_reset_host_port(sie, port);
+			OK(0);
+		case USB_PORT_FEAT_POWER:
+			/* Power always enabled */
+			OK(0);
+		default:
+			dev_dbg(c67x00_dev(c67x00),
+				"%s: SetPortFeature %d (0x%04x) Error!\n",
+				__FUNCTION__, port, wValue);
+			goto err;
+		}
+		break;
+	case ClearPortFeature:
+		if (wIndex > C67X00_PORTS)
+			goto err;
+
+		switch (wValue) {
+		case USB_PORT_FEAT_ENABLE:
+			/* Reset the port so that the c67x00 also notices the
+			 * disconnect */
+			c67x00_hub_reset_host_port(sie, port);
+			OK(0);
+		case USB_PORT_FEAT_C_ENABLE:
+			dev_dbg(c67x00_dev(c67x00),
+				"ClearPortFeature (%d): C_ENABLE\n", port);
+			OK(0);
+		case USB_PORT_FEAT_SUSPEND:
+			dev_dbg(c67x00_dev(c67x00),
+				"ClearPortFeature (%d): SUSPEND\n", port);
+			OK(0);
+		case USB_PORT_FEAT_C_SUSPEND:
+			dev_dbg(c67x00_dev(c67x00),
+				"ClearPortFeature (%d): C_SUSPEND\n", port);
+			OK(0);
+		case USB_PORT_FEAT_POWER:
+			dev_dbg(c67x00_dev(c67x00),
+				"ClearPortFeature (%d): POWER\n", port);
+			goto err;
+		case USB_PORT_FEAT_C_CONNECTION:
+			c67x00_ll_husb_clear_status(sie,
+						    PORT_CONNECT_CHANGE(port));
+			OK(0);
+		case USB_PORT_FEAT_C_OVER_CURRENT:
+			dev_dbg(c67x00_dev(c67x00),
+				"ClearPortFeature (%d): OVER_CURRENT\n", port);
+			OK(0);
+		case USB_PORT_FEAT_C_RESET:
+			dev_dbg(c67x00_dev(c67x00),
+				"ClearPortFeature (%d): C_RESET\n", port);
+			OK(0);
+		default:
+			dev_dbg(c67x00_dev(c67x00),
+				"%s: ClearPortFeature %d (0x%04x) Error!\n",
+				__FUNCTION__, port, wValue);
+			goto err;
+		}
+		break;
+	case GetHubDescriptor:
+		len = min_t(unsigned int, sizeof(root_hub_hub_des), wLength);
+		memcpy(buf, root_hub_hub_des, len);
+		OK(len);
+	default:
+		dev_dbg(c67x00_dev(c67x00), "%s: unknown\n", __FUNCTION__);
+	      err:
+		retval = -EPIPE;
+	}
+
+	return retval;
+}
 
 /* -------------------------------------------------------------------------- */
 
diff --git a/drivers/usb/c67x00/c67x00-hub.c b/drivers/usb/c67x00/c67x00-hub.c
deleted file mode 100644
index 2518106..0000000
--- a/drivers/usb/c67x00/c67x00-hub.c
+++ /dev/null
@@ -1,206 +0,0 @@
-/*
- * c67x00-hub.c: Cypress C67X00 USB Host Controller Driver - HUB functionality
- *
- * Copyright (C) 2006-2007 Barco N.V.
- *    Derived from the Cypress cy7c67200/300 ezusb linux driver and
- *    based on multiple host controller drivers inside the linux kernel.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA  02110-1301  USA.
- */
-
-/* Included in c67x00-hcd.c */
-
-static __u8 root_hub_hub_des[] = {
-	0x09,			/*  __u8  bLength; */
-	0x29,			/*  __u8  bDescriptorType; Hub-descriptor */
-	0x02,			/*  __u8  bNbrPorts; */
-	0x00,			/* __u16  wHubCharacteristics; */
-	0x00,			/*   (per-port OC, no power switching) */
-	0x32,			/*  __u8  bPwrOn2pwrGood; 2ms */
-	0x00,			/*  __u8  bHubContrCurrent; 0 mA */
-	0x00,			/*  __u8  DeviceRemovable; ** 7 Ports max ** */
-	0xff,			/*  __u8  PortPwrCtrlMask; ** 7 ports max ** */
-};
-
-#define OK(x)			len = (x); break
-
-/* -------------------------------------------------------------------------- */
-
-static void reset_host_port(struct c67x00_sie *sie, int port)
-{
-	struct c67x00_hcd *c67x00 = sie->private_data;
-	unsigned long flags;
-
-	c67x00_ll_husb_reset(sie, port);
-
-	spin_lock_irqsave(&c67x00->lock, flags);
-	c67x00_ll_husb_reset_port(sie, port);
-	spin_unlock_irqrestore(&c67x00->lock, flags);
-
-	c67x00_ll_set_husb_eot(sie->dev, DEFAULT_EOT);
-}
-
-/* -------------------------------------------------------------------------- */
-
-static int c67x00_hub_status_data(struct usb_hcd *hcd, char *buf)
-{
-	struct c67x00_hcd *c67x00 = hcd_to_c67x00_hcd(hcd);
-	struct c67x00_sie *sie = c67x00->sie;
-	u16 status;
-	int i;
-
-	*buf = 0;
-	status = c67x00_ll_husb_get_status(sie);
-	for (i=0; i<C67X00_PORTS; i++)
-		if (status & PORT_CONNECT_CHANGE(i))
-			*buf |= (1 << i);
-
-	/* bit 0 denotes hub change, b1..n port change */
-	*buf <<= 1;
-
-	return !!*buf;
-}
-
-static int c67x00_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
-			      u16 wIndex, char *buf, u16 wLength)
-{
-	struct c67x00_hcd *c67x00 = hcd_to_c67x00_hcd(hcd);
-	struct c67x00_sie *sie = c67x00->sie;
-	u16 status, usb_status;
-	int retval = 0, len = 0;
-	unsigned int port = wIndex-1;
-	u16 wPortChange, wPortStatus;
-
-	switch (typeReq) {
-
-	case GetHubStatus:
-		*(__le32 *) buf = cpu_to_le32(0);
-		OK(4);		/* hub power */
-	case GetPortStatus:
-		if (wIndex > C67X00_PORTS)
-			goto err;
-
-		status = c67x00_ll_husb_get_status(sie);
-		usb_status = c67x00_ll_get_usb_ctl(sie);
-
-		wPortChange = 0;
-		if (status & PORT_CONNECT_CHANGE(port))
-			wPortChange |= USB_PORT_STAT_C_CONNECTION;
-
-		wPortStatus = USB_PORT_STAT_POWER;
-		if (!(status & PORT_SE0_STATUS(port)))
-			wPortStatus |= USB_PORT_STAT_CONNECTION;
-		if (usb_status & LOW_SPEED_PORT(port)) {
-			wPortStatus |= USB_PORT_STAT_LOW_SPEED;
-			c67x00->low_speed_ports |= (1 << port);
-		} else
-			c67x00->low_speed_ports &= ~(1 << port);
-
-		if (usb_status & SOF_EOP_EN(port))
-			wPortStatus |= USB_PORT_STAT_ENABLE;
-
-		*(__le16 *) buf = cpu_to_le16(wPortStatus);
-		*(__le16 *) (buf + 2) = cpu_to_le16(wPortChange);
-		OK(4);
-	case SetHubFeature:	/* We don't implement these */
-	case ClearHubFeature:
-		switch (wValue) {
-		case C_HUB_OVER_CURRENT:
-		case C_HUB_LOCAL_POWER:
-			OK(0);
-		default:
-			goto err;
-		}
-		break;
-	case SetPortFeature:
-		if (wIndex > C67X00_PORTS)
-			goto err;
-
-		switch (wValue) {
-		case USB_PORT_FEAT_SUSPEND:
-			dev_dbg(c67x00_dev(c67x00),
-				"SetPortFeature %d (SUSPEND)\n", port);
-			OK(0);
-		case USB_PORT_FEAT_RESET:
-			reset_host_port(sie, port);
-			OK(0);
-		case USB_PORT_FEAT_POWER:
-			/* Power always enabled */
-			OK(0);
-		default:
-			dev_dbg(c67x00_dev(c67x00),
-				"%s: SetPortFeature %d (0x%04x) Error!\n",
-				__FUNCTION__, port, wValue);
-			goto err;
-		}
-		break;
-	case ClearPortFeature:
-		if (wIndex > C67X00_PORTS)
-			goto err;
-
-		switch (wValue) {
-		case USB_PORT_FEAT_ENABLE:
-			/* Reset the port so that the c67x00 also notices the
-			 * disconnect */
-			reset_host_port(sie, port);
-			OK(0);
-		case USB_PORT_FEAT_C_ENABLE:
-			dev_dbg(c67x00_dev(c67x00),
-				"ClearPortFeature (%d): C_ENABLE\n", port);
-			OK(0);
-		case USB_PORT_FEAT_SUSPEND:
-			dev_dbg(c67x00_dev(c67x00),
-				"ClearPortFeature (%d): SUSPEND\n", port);
-			OK(0);
-		case USB_PORT_FEAT_C_SUSPEND:
-			dev_dbg(c67x00_dev(c67x00),
-				"ClearPortFeature (%d): C_SUSPEND\n", port);
-			OK(0);
-		case USB_PORT_FEAT_POWER:
-			dev_dbg(c67x00_dev(c67x00),
-				"ClearPortFeature (%d): POWER\n", port);
-			goto err;
-		case USB_PORT_FEAT_C_CONNECTION:
-			c67x00_ll_husb_clear_status(sie,
-						    PORT_CONNECT_CHANGE(port));
-			OK(0);
-		case USB_PORT_FEAT_C_OVER_CURRENT:
-			dev_dbg(c67x00_dev(c67x00),
-				"ClearPortFeature (%d): OVER_CURRENT\n", port);
-			OK(0);
-		case USB_PORT_FEAT_C_RESET:
-			dev_dbg(c67x00_dev(c67x00),
-				"ClearPortFeature (%d): C_RESET\n", port);
-			OK(0);
-		default:
-			dev_dbg(c67x00_dev(c67x00),
-				"%s: ClearPortFeature %d (0x%04x) Error!\n",
-				__FUNCTION__, port, wValue);
-			goto err;
-		}
-		break;
-	case GetHubDescriptor:
-		len = min_t(unsigned int, sizeof(root_hub_hub_des), wLength);
-		memcpy(buf, root_hub_hub_des, len);
-		OK(len);
-	default:
-		dev_dbg(c67x00_dev(c67x00), "%s: unknown\n", __FUNCTION__);
-	      err:
-		retval = -EPIPE;
-	}
-
-	return retval;
-}
-- 
1.4.4.2
