Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CF9D0B7BD9
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Sep 2009 23:24:46 +1000 (EST)
In-Reply-To: <20090925211848.GA3371@compile2.chatsunix.int.mrv.com>
References: <20090924004552.GA11737@compile2.chatsunix.int.mrv.com>	<1253774659.7103.405.camel@pasglop>
	<20090924233346.GA445@compile2.chatsunix.int.mrv.com>	<1253836376.7103.469.camel@pasglop>
	<20090925013528.GA2584@compile2.chatsunix.int.mrv.com>	<1253843480.7103.492.camel@pasglop>
	<1253847827.7103.504.camel@pasglop>
	<20090925211848.GA3371@compile2.chatsunix.int.mrv.com>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache	coherency
	rewrite
To: Rex Feany <RFeany@mrv.com>
Message-ID: <OFEC38184A.A376E71D-ONC125763E.0048F581-C125763E.00497FD3@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sun, 27 Sep 2009 15:22:48 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> Thus spake Benjamin Herrenschmidt (benh@kernel.crashing.org):
>
> >
> > > I think there's more finishyness to 8xx than we thought. IE. That
> > > tlbil_va might have more reasons to be there than what the comment
> > > seems to advertize. Can you try to move it even higher up ? IE.
> > > Unconditionally at the beginning of set_pte_filter ?
> > >
> > > Also, if that doesn't help, can you try putting one in
> > > set_access_flags_filter() just below ?
> >
> > Ok, I got a refresher on the whole concept of "unpopulated TLB entries"
> > on 8xx, and that's damn scary. I think what mislead me initially is that
> > the comment around the workaround is simply not properly describing the
> > extent of the problem :-)
>
> Oh boy, that sounds bad. Where is a good place to read about this?
>
> > So I'm not going to make the 8xx TLB miss code sane, that's beyond what
> > I'm prepare to do with it, but I suspect that this should fix it (on top
> > of upstream). Let me know if that's enough or if we also need to put
> > one of these in ptep_set_access_flags().
> >
> > Please let me know if that works for you.
>
> Putting the tlbil_va() in the top of set_pte_filter() doesn't work - it
> hangs on boot before it even prints any messages to the console.
>
> However, adding tlbil_va() to ptep_set_access_flags() as you suggested
> makes everything happy. I need to test it some more, but it looks good
> so far. Below is what I am testing now.

8xx, is getting very hacky and I suspect that the only long term fix is
add code to trap the cache instructions in TLB error/miss and fixup the
exception in page fault handler. This will also have the added benefit on being able
to use the cache instructions in both kernel and user space like any other
ppc arch.

   Jocke
