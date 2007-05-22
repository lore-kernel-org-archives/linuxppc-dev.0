Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BED7DDDE47
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 19:16:38 +1000 (EST)
Subject: Re: [PATCH 07/13] Implement arch disable/enable irq hooks.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1179824589.3673.1.camel@johannes.berg>
References: <20070507182950.GF26920@ld0162-tx32.am.freescale.net>
	<1179762902.9122.19.camel@johannes.berg>
	<1179818066.32247.812.camel@localhost.localdomain>
	<1179824589.3673.1.camel@johannes.berg>
Content-Type: text/plain
Date: Tue, 22 May 2007 19:15:34 +1000
Message-Id: <1179825335.32247.829.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-22 at 11:03 +0200, Johannes Berg wrote:
> On Tue, 2007-05-22 at 17:14 +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2007-05-21 at 17:55 +0200, Johannes Berg wrote:
> > > 
> > > Then again, if we don't implement these in common code, might we get
> > > link problems when we try building some multiplatform kernel?
> > 
> > That's what ppc_md is for :-)
> 
> So you're saying we should globally implement
> arch_suspend_irq_{enable,disable} and then call some ppc_md hook? Sounds
> good to me as well, I'd like to ask for a revision of this patch
> including that, then I'll update my patches for that.

Yup.

Global version calls into the ppc_md hooks and possibly provide a
useable default if no hook is there (Scott's implementation looks like a
reasonably good default).

Ben.
