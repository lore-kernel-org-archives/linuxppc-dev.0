Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE605B7B6F
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2009 09:10:45 +1100 (EST)
In-Reply-To: <1254950092.2409.7.camel@pasglop>
References: <1254948364-30074-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1254948364-30074-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254948364-30074-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254950092.2409.7.camel@pasglop>
Subject: Re: [PATCH 2/6] 8xx: get rid of _PAGE_HWWRITE dependency in MMU.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF8D2D6F89.B0DB8BCB-ONC1257648.00787F6E-C1257648.00799B83@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 8 Oct 2009 00:08:16 +0200
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



Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 07/10/2009 23:14:52:
>
> On Wed, 2009-10-07 at 22:46 +0200, Joakim Tjernlund wrote:
>
> > +   andi.   r11, r10, _PAGE_USER | _PAGE_ACCESSED
> > +   cmpwi   cr0, r11, _PAGE_USER | _PAGE_ACCESSED
> > +   bne-   cr0, 2f
>
> Did you mean _PAGE_PRESENT | _PAGE_ACCESSED ?
>
> > +2:
> > +   mfspr   r11, SRR1
> > +   rlwinm   r11, r11, 0, 5, 3 /* clear guarded */
> > +   mtspr   SRR1, r11
>
> What is the above for ?

TLB Miss will set that bit unconditionally and that is
the same bit as protection error in TLB error.

>
> > +   mfspr   r10, SPRN_M_TW   /* Restore registers */
> > +   lwz   r11, 0(r0)
> > +   mtcr   r11
> > +   lwz   r11, 4(r0)
> > +#ifdef CONFIG_8xx_CPU6
> > +   lwz   r3, 8(r0)
> > +#endif
> > +   b   InstructionAccess
> >
>
>  .../...
>
> > +   andi.   r11, r10, _PAGE_ACCESSED
> > +   bne+   cr0, 5f   /* branch if access allowed */
> > +   rlwinm   r10, r10, 0, 21, 19 /* Clear _PAGE_USER */
> > +   ori   r10, r10, _PAGE_RW  /* Set RW bit for xor below to clear it */
> > +5:   xori   r10, r10, _PAGE_RW  /* invert RW bit */
>
> Why are you clearing _PAGE_USER ? One needs to differenciate usr
> from kernel pages or user will be access to write to kernel...

To force a TLB error so I can work out load or store. I just
came up with a better idea for that, need to test it though.

>
> Why don't you do the trick I proposed in my email with loading a
> constant that contains all the bit combinations and shifting it
> by the amount defined by _PAGE_RW and _PAGE_USER used as a two
> bits index ?

Lets start simple, shall we? :)
Anyhow, I looked some more at that and I don't the best thing is
to use shifts. All bits are correct if you invert RW and add an exception
for extended coding.

>
> >     /* The Linux PTE won't go exactly into the MMU TLB.
> > -    * Software indicator bits 21, 22 and 28 must be clear.
> > +    * Software indicator bits 22 and 28 must be clear.
> >      * Software indicator bits 24, 25, 26, and 27 must be
> >      * set.  All other Linux PTE bits control the behavior
> >      * of the MMU.
> > @@ -472,8 +470,8 @@ DataTLBError:
> >     /* First, make sure this was a store operation.
> >     */
> >     mfspr   r10, SPRN_DSISR
> > -   andis.   r11, r10, 0x4800 /* no translation, no permission. */
> > -   bne   2f   /* branch if either is set */
> > +   andis.   r11, r10, 0x4000 /* no translation */
> > +   bne   2f   /* branch if set */
> >
> >     /* The EA of a data TLB miss is automatically stored in the MD_EPN
> >      * register.  The EA of a data TLB error is automatically stored in
> > @@ -522,26 +520,20 @@ DataTLBError:
> >     mfspr   r11, SPRN_MD_TWC      /* ....and get the pte address */
> >     lwz   r10, 0(r11)      /* Get the pte */
> >
> > -   andi.   r11, r10, _PAGE_RW   /* Is it writeable? */
> > -   beq   2f         /* Bail out if not */
> > -
> > -   /* Update 'changed', among others.
> > -   */
> > -#ifdef CONFIG_SWAP
> > +   mfspr   r11, DSISR
> > +   andis.   r11, r11, 0x0200   /* store */
> > +   beq   5f
> > +   andi.   r11, r10, _PAGE_RW   /* writeable? */
> > +   beq   2f /* nope */
> >     ori   r10, r10, _PAGE_DIRTY|_PAGE_HWWRITE
> > -   /* do not set the _PAGE_ACCESSED bit of a non-present page */
> > -   andi.   r11, r10, _PAGE_PRESENT
> > -   beq   4f
> > -   ori   r10, r10, _PAGE_ACCESSED
> > -4:
> > -#else
> > -   ori   r10, r10, _PAGE_DIRTY|_PAGE_ACCESSED|_PAGE_HWWRITE
> > -#endif
> > -   mfspr   r11, SPRN_MD_TWC      /* Get pte address again */
> > +5:   ori   r10, r10, _PAGE_ACCESSED
> > +   mfspr   r11, MD_TWC      /* Get pte address again */
> >     stw   r10, 0(r11)      /* and update pte in table */
> >
> > +   xori   r10, r10, _PAGE_RW   /* RW bit is inverted */
> > +
> >     /* The Linux PTE won't go exactly into the MMU TLB.
> > -    * Software indicator bits 21, 22 and 28 must be clear.
> > +    * Software indicator bits 22 and 28 must be clear.
> >      * Software indicator bits 24, 25, 26, and 27 must be
> >      * set.  All other Linux PTE bits control the behavior
> >      * of the MMU.
>
> I still don't find how any of the above is useful... why not just go
> straight to C code ?

Because if you go to C with a protection fault, you are in trouble.
So deal with it here. Now, I got another idea too that will make this go away
if it work out
