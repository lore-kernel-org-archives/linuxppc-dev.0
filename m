Return-Path: <pratyush.anand@st.com>
Received: from eu1sys200aog117.obsmtp.com (eu1sys200aog117.obsmtp.com
	[207.126.144.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17849B6F7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Aug 2011 22:26:31 +1000 (EST)
From: Pratyush Anand <pratyush.anand@st.com>
To: <linux-usb@vger.kernel.org>
Subject: [PATCH 13/14] usb/gadget/kconfig: added dwc otg as an option for
	peripheral controller
Date: Tue, 30 Aug 2011 17:28:00 +0530
Message-ID: <0141f2f382fd7e96192c528126384a252d96ae1e.1314704558.git.pratyush.anand@st.com>
In-Reply-To: <cover.1314704557.git.pratyush.anand@st.com>
References: <cover.1314704557.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Pratyush Anand <pratyush.anand@st.com>, viresh.kumar@st.com,
	vipulkumar.samar@st.com, bhupesh.sharma@st.com, tmarri@apm.com,
	vipin.kumar@st.com, shiraz.hashim@st.com, Amit.VIRDI@st.com,
	rajeev-dlh.kumar@st.com, mmiesfeld@apm.com, deepak.sikri@st.com,
	linuxppc-dev@lists.ozlabs.org, fchen@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When dwc otg is configured as either dual or device only mode, then it can also
be used as a usb gadget. So added dwc otg as an option for peripheral
controller.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
---
 drivers/usb/gadget/Kconfig |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 09fa211..ca0d83a 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -169,6 +169,23 @@ config USB_DESIGNWARE
 	default USB_GADGET
 	select USB_GADGET_SELECTED
 
+config USB_GADGET_DESIGNWARE_OTG
+	boolean "Synopsys designware OTG Device Controller"
+	depends on DWC_OTG_MODE || DWC_DEVICE_ONLY
+	select USB_GADGET_DUALSPEED
+	help
+	  This driver supports the OTG device synopsys controller.
+	  Say "y" to link the driver statically, or "m" to build a
+	  dynamically linked module called "spear_udc" and force all
+	  gadget drivers to also be dynamically linked.
+
+config USB_DESIGNWARE_OTG
+	tristate
+	depends on USB_GADGET_DESIGNWARE_OTG
+	default USB_GADGET
+	select USB_GADGET_SELECTED
+
+
 config USB_GADGET_FSL_USB2
 	boolean "Freescale Highspeed USB DR Peripheral Controller"
 	depends on FSL_SOC || ARCH_MXC
-- 
1.7.2.2
