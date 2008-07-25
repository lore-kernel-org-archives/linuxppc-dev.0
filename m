Return-Path: <segher@gcc17.fsffrance.org>
Received: from snail.fsffrance.org (eucd.info [88.191.250.43])
	by ozlabs.org (Postfix) with ESMTP id 2737FDDE11
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 10:29:45 +1000 (EST)
From: Segher Boessenkool <segher@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org,
	benh@kernel.crashing.org
Subject: [PATCH] powerpc: Fix compile error with binutils 2.15
Date: Fri, 25 Jul 2008 02:08:41 +0200
Message-Id: <25a77ae6580f7ea388ccae2f190b1b3f7415a928.1216944498.git.segher@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

My previous patch to fix compilation with binutils-2.17 causes
a "file truncated" build error from ld with binutils 2.15 (and
possibly older), and a warning with 2.16 and 2.17.

This fixes it.

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
---
 arch/powerpc/kernel/vmlinux.lds.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index a914411..4a8ce62 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -85,7 +85,7 @@ SECTIONS
 
 	/* The dummy segment contents for the bug workaround mentioned above
 	   near PHDRS.  */
-	.dummy : {
+	.dummy : AT(ADDR(.dummy) - LOAD_OFFSET) {
 		LONG(0xf177)
 	} :kernel :dummy
 
-- 
1.5.6.4.gf1ba5
