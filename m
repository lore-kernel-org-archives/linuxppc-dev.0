Return-Path: <perex@suse.cz>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by ozlabs.org (Postfix) with ESMTP id 95EA2679E2
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 16:41:50 +1000 (EST)
Date: Wed, 17 May 2006 08:41:47 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Alsa-devel] [RFC] alsa integer control ranges
In-Reply-To: <1147817058.6753.7.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0605170836470.10248@tm8103.perex-int.cz>
References: <1147780945.29795.110.camel@johannes>
	<Pine.LNX.4.61.0605161430220.9330@tm8103.perex-int.cz>
	<1147817058.6753.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	ALSA development <alsa-devel@alsa-project.org>,
	Benjamin Berg <benjamin@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 17 May 2006, Benjamin Herrenschmidt wrote:

> On Tue, 2006-05-16 at 14:31 +0200, Jaroslav Kysela wrote:
> > On Tue, 16 May 2006, Johannes Berg wrote:
> > 
> > > Apparently all alsa userspace programs including alsamixer suck. Hence,
> > > this patch is required to make them work properly. Why is it so hard to
> > > do these additions/subtractions in the program or maybe even in the alsa
> > > library? The alsa libraries already think they know better and mess up
> > > all kinds of things.
> > 
> > It's better to fix apps, if they are broken.
> 
> Problem is, they are currently all broken (pretty much) and thus unless
> we want to release a driver that won't work with any current distros,
> we'll have to whack the ranges :(

It's better to have problematic values by default and define a module 
(driver) option to enable the "compatible" behaviour. Otherwise the apps 
will be never fixed. Also, ideally, you can fix apps and send patches to 
authors and/or create problematic controls in the dummy driver 
(drivers/dummy.c) and send a notice to app developers that they have 
broken apps and ask to fix them refering to the dummy driver test case.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
