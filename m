Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A95DD2C0350
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 15:50:22 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 15 Nov 2012 14:49:20 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAF4daYl64094448
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 15:39:36 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAF4nxgj028259
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 15:50:00 +1100
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 6/7] powerpc: Update Kconfig + Makefile to prepare for server
 doorbells
Date: Thu, 15 Nov 2012 15:49:49 +1100
Message-Id: <1352954990-2858-7-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1352954990-2858-1-git-send-email-imunsie@au1.ibm.com>
References: <1352954990-2858-1-git-send-email-imunsie@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

Move the rule to build doorbell support out of the Makefile and into a
new Kconfig boolean that platforms can select.

We will add doorbell support to pseries as well in the next patch.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Tested-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/Makefile           |    4 ++--
 arch/powerpc/platforms/Kconfig.cputype |    6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 8f61934..44fbbea 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -75,8 +75,8 @@ endif
 obj64-$(CONFIG_HIBERNATION)	+= swsusp_asm64.o
 obj-$(CONFIG_MODULES)		+= module.o module_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_44x)		+= cpu_setup_44x.o
-obj-$(CONFIG_PPC_FSL_BOOK3E)	+= cpu_setup_fsl_booke.o dbell.o
-obj-$(CONFIG_PPC_BOOK3E_64)	+= dbell.o
+obj-$(CONFIG_PPC_FSL_BOOK3E)	+= cpu_setup_fsl_booke.o
+obj-$(CONFIG_PPC_DOORBELL)	+= dbell.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
 extra-y				:= head_$(CONFIG_WORD_SIZE).o
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 72afd28..cea2f09 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -76,6 +76,7 @@ config PPC_BOOK3E_64
 	bool "Embedded processors"
 	select PPC_FPU # Make it a choice ?
 	select PPC_SMP_MUXED_IPI
+	select PPC_DOORBELL
 
 endchoice
 
@@ -208,6 +209,7 @@ config PPC_FSL_BOOK3E
 	select FSL_EMB_PERFMON
 	select PPC_SMP_MUXED_IPI
 	select SYS_SUPPORTS_HUGETLBFS if PHYS_64BIT || PPC64
+	select PPC_DOORBELL
 	default y if FSL_BOOKE
 
 config PTE_64BIT
@@ -382,4 +384,8 @@ config NOT_COHERENT_CACHE
 config CHECK_CACHE_COHERENCY
 	bool
 
+config PPC_DOORBELL
+	bool
+	default n
+
 endmenu
-- 
1.7.10.4
