Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C9608B7BC1
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 18:09:05 +1000 (EST)
In-Reply-To: <20091002214949.GA20514@b07421-ec1.am.freescale.net>
References: <OF490DC464.F75531A6-ONC1257640.002AC41C-C1257640.002D2820@transmode.se>
	<1254212198.5256.0.camel@pasglop>
	<OF94793A12.243E8E02-ONC1257640.0040DE05-C1257640.00419DBD@transmode.se>
	<20090929210331.GA25779@laura.chatsunix.int.mrv.com>
	<OF5D06EC36.28A07DB5-ONC1257641.00299A2D-C1257641.002BE7B1@transmode.se>
	<OFFEC1BDFB.17183440-ONC1257641.002D81B9-C1257641.002DC24F@transmode.se>
	<20090930090002.GA2928@compile2.chatsunix.int.mrv.com>
	<OF46F87EEF.62BE7D78-ONC1257641.003D4172-C1257641.003E1445@transmode.se>
	<OFC29CE070.42D58057-ONC1257641.005F19FD-C1257641.005F8ED3@transmode.se>
	<1254350159.5699.21.camel@pasglop>
	<20091002214949.GA20514@b07421-ec1.am.freescale.net>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache coherency
	rewrite
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF4175DD8E.796930EB-ONC1257644.002A7135-C1257644.002C7929@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 3 Oct 2009 10:05:46 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 02/10/2009 23:49:49:
>
> On Thu, Oct 01, 2009 at 08:35:59AM +1000, Benjamin Herrenschmidt wrote:
> > >From what I can see, the TLB miss code will check _PAGE_PRESENT, and
> > when not set, it will -still- insert something into the TLB (unlike
> > all other CPU types that go straight to data access faults from there).
> >
> > So we end up populating with those unpopulated entries that will then
> > cause us to take a DSI (or ISI) instead of a TLB miss the next time
> > around ... and so we need to remove them once we do that, no ? IE. Once
> > we have actually put a valid PTE in.
> >
> > At least that's my understanding and why I believe we should always have
> > tlbil_va() in set_pte() and ptep_set_access_flags(), which boils down
> > in putting it into the 2 "filter" functions in the new code.
> >
> > Well.. actually, the ptep_set_access_flags() will already do a
> > flush_tlb_page_nohash() when the PTE is changed. So I suppose all we
> > really need here would be in set_pte_filter(), to do the same if we are
> > writing a PTE that has _PAGE_PRESENT, at least on 8xx.
> >
> > But just unconditionally doing a tlbil_va() in both the filter functions
> > shouldn't harm and also fix the problem, though Rex seems to indicate
> > that is not the case.
>
> Adding a tlbil_va to do_page_fault makes the problem go away for me (on
> top of your "merge" branch) -- none of the other changes in this thread
> do (assuming I didn't miss any).  FWIW, when it gets stuck on a fault,
> DSISR is 0xc0000000, and handle_mm_fault returns zero.

OK, that is a no translation error for a load (assuming trap is 0x400)
Do you know what insn this is? I am adding a patch last in this mail
for catching dcbX insn in do_page_fault()

You need the patch I posted yesterday too:

>From c5f1a70561730b8a443f7081fbd9c5b023147043 Mon Sep 17 00:00:00 2001
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Fri, 2 Oct 2009 14:59:21 +0200
Subject: [PATCH] powerpc, 8xx: DTLB Error must check for more errors.

DataTLBError currently does:
 if ((err & 0x02000000) == 0)
    DSI();
This won't handle a store with no valid translation.
Change this to
 if ((err & 0x48000000) != 0)
    DSI();
that is, branch to DSI if either !permission or
!translation.
---
 arch/powerpc/kernel/head_8xx.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 52ff8c5..118bb05 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -472,8 +472,8 @@ DataTLBError:
 	/* First, make sure this was a store operation.
 	*/
 	mfspr	r10, SPRN_DSISR
-	andis.	r11, r10, 0x0200	/* If set, indicates store op */
-	beq	2f
+	andis.	r11, r10, 0x4800 /* no translation, no permission. */
+	bne	2f	/* branch if either is set */

 	/* The EA of a data TLB miss is automatically stored in the MD_EPN
 	 * register.  The EA of a data TLB error is automatically stored in
--
1.6.4.4


Cannot shake the feeling that it this snip of code that causes it
	lwz	r11, 0(r10)	/* Get the level 1 entry */
	rlwinm.	r10, r11,0,0,19	/* Extract page descriptor page address */
	beq	2f		/* If zero, don't try to find a pte */
Perhaps we can do something better? I still feel that we need to
force a TLB Error as the TLBMiss does not set DSISR so we have no way of
knowing if it is an load or store.

 Jocke

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 7699394..c33c6de 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -139,6 +139,88 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
 #else
 	is_write = error_code & ESR_DST;
 #endif /* CONFIG_4xx || CONFIG_BOOKE */
+#if 1 /* defined(CONFIG_8xx)*/
+#define DEBUG_DCBX
+/*
+ Work around DTLB Miss/Error, as these do not update
+ DAR for dcbf, dcbi, dcbst, dcbz and icbi instructions
+ This relies on every exception tagging DAR with 0xf0
+ before returning (rfi)
+ DAR is passed as 'address' to this function.
+ */
+	{
+		unsigned long ra, rb, dar, insn;
+#ifdef DEBUG_DCBX
+		const char *istr = NULL;
+
+		insn = *((unsigned long *)regs->nip);
+		if (((insn >> (31-5)) & 0x3f) == 31) {
+			if (((insn >> 1) & 0x3ff) == 1014) /* dcbz ? 0x3f6 */
+				istr = "dcbz";
+			if (((insn >> 1) & 0x3ff) == 86) /* dcbf ? 0x56 */
+				istr = "dcbf";
+			if (((insn >> 1) & 0x3ff) == 470) /* dcbi ? 0x1d6 */
+				istr = "dcbi";
+			if (((insn >> 1) & 0x3ff) == 54) /* dcbst ? 0x36 */
+				istr = "dcbst";
+			if (((insn >> 1) & 0x3ff) == 982) /* icbi ? 0x3d6 */
+				istr = "icbi";
+			if (istr) {
+				ra = (insn >> (31-15)) & 0x1f; /* Reg RA */
+				rb = (insn >> (31-20)) & 0x1f; /* Reg RB */
+				dar = regs->gpr[rb];
+				if (ra)
+					dar += regs->gpr[ra];
+				if (dar != address && address != 0x00f0 && trap == 0x300)
+					printk(KERN_CRIT "%s: address:%lx, dar:%lx!\n", istr, address, dar);
+				if (!strcmp(istr, "dcbst") && is_write) {
+					printk(KERN_CRIT "dcbst R%ld,R%ld = %lx as a store, fixing!\n",
+					       ra, rb, dar);
+					is_write = 0;
+				}
+
+				if (trap == 0x300 && address != dar) {
+					__asm__ ("mtdar %0" : : "r" (dar));
+					return 0;
+				}
+			}
+		}
+#endif
+		if (address == 0x00f0 && trap == 0x300) {
+			pte_t *ptep;
+
+			/* This is from a dcbX or icbi insn gone bad, these
+			 * insn do not set DAR so we have to do it here instead */
+			insn = *((unsigned long *)regs->nip);
+
+			ra = (insn >> (31-15)) & 0x1f; /* Reg RA */
+			rb = (insn >> (31-20)) & 0x1f; /* Reg RB */
+			dar = regs->gpr[rb];
+			if (ra)
+				dar += regs->gpr[ra];
+			/* Set DAR to correct address for the DTLB Miss/Error handler
+			 * to redo the TLB exception. This time with correct address */
+			__asm__ ("mtdar %0" : : "r" (dar));
+#ifdef DEBUG_DCBX
+			printk(KERN_CRIT "trap:%x address:%lx, dar:%lx,err:%lx %s\n",
+			       trap, address, dar, error_code, istr);
+#endif
+			address = dar;
+#if 1
+			if (is_write && get_pteptr(mm, dar, &ptep, NULL)) {
+				pte_t my_pte = *ptep;
+
+				if (pte_present(my_pte) && pte_write(my_pte)) {
+					pte_val(my_pte) |= _PAGE_DIRTY|_PAGE_ACCESSED|_PAGE_HWWRITE;
+					set_pte_at(mm, dar, ptep, my_pte);
+				}
+			}
+#else
+			return 0;
+#endif
+		}
+	}
+#endif

 	if (notify_page_fault(regs))
 		return 0;
