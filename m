Return-Path: <pratyush.anand@st.com>
Received: from eu1sys200aog114.obsmtp.com (eu1sys200aog114.obsmtp.com
	[207.126.144.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B70FFB6F8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Aug 2011 22:26:37 +1000 (EST)
From: Pratyush Anand <pratyush.anand@st.com>
To: <linux-usb@vger.kernel.org>
Subject: [PATCH 11/14] dwc/otg: Driver enable gadget support
Date: Tue, 30 Aug 2011 17:27:58 +0530
Message-ID: <d12fef0c09645ba1cd56dd011b5090cc8bde4b4b.1314704558.git.pratyush.anand@st.com>
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

From: Tirumala Marri <tmarri@apm.com>

Enable gadget support

Signed-off-by: Tirumala R Marri <tmarri@apm.com>
Signed-off-by: Fushen Chen <fchen@apm.com>
Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
---
 drivers/usb/gadget/gadget_chips.h |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/gadget_chips.h b/drivers/usb/gadget/gadget_chips.h
index 0978103..66b8018 100644
--- a/drivers/usb/gadget/gadget_chips.h
+++ b/drivers/usb/gadget/gadget_chips.h
@@ -148,6 +148,19 @@
 #define gadget_is_s3c_hsotg(g)    0
 #endif
 
+#if defined(CONFIG_DWC_OTG_MODE) || defined(CONFIG_DWC_DEVICE_ONLY)
+#define gadget_is_dwc_otg_pcd(g)	(!strcmp("dwc_otg_pcd", (g)->name))
+#else
+#define gadget_is_dwc_otg_pcd(g)	0
+#endif
+
+#ifdef CONFIG_USB_GADGET_CI13XXX_MSM
+#define gadget_is_ci13xxx_msm(g)	(!strcmp("ci13xxx_msm", (g)->name))
+#else
+#define gadget_is_ci13xxx_msm(g)	0
+#endif
+
+
 
 /**
  * usb_gadget_controller_number - support bcdDevice id convention
@@ -208,10 +221,13 @@ static inline int usb_gadget_controller_number(struct usb_gadget *gadget)
 		return 0x26;
 	else if (gadget_is_designware(gadget))
 		return 0x27;
+	else if (gadget_is_ci13xxx_msm(gadget))
+		return 0x28;
+	else if (gadget_is_dwc_otg_pcd(gadget))
+		return 0x29;
 	return -ENOENT;
 }
 
-
 /**
  * gadget_supports_altsettings - return true if altsettings work
  * @gadget: the gadget in question
-- 
1.7.2.2
