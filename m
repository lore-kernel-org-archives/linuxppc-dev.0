Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7BD7B7B78
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Sep 2009 08:40:43 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc/44x: Fix xmon single step on PowerPC 44x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090923223539.GJ14261@zod.rchland.ibm.com>
References: <20090923134844.GF14261@zod.rchland.ibm.com>
	<20090923135156.GH14261@zod.rchland.ibm.com>
	<1253741674.7103.327.camel@pasglop>
	<20090923223539.GJ14261@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Thu, 24 Sep 2009 08:40:36 +1000
Message-Id: <1253745636.7103.341.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-09-23 at 18:35 -0400, Josh Boyer wrote:

> >Any reason why that couldn't be in CONFIG_BOOKE ?
> 
> Off the top of my head, no.  I haven't tested on 40x yet though.  Will try
> and do that and revise.

Does 40x have CONFIG_BOOKE ? I was thinking more about FSL etc... but
yeah, 40x is worth having a look too.

> It could be.  I have no external debugger, thus no way to check it.  You don't
> get an exception without IDM set though, so it won't trap back into xmon like
> it should.  This is how we did it in arch/ppc (which isn't always a great
> thing) as well.

Ok, let's leave it there for now.

> I don't see how you could get it working without IDM, unless you inserted a
> trap (aka breakpoint) every time.  That seems sort of suboptimal when we have
> the IC event we can use.

The question is more whether IDM should be set once for all at boot (or
not) but let's ignore that for now.

Ben.
