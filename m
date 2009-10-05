Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 592F1B7B91
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Oct 2009 10:03:35 +1100 (EST)
In-Reply-To: <1254782248.7122.49.camel@pasglop>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<20091005220420.GA27923@compile2.chatsunix.int.mrv.com>
	<OF9AD6CA21.DCD59A1B-ONC1257646.007AE622-C1257646.007BB767@transmode.se>
	<1254782248.7122.49.camel@pasglop>
Subject: Re: [PATCH 0/6] PowerPc 8xx TLB/MMU fixes
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF1D89EEC1.4934A6F8-ONC1257646.007E061D-C1257646.007E3BF1@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 6 Oct 2009 00:58:48 +0200
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 06/10/2009 00:37:28:
>
> On Tue, 2009-10-06 at 00:31 +0200, Joakim Tjernlund wrote:
> >
> > regs or regs->nip is NULL? Either one does not make sense
> > In any case it might be a secondary problem as DAR is NULL already
> > when you
> > enter the page fault.
> > >
> > >                 insn = *((unsigned long *)regs->nip);
> > > c000e110:       80 a9 00 00     lwz     r5,0(r9)
> > >
> > > fails.
> >
> > hmm, I wonder if you managed to invalidate the a kernel TLB?
> > Are you using pinned kernel TLBs?
>
> You should not dereference a user address like that. Use get_user !

Ah, forgot about that. Will change

>
> Obviously you got 0 in SRR0 for some reason (somebody tried to jump
> to 0, either intentionally or as a result of some other problem) and
> the above will crash the kernel when it happens.
>
> Cheers,
> Ben.
>
>
>
