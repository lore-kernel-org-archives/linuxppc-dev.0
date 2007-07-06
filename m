Return-Path: <>
Received: from asclepius.site5.com (asclepius.site5.com [70.47.36.37])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B3D0DDF6E
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 19:39:22 +1000 (EST)
Date: Fri, 6 Jul 2007 05:16:34 -0400
From: Sonny Rao <sonny@burdell.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] pseries: don't die if unknown/missing interrupt
	controller property
Message-ID: <20070706091634.GA19238@kevlar.boston.burdell.org>
References: <20070702004937.GA15712@kevlar.boston.burdell.org>
	<20070705133734.GA9215@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070705133734.GA9215@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 05, 2007 at 08:37:34AM -0500, Olof Johansson wrote:
> On Sun, Jul 01, 2007 at 08:49:37PM -0400, Sonny Rao wrote:
> > The pseries platform does not have a default function for init_IRQ and
> > does not install one if it doesn't find or doesn't recognize an
> > interrupt controller in the device tree.  Currently, the kernel dies
> > when it tries to call the NULL init_IRQ() function.  Clean that up.
> 
> Doesn't it make more sense to make init_IRQ() check that the pointer is
> set instead? That'll work for more platforms than just pseries.

Yeah, that might be the simplest way.  The only reason I can think of
to do it this way is that (I think) every single other platform in
arch/powerpc statically initializes init_IRQ, with pseries being the
oddball.  It doesn't matter much to me, so I can post another patch in a
bit.

Sonny
