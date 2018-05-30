Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wjx81NlMzDr61
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 18:11:55 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id c10-v6so8620239pfi.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 01:11:55 -0700 (PDT)
Date: Wed, 30 May 2018 16:11:50 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Cyril Bur <cyrilbur@gmail.com>
Subject: Re: [PATCH v6 1/4] powerpc/64: Align bytes before fall back to
 .Lshort in powerpc64 memcmp()
Message-ID: <20180530081150.GA5951@simonLocalRHEL7.x64>
References: <1527221256-17029-1-git-send-email-wei.guo.simon@gmail.com>
 <1527221256-17029-2-git-send-email-wei.guo.simon@gmail.com>
 <20180528103505.GY17342@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180528103505.GY17342@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Segher,
On Mon, May 28, 2018 at 05:35:12AM -0500, Segher Boessenkool wrote:
> On Fri, May 25, 2018 at 12:07:33PM +0800, wei.guo.simon@gmail.com wrote:
> >  _GLOBAL(memcmp)
> >  	cmpdi	cr1,r5,0
> >  
> > -	/* Use the short loop if both strings are not 8B aligned */
> > -	or	r6,r3,r4
> > +	/* Use the short loop if the src/dst addresses are not
> > +	 * with the same offset of 8 bytes align boundary.
> > +	 */
> > +	xor	r6,r3,r4
> >  	andi.	r6,r6,7
> >  
> > -	/* Use the short loop if length is less than 32B */
> > -	cmpdi	cr6,r5,31
> > +	/* Fall back to short loop if compare at aligned addrs
> > +	 * with less than 8 bytes.
> > +	 */
> > +	cmpdi   cr6,r5,7
> >  
> >  	beq	cr1,.Lzero
> > -	bne	.Lshort
> > -	bgt	cr6,.Llong
> > +	bgt	cr6,.Lno_short
> 
> If this doesn't use cr0 anymore, you can do  rlwinm r6,r6,0,7  instead of
> andi r6,r6,7 .
> 
CR0 is used at .Lno_short handling.

> > +.Lsameoffset_8bytes_make_align_start:
> > +	/* attempt to compare bytes not aligned with 8 bytes so that
> > +	 * rest comparison can run based on 8 bytes alignment.
> > +	 */
> > +	andi.   r6,r3,7
> > +
> > +	/* Try to compare the first double word which is not 8 bytes aligned:
> > +	 * load the first double word at (src & ~7UL) and shift left appropriate
> > +	 * bits before comparision.
> > +	 */
> > +	clrlwi  r6,r3,29
> > +	rlwinm  r6,r6,3,0,28
> 
> Those last two lines are together just
>   rlwinm r6,r3,3,0x1c
> 
Yes. I will combine them.

> > +	subfc.	r5,r6,r5
> 
> Why subfc?  You don't use the carry.
OK. I will use subfc instead.

> 
> > +	rlwinm  r6,r6,3,0,28
> 
> That's
>   slwi r6,r6,3
Yes.

> 
> > +	bgt	cr0,8f
> > +	li	r3,-1
> > +8:
> > +	blr
> 
>   blelr
>   li r3,-1
>   blr
Sure. That looks more impact.

> 
> (and more of the same things elsewhere).
> 
> 
> Segher

Thanks for your good comments.

BR,
- Simon
