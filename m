Date: Thu, 27 May 2004 09:53:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Dan Malek <dan@embeddededge.com>,
	Kumar Gala <kumar.gala@motorola.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH #4/9] 8xx-2.6 | MM tweaks
Message-ID: <20040527165316.GF6763@smtp.west.cox.net>
References: <40B48819.9000904@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40B48819.9000904@intracom.gr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 26, 2004 at 03:05:45PM +0300, Pantelis Antoniou wrote:

> Hi
>
> The following patch consists of minor tweaks in order to get
> the mm to work.

I was wondering.  The fault.c change boils down to:
===== arch/ppc/mm/fault.c 1.26 vs edited =====
--- 1.26/arch/ppc/mm/fault.c	2004-05-25 04:50:34 -07:00
+++ edited/arch/ppc/mm/fault.c	2004-05-27 09:48:17 -07:00
@@ -350,11 +350,14 @@
 	pgd_t *dir;
 	pmd_t *pmd;
 	pte_t *pte;
+	struct mm_struct *mm;

 	if (address < TASK_SIZE)
-		return NULL;
+		mm = current->mm;
+	else
+		mm = &init_mm;

-	dir = pgd_offset(&init_mm, address);
+	dir = pgd_offset(mm, address & PAGE_MASK);
 	if (dir) {
 		pmd = pmd_offset(dir, address & PAGE_MASK);
 		if (pmd && pmd_present(*pmd)) {

Can you explain this a bit more?  Looking back at the history in
BitKeeper, this change came from Paul, in the changeset with the
comments of:
PPC update for the recent changes to the pgd/pmd/pte functions.
This implements ptes-in-highmem for PPC, removes the quicklist
and zero-page stuff.  PTEs in highmem on SMP turned out to need
some significant changes to avoid deadlocks on the hash_table_lock
(now renamed to mmu_hash_lock).  The PMDs now contain the physical
address of the PTE page rather than the virtual address.
Anything that takes the mmu_hash_lock now operates with the DMMU
off to avoid MMU hash-table misses.

And for this file in particular:
Do pte_unmap after get_pteptr; use pte_offset_kernel instead of
pte_offset in a couple of places.

Which you exactly reverted.  Were the changes from Paul incorrect here?
Or is perhaps there something more needed on the 8xx side of things?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
