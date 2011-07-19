Return-Path: <B29882@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2A8EEB6F62
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jul 2011 02:25:17 +1000 (EST)
Received: from mail147-tx2 (localhost.localdomain [127.0.0.1])	by
	mail147-tx2-R.bigfish.com (Postfix) with ESMTP id AF042A9809B	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2011 16:25:12 +0000 (UTC)
Received: from TX2EHSMHS044.bigfish.com (unknown [10.9.14.250])	by
	mail147-tx2.bigfish.com (Postfix) with ESMTP id 53F371B7830F	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2011 16:22:50 +0000 (UTC)
From: Matthew McClintock <msm@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc: Fix build dependencies for epapr.c which needs
	libfdt.h
Date: Tue, 19 Jul 2011 11:22:44 -0500
Message-ID: <1311092564-10102-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Matthew McClintock <msm@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, the build can (very rarely) fail to build because libfdt.h has
not been created or is in the process of being copied.

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
I think this fixes this build error. Please comment as it's really hard to
reproduce this build error. I've seen this happen a few times now on our
automated build server.

 BOOTCC  arch/powerpc/boot/ep8248e.o
 BOOTCC  arch/powerpc/boot/cuboot-warp.o
 BOOTCC  arch/powerpc/boot/cuboot-85xx-cpm2.o
In file included from arch/powerpc/boot/epapr.c:20:0:
arch/powerpc/boot/libfdt.h:382:1: error: unterminated comment
arch/powerpc/boot/libfdt.h:1:0: error: unterminated #ifndef
 BOOTCC  arch/powerpc/boot/cuboot-yosemite.o
make[1]: *** [arch/powerpc/boot/epapr.o] Error 1
make[1]: *** Waiting for unfinished jobs....
 BOOTCC  arch/powerpc/boot/simpleboot.o
make: *** [uImage] Error 2
Build step 'Execute shell' marked build as failure

 arch/powerpc/boot/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index c26200b..ac6705e 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -58,7 +58,7 @@ $(addprefix $(obj)/,$(zlib) cuboot-c2k.o gunzip_util.o main.o prpmc2800.o): \
 libfdt       := fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
 libfdtheader := fdt.h libfdt.h libfdt_internal.h
 
-$(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o): \
+$(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o epapr.o): \
 	$(addprefix $(obj)/,$(libfdtheader))
 
 src-wlib := string.S crt0.S crtsavres.S stdio.c main.c \
-- 
1.7.5
