Return-Path: <rostedt@goodmis.org>
Received: from ms-smtp-01.nyroc.rr.com (ms-smtp-01.nyroc.rr.com [24.24.2.55])
	by ozlabs.org (Postfix) with ESMTP id 8385267A6F
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 19:57:01 +1000 (EST)
Date: Wed, 17 May 2006 05:56:55 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 01/09] robust VM per_cpu mm header update
In-Reply-To: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605170556220.8408@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, benedict.gaster@superh.com,
	sam@ravnborg.org, bjornw@axis.com, kenneth.w.chen@intel.com,
	Ingo Molnar <mingo@elte.hu>, kiran@scalex86.org,
	clameter@sgi.com, Nick Piggin <nickpiggin@yahoo.com.au>,
	grundler@parisc-linux.org, arnd@arndb.de,
	Rusty Russell <rusty@rustcorp.com.au>, starvik@axis.com,
	Linus Torvalds <torvalds@osdl.org>,
	Thomas Gleixner <tglx@linutronix.de>, rth@twiddle.net,
	Chris Zankel <chris@zankel.net>, tony.luck@intel.com,
	Andi Kleen <ak@suse.de>, ralf@linux-mips.org,
	Marc Gauthier <marc@tensilica.com>, lethal@linux-sh.org,
	schwidefsky@de.ibm.com, linux390@de.ibm.com, davem@davemloft.net,
	parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch declares the three functions needed by the archs to
implement the percpu VM.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-test/include/linux/mm.h
===================================================================
--- linux-2.6.16-test.orig/include/linux/mm.h	2006-05-17 04:32:27.000000000 -0400
+++ linux-2.6.16-test/include/linux/mm.h	2006-05-17 04:56:52.000000000 -0400
@@ -795,6 +795,15 @@ int __pmd_alloc(struct mm_struct *mm, pu
 int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address);
 int __pte_alloc_kernel(pmd_t *pmd, unsigned long address);

+#ifdef CONFIG_HAS_VM_PERCPU
+pud_t *pud_boot_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long addr,
+		      int cpu);
+pmd_t *pmd_boot_alloc(struct mm_struct *mm, pud_t *pud, unsigned long addr,
+		      int cpu);
+pte_t *pte_boot_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
+		      int cpu);
+#endif
+
 /*
  * The following ifdef needed to get the 4level-fixup.h header to work.
  * Remove it when 4level-fixup.h has been removed.
