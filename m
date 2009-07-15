Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CE812B7BAD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jul 2009 16:53:00 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 15 Jul 2009 16:52:56 +1000
Subject: [PATCH 4/4] powerpc: Change PACA from SPRG3 to SPRG1
Message-Id: <20090715065300.BECACDDDD4@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This change the SPRG used to store the PACA on ppc64 from
SPRG3 to SPRG1. SPRG3 is user readable on most processors
and we want to use it for other things. We change the scratch
SPRG used by exception vectors from SRPG1 to SPRG2.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/reg.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/reg.h	2009-07-15 15:24:07.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/reg.h	2009-07-15 15:56:42.000000000 +1000
@@ -649,12 +649,12 @@
  * SPRG usage:
  *
  * All 64-bit:
- *	- SPRG3 stores PACA pointer
+ *	- SPRG1 stores PACA pointer
  *
  * 64-bit server:
  *	- SPRG0 unused (reserved for HV on Power4)
- *	- SPRG1 scratch for exception vectors
- *	- SPRG2 unused
+ *	- SPRG2 scratch for exception vectors
+ *	- SPRG3 unused (user visible)
  *
  * All 32-bit:
  *	- SPRG3 current thread_info pointer
@@ -700,13 +700,13 @@
  *
  */
 #ifdef CONFIG_PPC64
-#define SPRN_SPRG_PACA 		SPRN_SPRG3
+#define SPRN_SPRG_PACA 		SPRN_SPRG1
 #else
 #define SPRN_SPRG_THREAD 	SPRN_SPRG3
 #endif
 
 #ifdef CONFIG_PPC_BOOK3S_64
-#define SPRN_SPRG_SCRATCH0	SPRN_SPRG1
+#define SPRN_SPRG_SCRATCH0	SPRN_SPRG2
 #endif
 
 #ifdef CONFIG_PPC_BOOK3S_32
