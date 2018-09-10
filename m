Return-Path: <joel.stan@gmail.com>
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42824J6STMzF3FQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 18:57:36 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id s7-v6so10143832pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 01:57:36 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org,
	Anton Blanchard <anton@ozlabs.org>
Subject: [PATCH 2/2] powerpc/boot: Ensure _zimage_start is a weak symbol
Date: Mon, 10 Sep 2018 18:57:14 +1000
Message-Id: <20180910085714.4834-3-joel@jms.id.au>
In-Reply-To: <20180910085714.4834-1-joel@jms.id.au>
References: <20180910085714.4834-1-joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When building with clang crt0's _zimage_start is not marked weak, which
breaks the build when linking the kernel image:

 $ objdump -t arch/powerpc/boot/crt0.o |grep _zimage_start$
 0000000000000058 g       .text  0000000000000000 _zimage_start

 ld: arch/powerpc/boot/wrapper.a(crt0.o): in function '_zimage_start':
 (.text+0x58): multiple definition of '_zimage_start';
 arch/powerpc/boot/pseries-head.o:(.text+0x0): first defined here

Clang requires the .weak directive to appear after the symbol is
declared. The binutils manual says:

 This directive sets the weak attribute on the comma separated list of
 symbol names. If the symbols do not already exist, they will be
 created.

So it appears this is different with clang. The only reference I could
see for this was an OpenBSD mailing list post[1].

Changing it to be after the declaration fixes building with Clang, and
still works with GCC.

 $ objdump -t arch/powerpc/boot/crt0.o |grep _zimage_start$
 0000000000000058  w      .text	0000000000000000 _zimage_start

[1] https://groups.google.com/forum/#!topic/fa.openbsd.tech/PAgKKen2YCY

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/boot/crt0.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
index ace3f3c64620..41c6d03d6e2d 100644
--- a/arch/powerpc/boot/crt0.S
+++ b/arch/powerpc/boot/crt0.S
@@ -47,8 +47,8 @@ p_end:		.long	_end
 p_pstack:	.long	_platform_stack_top
 #endif
 
-	.weak	_zimage_start
 	.globl	_zimage_start
+	.weak	_zimage_start
 _zimage_start:
 	.globl	_zimage_start_lib
 _zimage_start_lib:
-- 
2.17.1
