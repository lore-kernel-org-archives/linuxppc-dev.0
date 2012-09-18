Return-Path: <B29882@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5BD062C0085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2012 05:51:20 +1000 (EST)
Received: from mail146-ch1 (localhost [127.0.0.1])	by
 mail146-ch1-R.bigfish.com (Postfix) with ESMTP id 0C5E86012B	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2012 19:51:16 +0000 (UTC)
Received: from CH1EHSMHS002.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.248])	by mail146-ch1.bigfish.com (Postfix) with ESMTP id
 517782C006A	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2012 19:50:59
 +0000 (UTC)
Received: from right.am.freescale.net (right.am.freescale.net [10.82.176.228])
 by tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id
 q8IJousS029212
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2012 12:50:56 -0700
From: Matthew McClintock <msm@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] arch/powerpc: dtc is required to build dtb files
Date: Tue, 18 Sep 2012 14:50:55 -0500
Message-ID: <1347997855-6730-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixes this following:

$ make distclean; make corenet32_smp_defconfig; make p4080ds.dtb
  CLEAN   arch/powerpc/boot
  CLEAN   scripts/basic
  CLEAN   scripts/dtc
  CLEAN   scripts/genksyms
  CLEAN   scripts/kconfig
  CLEAN   scripts/mod
  CLEAN   scripts
  CLEAN   include/config include/generated
  CLEAN   .config
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/zconf.lex.c
  SHIPPED scripts/kconfig/zconf.hash.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf --silentoldconfig Kconfig
  DTC     arch/powerpc/boot/p4080ds.dtb
/bin/sh: /local/home/mattsm/git/linux/scripts/dtc/dtc: No such file or directory
make[1]: *** [arch/powerpc/boot/p4080ds.dtb] Error 1
make: *** [p4080ds.dtb] Error 2

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 arch/powerpc/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 159e94f..b639852 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -181,7 +181,7 @@ $(BOOT_TARGETS2): vmlinux
 bootwrapper_install:
 	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 
-%.dtb:
+%.dtb: scripts
 	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 
 define archhelp
-- 
1.7.9.7
