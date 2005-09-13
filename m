Return-Path: <marcelo.tosatti@cyclades.com>
Date: Tue, 13 Sep 2005 14:50:28 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linuxppc-dev@ozlabs.org, linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20050913175028.GB14889@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: __switch_to test-and-branch ALTIVEC specific?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

This test&branch looks AltiVec specific, any reason for not #ifdef'ing it
out?

--- arch/ppc/kernel/process.c.orig      2005-09-13 14:43:13.000000000 -0300
+++ arch/ppc/kernel/process.c   2005-09-13 14:43:51.000000000 -0300
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
