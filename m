Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 227A4B7B72
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 09:45:12 +1100 (EST)
In-Reply-To: <1255035843.2146.39.camel@pasglop>
References: <1255008298-19949-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1255008298-19949-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255008298-19949-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255035843.2146.39.camel@pasglop>
Subject: Re: [PATCH 2/6] 8xx: Update TLB asm so it behaves as linux mm expects.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF0E7CD530.5EA71A5E-ONC1257649.00797FD2-C1257649.007CEF55@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 9 Oct 2009 00:44:37 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 08/10/2009 23:04:03:
>
> On Thu, 2009-10-08 at 15:24 +0200, Joakim Tjernlund wrote:
>
> > +#define _PAGE_RW   0x0400   /* lsb PP bits, inverted in HW */
> > +#define _PAGE_USER   0x0800   /* msb PP bits */
> >
> > +   /* r10=(r10&~_PAGE_PRESENT)|((r10&_PAGE_ACCESSED)>>5) */
> > +   rlwimi.   r10, r10, 27, 31, 31
> > +   beq-   cr0, 2f /* Can be removed, costs a ITLB Err */
>
> Did you mean

(counting bits) ... No, it should be >> 5

>
> +    /* r10=(r10&~_PAGE_PRESENT)|((r10&_PAGE_ACCESSED)>>4) */
> +   rlwimi.   r10, r10, 28, 30, 31
> +   beq-   cr0, 2f /* Can be removed, costs a ITLB Err */
>
> Which would still be incorrect. You want -both- to be set,
> and your code will move on if -any- is set. Might want to add
> a ~ of the whole thing maybe and invert the condition ?

I want:
  if (!accessed)
     present = 0;

accessed == 1 and present = 0 is impossible, right?
So basically just copy over accessed to present and
linux mm set both when trapping to C.


>
> I find it easier to just do li rX, requested_bits, and then, andc.
> rscratch, rX, rPTE
>
> > +#if 0    /* Dont' bother with PP lsb, bit 21 for now */
> > +   /* r10 = (r10 & ~0x0400) | ((r10 & _PAGE_EXEC) << 7) */
> > +   rlwimi   r10, r10, 7, 21, 21 /* Set _PAGE_EXEC << 7 */
> > +#endif
>
> I don't get that one. Don't bother with _PAGE_EXEC, there's no
> control of execute permission that works on 8xx. It's #if 0 anyway.

What about the execute perms in Level 2 descriptor, page 247?

>
> You still need to massage the PP bits into place. I don't see that
> happening.

Not at the moment, later.

>
> As it is, your PTE contains for bit 20 and 21, which translates to:
>
>    PTE:                 Translates to PP bits:
> RW: 0   USER: 0          00  supervisor RW (ok)
> RW: 0   USER: 1          01  supervisor RW user RO (WRONG)
> RW: 1   USER: 0          10  supervisor RW user RW (WRONG)
> RW: 1   USER: 1          11  supervisor RO user RO (WRONG)

You got USER and RW swapped and the table is different
for exec.

>
> I would suggest you do the stuff I suggested initially with RW and USER
> being an "index" into a pre-cooked immediate value with all the encodings
> which also gives you the extended encoding for supervisor RO for free.
>
> > +   /* Need to know if load/store -> force a TLB Error
> > +    * by copying ACCESSED to PRESENT.
> > +   */
> > +   /* r10=(r10&~_PAGE_PRESENT)|((r10&_PAGE_ACCESSED)>>5) */
> > +   rlwimi   r10, r10, 27, 31, 31
>
> That doesn't sound right, just like ITLB... you need to AND those two
> bits in a way or another, or basically test that they are both set
> (or neither is set)

Same here as for ITLB.

>
> > +#if 0 /* Not yet */
> > +   /* Honour kernel RO, User NA */
> > +   andi.   r11, r10, _PAGE_USER | _PAGE_RW
> > +   bne-   cr0, 5f
> > +   ori   r10,r10, 0x200 /* Extended encoding, bit 22 */
> >  #endif
> > -   mfspr   r11, SPRN_MD_TWC   /* get the pte address again */
> > -   stw   r10, 0(r11)
> > +5:   xori   r10, r10, _PAGE_RW  /* invert RW bit */
>
> Well, you are missing that xori from the ITLB miss I think. Also, that

Nope, no xori needed for exec perms

> changes the table above to:
>
>    PTE:                 Translates to PP bits:
> RW: 0   USER: 0          10  supervisor RW user RW (WRONG)
> RW: 0   USER: 1          11  supervisor RO user RO (ok)
> RW: 1   USER: 0          00  supervisor RW (ok)
> RW: 1   USER: 1          01  supervisor RW user RO (WRONG)
>
> So it's still not right :-)

User and RW swapped here too, as I read the table.
I don't think user space would boot if I got it wrong.
