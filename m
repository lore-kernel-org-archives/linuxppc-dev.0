Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH]: powerpc: Avoid link stack corruption in MMU on syscall entry
 path
Date: Wed, 27 Feb 2013 14:45:52 -0600
Message-ID: <24511.1361997952@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, anton@samba.org, matt@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we use the link register to branch up high in the early MMU on
syscall entry path.  Unfortunately, this trashes the link stack as the
address we are going to is not associated with the earlier mflr.

This patch simply converts us to used the count register (volatile over
syscalls anyway) instead.  This is much better at predicting in this
scenario and doesn't trash link stack causing a bunch of additional
branch mispredicts later.  Benchmarking this on POWER8 saves a bunch of
cycles on Anton's null syscall benchmark here:
   http://ozlabs.org/~anton/junkcode/null_syscall.c

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a8a5361..87ef8f5 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -74,13 +74,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 	mflr	r10 ;						\
 	ld	r12,PACAKBASE(r13) ; 				\
 	LOAD_HANDLER(r12, system_call_entry_direct) ;		\
-	mtlr	r12 ;						\
+	mtctr	r12 ;						\
 	mfspr	r12,SPRN_SRR1 ;					\
 	/* Re-use of r13... No spare regs to do this */	\
 	li	r13,MSR_RI ;					\
 	mtmsrd 	r13,1 ;						\
 	GET_PACA(r13) ;	/* get r13 back */			\
-	blr ;
+	bctr ;
 #else
 	/* We can branch directly */
 #define SYSCALL_PSERIES_2_DIRECT				\
