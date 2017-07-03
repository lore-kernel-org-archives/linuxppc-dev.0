Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1S2m582szDr8S
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 23:02:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v6 10/10] powerpc/Kconfig: Enable STRICT_KERNEL_RWX for some
 configs
Date: Mon,  3 Jul 2017 23:01:54 +1000
Message-Id: <1499086914-25695-10-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1499086914-25695-1-git-send-email-mpe@ellerman.id.au>
References: <1499086914-25695-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Balbir Singh <bsingharora@gmail.com>

All code that patches kernel text has been moved over to using
patch_instruction() and patch_instruction() is able to cope with the
kernel text being read only.

The linker script has been updated to ensure the read only data ends
on a large page boundary, so it and the preceding kernel text can be
marked R_X. We also have implementations of mark_rodata_ro() for Hash
and Radix MMU modes.

There are some corner-cases missing when the kernel is built
relocatable, so for now make it depend on !RELOCATABLE.

There's also a temporary workaround to depend on !HIBERNATION to avoid
a build failure, that will be removed once we've merged with the PM
tree.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
[mpe: Make it depend on !RELOCATABLE, munge change log]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index eb0e591c867d..0190340f8ca9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -164,6 +164,8 @@ config PPC
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
+	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC_BOOK3S_64 && !RELOCATABLE && !HIBERNATION)
+	select ARCH_OPTIONAL_KERNEL_RWX		if ARCH_HAS_STRICT_KERNEL_RWX
 	select HAVE_CBPF_JIT			if !PPC64
 	select HAVE_CONTEXT_TRACKING		if PPC64
 	select HAVE_DEBUG_KMEMLEAK
-- 
2.7.4
