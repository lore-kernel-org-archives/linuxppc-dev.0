Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6E67CDE184
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 08:27:06 +1100 (EST)
Message-Id: <200803282121.m2SLL9xV010674@imap1.linux-foundation.org>
Subject: [patch 04/24] powerpc: remove redundant display of free swap space in
	show_mem()
To: paulus@samba.org
From: akpm@linux-foundation.org
Date: Fri, 28 Mar 2008 14:21:09 -0700
Cc: akpm@linux-foundation.org, hannes@saeurebad.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Johannes Weiner <hannes@saeurebad.de>

show_mem() has no need to print the amount of free swap space manually because
show_free_areas() does this already and is called by the former.

The two outputs only differ in text formatting:

  printk("Free swap  = %lukB\n", ...);
  printk("Free swap:       %6ldkB\n", ...);

Signed-off-by: Johannes Weiner <hannes@saeurebad.de>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/mm/mem.c |    1 -
 1 file changed, 1 deletion(-)

diff -puN arch/powerpc/mm/mem.c~powerpc-remove-redundant-display-of-free-swap-space-in-show_mem arch/powerpc/mm/mem.c
--- a/arch/powerpc/mm/mem.c~powerpc-remove-redundant-display-of-free-swap-space-in-show_mem
+++ a/arch/powerpc/mm/mem.c
@@ -175,7 +175,6 @@ void show_mem(void)
 
 	printk("Mem-info:\n");
 	show_free_areas();
-	printk("Free swap:       %6ldkB\n", nr_swap_pages<<(PAGE_SHIFT-10));
 	for_each_online_pgdat(pgdat) {
 		unsigned long flags;
 		pgdat_resize_lock(pgdat, &flags);
_
