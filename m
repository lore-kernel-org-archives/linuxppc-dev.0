Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 343C3DDDD5
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 11:13:05 +1100 (EST)
Date: Wed, 28 Nov 2007 11:13:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] kernel_execve is identical in 32 and 64 bit
Message-Id: <20071128111302.78c94470.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

so concolidate it into misc.S.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/misc.S    |    8 ++++++++
 arch/powerpc/kernel/misc_32.S |    7 -------
 arch/powerpc/kernel/misc_64.S |    7 -------
 3 files changed, 8 insertions(+), 14 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index 330c9dc..74ce0c7 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -14,6 +14,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 #include <asm/ppc_asm.h>
+#include <asm/unistd.h>
 
 	.text
 
@@ -43,3 +44,10 @@ _GLOBAL(add_reloc_offset)
 	add	r3,r3,r5
 	mtlr	r0
 	blr
+
+_GLOBAL(kernel_execve)
+	li	r0,__NR_execve
+	sc
+	bnslr
+	neg	r3,r3
+	blr
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 8b642ab..ea11378 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -793,13 +793,6 @@ _GLOBAL(kernel_thread)
 	addi	r1,r1,16
 	blr
 
-_GLOBAL(kernel_execve)
-	li	r0,__NR_execve
-	sc
-	bnslr
-	neg	r3,r3
-	blr
-
 /*
  * This routine is just here to keep GCC happy - sigh...
  */
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index bbb3ba5..a3c491e 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -518,13 +518,6 @@ _GLOBAL(giveup_altivec)
 
 #endif /* CONFIG_ALTIVEC */
 
-_GLOBAL(kernel_execve)
-	li	r0,__NR_execve
-	sc
-	bnslr
-	neg	r3,r3
-	blr
-
 /* kexec_wait(phys_cpu)
  *
  * wait for the flag to change, indicating this kernel is going away but
-- 
1.5.3.6
