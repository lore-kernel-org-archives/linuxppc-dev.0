Return-Path: <rostedt@goodmis.org>
Received: from ms-smtp-03.nyroc.rr.com (ms-smtp-03.nyroc.rr.com [24.24.2.57])
	by ozlabs.org (Postfix) with ESMTP id 7441C67B5F
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 20:00:23 +1000 (EST)
Date: Wed, 17 May 2006 06:00:09 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 06/09] robust VM per_cpu i386 bootmem
In-Reply-To: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605170559410.8408@gandalf.stny.rr.com>
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

This patch was to get my VM percpu working on my laptop.  This patch
still needs work to handle NUMA and other types of X86 architectures.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-test/arch/i386/mm/init.c
===================================================================
--- linux-2.6.16-test.orig/arch/i386/mm/init.c	2006-05-17 04:32:28.000000000 -0400
+++ linux-2.6.16-test/arch/i386/mm/init.c	2006-05-17 04:58:37.000000000 -0400
@@ -772,3 +772,39 @@ void free_initrd_mem(unsigned long start
 	}
 }
 #endif
+
+/*
+ * The following three functions are to impement per_cpu variables
+ * into VM.  per_cpu variables are initialized very early on startup
+ * and before memory management. So the per_cpu initialization needs
+ * a way to allocate pages using bootmem.
+ */
+pud_t __init *pud_boot_alloc(struct mm_struct *mm, pgd_t *pgd,
+			     unsigned long addr, int cpu)
+{
+	return (pud_t*)pgd;
+}
+
+pmd_t __init *pmd_boot_alloc(struct mm_struct *mm, pud_t *pud,
+			     unsigned long addr, int cpu)
+{
+	return pmd_offset(pud, addr);
+}
+
+/* FIXME - handle NUMA handling with the CPU parameter */
+pte_t __init *pte_boot_alloc(struct mm_struct *mm, pmd_t *pmd,
+			     unsigned long addr, int cpu)
+{
+	pte_t *pte;
+
+	if (pmd_none(*pmd)) {
+		pte = alloc_bootmem_pages(PAGE_SIZE);
+		if (!pte)
+			return NULL;
+		mm->nr_ptes++;
+		set_pmd(pmd, __pmd(__pa(pte) | _PAGE_TABLE));
+	} else
+		pte = pte_offset_kernel(pmd, addr);
+
+	return pte;
+}
