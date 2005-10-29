Return-Path: <akpm@osdl.org>
Message-Id: <200510290046.j9T0kkk2030000@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:15 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: [patch 05/43] ppc32: #ifdef out ALTIVEC specific code in __switch_to
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

#ifdef out an ALTIVEC specific tweak in __switch_to()

Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc/kernel/process.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN arch/ppc/kernel/process.c~ppc32-ifdef-out-altivec-specific-code-in-__switch_to arch/ppc/kernel/process.c
--- devel/arch/ppc/kernel/process.c~ppc32-ifdef-out-altivec-specific-code-in-__switch_to	2005-10-28 17:44:02.000000000 -0700
+++ devel-akpm/arch/ppc/kernel/process.c	2005-10-28 17:44:02.000000000 -0700
@@ -287,11 +287,13 @@ struct task_struct *__switch_to(struct t
 #endif /* CONFIG_SPE */
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_ALTIVEC
 	/* Avoid the trap.  On smp this this never happens since
 	 * we don't set last_task_used_altivec -- Cort
 	 */
 	if (new->thread.regs && last_task_used_altivec == new)
 		new->thread.regs->msr |= MSR_VEC;
+#endif
 #ifdef CONFIG_SPE
 	/* Avoid the trap.  On smp this this never happens since
 	 * we don't set last_task_used_spe
_
