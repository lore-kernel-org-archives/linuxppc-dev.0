Message-Id: <20010329021803.Postino-029218@smtp01.highway.ne.jp>
Date: Thu, 29 Mar 2001 02:18:03 +0900
To: linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: spin_lock problem in recent kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

I had tried SMP kernel using paulus rsync tree and 2_4 bk tree.
Since 2.4.3pre6 it has spin_lock problem in both tree.

I used that patch when pre6,pre7
Then I could boot kernel and it's work well.

2.4.3pre8 is not boot that has the other spin_lock problem.
(around ip_tables loading)

When i used this patch when pre6, pre7.

Please check spin_lock problem of pre8 with SMP kernel.

the machine is G4 dual
Thanks

Kaoru

diff -urN base/arch/ppc/mm/init.c fixed/arch/ppc/mm/init.c
--- base/arch/ppc/mm/init.c	Thu Mar 22 19:29:46 2001
+++ fixed/arch/ppc/mm/init.c	Fri Mar 23 05:52:33 2001
@@ -436,11 +436,11 @@
 	 * Should check if it is a candidate for a BAT mapping
 	 */

-	spin_lock(&init_mm.page_table_lock);
+//	spin_lock(&init_mm.page_table_lock);
 	err = 0;
 	for (i = 0; i < size && err == 0; i += PAGE_SIZE)
 		err = map_page(v+i, p+i, flags);
-	spin_unlock(&init_mm.page_table_lock);
+//	spin_unlock(&init_mm.page_table_lock);
 	if (err) {
 		if (mem_init_done)
 			vfree((void *)v);


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
