Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <3756cbfb076b2fa0b93ec990aabfee73296443d9.1216279070.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/3] powerpc: Add a #define for aligning to a long-sized
	boundary
Date: Thu, 17 Jul 2008 17:17:51 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a #define for aligning to a long-sized boundary. It would be nice
to use sizeof(long) for this, but that requires generating the value
with asm-offsets.c, and asm-offsets.c includes asm-compat.h and we
descend into some sort of recursive include hell.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 include/asm-powerpc/asm-compat.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/asm-compat.h b/include/asm-powerpc/asm-compat.h
index 8ec2e1d..8f0fe79 100644
--- a/include/asm-powerpc/asm-compat.h
+++ b/include/asm-powerpc/asm-compat.h
@@ -22,6 +22,7 @@
 #define PPC_STL		stringify_in_c(std)
 #define PPC_LCMPI	stringify_in_c(cmpdi)
 #define PPC_LONG	stringify_in_c(.llong)
+#define PPC_LONG_ALIGN	stringify_in_c(.balign 8)
 #define PPC_TLNEI	stringify_in_c(tdnei)
 #define PPC_LLARX	stringify_in_c(ldarx)
 #define PPC_STLCX	stringify_in_c(stdcx.)
@@ -43,6 +44,7 @@
 #define PPC_STL		stringify_in_c(stw)
 #define PPC_LCMPI	stringify_in_c(cmpwi)
 #define PPC_LONG	stringify_in_c(.long)
+#define PPC_LONG_ALIGN	stringify_in_c(.balign 4)
 #define PPC_TLNEI	stringify_in_c(twnei)
 #define PPC_LLARX	stringify_in_c(lwarx)
 #define PPC_STLCX	stringify_in_c(stwcx.)
-- 
1.5.5
