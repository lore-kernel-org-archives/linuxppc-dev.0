Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 97E24DDEF2
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 11:53:22 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBB0qcKN011901
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 19:52:38 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBB0rI1U190880
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 19:53:18 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBB1rSXw031142
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 20:53:28 -0500
Date: Wed, 10 Dec 2008 19:53:13 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [PATCH] Introduce ppc_pci_flags accessors
Message-ID: <20081210195313.4014ca85@zod.rchland.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0812101613140.28806@t2.domain.actdsltmp>
References: <20081210191148.GA1769@yoda.jdub.homelinux.org>
	<1228952788.7999.0.camel@localhost>
	<20081210185446.13e33cb2@zod.rchland.ibm.com>
	<Pine.LNX.4.64.0812101613140.28806@t2.domain.actdsltmp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 10 Dec 2008 16:17:13 -0800 (PST)
Trent Piepho <tpiepho@freescale.com> wrote:

> On Wed, 10 Dec 2008, Josh Boyer wrote:
> > On Thu, 11 Dec 2008 10:46:28 +1100
> >>> +#ifdef CONFIG_PCI
> >>> +extern unsigned int ppc_pci_flags;
> >>> +#define ppc_pci_set_flags(flags) ppc_pci_flags = (flags)
> >>> +#define ppc_pci_add_flags(flags) ppc_pci_flags |= (flags)
> >>> +#define ppc_pci_flag_is_set(flag) (ppc_pci_flags & (flag))
> >>> +#else
> >>> +#define ppc_pci_set_flags(flags) do {} while (0)
> >>> +#define ppc_pci_add_flags(flags) do {} while (0)
> >>> +#define ppc_pci_flag_is_set(flag) (0)
> >>> +#endif
> >>
> >> I hate to be picky, but I don't see any reason why these shouldn't be
> >> static inlines.
> >
> > There's a perfectly good reason.  I AM LAZY.
> >
> > That aside, it doesn't matter to me either way.  If the general idea
> > seems fine and the naming of the functions is acceptable, I'd be happy
> > to respin.
> 
> If were allowed to be picky, I think ppc_pci_has_flag() is a better name
> than ppc_pci_flag_is_set().  Matches the other function names better, and a
> quick grep of the kernel source shows bar_has_foo() is much more common
> than bar_foo_is_set().

That's fine too.  I think you can Michael can have a virtual
arm-wrestling match to decide whether ppc_pci_has_flag or
ppc_pci_flags_are_set wins ;)

josh
