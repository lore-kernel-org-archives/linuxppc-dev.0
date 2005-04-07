Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 85A0C67B1A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Apr 2005 06:18:39 +1000 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Tom Rini" <trini@kernel.crashing.org>
Date: Thu, 7 Apr 2005 22:18:29 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHMEGGCLAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050407161935.GM3396@smtp.west.cox.net>
Cc: "Linuxppc-Embedded@Ozlabs. Org" <linuxppc-embedded@ozlabs.org>
Subject: RE: [PATCH] [RFC] workaround buggy dcbX instructions in 8xx
Reply-To: Joakim.Tjernlund@lumentis.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> 
> On Wed, Apr 06, 2005 at 05:22:57PM +0200, Joakim Tjernlund wrote:
> 
> > All cache instructions in 8xx are somewhat buggy as they
> > do not update the DAR register when causing a DTLB Miss/Error
> [snip]
> > ===== head_8xx.S 1.21 vs edited =====
> [snip]
> > +#define CONFIG_8xx_DCBxFIXED
> 
> If this is configurable, it needs to be done in the Kconfig like, well a
> real config option.  The arguement for doing it as a config option is
> that it is possible to avoid these instructions in userland (I _think_
> with a properly configured gcc, all you need to do is remove the
> memset.S file from glibc), and avoid the (theoretical) slow-down.
> 
> That said, it should also probably be an 'advanced' option that defaults
> to the fixup.

Yes, I don't want the patch applied as is. This is just how the patch
progressed as I wen't along. I wan't to hash out what to do next
before messing with files outside head_8xx.S.
Should it be configurable or not?

> 
> [snip]
> > +#ifdef CONFIG_8xx_DCBxFIXED
> > +/* These macros are used to tag DAR with a known value so that the
> > + * DataTLBError can recognize a buggy dcbx instruction and workaround
> > + * the problem.
> > + */
> > +#define TAG_VAL 0x00f0	/*  -1 may also be used */
> 
> Is there an advantage of using -1?  If it just "or we could use",
> perhaps we should just comment about it, and always define TAG_VAL to
> 0x00f0 (which will make the rest of the patch a bit cleaner).

Not sure. -1 is more "logical" than 0xf0, but 0xf0 saves an instruction
in the DTLB handlers. Comments welcome.

> 
> [snip]
> > +#ifdef CONFIG_8xx_DCBxFIXED
> > +/* This is the workaround procedure to calculate the data EA for buggy dcbx,dcbi instructions
> > + * by decoding the registers used by the dcbx instruction and adding them.
> > + * DAR is set to the calculated address and r10 also holds the EA on exit.
> > + */
> > +//#define INSTR_CHECK /* define to verify if it is a dcbx instr. Should not be needed. */
> > +//#define NO_SELF_MODIFYING_CODE /* define if you don't want to use self modifying code */
> > +//#define DEBUG_DCBX_INSTRUCTIONS /* for debugging only. Needs INSTR_CHECK defined as well. */
> > +//#define KERNEL_SPACE_ONLY /* define if user space do NOT contain dcbx instructions. */
> 
> Aside from preferring #undef FOO to /* #define FOO *//* Comment */ and
> detesting // comments:
> - Perhaps just one debug symbol (combine INSTR_CHECK and
>   DEBUG_DCBX_INSTRUCTIONS).

NP.

> - Is there (aside from "eww, self modifying code") a good reason to have
>   NO_SELF_MODIFYING_CODE ?

The self modifying code version is smaller, eaiser to maintain and possibly faster.
I would like to remove the other alternative if acceptable.

> - Since today, IIRC, we avoid these instructions in the kernel anyhow,
>   is there a reason for KERNEL_SPACE_ONLY ?  In my mind at least, I
>   could see a why for userspace-only, but would think an all/nothing
>   approach is probably most sane (if you can avoid in space A why not
>   B?).

I just started out this way and added user space later, the KERNEL_SPACE_ONLY
should be removed.

we don't avoid all of these instructions in kernel space, but the bigger point is that we don't
need to avoid them if we do this workaround instead. Then 8xx can use the same code as the rest of
the PPC CPU:s

I am just showing the options with these defines and I hope we can agree on
removing some or all of these choises.

Before I invest any more time on this, is this something we want in the kernel?

BTW, have you tested the patch? Does it work if you remove the 8xx special handling in
copy_tofrom_user()?

 Jocke 
