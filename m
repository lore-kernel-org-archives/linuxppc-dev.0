Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyb7J714CzDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 16:10:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc: Make sparsemem the default on 64-bit Book3S
Date: Wed,  5 Apr 2017 16:10:48 +1000
Message-Id: <1491372648-21708-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make sparsemem the default on all 64-bit Book3S platforms. It already is
for pseries and ps3, and we need to enable it for powernv because on
POWER9 memory between chips is discontiguous.

For the other platforms sparsemem should work fine, though it might add
a small amount of overhead. We can always force FLATMEM in the
defconfigs if necessary.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v2: Rather than enabling it for powernv, just turn it on for all 64-bit Book3S.

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 97a8bc8a095c..0ab49b1256a8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -586,7 +586,7 @@ config ARCH_SPARSEMEM_ENABLE
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
-	depends on (SMP && PPC_PSERIES) || PPC_PS3
+	depends on PPC_BOOK3S_64
 
 config SYS_SUPPORTS_HUGETLBFS
 	bool
-- 
2.7.4
