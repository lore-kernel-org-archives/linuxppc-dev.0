Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (E23SMTP01.au.ibm.com [202.81.18.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 440F9DE071
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 13:30:39 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9C3UmYR029083
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 13:30:48 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9C3Ucmo4743284
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 13:30:38 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9C3Ub1i006672
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 13:30:38 +1000
Date: Fri, 12 Oct 2007 13:23:44 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4 v2] [POWERPC] Kilauea defconfig file
Message-ID: <20071012032344.GG21056@localhost.localdomain>
References: <200710111408.34207.sr@denx.de>
	<1192107771.5534.120.camel@localhost.localdomain>
	<200710111531.13022.sr@denx.de>
	<20071011201232.GD4247@loki.buserror.net>
	<1192137219.3061.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1192137219.3061.2.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 11, 2007 at 04:13:39PM -0500, Josh Boyer wrote:
> On Thu, 2007-10-11 at 15:12 -0500, Scott Wood wrote:
> > On Thu, Oct 11, 2007 at 03:31:12PM +0200, Stefan Roese wrote:
> > > Yes, good catch. Since I'm not using the bootwrapper, I should be able to get 
> > > rid of WANT_DEVICE_TREE too. But it seems to be autoselected in 
> > > arch/powerpc/platforms/Kconfig.cputype for 40x and most other "embedded" 
> > > CPU's. Any idea why this is the case?
> > 
> > Probably copying from 83xx, 85xx, etc, which set it on the entire CPU family
> > because there's a wrapper platform that covers the entire family.  AFAICT,
> > there are only board wrappers for 4xx, so individual boards should be
> > selecting WANT_DEVICE_TREE.
> 
> Probably.  Seems somewhat redundant at this point to move it into the
> individual board options though.
> 
> > In any case, you can just set DEVICE_TREE to an empty string if you only
> > want the regular uImage.
> 
> Well, he wants the raw uImage, and a separate DTB to be spit out as far
> as I can tell.  So we don't want an empty string here, but what's there
> currently doesn't do the latter part either.

I think it should be DEVICE_TREE="kilauea.dts".  DEVICE_TREE will
actually be ignored for building the uImage in any case, but this way
it will be correct if we ever do add a cuboot or other dtb-requiring
bootwrapper for Kilauea.

This is, of course, why CONFIG_DEVICE_TREE makes no real sense and
never has: it's a per-image, not a per-configuration variable.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
