Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D51C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 04:15:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 521C4214C6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 04:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521C4214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Pflm1rlWzDqKq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 15:15:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43PfDG3HZhzDqJs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2018 14:51:58 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 0B5692952C; Tue, 25 Dec 2018 19:43:57 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Message-Id: <22b3299016531a7a05c9c45b36d43565c794e67d.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v8 22/25] powerpc: Remove CONFIG_GENERIC_NVRAM and adopt
 CONFIG_HAVE_ARCH_NVRAM_OPS
Date: Wed, 26 Dec 2018 11:37:59 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Switch PPC32 kernels from the generic_nvram module to the nvram module.

Also fix a theoretical bug where CHRP omits the chrp_nvram_init()
call when CONFIG_NVRAM_MODULE=m.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <lvivier@redhat.com>
Tested-by: Stan Johnson <userm57@yahoo.com>
---
The change in the name of the module is visible to userspace. The module
that implements /dev/nvram on PowerPC now has suitable aliases, i.e.
MODULE_ALIAS_MISCDEV(NVRAM_MINOR);
MODULE_ALIAS("devname:nvram");
so that the device special file can be automatically created and the
module automatically loaded when needed. Previously this was not the case.

Changed since v7:
 - Improved Kconfig help text for CONFIG_NVRAM.
 - Changed the default for CONFIG_NVRAM, which used to be "n". This is to
reduce the risk that CONFIG_GENERIC_NVRAM=y accidentally gets changed to
CONFIG_NVRAM=n.
---
 arch/powerpc/Kconfig                    |  2 +-
 arch/powerpc/kernel/setup_32.c          |  2 +-
 arch/powerpc/platforms/chrp/Makefile    |  2 +-
 arch/powerpc/platforms/chrp/setup.c     |  2 +-
 arch/powerpc/platforms/powermac/setup.c |  3 +--
 drivers/char/Kconfig                    | 19 +++++++++----------
 6 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8be31261aec8..5b859b7f6599 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -272,7 +272,7 @@ config SYSVIPC_COMPAT
 	default y
 
 # All PPC32s use generic nvram driver through ppc_md
-config GENERIC_NVRAM
+config HAVE_ARCH_NVRAM_OPS
 	bool
 	default y if PPC32
 
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index bdbe6acbef11..96782abb0c41 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -150,7 +150,7 @@ static int __init ppc_setup_l3cr(char *str)
 }
 __setup("l3cr=", ppc_setup_l3cr);
 
-#ifdef CONFIG_GENERIC_NVRAM
+#if IS_ENABLED(CONFIG_NVRAM)
 
 static unsigned char ppc_nvram_read_byte(int addr)
 {
diff --git a/arch/powerpc/platforms/chrp/Makefile b/arch/powerpc/platforms/chrp/Makefile
index 4b3bfadc70fa..dc3465cc8bc6 100644
--- a/arch/powerpc/platforms/chrp/Makefile
+++ b/arch/powerpc/platforms/chrp/Makefile
@@ -1,3 +1,3 @@
 obj-y				+= setup.o time.o pegasos_eth.o pci.o
 obj-$(CONFIG_SMP)		+= smp.o
-obj-$(CONFIG_NVRAM)		+= nvram.o
+obj-$(CONFIG_NVRAM:m=y)		+= nvram.o
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index d6d8ffc0271e..ba216aef964a 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -556,7 +556,7 @@ static void __init chrp_init_IRQ(void)
 static void __init
 chrp_init2(void)
 {
-#ifdef CONFIG_NVRAM
+#if IS_ENABLED(CONFIG_NVRAM)
 	chrp_nvram_init();
 #endif
 
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 2f00e3daafb0..ce340ae4ee38 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -316,8 +316,7 @@ static void __init pmac_setup_arch(void)
 	find_via_pmu();
 	smu_init();
 
-#if defined(CONFIG_NVRAM) || defined(CONFIG_NVRAM_MODULE) || \
-    defined(CONFIG_PPC64)
+#if IS_ENABLED(CONFIG_NVRAM) || defined(CONFIG_PPC64)
 	pmac_nvram_init();
 #endif
 #ifdef CONFIG_PPC32
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index f9960bd65481..2a193b298d27 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -236,25 +236,24 @@ source "drivers/char/hw_random/Kconfig"
 
 config NVRAM
 	tristate "/dev/nvram support"
-	depends on X86 || GENERIC_NVRAM || HAVE_ARCH_NVRAM_OPS
-	default M68K
+	depends on X86 || HAVE_ARCH_NVRAM_OPS
+	default M68K || PPC
 	---help---
 	  If you say Y here and create a character special file /dev/nvram
 	  with major number 10 and minor number 144 using mknod ("man mknod"),
-	  you get read and write access to the extra bytes of non-volatile
-	  memory in the real time clock (RTC), which is contained in every PC
-	  and most Ataris.  The actual number of bytes varies, depending on the
-	  nvram in the system, but is usually 114 (128-14 for the RTC).
-
-	  This memory is conventionally called "CMOS RAM" on PCs and "NVRAM"
-	  on Ataris. /dev/nvram may be used to view settings there, or to
-	  change them (with some utility). It could also be used to frequently
+	  you get read and write access to the non-volatile memory.
+
+	  /dev/nvram may be used to view settings in NVRAM or to change them
+	  (with some utility). It could also be used to frequently
 	  save a few bits of very important data that may not be lost over
 	  power-off and for which writing to disk is too insecure. Note
 	  however that most NVRAM space in a PC belongs to the BIOS and you
 	  should NEVER idly tamper with it. See Ralf Brown's interrupt list
 	  for a guide to the use of CMOS bytes by your BIOS.
 
+	  This memory is conventionally called "NVRAM" on PowerPC machines,
+	  "CMOS RAM" on PCs, "NVRAM" on Ataris and "PRAM" on Macintoshes.
+
 	  To compile this driver as a module, choose M here: the
 	  module will be called nvram.
 
-- 
2.19.2

