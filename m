Return-Path: <srs0=aaay=lm=linaro.org=ard.biesheuvel@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420bmN1TKgzDrJ7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 16:48:04 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 420bmN0jHVz8vCd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 16:48:04 +1000 (AEST)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 420bmM2bh1z9s3Z
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2018 16:48:02 +1000 (AEST)
Received: by mail-ed1-x543.google.com with SMTP id h4-v6so3105705edi.6
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2018 23:48:02 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linuxppc-dev@ozlabs.org
Cc: nicholas.piggin@gmail.com, schwab@linux-m68k.org, jeyu@kernel.org,
 mpe@ellerman.id.au, will.deacon@arm.com, mingo@kernel.org,
 akpm@linux-foundation.org, linux-arch@vger.kernel.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] powerpc: disable support for relative ksymtab references
Date: Wed, 29 Aug 2018 08:47:53 +0200
Message-Id: <20180829064753.7133-1-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The newly added code that emits ksymtab entries as pairs of 32-bit
relative references interacts poorly with the way powerpc lays out
its address space: when a module exports a per-CPU variable, the
primary module region covering the ksymtab entry -and thus the 32-bit
relative reference- is too far away from the actual per-CPU variable's
base address (to which the per-CPU offsets are applied to obtain the
respective address of each CPU's copy), resulting in corruption when
the module loader attempts to resolve symbol references of modules
that are loaded on top and link to the exported per-CPU symbol.

So let's disable this feature on powerpc. Even though it implements
CONFIG_RELOCATABLE, it does not implement CONFIG_RANDOMIZE_BASE and
so KASLR kernels (which are the main target of the feature) do not
exist on powerpc anyway.

Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Suggested-by: Nicholas Piggin <nicholas.piggin@gmail.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/powerpc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index db0b6eebbfa5..a80669209155 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -177,7 +177,6 @@ config PPC
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
-	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_CBPF_JIT			if !PPC64
-- 
2.17.1
