Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1CA36B7043
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Jan 2011 03:00:52 +1100 (EST)
In-Reply-To: <OFCA182CE3.B20BFA9C-ONC1257814.005C7CE1-C1257814.005CF1A7@transmode.se>
References: <AANLkTin5XTnDEu1BJUOeF0UWtfEpotW5Bq__i8g6U05h@mail.gmail.com>	<4D24B725.2020300@evidence.eu.com>
	<20110105174256.29fd378a@udp111988uds.am.freescale.net>	<4D25BB08.7000001@evidence.eu.com>
	<OFB0350E05.07B070EF-ONC1257810.005CAF17-C1257810.005CAF19@transmode.se>	<AANLkTinbdEc2kTVHZp3b31V6sFSqOfquUidb5BZYdgEX@mail.gmail.com>
	<OFBA8894F8.FF5AA75D-ONC1257812.00773DA9-C1257812.00776196@transmode.se>	<AANLkTi=cAswFh1cFCU=nomd6yg5Ux9jK0x9h9s7f2571@mail.gmail.com>
	<OFCA182CE3.B20BFA9C-ONC1257814.005C7CE1-C1257814.005CF1A7@transmode.se>
Subject: Re: mpc880 linux-2.6.32 slow running processes
Message-ID: <OF14B8C2B7.A99F8A1E-ONC1257815.0057AC0A-C1257815.0057F664@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 11 Jan 2011 17:00:47 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: michael@evidence.eu.com, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	RFeany <RFeany@mrv.com>, scottwood <scottwood@freescale.com>,
	Rafael Beims <rbeims@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Sent by: linuxppc-dev-bounces+joakim.tjernlund=transmode.se@lists.ozlabs.org
>
> Rafael Beims <rbeims@gmail.com> wrote on 2011/01/10 17:35:38:
> > >
> > > Once you have tested it and it works, please send a patch to remove the 8xx workaround.
> > > Make sure Scott is cc:ed
> > >
> > >
> >
> > I tested linux-2.6.33 on my ppc880 board today, and even without the
> > slowdown.patch applied, the board runs processes with good
> > performance.
> > It really seems that the problem is solved from linux-2.6.33 on.
> >
> > I'm not sure what you mean by sending a patch to remove the
> > workaround. The only thing that I did in the 2.6.32 version was to
> > apply the slowdown.patch attached in the message from Michael.
> >
> > Could you clarify please?
>
> Yes, this part in arch/powerpc/mm/pgtable.c:
> #ifdef CONFIG_8xx
>          /* On 8xx, cache control instructions (particularly
>           * "dcbst" from flush_dcache_icache) fault as write
>           * operation if there is an unpopulated TLB entry
>           * for the address in question. To workaround that,
>           * we invalidate the TLB here, thus avoiding dcbst
>           * misbehaviour.
>           */
>          /* 8xx doesn't care about PID, size or ind args */
>          _tlbil_va(addr, 0, 0, 0);
> #endif /* CONFIG_8xx */
>
> Should be removed in >= 2.6.33 kernels.
> My 8xx TLB work fixes this problem more efficiently.

Can you test these 2 patches on recent 2.6 linux:
>From 9024200169bf86b4f34cb3b1ebf68e0056237bc0 Mon Sep 17 00:00:00 2001
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Tue, 11 Jan 2011 13:43:42 +0100
Subject: [PATCH 1/2] powerpc: Move 8xx invalidation of non present TLBs

8xx does not invalidate ~PRESENT TLBs, move the workaround
in mm/fault.c here to keep 8xx quirks localized and expedite
the invalidation faster.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/powerpc/kernel/head_8xx.S |   12 ++++++++++--
 arch/powerpc/mm/fault.c        |    6 ------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 1f1a04b..6cd99e2 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -221,7 +221,11 @@ DataAccess:
 	stw	r10,_DSISR(r11)
 	mr	r5,r10
 	mfspr	r4,SPRN_DAR
-	li	r10,0x00f0
+	/* invalidate ~PRESENT TLBs, 8xx MMU don't do this */
+	andis.	r10,r5,0x4000
+	beq+	1f
+	tlbie	r4
+1:	li	r10,0x00f0
 	mtspr	SPRN_DAR,r10	/* Tag DAR, to be used in DTLB Error */
 	EXC_XFER_EE_LITE(0x300, handle_page_fault)

@@ -234,7 +238,11 @@ InstructionAccess:
 	EXCEPTION_PROLOG
 	mr	r4,r12
 	mr	r5,r9
-	EXC_XFER_EE_LITE(0x400, handle_page_fault)
+	/* invalidate ~PRESENT TLBs, 8xx MMU don't do this */
+	andis.	r10,r5,0x4000
+	beq+	1f
+	tlbie	r4
+1:	EXC_XFER_EE_LITE(0x400, handle_page_fault)

 /* External interrupt */
 	EXCEPTION(0x500, HardwareInterrupt, do_IRQ, EXC_XFER_LITE)
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 1bd712c..31226c8 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -247,12 +247,6 @@ good_area:
 		goto bad_area;
 #endif /* CONFIG_6xx */
 #if defined(CONFIG_8xx)
-	/* 8xx sometimes need to load a invalid/non-present TLBs.
-	 * These must be invalidated separately as linux mm don't.
-	 */
-	if (error_code & 0x40000000) /* no translation? */
-		_tlbil_va(address, 0, 0, 0);
-
         /* The MPC8xx seems to always set 0x80000000, which is
          * "undefined".  Of those that can be set, this is the only
          * one which seems bad.
--
1.7.3.4


and

>From 0ef93601290a75b087495dddeee6062a870f1dc6 Mon Sep 17 00:00:00 2001
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Tue, 11 Jan 2011 13:55:22 +0100
Subject: [PATCH 2/2] powerpc: Remove 8xx redundant dcbst workaround.

On 8xx dcbst fault as write operation if there is an unpopulated TLB entry
for the address in question. There is as of commit
0a2ab51ffb8dfdf51402dcfb446629648c96bc78,
powerpc/8xx: Fixup DAR from buggy dcbX instructions
a better workaround in the TLB error handler so this bad
one can be removed.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 arch/powerpc/mm/pgtable.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index ebc2f38..d3f47a6 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -185,17 +185,6 @@ static pte_t set_pte_filter(pte_t pte, unsigned long addr)
 		if (!pg)
 			return pte;
 		if (!test_bit(PG_arch_1, &pg->flags)) {
-#ifdef CONFIG_8xx
-			/* On 8xx, cache control instructions (particularly
-			 * "dcbst" from flush_dcache_icache) fault as write
-			 * operation if there is an unpopulated TLB entry
-			 * for the address in question. To workaround that,
-			 * we invalidate the TLB here, thus avoiding dcbst
-			 * misbehaviour.
-			 */
-			/* 8xx doesn't care about PID, size or ind args */
-			_tlbil_va(addr, 0, 0, 0);
-#endif /* CONFIG_8xx */
 			flush_dcache_icache_page(pg);
 			set_bit(PG_arch_1, &pg->flags);
 		}
--
1.7.3.4
