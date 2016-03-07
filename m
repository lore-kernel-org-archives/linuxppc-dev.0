Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C19A31A01EB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 10:20:22 +1100 (AEDT)
Message-ID: <1457392822.25457.4.camel@ellerman.id.au>
Subject: Re: How to merge? (was Re: [PATCH][v4] livepatch/ppc: Enable
 livepatching on powerpc)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jiri Kosina <jikos@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, linuxppc-dev@ozlabs.org,
 jeyu@redhat.com,  linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com,  duwe@lst.de, live-patching@vger.kernel.org,
 mbenes@suse.cz, Torsten Duwe <duwe@suse.de>, vojtech@suse.com,
 jpoimboe@redhat.com, sjenning@redhat.com
Date: Tue, 08 Mar 2016 10:20:22 +1100
In-Reply-To: <alpine.LNX.2.00.1603072348280.3656@cbobk.fhfr.pm>
References: <1457023921-2051-1-git-send-email-pmladek@suse.com>
 <1457078800.20076.4.camel@ellerman.id.au>
 <alpine.LNX.2.00.1603040952330.3656@cbobk.fhfr.pm>
 <1457345161.18915.3.camel@ellerman.id.au>
 <alpine.LNX.2.00.1603072348280.3656@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-03-07 at 23:52 +0100, Jiri Kosina wrote:
> On Mon, 7 Mar 2016, Michael Ellerman wrote:
>
> > > This aligns with my usual workflow, so that'd be my preferred way of doing
> > > things; i.e. you put all the ftrace changes into a separate topic branch,
> > > and then
> > >
> > > - you pull that branch into powerpc#next
> > > - I pull that branch into livepatching tree
> > > - I apply the ppc livepatching support on top of that
> > > - I send a pull request to Linus only after powerpc#next gets merged to
> > >   Linus' tree
> > >
> > > Sounds good?
> >
> > Yep, here it is:
> >
> >   https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/log/?h=topic/mprofile-kernel
> >
> > aka:
> >
> >   git fetch git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git topic/mprofile-kernel
>
> Excellent, thanks.
>
> > I haven't merged it into my next yet, but I will tomorrow unless you tell me
> > there's something wrong with it.
>
> There is one remaining issue which I think would be really nice to
> have(TM), and that's Steven's Ack for the whole thing :)

Yeah. He's been on CC the whole time, but he's probably getting a bit sick of
it all, as we're up to about version 15. So I figure if he really hated it he'd
have said so by now :) - but an Ack would still be good.

> For the livepatching part, I don't think we are quite there yet (so maybe
> it'll miss the upcoming merge window anyway).
>
> My primary worry there is what Torsten pointed out, i.e. functions with
> either varargs or more than 8 args needing special care.

Yeah true. My preference would be to merge it, but mark LIVEPATCH as
experimental on powerpc. I think having it in the tree would help it get more
testing, and probably find other bugs too. But it's up to you guys.

> Also, I'd like to have this positively reviewed by at least one more
> livepatching maintainer (I am currently looking into it myself, but my
> understanding of powerpc arch is rather low, so the more eyes, the
> better).

Sure. I can answer powerpc questions, though Torsten is probably the person who
has the best understanding of (livepatching && powerpc).

cheers
