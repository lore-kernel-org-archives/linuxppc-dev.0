Return-Path: <mkravetz@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A3AB467B92
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 12:31:18 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7F2VE7T000503
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 22:31:14 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7F2VES3271188
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 22:31:14 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7F2VDEu027743
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 22:31:14 -0400
Date: Mon, 14 Aug 2006 19:32:24 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc: Instrument Hypervisor Calls
Message-ID: <20060815023224.GA3622@monkey.ibm.com>
References: <20060814232144.GG3213@w-mikek2.ibm.com>
	<20060815110319.5f34417a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060815110319.5f34417a.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 15, 2006 at 11:03:19AM +1000, Stephen Rothwell wrote:
> On Mon, 14 Aug 2006 16:21:44 -0700 Mike Kravetz <kravetz@us.ibm.com> wrote:
> > +#define HCALL_INST_POSTCALL					\
> > +	/* get time and PURR snapshots after hcall */		\
> > +	mftb	r7;			/* timebase after */	\
> > +BEGIN_FTR_SECTION;						\
> > +	mfspr	r8,SPRN_PURR;		/* PURR after */	\
> > +END_FTR_SECTION_IFSET(CPU_FTR_PURR);				\
> > +								\
> > +	/* calculate time and PURR deltas for call */		\
> > +	ld	r5,STK_PARM(r5)(r1);	/* timebase before */	\
> > +	subf	r5,r5,r7;					\
> > +	ld	r6,STK_PARM(r6)(r1);	/* PURR before */	\
> > +	subf	r6,r6,r8;					\
> 
> But here, if we have no PURR we produce random numbers.  Maybe you should
> reuse the TB value so the values reported may make some sense.

Good catch!

My intention was to detect the presence of PURR in the display (debugfs)
code.  If there is no PURR, then no PURR values are displayed.  My thought
is that it doesn't matter what values are in the field if we don't display
them.  

Unfortunately, I left that bit of code out of the patch.

How does that sound?  Suppose I can also put all the 'calculate PURR delta'
code in the FTR_SECTION to save a few cycles.
-- 
Mike
