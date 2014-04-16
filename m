Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0188.outbound.protection.outlook.com [207.46.163.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 536B41400A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Apr 2014 05:36:45 +1000 (EST)
Message-ID: <1397676986.28539.10.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 1/2] fsl/corenet_generic: add a particular
 initialization for platform
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <Dongsheng.Wang@freescale.com>
Date: Wed, 16 Apr 2014 14:36:26 -0500
In-Reply-To: <77e2c53b2f154faba68c8b7ac760accc@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1397541229-34383-1-git-send-email-dongsheng.wang@freescale.com>
 <1397590755.20280.250.camel@snotra.buserror.net>
 <77e2c53b2f154faba68c8b7ac760accc@BN1PR03MB188.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "haokexin@gmail.com" <haokexin@gmail.com>,
 Kushwaha Prabhakar-B32579 <prabhakar@freescale.com>,
 Jin Zhengxiong-R64188 <Jason.Jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-04-15 at 21:58 -0500, Wang Dongsheng-B40534 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, April 16, 2014 3:39 AM
> > To: Wang Dongsheng-B40534
> > Cc: Jin Zhengxiong-R64188; haokexin@gmail.com; Kushwaha Prabhakar-B32579;
> > linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH v2 1/2] fsl/corenet_generic: add a particular initialization
> > for platform
> > 
> > On Tue, 2014-04-15 at 13:53 +0800, Dongsheng Wang wrote:
> > > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > >
> > > Corenet_generic is a generic platform initialization. Those based on
> > > the corenet_generic board maybe need a particular initialize to
> > > enable/set some IP-Blocks. So add "Fix Generic Initialization" to solve
> > > this kind of special cases.
> > 
> > I still don't understand what you mean by "fix".  What are you fixing,
> > or what is fixed?
> > 
> > There is no need for adding an infrastructure layer here.  Just add a
> > new piece of code for t104x diu, and have it be called by an appropriate
> > initfunc.
> > 
> 
> "fix" is means to handle some boards those based on corenet_generic config file,
> But those boards may need some special handle. Perhaps these used to handle
> special feature codes not have an appropriate initfunc we cannot *just find*
> an appropriate place,

I'm not asking you to "just find" anything.  I'm asking you to add an
initfunc in a standalone file.

> if more and more boards need to do this, at that time maybe *initfunc*
> looks very complicated.

They would each have their own initfunc.  There is no reason to tie this
in with anything else.

> > > --- a/arch/powerpc/platforms/85xx/Kconfig
> > > +++ b/arch/powerpc/platforms/85xx/Kconfig
> > > @@ -269,6 +269,17 @@ config CORENET_GENERIC
> > >  	  The following boards are supported for both 32bit and 64bit kernel:
> > >  	    P5020 DS and P5040 DS
> > >
> > > +config FIX_GENERIC_PLATFORM_INIT
> > > +	bool "Fix Generic Initialization"
> > > +	depends on CORENET_GENERIC
> > 
> > Why does this depend on CORENET_GENERIC?
> > 
> 
> Because CORENET_GENERIC is a multiboards file, This is designed to handle this situation.

This DIU code is going to be just as applicable to a custom T104x board
which may or may not use CORENET_GENERIC.

> > > +	default y
> > 
> > No.
> > 
> 
> Why not? This will not increase any redundant operations if there is not any boards need fix.
> You can see my fix.c code.

default y should not be used for hardware specific code.

-Scott
