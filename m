Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A19C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:53:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2205420651
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2205420651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dydd5dknzDqcH
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 15:53:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43dxyG3lk1zDqWy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 15:22:30 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id D811729E84; Mon, 14 Jan 2019 23:22:24 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Message-Id: <1e72318aab0051f813c3f636ea43f5ef288e00dd.1547525936.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1547525936.git.fthain@telegraphics.com.au>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v9 20/22] powerpc: Enable HAVE_ARCH_NVRAM_OPS and disable
 GENERIC_NVRAM
Date: Tue, 15 Jan 2019 15:18:56 +1100
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

Also fix a theoretical bug where CHRP omits the chrp_nvram_init() call
when CONFIG_NVRAM_MODULE=m.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
The change in the name of the module is visible to userspace. The module
that implements /dev/nvram on PowerPC now has suitable aliases, i.e.
MODULE_ALIAS_MISCDEV(NVRAM_MINOR);
MODULE_ALIAS("devname:nvram");
so that the device special file can be automatically created and the
module automatically loaded when needed. Previously this was not the case.

Changed since v8:
 - Moved the HAVE_ARCH_NVRAM_OPS symbol to common code as suggested by
Christoph Hellwig.
 - Changed arch_nvram_ops method calls to ppc_md method calls.
 - Removed the now unused nvram_sync() export.

Changed since v7:
 - Improved Kconfig help text for CONFIG_NVRAM.
 - Changed the default for CONFIG_NVRAM, which used to be "n". This is to
reduce the risk that CONFIG_GENERIC_NVRAM=y accidentally gets changed to
CONFIG_NVRAM=n.
---
 arch/powerpc/Kconfig                    |  6 +-----
 arch/powerpc/include/asm/nvram.h        |  3 ---
 arch/powerpc/kernel/setup_32.c          | 11 -----------
 arch/powerpc/platforms/chrp/Makefile    |  2 +-
 arch/powerpc/platforms/chrp/setup.c     |  2 +-
 arch/powerpc/platforms/powermac/setup.c |  3 +--
 drivers/char/Kconfig                    | 19 +++++++++----------
 include/linux/nvram.h                   | 20 ++++++++++++++++++++
 8 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2890d36eb531..f62e6a3f9c4e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -178,6 +178,7 @@ config PPC
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
+	select HAVE_ARCH_NVRAM_OPS		if PPC32
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_CBPF_JIT			if !PPC64
@@ -274,11 +275,6 @@ config SYSVIPC_COMPAT
 	depends on COMPAT && SYSVIPC
 	default y
 
-# All PPC32s use generic nvram driver through ppc_md
-config GENERIC_NVRAM
-	bool
-	default y if PPC32
-
 config SCHED_OMIT_FRAME_POINTER
 	bool
 	default y
diff --git a/arch/powerpc/include/asm/nvram.h b/arch/powerpc/include/asm/nvram.h
index 56a388da9c4f..629a5cdcc865 100644
--- a/arch/powerpc/include/asm/nvram.h
+++ b/arch/powerpc/include/asm/nvram.h
@@ -78,9 +78,6 @@ extern int	pmac_get_partition(int partition);
 extern u8	pmac_xpram_read(int xpaddr);
 extern void	pmac_xpram_write(int xpaddr, u8 data);
 
-/* Synchronize NVRAM */
-extern void	nvram_sync(void);
-
 /* Initialize NVRAM OS partition */
 extern int __init nvram_init_os_partition(struct nvram_os_partition *part);
 
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index f5107796e2d7..c31082233a25 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -148,17 +148,6 @@ static int __init ppc_setup_l3cr(char *str)
 }
 __setup("l3cr=", ppc_setup_l3cr);
 
-#ifdef CONFIG_GENERIC_NVRAM
-
-void nvram_sync(void)
-{
-	if (ppc_md.nvram_sync)
-		ppc_md.nvram_sync();
-}
-EXPORT_SYMBOL(nvram_sync);
-
-#endif /* CONFIG_NVRAM */
-
 static int __init ppc_init(void)
 {
 	/* clear the progress line */
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
index e66644e0fb40..e8e804289c8e 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -550,7 +550,7 @@ static void __init chrp_init_IRQ(void)
 static void __init
 chrp_init2(void)
 {
-#ifdef CONFIG_NVRAM
+#if IS_ENABLED(CONFIG_NVRAM)
 	chrp_nvram_init();
 #endif
 
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 2e8221e20ee8..b47f49cf9c4d 100644
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
index ce9979529cf3..72866a004f07 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -244,25 +244,24 @@ source "drivers/char/hw_random/Kconfig"
 
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
 
diff --git a/include/linux/nvram.h b/include/linux/nvram.h
index 9e3a957c8f1f..d29d9c93a927 100644
--- a/include/linux/nvram.h
+++ b/include/linux/nvram.h
@@ -5,6 +5,10 @@
 #include <linux/errno.h>
 #include <uapi/linux/nvram.h>
 
+#ifdef CONFIG_PPC
+#include <asm/machdep.h>
+#endif
+
 /**
  * struct nvram_ops - NVRAM functionality made available to drivers
  * @read: validate checksum (if any) then load a range of bytes from NVRAM
@@ -42,6 +46,8 @@ extern const struct nvram_ops arch_nvram_ops;
 static inline ssize_t nvram_get_size(void)
 {
 #ifdef CONFIG_PPC
+	if (ppc_md.nvram_size)
+		return ppc_md.nvram_size();
 #else
 	if (arch_nvram_ops.get_size)
 		return arch_nvram_ops.get_size();
@@ -52,6 +58,8 @@ static inline ssize_t nvram_get_size(void)
 static inline unsigned char nvram_read_byte(int addr)
 {
 #ifdef CONFIG_PPC
+	if (ppc_md.nvram_read_val)
+		return ppc_md.nvram_read_val(addr);
 #else
 	if (arch_nvram_ops.read_byte)
 		return arch_nvram_ops.read_byte(addr);
@@ -62,6 +70,8 @@ static inline unsigned char nvram_read_byte(int addr)
 static inline void nvram_write_byte(unsigned char val, int addr)
 {
 #ifdef CONFIG_PPC
+	if (ppc_md.nvram_write_val)
+		ppc_md.nvram_write_val(addr, val);
 #else
 	if (arch_nvram_ops.write_byte)
 		arch_nvram_ops.write_byte(val, addr);
@@ -98,15 +108,25 @@ static inline ssize_t nvram_write_bytes(char *buf, size_t count, loff_t *ppos)
 
 static inline ssize_t nvram_read(char *buf, size_t count, loff_t *ppos)
 {
+#ifdef CONFIG_PPC
+	if (ppc_md.nvram_read)
+		return ppc_md.nvram_read(buf, count, ppos);
+#else
 	if (arch_nvram_ops.read)
 		return arch_nvram_ops.read(buf, count, ppos);
+#endif
 	return nvram_read_bytes(buf, count, ppos);
 }
 
 static inline ssize_t nvram_write(char *buf, size_t count, loff_t *ppos)
 {
+#ifdef CONFIG_PPC
+	if (ppc_md.nvram_write)
+		return ppc_md.nvram_write(buf, count, ppos);
+#else
 	if (arch_nvram_ops.write)
 		return arch_nvram_ops.write(buf, count, ppos);
+#endif
 	return nvram_write_bytes(buf, count, ppos);
 }
 
-- 
2.19.2

