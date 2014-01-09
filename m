Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 246E52C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 07:33:50 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Subject: [PATCH] powerpc: fix 8xx and 6xx final link failures
Date: Thu, 9 Jan 2014 15:33:35 -0500
Message-ID: <1389299615-7152-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As of commit b81f18e55e9f4ea81759bcb00fea295de679bbe8 ("powerpc/boot:
Only build board support files when required.") the two defconfigs
ep88xc_defconfig and storcenter_defconfig would fail final link as
follows:

  WRAP    arch/powerpc/boot/dtbImage.ep88xc
arch/powerpc/boot/wrapper.a(mpc8xx.o): In function `mpc885_get_clock':
arch/powerpc/boot/mpc8xx.c:30: undefined reference to `fsl_get_immr'
make[1]: *** [arch/powerpc/boot/dtbImage.ep88xc] Error 1

 ...and...

  WRAP    arch/powerpc/boot/cuImage.storcenter
arch/powerpc/boot/cuboot-pq2.o: In function `pq2_platform_fixups':
cuboot-pq2.c:(.text+0x324): undefined reference to `fsl_get_immr'
make[1]: *** [arch/powerpc/boot/cuImage.storcenter] Error 1

We need the fsl-soc board files built for these two platforms.

Cc: Tony Breeds <tony@bakeyournoodle.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Fixes: b81f18e55e9f ("powerpc/boot: Only build board support files when required.")
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index ca7f08c..4676e55 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -71,9 +71,9 @@ src-wlib-y := string.S crt0.S crtsavres.S stdio.c main.c \
 		uartlite.c mpc52xx-psc.c
 src-wlib-$(CONFIG_40x) += 4xx.c planetcore.c
 src-wlib-$(CONFIG_44x) += 4xx.c ebony.c bamboo.c
-src-wlib-$(CONFIG_8xx) += mpc8xx.c planetcore.c
+src-wlib-$(CONFIG_8xx) += mpc8xx.c planetcore.c fsl-soc.c
 src-wlib-$(CONFIG_PPC_82xx) += pq2.c fsl-soc.c planetcore.c
-src-wlib-$(CONFIG_EMBEDDED6xx) += mv64x60.c mv64x60_i2c.c ugecon.c
+src-wlib-$(CONFIG_EMBEDDED6xx) += mv64x60.c mv64x60_i2c.c ugecon.c fsl-soc.c
 
 src-plat-y := of.c epapr.c
 src-plat-$(CONFIG_40x) += fixed-head.S ep405.c cuboot-hotfoot.c \
-- 
1.8.5.1
