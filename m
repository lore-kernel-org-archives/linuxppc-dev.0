Message-Id: <20010402041101.Postino-017970@smtp01.highway.ne.jp>
Date: Mon, 2 Apr 2001 04:11:01 +0900
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>, <paulus@samba.org>,
	cort@fsmlabs.com
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: Fwd: CPU features
In-Reply-To: <20010401170418.2024@smtp.wanadoo.fr>
References: <20010402002232.Postino-025103@smtp01.highway.ne.jp>
 <20010401170418.2024@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

Thanks,
Your fix  is very nice.
I could run fine smp-kernel-2.4.3 which your patch to penguinppc's 2.4-bk.

Last one is a problem of "smp_core99_kick_cpu" on your tree.

Thanks again

Kaoru

--------------------------
diff -urN base/arch/ppc/mm/init.c fixed/arch/ppc/mm/init.c
--- base/arch/ppc/mm/init.c	Mon Apr  2 02:46:43 2001
+++ fixed/arch/ppc/mm/init.c	Mon Apr  2 01:56:16 2001
@@ -778,7 +778,9 @@
 			f |= _PAGE_USER;
 #endif /* CONFIG_8xx */
 #endif /* CONFIG_KGDB */
+		spin_lock(&init_mm.page_table_lock);
 		map_page(v, p, f);
+		spin_unlock(&init_mm.page_table_lock);
 		v += PAGE_SIZE;
 		p += PAGE_SIZE;
 	}
@@ -1098,11 +1100,13 @@
 	unsigned long zones_size[MAX_NR_ZONES], i;

 #ifdef CONFIG_HIGHMEM
+	spin_lock(&init_mm.page_table_lock);
 	map_page(PKMAP_BASE, 0, 0);	/* XXX gross */
 	pkmap_page_table = pte_offset(pmd_offset(pgd_offset_k(PKMAP_BASE), PKMAP_
BASE), PKMAP_BASE);
 	map_page(KMAP_FIX_BEGIN, 0, 0);	/* XXX gross */
 	kmap_pte = pte_offset(pmd_offset(pgd_offset_k(KMAP_FIX_BEGIN), KMAP_FIX_BEGIN),
 KMAP_FIX_BEGIN);
 	kmap_prot = PAGE_KERNEL;
+	spin_unlock(&init_mm.page_table_lock);
 #endif /* CONFIG_HIGHMEM */

 	/*

--------------------------


From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: Fwd: CPU features
Date: Sun, 1 Apr 2001 19:04:18 +0200
Cc: <linuxppc-dev@lists.linuxppc.org>, <paulus@samba.org>, <cort@fsmlabs.com>

>
> >
> >Hi
> >Thanks your great kernel works.
> >Recently kernel source has spin_lock problem.
> >
> >I  needed the patch for kernel-2.4.3.pre8-SMP on Dual G4.
> >
> >Kernel Guys, Please look the patch or
> >Please Look this problem.
>
> Hrm.. your patch isn't good. I think I found the problem (but didn't
> yet test. My proposed fix is in my rsync, please test and report).
>
> Basically, pte_alloc() is meant to be called with the page table lock
> held. It may itself unlock & re-lock it.
>
> There are places in arch/ppc/mm/init.c where we call it (via map_page())
> without the lock. That mean that we can go out of mapin_ram and paging_init
> with a dangling page table lock held init init_mm, causing further calls
> to __ioremap (or other things) to lockup as soon as they try to grab that
> lock.
>
> The fix would be to enclose those calls to map_page() with a
> spin_lock(&init_mm.page_table_lock);
> and
> spin_unlock(&init_mm.page_table_lock);
>
> Tell me what result you get with that.
>
> ben.
>
>
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
