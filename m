Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BA976B7120
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 08:01:14 +1000 (EST)
Subject: Re: CONFIG_PROVE_LOCKING broken on 83xx (and all of powerpc?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
In-Reply-To: <20100909193642.GD3496@ovro.caltech.edu>
References: <20100908232124.GB30291@ovro.caltech.edu>
	<1283994156.6515.6.camel@pasglop>
	<20100909025214.GA21846@ovro.caltech.edu>
	<1284001096.6515.33.camel@pasglop>
	<20100909162306.GA3496@ovro.caltech.edu>
	<20100909184446.GB3496@ovro.caltech.edu>
	<AANLkTinFu+dttvBA2qyXFxQGOTRpmWeuvmHj40BFKNCm@mail.gmail.com>
	<20100909193642.GD3496@ovro.caltech.edu>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 10 Sep 2010 08:01:01 +1000
Message-ID: <1284069661.6515.37.camel@pasglop>
Mime-Version: 1.0
Cc: peterz@infradead.org, mingo@redhat.com, linuxppc-dev@lists.ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-09-09 at 12:36 -0700, Ira W. Snyder wrote:
> On Thu, Sep 09, 2010 at 02:10:59PM -0500, Timur Tabi wrote:
> > On Thu, Sep 9, 2010 at 1:44 PM, Ira W. Snyder <iws@ovro.caltech.edu> wrote:
> > 
> > > Single stepping through the initial assembly portion of kernel startup
> > > shows that the FDT gets clobbered during the function early_init(). This
> > > trace is reproduced below.
> > 
> > Have you tried also enabling CONFIG_DEBUG_LOCK_ALLOC?  These two
> > config options are related.
> > 
> 
> Yes, I have had it enabled the whole time.
> 
> As noted in another email, it appears that U-Boot puts the FDT in such a
> place that Linux overwrites it with the BSS. The CONFIG_PROVE_LOCKING=y
> option expands the BSS by a large amount, which causes the error. It
> isn't directly lockdep related.
> 
> I don't know if this is a U-Boot problem or a Linux problem. I have no
> idea how to fix the bug.

Definitely a u-boot problem. There must be a way to set where the fdt
goes somewhere.

Cheers,
Ben.
