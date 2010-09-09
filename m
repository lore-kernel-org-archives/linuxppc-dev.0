Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id C6C67B70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 05:36:44 +1000 (EST)
Date: Thu, 9 Sep 2010 12:36:42 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Timur Tabi <timur@freescale.com>
Subject: Re: CONFIG_PROVE_LOCKING broken on 83xx (and all of powerpc?)
Message-ID: <20100909193642.GD3496@ovro.caltech.edu>
References: <20100908232124.GB30291@ovro.caltech.edu>
	<1283994156.6515.6.camel@pasglop>
	<20100909025214.GA21846@ovro.caltech.edu>
	<1284001096.6515.33.camel@pasglop>
	<20100909162306.GA3496@ovro.caltech.edu>
	<20100909184446.GB3496@ovro.caltech.edu>
	<AANLkTinFu+dttvBA2qyXFxQGOTRpmWeuvmHj40BFKNCm@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTinFu+dttvBA2qyXFxQGOTRpmWeuvmHj40BFKNCm@mail.gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 09, 2010 at 02:10:59PM -0500, Timur Tabi wrote:
> On Thu, Sep 9, 2010 at 1:44 PM, Ira W. Snyder <iws@ovro.caltech.edu> wrote:
> 
> > Single stepping through the initial assembly portion of kernel startup
> > shows that the FDT gets clobbered during the function early_init(). This
> > trace is reproduced below.
> 
> Have you tried also enabling CONFIG_DEBUG_LOCK_ALLOC?  These two
> config options are related.
> 

Yes, I have had it enabled the whole time.

As noted in another email, it appears that U-Boot puts the FDT in such a
place that Linux overwrites it with the BSS. The CONFIG_PROVE_LOCKING=y
option expands the BSS by a large amount, which causes the error. It
isn't directly lockdep related.

I don't know if this is a U-Boot problem or a Linux problem. I have no
idea how to fix the bug.

Thanks,
Ira
