Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 966AA67B2A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 10 Apr 2005 14:13:59 +1000 (EST)
Date: Sat, 9 Apr 2005 19:37:21 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Message-ID: <20050409223721.GA27454@logos.cnet>
References: <86e2fa4b5afe5bd8afc33ca47a7ab50c@embeddededge.com>
	<BCEFJBPJCGFCNMMMIDBHKEGMCLAA.Joakim.Tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BCEFJBPJCGFCNMMMIDBHKEGMCLAA.Joakim.Tjernlund@lumentis.se>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 8xx v2.6 TLB problems and suggested workaround
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Apr 09, 2005 at 09:03:54PM +0200, Joakim Tjernlund wrote:
> > 
> > On Apr 8, 2005, at 7:07 AM, Marcelo Tosatti wrote:
> > 
> > > 1) _tlbie() on update_mmu_cache() surrounded by CONFIG_8xx #ifdef
> > > Did you give up about it?
> > 
> > I think a tlbia() of the vaddr should work here.  No sense blowing
> > away the whole TLB cache for this.
> 
> Umm, isn't it the other way around? tlbie flushes one TLB whereas tlbia flushes
> all TLBs.

Yep

> > > What else you think can be done?
> > 
> > It would be interesting to change __flush_dcache_icache()
> > to use the 8xx SPR cache operations instead of the dcbst instruction.
> 
> yes, but I think these operates on physical addresses which makes it a bit harder.

Other than the fact of userspace dcbst users.

> I still think this can be resolved in fault.c. Replace 
> 	andis.	r11, r10, 0x0200	/* If set, indicates store op */
> 	beq	2f
> in the DTLB Error handler with
> 	andis.	r11, r10, 0x4800	/* If set, indicates invalid pte or protection violation */
> 	bne	2f

Why does the current code jump to page fault handler in case of store operation? 

Out of curiosity, aren't there any other valid bit combinations for DSISR other
than 0x4800 which should allow a fastpath DataTLBError ?

I can't find DSISR settings in MPC860UM.pdf neither paper manual. AFAICS it
always refer to the PEM when talking about DSISR bit assignments. 

I can't find section "7-15" as you mentioned in the other email.

> In fault.c you can check if both store and invalid is set simultaneously. If it is, clear
> the store flag and continue as usual.

One point is that by changing the in-kernel dcbst implementation userspace is 
still vulnerable to the problem.

Now fixing the exception handler to deal with such boggosity as Joakim proposes is 
complete - it handles userspace dcbst callers. 

> > I wouldn't be surprised if it worked differently, but I'd not be
> > able to explain it :-)
> > 
> > Thanks.
> > 
> > 	-- Dan
> > 
