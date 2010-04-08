Return-Path: <Bruce_Leonard@selinc.com>
Received: from duster.selinc.com (duster.selinc.com [74.117.214.140])
	by ozlabs.org (Postfix) with ESMTP id C41DAB7D21
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Apr 2010 05:33:15 +1000 (EST)
In-Reply-To: <1270735170.19546.2.camel@concordia>
References: <OF788A7534.456B03AA-ON882576F6.00228BC4-882576F6.00233EC1@selinc.com>
	<1270735170.19546.2.camel@concordia>
To: michael@ellerman.id.au
MIME-Version: 1.0
Subject: Re: Question regarding the DTLB Miss exceptions
Message-ID: <OFD957C4B7.2DDD66CF-ON882576FF.0069A7B1-882576FF.006B689A@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 8 Apr 2010 12:33:11 -0700
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > When a DTLB Miss exception can't find a PTE for the virtual address 
being 
> > written/read, it dummies up the SPRs for a DSI exception and then 
calls 
> > directly into the DSI exception code.  Just before the DTLB miss code 
> > stores a value into DSISR it sets bit 2, which for a DSI exception is 
a 
> > reserved bit and should be cleared.  There's no comment on the code 
> > (.../arch/powerpc/kernel/head_32.S line 619 of the 2.6.33-rc1 kernel). 
Can 
> > anyone tell me why this bit is getting set?
> 
> You mean:
> 
> 616 DataAddressInvalid:
>  617         mfspr   r3,SPRN_SRR1
>  618         rlwinm  r1,r3,9,6,6     /* Get load/store bit */
>  619         addis   r1,r1,0x2000  
>  620         mtspr   SPRN_DSISR,r1
> 
> Is it trying to set DSISR_ISSTORE?
> 
> #define   DSISR_ISSTORE         0x02000000      /* access was a store */ 
 
> 
Michael,

Thanks for the reply.

I mean line 619 above.  It's setting 0x20000000 (bit 2) in the DSISR. 
0x02000000 (bit 6 or DSISR_ISSTORE) is already set because it's a DTLB 
Data Store Miss Exception.  But 0x20000000 is meaningless for the DSI 
Exception about to be called.  According to the data sheet, it's supposed 
to be cleared.  Someone wrote code to explicitly set a bit in the DSISR 
that has no meaning in the PPC architecture.  So I assume it's being 
overloaded for some purpose, but I can't glean that purpose from the code. 
 Equally perplexing to me is the following line of code from the DSI 
Exception code:

andis.  r0,r10,0xa470   /* weird error? */

It's checking to see if the following bits of DSISR are set:
0 - set by DTLB miss if no hash table entry group is found
2 - an invalid bit
5 - an invalid bit
9 - set if breakpoint match
10 - invalid bit
11 - set if the instruction is an ecwix or ecowx and EAR[E] = 0

So it's checking to see if three bits not defined by the PPC architecture 
are set and calling it a "weird error".  What the heck does that mean, a 
"weird error"?  Obviously overloaded bits used for some totally 
undocumented purpose that I can't figure out from the code and I'm just 
trying to understand what they're used for to see if it's related to my 
problem.

Bruce
