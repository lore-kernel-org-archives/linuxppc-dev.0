Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 38CE9B7BA9
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 08:08:15 +1100 (EST)
In-Reply-To: <20091005200941.GD3576@loki.buserror.net>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091005181233.GA3576@loki.buserror.net>
	<OF44D5E829.2889B774-ONC1257646.00645628-C1257646.006568EE@transmode.se>
	<20091005200941.GD3576@loki.buserror.net>
Subject: Re: [PATCH 0/6] PowerPc 8xx TLB/MMU fixes
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OFFC147C60.2DA4B63D-ONC1257646.00733843-C1257646.0073CFFD@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 5 Oct 2009 23:04:58 +0200
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

Scott Wood <scottwood@freescale.com> wrote on 05/10/2009 22:09:41:
>
> On Mon, Oct 05, 2009 at 08:27:39PM +0200, Joakim Tjernlund wrote:
> > > After resolving the conflict, without adding tlbil_va in do_page_fault(), I
> > > get the same stuck behavior as before.
> >
> > Expected, I havn't not tried to fix the missing tlbil_va(). That is
> > different problem that you and Ben needs to sort out.
>
> Right, I just wanted to be clear about which results were from which
> modifications.
>
> > >  With tlbil_va, I get this (not sure
> > > if it's related to using the wrong base tree):
> >
> > Could be the debug code doing something bad or the
> > "Fixup DAR from buggy dcbX instructions". Could you back that one out?
>
> That gets rid of the segfaults.  The bootup gets stuck running udev, though
> -- the system is either idle, or it's stuck doing some syscall.

Ok, that just means that my asm version of fixing up dcbX insn does not work.

>
> I see it sometimes (but less reliably) without this patchset, so it may just
> be changing the circumstances to expose the issue more consistently.  Or
> maybe I'm seeing the dcbX bug?  There do seem to be dcbX instructions in the
> dynamic linker I'm using (including a disturbing section that appears to be
> assuming 32 byte cache lines, even though this is supposed to be an 8xx
> RFS).

Yes, every ld.so uses dcbX and icbi insn when relocatin code.
Maybe you see some version of the dcbX bug, but my fault.c should
fix them up. My bet would be the 32 byte cache line, it will miss
out every second line and so the results are unreliable.

>
> I'll look into it.
>
> > and if that does not help, backout:
> > "start using dcbX instructions in various copy routines" too.
>
> No difference.

Good, it seems possible to uses the dcbX insn now. I will
have to fixup fault a bit more though.
