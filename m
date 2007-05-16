Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id BB592DDEE7
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 14:04:52 +1000 (EST)
Date: Tue, 15 May 2007 23:08:00 -0500
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] iseries: fix CONFIG_VIOCONS/CONFIG_VT dependency
Message-ID: <20070516040800.GA17199@lixom.net>
References: <20070515190343.GA13203@lixom.net>
	<1179286919.4120.39.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1179286919.4120.39.camel@concordia.ozlabs.ibm.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 16, 2007 at 01:41:59PM +1000, Michael Ellerman wrote:
> On Tue, 2007-05-15 at 14:03 -0500, Olof Johansson wrote:
> > VT already depends on !VIOCONS, but there's no restriction in the other
> > direction. This makes an allyesconfig not build.
> > 
> > Switch to a Kconfig dependency instead of a compile-time error.
> > 
> > 
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > 
> > diff --git a/arch/powerpc/platforms/iseries/Kconfig b/arch/powerpc/platforms/iseries/Kconfig
> > index 46c3a8e..e48f018 100644
> > --- a/arch/powerpc/platforms/iseries/Kconfig
> > +++ b/arch/powerpc/platforms/iseries/Kconfig
> > @@ -8,6 +8,7 @@ menu "iSeries device drivers"
> >  
> >  config VIOCONS
> >  	tristate "iSeries Virtual Console Support (Obsolete)"
> > +	depends on !VT
> >  	help
> 
> This context doesn't match linus' or the powerpc tree, I see:
> 
> config VIOCONS
>         bool "iSeries Virtual Console Support (Obsolete)"
>         depends on !HVC_ISERIES
>         default n
>         help

Boggle, I thought I did the checks in paulus' tree. It must have been
in my 2.6.21 one instead. :(

So nevermind, the above is obviously enough.


-Olof
