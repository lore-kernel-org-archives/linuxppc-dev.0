Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvPK25NV5zDqH3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 12:38:14 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id n11so2772491pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 18:38:14 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>, Rashmica Gupta <rashmica.g@gmail.com>
Subject: [PATCH 2/2] powerpc/mm: add phys addr to linux page table dump
Date: Fri, 31 Mar 2017 12:37:49 +1100
Message-Id: <20170331013749.17874-2-oohall@gmail.com>
In-Reply-To: <20170331013749.17874-1-oohall@gmail.com>
References: <20170331013749.17874-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current page table dumper scans the linux page tables and coalesces
mappings with adjacent virtual addresses and similar PTE flags. This
behaviour is somewhat broken when you consider the IOREMAP space where
entirely unrelated mappings will appear to be contiguous.  This patch
modifies the range coalescing so that only ranges that are both physically
and virtually contiguous are combined. This patch also adds to the dump
output the physical address at the start of each range.

Cc: Rashmica Gupta <rashmica.g@gmail.com>
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/mm/dump_linuxpagetables.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index e7cbfd5a0940..85e6a45bd7ee 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -56,6 +56,8 @@ struct pg_state {
 	struct seq_file *seq;
 	const struct addr_marker *marker;
 	unsigned long start_address;
+	unsigned long start_pa;
+	unsigned long last_pa;
 	unsigned int level;
 	u64 current_flags;
 };
@@ -265,7 +267,9 @@ static void dump_addr(struct pg_state *st, unsigned long addr)
 	const char *unit = units;
 	unsigned long delta;
 
-	seq_printf(st->seq, "0x%016lx-0x%016lx   ", st->start_address, addr-1);
+	seq_printf(st->seq, "0x%016lx-0x%016lx ", st->start_address, addr-1);
+	seq_printf(st->seq, "%016lx ", st->start_pa);
+
 	delta = (addr - st->start_address) >> 10;
 	/* Work out what appropriate unit to use */
 	while (!(delta & 1023) && unit[1]) {
@@ -280,11 +284,15 @@ static void note_page(struct pg_state *st, unsigned long addr,
 	       unsigned int level, u64 val)
 {
 	u64 flag = val & pg_level[level].mask;
+	u64 pa = val & PTE_RPN_MASK;
+
 	/* At first no level is set */
 	if (!st->level) {
 		st->level = level;
 		st->current_flags = flag;
 		st->start_address = addr;
+		st->start_pa = pa;
+		st->last_pa = pa;
 		seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
 	/*
 	 * Dump the section of virtual memory when:
@@ -292,9 +300,11 @@ static void note_page(struct pg_state *st, unsigned long addr,
 	 *   - we change levels in the tree.
 	 *   - the address is in a different section of memory and is thus
 	 *   used for a different purpose, regardless of the flags.
+	 *   - the pa of this page is not adjacent to the last inspected page
 	 */
 	} else if (flag != st->current_flags || level != st->level ||
-		   addr >= st->marker[1].start_address) {
+		   addr >= st->marker[1].start_address ||
+		   pa != st->last_pa + PAGE_SIZE) {
 
 		/* Check the PTE flags */
 		if (st->current_flags) {
@@ -318,8 +328,12 @@ static void note_page(struct pg_state *st, unsigned long addr,
 			seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
 		}
 		st->start_address = addr;
+		st->start_pa = pa;
+		st->last_pa = pa;
 		st->current_flags = flag;
 		st->level = level;
+	} else {
+		st->last_pa = pa;
 	}
 }
 
-- 
2.9.3
