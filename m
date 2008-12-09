Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6CAC3DDF18
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 14:35:06 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	mB93Z20Z012048
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Dec 2008 20:35:02 -0700 (MST)
From: Trent Piepho <tpiepho@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/5] powerpc: booke: Make CAM entries used for lowmem
	configurable
Date: Mon,  8 Dec 2008 19:34:58 -0800
Message-Id: <1228793699-23110-4-git-send-email-tpiepho@freescale.com>
In-Reply-To: <1228793699-23110-1-git-send-email-tpiepho@freescale.com>
References: <1228793699-23110-1-git-send-email-tpiepho@freescale.com>
Cc: Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On booke processors, the code that maps low memory only uses up to three
CAM entries, even though there are sixteen and nothing else uses them.

Make this number configurable in the advanced options menu along with max
low memory size.  If one wants 1 GB of lowmem, then it's typically
necessary to have four CAM entries.

Signed-off-by: Trent Piepho <tpiepho@freescale.com>
---
 arch/powerpc/Kconfig            |   16 ++++++++++++++++
 arch/powerpc/mm/fsl_booke_mmu.c |    6 +++++-
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index be4f99b..2bb645c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -696,6 +696,22 @@ config LOWMEM_SIZE
 	hex "Maximum low memory size (in bytes)" if LOWMEM_SIZE_BOOL
 	default "0x30000000"
 
+config LOWMEM_CAM_NUM_BOOL
+	bool "Set number of CAMs to use to map low memory"
+	depends on ADVANCED_OPTIONS && FSL_BOOKE
+	help
+	  This option allows you to set the maximum number of CAM slots that
+	  will be used to map low memory.  There are a limited number of slots
+	  available and even more limited number that will fit in the L1 MMU.
+	  However, using more entries will allow mapping more low memory.  This
+	  can be useful in optimizing the layout of kernel virtual memory.
+
+	  Say N here unless you know what you are doing.
+
+config LOWMEM_CAM_NUM
+	int "Number of CAMs to use to map low memory" if LOWMEM_CAM_NUM_BOOL
+	default 3
+
 config RELOCATABLE
 	bool "Build a relocatable kernel (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM && FSL_BOOKE
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 1dabe1a..73aa9b7 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -56,10 +56,14 @@
 
 extern void loadcam_entry(unsigned int index);
 unsigned int tlbcam_index;
-static unsigned long cam[3];
+static unsigned long cam[CONFIG_LOWMEM_CAM_NUM];
 
 #define NUM_TLBCAMS	(16)
 
+#if defined(CONFIG_LOWMEM_CAM_NUM_BOOL) && (CONFIG_LOWMEM_CAM_NUM >= NUM_TLBCAMS)
+#error "LOWMEM_CAM_NUM must be less than NUM_TLBCAMS"
+#endif
+
 struct tlbcam TLBCAM[NUM_TLBCAMS];
 
 struct tlbcamrange {
-- 
1.5.4.1
