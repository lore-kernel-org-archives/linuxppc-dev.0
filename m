Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9A48FB7109
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 25 Sep 2010 07:44:23 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8OLTIso013659
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Sep 2010 17:29:18 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8OLiHP8122442
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Sep 2010 17:44:17 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o8OLiG7u021974
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Sep 2010 15:44:16 -0600
Subject: [PATCH 1/1]  Add config option for batched hcalls
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 24 Sep 2010 16:44:15 -0500
Message-ID: <1285364655.3016.25.camel@lexx>
Mime-Version: 1.0
Cc: Anton Blanchard <anton@samba.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Add a config option for the (batched) MULTITCE and BULK_REMOVE h-calls.

By default, these options are on and are beneficial for performance and
throughput reasons.   If disabled, the code will fall back to using less
optimal TCE and REMOVE hcalls.   The ability to easily disable these
options is useful for some of the PREEMPT_RT related investigation and
work occurring on Power.


Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>
cc: Anton Blanchard <anton@samba.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index f0e6f28..0b5e6a9 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -81,3 +81,23 @@ config DTL
 	  which are accessible through a debugfs file.
 
 	  Say N if you are unsure.
+
+config BULK_REMOVE
+	bool "Enable BULK_REMOVE"
+	depends on PPC_PSERIES
+	default y
+	help
+	  Enable the BULK_REMOVE option for the hash page code.
+	  This relies on a "hcall-bulk" firmware feature, and
+	  should be enabled for performance throughput.
+
+config MULTITCE
+	bool "Enable MultiTCE"
+	depends on PPC_PSERIES
+	default y
+	help
+	  Enable the Multi-TCE code, allowing a single hcall to
+	  update multiple TCE entries at one time.  This relies
+	  on a "hcall-multi-tce" firmware feature, and should be
+	  enabled for performance throughput.
+
diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index 0a4d8c..4327064 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -51,9 +51,13 @@ firmware_features_table[FIRMWARE_MAX_FEATURES] = {
 	{FW_FEATURE_VIO,		"hcall-vio"},
 	{FW_FEATURE_RDMA,		"hcall-rdma"},
 	{FW_FEATURE_LLAN,		"hcall-lLAN"},
+#if defined(CONFIG_BULK_REMOVE)
 	{FW_FEATURE_BULK_REMOVE,	"hcall-bulk"},
+#endif
 	{FW_FEATURE_XDABR,		"hcall-xdabr"},
+#if defined(CONFIG_MULTITCE)
 	{FW_FEATURE_MULTITCE,		"hcall-multi-tce"},
+#endif
 	{FW_FEATURE_SPLPAR,		"hcall-splpar"},
 };
 
 /* Build up the firmware features bitmask using the contents of
