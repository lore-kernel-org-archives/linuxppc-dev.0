Return-Path: <B29882@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9668D2C008D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 04:49:07 +1000 (EST)
Received: from mail243-tx2 (localhost [127.0.0.1])	by
 mail243-tx2-R.bigfish.com (Postfix) with ESMTP id 8A14E8000D5	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 18:49:02 +0000 (UTC)
Received: from TX2EHSMHS013.bigfish.com (unknown [10.9.14.250])	by
 mail243-tx2.bigfish.com (Postfix) with ESMTP id 33F481840045	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 18:49:00 +0000 (UTC)
Received: from right.am.freescale.net (right.am.freescale.net [10.82.176.228])
 by tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id
 q86Imtku000368
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Sep 2012 11:48:57 -0700
From: Matthew McClintock <msm@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc: Fix build dependencies for c files requiring libfdt.h
Date: Thu, 6 Sep 2012 13:48:54 -0500
Message-ID: <1346957334-16017-1-git-send-email-msm@freescale.com>
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

Several files in obj-plat depend on libfdt header file. Sometimes
when building one can see the following issue. This patch adds
libfdt as dependency to those object files

| In file included from arch/powerpc/boot/treeboot-iss4xx.c:33:0:
| arch/powerpc/boot/libfdt.h:854:1: error: unterminated comment
| In file included from arch/powerpc/boot/treeboot-iss4xx.c:33:0:
| arch/powerpc/boot/libfdt.h:1:0: error: unterminated #ifndef
|   BOOTCC  arch/powerpc/boot/inffast.o
| make[1]: *** [arch/powerpc/boot/treeboot-iss4xx.o] Error 1
| make[1]: *** Waiting for unfinished jobs....
|   BOOTCC  arch/powerpc/boot/inflate.o
| make: *** [uImage] Error 2
| ERROR: oe_runmake failed
| ERROR: Function failed: do_compile (see /srv/home/pokybuild/yocto-autobuilder/yocto-slave/p1022ds/build/build/tmp/work/p1022ds-poky-linux-gnuspe/linux-qoriq-sdk-3.0.34-r5/temp/log.do_compile.2167 for further information)
NOTE: recipe linux-qoriq-sdk-3.0.34-r5: task do_compile: Failed

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 arch/powerpc/boot/Makefile |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index b7d8333..6a15c96 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -107,6 +107,7 @@ src-boot := $(addprefix $(obj)/, $(src-boot))
 obj-boot := $(addsuffix .o, $(basename $(src-boot)))
 obj-wlib := $(addsuffix .o, $(basename $(addprefix $(obj)/, $(src-wlib))))
 obj-plat := $(addsuffix .o, $(basename $(addprefix $(obj)/, $(src-plat))))
+obj-plat: $(libfdt)
 
 quiet_cmd_copy_zlib = COPY    $@
       cmd_copy_zlib = sed "s@__used@@;s@<linux/\([^>]*\).*@\"\1\"@" $< > $@
-- 
1.7.9.7
