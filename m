Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3781E1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Mar 2011 14:37:36 +1100 (EST)
Subject: Re: [PATCH V2 1/6] powerpc: Move udbg_early_init() after
	early_init_devtree()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20110207082934.GA28943@yookeroo>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1296586126-32765-2-git-send-email-shaggy@linux.vnet.ibm.com>
	<20110202230643.GF3032@yookeroo>
	<1296691225.12290.112.camel@shaggy-w500>
	<20110207082934.GA28943@yookeroo>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Mar 2011 14:37:17 +1100
Message-ID: <1299037037.8833.821.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-02-07 at 19:29 +1100, David Gibson wrote:
> On Wed, Feb 02, 2011 at 06:00:25PM -0600, Dave Kleikamp wrote:
> > On Thu, 2011-02-03 at 10:06 +1100, David Gibson wrote:
> > > On Tue, Feb 01, 2011 at 12:48:41PM -0600, Dave Kleikamp wrote:
> > > > so that it can use information from the device tree.
> > > 
> > > Hrm.  On the other hand this means that the early_init_devtree() code
> > > can't benefit from hardcoded early debugging.  Since you don't
> > > actually appear to use devtree information in udbg_early_init() in the
> > > latest series, I'd suggest dropping this patch.
> > 
> > Patch 2 depends on early_init_devtree() being run.  Until then, I don't
> > know of a way to get at the bootargs.
> 
> Ah, yes.  Drat.

Doesn't matter. _Early_ debug has (or should have) the address in
the .config file anyways, so it really shouldn't have to care about the
arguments.

So I'll drop this patch.

There are plenty of reasons why we want to be able to use the early
debug stuff to debug what's happening inside early_init_devtree() :-)

Cheers,
Ben.
