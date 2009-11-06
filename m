Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E2EFDB7B69
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 19:03:50 +1100 (EST)
In-Reply-To: <20091106003305.GA15814@loki.buserror.net>
References: <1257341920-29277-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091106003305.GA15814@loki.buserror.net>
Subject: Re: [PATCH 0/8] 8xx: Misc fixes for buggy insn
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF2C4359C9.0EB89938-ONC1257666.00299975-C1257666.002C206F@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 6 Nov 2009 09:01:58 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 06/11/2009 01:33:05:
>
> On Wed, Nov 04, 2009 at 02:38:32PM +0100, Joakim Tjernlund wrote:
> > Here is the latest(last?) round of this series. I
> > hope I got everything right now.
> > Scott and Rex, please test and send ACK/NACK.
> >
> >   Jocke
> >
> > Joakim Tjernlund (8):
> >   8xx: invalidate non present TLBs
>
> This works, and is an important fix -- it should be applied even if the rest
> of the patchset isn't ready.

True.

>
> >   8xx: Update TLB asm so it behaves as linux mm expects.

I think this is ready too.

> >   8xx: Tag DAR with 0x00f0 to catch buggy instructions.
>
> Up through this point works.

hmm, here tagging of DAR is in place, do you ever hit the
page fault handler with address == 0x00f0? If you do,
the kernel somehow manges to fix it instead of erroring out.

I do notice one thing, I forgot to add the CPU6 errata to
the DAR tagging. Are you using the CPU6 errata?

>
> >   8xx: Fixup DAR from buggy dcbX instructions.
>
> With this, the kernel hangs after "Mount-cache hash table entries: 512".

Somewhat surprising result. I didn't expect you would even hit this
condition now as we haven't enabled the use of dcbX insn yet.
The only thing I can think of is the you hit the 0x00f0 due to other
dcbX insn use and the kernel managed to fixup this in the page fault handler
by pure luck before.

The only thing I can thing of being wrong here is your suggested fix:
+       lis     r11, (swapper_pg_dir-PAGE_OFFSET)@h
+       ori     r11, r11, (swapper_pg_dir-PAGE_OFFSET)@l
+       rlwimi  r11, r10, 22, 0xffc

What if you change that back to what worked for you before:
 lis     r11, swapper_pg_dir@h
 ori     r11, r11, swapper_pg_dir@l
 rlwinm  r11, r11, 0, 0x3ffff000
 rlwimi  r11, r10, 22, 0xffc
or possibly
 lis		 r11, swapper_pg_dir@h
 ori		 r11, r11, swapper_pg_dir@l
 subis	 r11, r11, PAGE_OFFSET@h
 rlwimi	 r11, r10, 22, 0xffc

hmm, some missed CPU6 errata calls in DARFixup too.
>
> >   8xx: Add missing Guarded setting in DTLB Error.
> >   8xx: Restore _PAGE_WRITETHRU
> >   8xx: start using dcbX instructions in various copy routines
>
> Once I get up to this patch, it no longer hangs, but I get some user
> processes consistently failing with EFAULT.

No surprise as the it seems like the DAR decoding is broken.

>
> >   8xx: Remove DIRTY pte handling in DTLB Error.
>
> No change after this patch.
>
> -Scott
>
>
