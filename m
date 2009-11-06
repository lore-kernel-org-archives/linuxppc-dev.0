Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1CA50B6F2B
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 20:33:58 +1100 (EST)
In-Reply-To: <OF2C4359C9.0EB89938-ONC1257666.00299975-C1257666.002C206F@transmode.se>
References: <1257341920-29277-1-git-send-email-Joakim.Tjernlund@transmode.se>	<20091106003305.GA15814@loki.buserror.net>
	<OF2C4359C9.0EB89938-ONC1257666.00299975-C1257666.002C206F@transmode.se>
Subject: Re: [PATCH 0/8] 8xx: Misc fixes for buggy insn
Message-ID: <OFBF62CE94.BC53D847-ONC1257666.0033CF65-C1257666.0034293A@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 6 Nov 2009 10:29:44 +0100
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

>
> Scott Wood <scottwood@freescale.com> wrote on 06/11/2009 01:33:05:
> >
> > On Wed, Nov 04, 2009 at 02:38:32PM +0100, Joakim Tjernlund wrote:
> > > Here is the latest(last?) round of this series. I
> > > hope I got everything right now.
> > > Scott and Rex, please test and send ACK/NACK.
> > >
> > >   Jocke
> > >
> > > Joakim Tjernlund (8):
> > >   8xx: invalidate non present TLBs
> >
> > This works, and is an important fix -- it should be applied even if the rest
> > of the patchset isn't ready.
>
> True.
>
> >
> > >   8xx: Update TLB asm so it behaves as linux mm expects.
>
> I think this is ready too.
>
> > >   8xx: Tag DAR with 0x00f0 to catch buggy instructions.
> >
> > Up through this point works.
>
> hmm, here tagging of DAR is in place, do you ever hit the
> page fault handler with address == 0x00f0? If you do,
> the kernel somehow manges to fix it instead of erroring out.
>
> I do notice one thing, I forgot to add the CPU6 errata to
> the DAR tagging. Are you using the CPU6 errata?

DAR isn't affected by CPU6 so this should not be a problem.

>
> >
> > >   8xx: Fixup DAR from buggy dcbX instructions.
> >
> > With this, the kernel hangs after "Mount-cache hash table entries: 512".
>
> Somewhat surprising result. I didn't expect you would even hit this
> condition now as we haven't enabled the use of dcbX insn yet.
> The only thing I can think of is the you hit the 0x00f0 due to other
> dcbX insn use and the kernel managed to fixup this in the page fault handler
> by pure luck before.
>
> The only thing I can thing of being wrong here is your suggested fix:
> +       lis     r11, (swapper_pg_dir-PAGE_OFFSET)@h
> +       ori     r11, r11, (swapper_pg_dir-PAGE_OFFSET)@l
> +       rlwimi  r11, r10, 22, 0xffc
>
> What if you change that back to what worked for you before:
>  lis     r11, swapper_pg_dir@h
>  ori     r11, r11, swapper_pg_dir@l
>  rlwinm  r11, r11, 0, 0x3ffff000
>  rlwimi  r11, r10, 22, 0xffc
> or possibly
>  lis       r11, swapper_pg_dir@h
>  ori       r11, r11, swapper_pg_dir@l
>  subis    r11, r11, PAGE_OFFSET@h
>  rlwimi    r11, r10, 22, 0xffc
>
> hmm, some missed CPU6 errata calls in DARFixup too.

Same here, not a problem

I did notice a bug that has been there a long time so
I don't think it is the problem:
+       add     r10, r10, r25   ;b      151f
+       add     r10, r10, r25   ;b      151f
should be r26 instead:
+       add     r10, r10, r25   ;b      151f
+       add     r10, r10, r26   ;b      151f

 Jocke
