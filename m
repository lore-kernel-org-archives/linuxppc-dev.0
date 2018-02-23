Return-Path: <groeck7@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zp3R813BSzF1mk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Feb 2018 07:56:03 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id v9-v6so3560949plp.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 12:56:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] powerpc/boot: Fix random build errors
Date: Fri, 23 Feb 2018 12:55:59 -0800
Message-Id: <1519419359-19163-1-git-send-email-linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Once in a while I see build errors similar to the following
when building images from a clean tree.

Building powerpc:virtex-ml507:44x/virtex5_defconfig ... failed
------------
Error log:
arch/powerpc/boot/treeboot-akebono.c:37:20: fatal error:
	libfdt.h: No such file or directory

Building powerpc:bamboo:smpdev:44x/bamboo_defconfig ... failed
------------
Error log:
arch/powerpc/boot/treeboot-akebono.c:37:20: fatal error:
	libfdt.h: No such file or directory

arch/powerpc/boot/treeboot-currituck.c:35:20: fatal error:
     libfdt.h: No such file or directory

Rebuilds will succeed.

Turns out that several source files in arch/powerpc/boot/ include
libfdt.h, but Makefile dependencies are incomplete. Let's fix that.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/powerpc/boot/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index ef6549e57157..26d5d2a5b8e9 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -101,7 +101,8 @@ $(addprefix $(obj)/,$(zlib-y)): \
 libfdt       := fdt.c fdt_ro.c fdt_wip.c fdt_sw.c fdt_rw.c fdt_strerror.c
 libfdtheader := fdt.h libfdt.h libfdt_internal.h
 
-$(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o epapr.o opal.o): \
+$(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o epapr.o opal.o \
+	treeboot-akebono.o treeboot-currituck.o treeboot-iss4xx.o): \
 	$(addprefix $(obj)/,$(libfdtheader))
 
 src-wlib-y := string.S crt0.S stdio.c decompress.c main.c \
-- 
2.7.4
