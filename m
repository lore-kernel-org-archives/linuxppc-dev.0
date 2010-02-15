Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CE015B7C67
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2010 08:05:05 +1100 (EST)
Subject: Re: register long sp asm("r1") incorrect
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20100215202854.GA21601@elf.ucw.cz>
References: <20100209152444.GA30176@atrey.karlin.mff.cuni.cz>
	<1265866273.16346.34.camel@pasglop>
	<20100215073405.GB20456@atrey.karlin.mff.cuni.cz>
	<1266263992.16346.125.camel@pasglop>
	<20100215202854.GA21601@elf.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 16 Feb 2010 08:04:58 +1100
Message-ID: <1266267898.16346.135.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-02-15 at 21:28 +0100, Pavel Machek wrote:
> On Tue 2010-02-16 06:59:52, Benjamin Herrenschmidt wrote:
> > On Mon, 2010-02-15 at 08:34 +0100, Pavel Machek wrote:
> > > > On Tue, 2010-02-09 at 16:24 +0100, Pavel Machek wrote:
> > > > > ...according to gcc docs, sp should be global, or placement in
> > > > > register is not guaranteed (except at asm boundaries, but there
> > > are
> > > > > none).
> > > > 
> > > > Sorry I'm not sure I grok what you mean.
> > > 
> > > Well, according to gcc doscs and my experience, local "register int
> > > __asm()" variables only work by accident (or not at all). 
> > 
> > Hrm... we definitely rely on that for our thread_info() access, and so
> > far it has worked well for us, but I'll poke our gcc folks just in case.
> 
> Thanks, and let me know about any results.

All the gcc folks I talked to say something along the lines that there
is no way in hell it doesn't work :-)

It's true that most other use of it we have are global scope (local_paca
in r13, glibc use of r2/r13, etc...) afaik, but since r1 itself is the
stack pointer always, I think they pretty much guarantee it works.

I'm CCing a couple of experts just to be sure.

Cheers,
Ben.
