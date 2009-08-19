Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 87498B7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 17:26:05 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DCC12DDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 17:26:04 +1000 (EST)
Subject: Re: [PATCH 1/5] powerpc/mm: Add MMU features for TLB reservation &
	Paired MAS registers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1250658513-13009-1-git-send-email-galak@kernel.crashing.org>
References: <1250658513-13009-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 19 Aug 2009 17:25:56 +1000
Message-Id: <1250666756.4810.16.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-08-19 at 00:08 -0500, Kumar Gala wrote:
> Support for TLB reservation (or TLB Write Conditional) and Paired MAS
> registers are optional for a processor implementation so we handle
> them via MMU feature sections.
> 
> We currently only used paired MAS registers to access the full RPN + perm
> bits that are kept in MAS7||MAS3.  We assume that if an implementation has
> hardware page table at this time it also implements in TLB reservations.

You also need to be careful with this code:

virt_page_table_tlb_miss_done:

	/* We have overriden MAS2:EPN but currently our primary TLB miss
	 * handler will always restore it so that should not be an issue,
	 * if we ever optimize the primary handler to not write MAS2 on
	 * some cases, we'll have to restore MAS2:EPN here based on the
	 * original fault's DEAR. If we do that we have to modify the
	 * ITLB miss handler to also store SRR0 in the exception frame
	 * as DEAR.
	 *
	 * However, one nasty thing we did is we cleared the reservation
	 * (well, potentially we did). We do a trick here thus if we
	 * are not a level 0 exception (we interrupted the TLB miss) we
	 * offset the return address by -4 in order to replay the tlbsrx
	 * instruction there
	 */
	subf	r10,r13,r12
	cmpldi	cr0,r10,PACA_EXTLB+EX_TLB_SIZE
	bne-	1f
	ld	r11,PACA_EXTLB+EX_TLB_SIZE+EX_TLB_SRR0(r13)
	addi	r10,r11,-4
	std	r10,PACA_EXTLB+EX_TLB_SIZE+EX_TLB_SRR0(r13)

You may want to make the 3 last lines conditional on having tlbsrx.

Right now, in the no-tlbsrx. case, what happens is that it will go back
to the previous instruction, an or, which hopefully should be harmless
-but- this code is nasty enough you really don't want to take that
sort of chances.

Feel free to add a fat comment next to the ld in the tlbsrx case itself
explaining why those two instructions must be kept together and any
change here must be reflected in the second level handler.

Cheers,
Ben.
