Message-Id: <20010330062000.Postino-000633@smtp01.highway.ne.jp>
Date: Fri, 30 Mar 2001 06:20:00 +0900
To: Tom Gall <gall@rochcivictheatre.org>
Cc: linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Success kernel-243pre8-SMP(patch)(Re: spin_lock problem in recent k
 ernel
In-Reply-To: <3AC33CA7.E5DF4C03@vnet.ibm.com>
References: <20010329021803.Postino-029218@smtp01.highway.ne.jp>
 <3AC2352D.384B57CA@rochcivictheatre.org>
 <20010329222953.Postino-006016@smtp01.highway.ne.jp>
 <3AC33CA7.E5DF4C03@vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Many thanks Tom,

I have had a success for kernel-2.4.3.pre8-SMP on Dual G4.
This kernel needs the patch.

Kernel Guys, Please look the patch

I will be able to upload this binary kernel into my directory tomorrow.

Kaoru
-------- this patch is needed for SMP kernel-2.4.3.pre8  ---------

diff -urN base/arch/ppc/mm/init.c fixed/arch/ppc/mm/init.c
--- base/arch/ppc/mm/init.c	Thu Mar 29 06:02:35 2001
+++ fixed/arch/ppc/mm/init.c	Fri Mar 30 05:51:16 2001
@@ -437,12 +437,15 @@
 	/*
 	 * Should check if it is a candidate for a BAT mapping
 	 */
-
+#ifndef CONFIG_SMP
 	spin_lock(&init_mm.page_table_lock);
+#endif
 	err = 0;
 	for (i = 0; i < size && err == 0; i += PAGE_SIZE)
 		err = map_page(v+i, p+i, flags);
+#ifndef CONFIG_SMP
 	spin_unlock(&init_mm.page_table_lock);
+#endif
 	if (err) {
 		if (mem_init_done)
 			vfree((void *)v);
diff -urN base/mm/memory.c fixed/mm/memory.c
--- base/mm/memory.c	Thu Mar 29 09:22:35 2001
+++ fixed/mm/memory.c	Fri Mar 30 05:52:17 2001
@@ -1320,9 +1320,13 @@
 		/* "fast" allocation can happen without dropping the lock.. */
 		new = pte_alloc_one_fast(address);
 		if (!new) {
+#ifndef CONFIG_SMP
 			spin_unlock(&mm->page_table_lock);
+#endif
 			new = pte_alloc_one(address);
+#ifndef CONFIG_SMP
 			spin_lock(&mm->page_table_lock);
+#endif
 			if (!new)
 				return NULL;

---------- END -------------

> > This is booing message when kernel-2.4.3pre8-SMP.
> >
> > <snip>
> > TCP: Hash tables configured (established 8192 bind 8192)
> > ip_conntrack(2048 buckets,16384 max)
> > _spin_lock(c02cc470) CPU# 1 NIP c0033404 holder: cpu 1 pc C002B384
> > _spin_lock(c02ce740) CPU# 0 NIP c0015890 holder: cpu 1 pc C0015890

>   Can you look at your system.map for that kernel and tell me what is at
> addresses:

> This is getton  data from system.map

> c00153b0 T schedule_tail
> <C001589>
> c0015a4c T __wake_up
> <snip>
> c002b28c T pte_alloc
> <C002b384>
> c002b3d8 T make_pages_present
> <snip>
> c02cc42c D init_mm
> <c02cc470>
> c02cc4d0 D init_task_union
> <snip>
> c02ce738 d null_pci_ops
> <c02ce740>
> c02ce750 D kernel_flag
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
