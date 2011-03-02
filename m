Return-Path: <shaggy@kernel.org>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 333AA1007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Mar 2011 00:03:11 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p22Cubp6001187
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2011 05:56:37 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p22D32ex098498
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2011 06:03:02 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p22D32eV025779
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2011 06:03:02 -0700
Subject: Re: [PATCH V2 1/6] powerpc: Move udbg_early_init() after
	early_init_devtree()
From: Dave Kleikamp <shaggy@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1299037037.8833.821.camel@pasglop>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1296586126-32765-2-git-send-email-shaggy@linux.vnet.ibm.com>
	<20110202230643.GF3032@yookeroo>
	<1296691225.12290.112.camel@shaggy-w500>
	<20110207082934.GA28943@yookeroo> <1299037037.8833.821.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Wed, 02 Mar 2011 07:03:00 -0600
Message-ID: <1299070980.8367.8.camel@shaggy-w500>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-03-02 at 14:37 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2011-02-07 at 19:29 +1100, David Gibson wrote:
> > On Wed, Feb 02, 2011 at 06:00:25PM -0600, Dave Kleikamp wrote:
> > > On Thu, 2011-02-03 at 10:06 +1100, David Gibson wrote:
> > > > On Tue, Feb 01, 2011 at 12:48:41PM -0600, Dave Kleikamp wrote:
> > > > > so that it can use information from the device tree.
> > > > 
> > > > Hrm.  On the other hand this means that the early_init_devtree() code
> > > > can't benefit from hardcoded early debugging.  Since you don't
> > > > actually appear to use devtree information in udbg_early_init() in the
> > > > latest series, I'd suggest dropping this patch.
> > > 
> > > Patch 2 depends on early_init_devtree() being run.  Until then, I don't
> > > know of a way to get at the bootargs.
> > 
> > Ah, yes.  Drat.
> 
> Doesn't matter. _Early_ debug has (or should have) the address in
> the .config file anyways, so it really shouldn't have to care about the
> arguments.
> 
> So I'll drop this patch.
> 
> There are plenty of reasons why we want to be able to use the early
> debug stuff to debug what's happening inside early_init_devtree() :-)

Fair enough.  I wasn't sure this was the right thing to do.  It's either
turn off early debug for AMP, or build separate kernels with a different
address in .config.

Shaggy
