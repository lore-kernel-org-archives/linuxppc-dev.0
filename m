Return-Path: <sam@mendozajonas.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdrc50z3YzDqFD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 13:18:29 +1000 (AEST)
Received: from mendozajonas.com (mendozajonas.com [188.166.185.233])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rdrc46BD4z9sDb
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jun 2016 13:18:28 +1000 (AEST)
From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
To: linuxppc-dev@ozlabs.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Alistair Popple <alistair@popple.id.au>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 "# 4 . 1 . x-" <stable@vger.kernel.org>
Subject: [PATCH 2/2] tty/hvc: Use opal irqchip interface if available
Date: Tue, 28 Jun 2016 13:11:39 +1000
Message-Id: <20160628031139.12500-2-sam@mendozajonas.com>
In-Reply-To: <20160628031139.12500-1-sam@mendozajonas.com>
References: <20160628031139.12500-1-sam@mendozajonas.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the hvc driver to use the OPAL irqchip if made available by the
running firmware. If it is not present, the driver falls back to the
existing OPAL event number.

Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Cc: <stable@vger.kernel.org> # 4.1.x-
---
 drivers/tty/hvc/hvc_opal.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index b7cd0ae..8c53f5b 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -170,6 +170,8 @@ static int hvc_opal_probe(struct platform_device *dev)
 	hv_protocol_t proto;
 	unsigned int termno, irq, boot = 0;
 	const __be32 *reg;
+	u32 prop;
+	int rc;
 
 	if (of_device_is_compatible(dev->dev.of_node, "ibm,opal-console-raw")) {
 		proto = HV_PROTOCOL_RAW;
@@ -214,7 +216,15 @@ static int hvc_opal_probe(struct platform_device *dev)
 		dev->dev.of_node->full_name,
 		boot ? " (boot console)" : "");
 
-	irq = opal_event_request(ilog2(OPAL_EVENT_CONSOLE_INPUT));
+	rc = of_property_read_u32(dev->dev.of_node, "interrupts", &prop);
+	if (rc) {
+		pr_info("hvc%d: No interrupts property, using OPAL event\n",
+				termno);
+		irq = opal_event_request(ilog2(OPAL_EVENT_CONSOLE_INPUT));
+	} else {
+		irq = irq_of_parse_and_map(dev->dev.of_node, 0);
+	}
+
 	if (!irq) {
 		pr_err("hvc_opal: Unable to map interrupt for device %s\n",
 			dev->dev.of_node->full_name);
-- 
2.9.0
