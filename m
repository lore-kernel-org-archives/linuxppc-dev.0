Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 4BA0767A71
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Feb 2005 09:43:08 +1100 (EST)
Date: Sun, 6 Feb 2005 15:43:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Message-ID: <20050206224306.GG7686@smtp.west.cox.net>
References: <20050206165428.GA7686@smtp.west.cox.net>
	<20050206165629.GA18769@suse.de>
	<20050206172431.GB7686@smtp.west.cox.net>
	<20050206172552.GC19327@suse.de>
	<20050206200431.GC7686@smtp.west.cox.net>
	<20050206200802.GA28652@suse.de>
	<20050206202154.GD7686@smtp.west.cox.net>
	<20050206211506.GA31123@suse.de>
	<20050206214951.GE7686@smtp.west.cox.net>
	<20050206215600.GA2062@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050206215600.GA2062@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] remove .tmp_gas_check
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Feb 06, 2005 at 10:56:00PM +0100, Olaf Hering wrote:
>  On Sun, Feb 06, Tom Rini wrote:
> 
> > On Sun, Feb 06, 2005 at 10:15:06PM +0100, Olaf Hering wrote:
> > 
> > >  On Sun, Feb 06, Tom Rini wrote:
> > > 
> > > > I agree you shouldn't have to see it.  I'm saying the problem is the
> > > > variable shouldn't be evaluated.
> > > 
> > > This patch seems to work for me.
> > 
> > What I don't like is that checkbin shouldn't be evaluated for 'tags' or
> > other non-compile targets, so you don't need those explicit rm's.  Also,
> > you forgot the signed-off-by line :)
> 
> Why should make tags or oldconfig ever care about the installed toolchain?

It shouldn't, and 'tags' at least shouldn't depend on 'checkbin'
(oldconfig I _believe_ actually invokes HOSTCC and creates other .tmp
files, but I don't have a tree handy).

> How should the tmpfile disappear if one calls make checkbin with success?

On make clean, like the other .tmp files that are around at the end of a
kernel compile (kallsyms/modules/maybe something else).

> Maybe I misunderstood you.

I think so.  We both agree there should be no ppc-specific .tmp files
around after certain make targets.  I'm saying that there's always some
.tmp files generated on every arch for certain targets, and removed with
a clean.  PPC should only create .tmp files (And leave them alone) in
the cases where every arch generates some .tmp files.

-- 
Tom Rini
http://gate.crashing.org/~trini/
