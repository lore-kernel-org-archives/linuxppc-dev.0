Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E9D86DDDE0
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 09:17:47 +1100 (EST)
Message-Id: <200812012216.mB1MGoor010592@imap1.linux-foundation.org>
Subject: [patch 1/1] arch/powerpc: eliminate NULL test and memset after
	alloc_bootmem
To: paulus@samba.org
From: akpm@linux-foundation.org
Date: Mon, 01 Dec 2008 14:16:50 -0800
Cc: akpm@linux-foundation.org, julia@diku.dk, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

As noted by Akinobu Mita in patch b1fceac2b9e04d278316b2faddf276015fc06e3b,
alloc_bootmem and related functions never return NULL and always return a
zeroed region of memory.  Thus a NULL test or memset after calls to these
functions is unnecessary.

This was fixed using the following semantic patch.
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@@
expression E;
statement S;
@@

E = \(alloc_bootmem\|alloc_bootmem_low\|alloc_bootmem_pages\|alloc_bootmem_low_pages\|alloc_bootmem_node\|alloc_bootmem_low_pages_node\|alloc_bootmem_pages_node\)(...)
... when != E
(
- BUG_ON (E == NULL);
|
- if (E == NULL) S
)

@@
expression E,E1;
@@

E = \(alloc_bootmem\|alloc_bootmem_low\|alloc_bootmem_pages\|alloc_bootmem_low_pages\|alloc_bootmem_node\|alloc_bootmem_low_pages_node\|alloc_bootmem_pages_node\)(...)
... when != E
- memset(E,0,E1);
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/kernel/setup_64.c |    2 --
 1 file changed, 2 deletions(-)

diff -puN arch/powerpc/kernel/setup_64.c~arch-powerpc-eliminate-null-test-and-memset-after-alloc_bootmem arch/powerpc/kernel/setup_64.c
--- a/arch/powerpc/kernel/setup_64.c~arch-powerpc-eliminate-null-test-and-memset-after-alloc_bootmem
+++ a/arch/powerpc/kernel/setup_64.c
@@ -606,8 +606,6 @@ void __init setup_per_cpu_areas(void)
 
 	for_each_possible_cpu(i) {
 		ptr = alloc_bootmem_pages_node(NODE_DATA(cpu_to_node(i)), size);
-		if (!ptr)
-			panic("Cannot allocate cpu data for CPU %d\n", i);
 
 		paca[i].data_offset = ptr - __per_cpu_start;
 		memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);
_
