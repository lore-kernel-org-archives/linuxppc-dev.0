Return-Path: <oohall@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404PQL0PqbzF1dw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 16:15:05 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id d1so6510837pgv.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2018 22:15:05 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 2/5] powerpc/zImage: Don't build zlib object files
Date: Mon, 19 Mar 2018 16:14:00 +1100
Message-Id: <20180319051403.23275-2-oohall@gmail.com>
In-Reply-To: <20180319051403.23275-1-oohall@gmail.com>
References: <20180319051403.23275-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The required source files are directly #include`ed into
decompress.c when using gzip compression. Building the
separate .o files for the zlib sources isn't required
and can cause linker errors due to the symbols being
defined in decompress.o and the zlib .o files.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
You can stop throwing up now
---
 arch/powerpc/boot/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 26d5d2a5b8e9..f66b9dba99fd 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -108,7 +108,7 @@ $(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o epapr.o opal.o \
 src-wlib-y := string.S crt0.S stdio.c decompress.c main.c \
 		$(libfdt) libfdt-wrapper.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
-		elf_util.c $(zlib-y) devtree.c stdlib.c \
+		elf_util.c devtree.c stdlib.c \
 		oflib.c ofconsole.c cuboot.c
 
 src-wlib-$(CONFIG_PPC_MPC52XX) += mpc52xx-psc.c
-- 
2.9.5
