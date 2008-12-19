Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 98301DDED6
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 23:37:22 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBJCaTua014417
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 07:36:29 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBJCbIYI145974
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 07:37:18 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBJCagBC001108
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 07:36:43 -0500
Date: Fri, 19 Dec 2008 07:37:05 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/10] powerpc/44x: No need to mask MSR:CE,ME or DE in
	_tlbil_va on 440
Message-ID: <20081219123705.GB2721@zod.rchland.ibm.com>
References: <1229663599.904385.502157196243.qpush@grosgo>
	<20081219051450.2B845DDF7F@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081219051450.2B845DDF7F@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 19, 2008 at 04:13:46PM +1100, Benjamin Herrenschmidt wrote:
>The handlers for Critical, Machine Check or Debug interrupts
>will save and restore MMUCR nowadays, thus we only need to
>disable normal interrupts when invalidating TLB entries.
>
>Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

>---
>
> arch/powerpc/mm/tlb_nohash_low.S |   19 ++++++++++---------
> 1 file changed, 10 insertions(+), 9 deletions(-)
>
>--- linux-work.orig/arch/powerpc/mm/tlb_nohash_low.S	2008-12-15 13:34:57.000000000 +1100
>+++ linux-work/arch/powerpc/mm/tlb_nohash_low.S	2008-12-15 13:35:07.000000000 +1100
>@@ -75,18 +75,19 @@ _GLOBAL(_tlbil_va)
> 	mfspr	r5,SPRN_MMUCR
> 	rlwimi	r5,r4,0,24,31			/* Set TID */
>
>-	/* We have to run the search with interrupts disabled, even critical
>-	 * and debug interrupts (in fact the only critical exceptions we have
>-	 * are debug and machine check).  Otherwise  an interrupt which causes
>-	 * a TLB miss can clobber the MMUCR between the mtspr and the tlbsx. */
>+	/* We have to run the search with interrupts disabled, otherwise
>+	 * an interrupt which causes a TLB miss can clobber the MMUCR
>+	 * between the mtspr and the tlbsx.
>+	 *
>+	 * Critical and Machine Check interrupts take care of saving
>+	 * and restoring MMUCR, so only normal interrupts have to be
>+	 * taken care of.
>+	 */
> 	mfmsr	r4
>-	lis	r6,(MSR_EE|MSR_CE|MSR_ME|MSR_DE)@ha
>-	addi	r6,r6,(MSR_EE|MSR_CE|MSR_ME|MSR_DE)@l
>-	andc	r6,r4,r6
>-	mtmsr	r6
>+	wrteei	0
> 	mtspr	SPRN_MMUCR,r5
> 	tlbsx.	r3, 0, r3
>-	mtmsr	r4
>+	wrtee	r4
> 	bne	1f
> 	sync
> 	/* There are only 64 TLB entries, so r3 < 64,
