Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0186.outbound.protection.outlook.com [207.46.163.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3A19214011D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Apr 2014 04:46:38 +1000 (EST)
Message-ID: <1398365188.7841.154.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 1/2] fsl/corenet_generic: add a particular
 initialization for platform
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <Dongsheng.Wang@freescale.com>
Date: Thu, 24 Apr 2014 13:46:28 -0500
In-Reply-To: <30c9d29df995426d9e01ffdf09fb1f33@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1397541229-34383-1-git-send-email-dongsheng.wang@freescale.com>
 <1397590755.20280.250.camel@snotra.buserror.net>
 <77e2c53b2f154faba68c8b7ac760accc@BN1PR03MB188.namprd03.prod.outlook.com>
 <1397676986.28539.10.camel@snotra.buserror.net>
 <30c9d29df995426d9e01ffdf09fb1f33@BN1PR03MB188.namprd03.prod.outlook.com>
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

On Thu, 2014-04-24 at 01:43 -0500, Wang Dongsheng-B40534 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, April 17, 2014 3:36 AM
> > To: Wang Dongsheng-B40534
> > Cc: Jin Zhengxiong-R64188; haokexin@gmail.com; Kushwaha Prabhakar-B32579;
> > linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH v2 1/2] fsl/corenet_generic: add a particular initialization
> > for platform
> > 
> > On Tue, 2014-04-15 at 21:58 -0500, Wang Dongsheng-B40534 wrote:
> > >
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Wednesday, April 16, 2014 3:39 AM
> > > > To: Wang Dongsheng-B40534
> > > > Cc: Jin Zhengxiong-R64188; haokexin@gmail.com; Kushwaha
> > > > Prabhakar-B32579; linuxppc-dev@lists.ozlabs.org
> > > > Subject: Re: [PATCH v2 1/2] fsl/corenet_generic: add a particular
> > > > initialization for platform
> > > >
> > > > On Tue, 2014-04-15 at 13:53 +0800, Dongsheng Wang wrote:
> > > > > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> > > > >
> > > > > Corenet_generic is a generic platform initialization. Those based
> > > > > on the corenet_generic board maybe need a particular initialize to
> > > > > enable/set some IP-Blocks. So add "Fix Generic Initialization" to
> > > > > solve this kind of special cases.
> > > >
> > > > I still don't understand what you mean by "fix".  What are you
> > > > fixing, or what is fixed?
> > > >
> > > > There is no need for adding an infrastructure layer here.  Just add
> > > > a new piece of code for t104x diu, and have it be called by an
> > > > appropriate initfunc.
> > > >
> > >
> > > "fix" is means to handle some boards those based on corenet_generic
> > > config file, But those boards may need some special handle. Perhaps
> > > these used to handle special feature codes not have an appropriate
> > > initfunc we cannot *just find* an appropriate place,
> > 
> > I'm not asking you to "just find" anything.  I'm asking you to add an initfunc
> > in a standalone file.
> > 
> > > if more and more boards need to do this, at that time maybe *initfunc*
> > > looks very complicated.
> > 
> > They would each have their own initfunc.  There is no reason to tie this in with
> > anything else.
> > 
> 
> Sorry, if those platforms are using corenet_generic, I don’t see any standalone file
> for initfunc of platform. That's why I'm adding "fix" layer.

It's totally unnecessary.

Just do this:

t104x_diu_init(void)
{
	if (t104x diu not in the device tree)
		return;

	...
}

early_initcall(t104x_diu_init);

> > > > > +config FIX_GENERIC_PLATFORM_INIT
> > > > > +	bool "Fix Generic Initialization"
> > > > > +	depends on CORENET_GENERIC
> > > >
> > > > Why does this depend on CORENET_GENERIC?
> > > >
> > >
> > > Because CORENET_GENERIC is a multiboards file, This is designed to handle this
> > situation.
> > 
> > This DIU code is going to be just as applicable to a custom T104x board which
> > may or may not use CORENET_GENERIC.
> > 
> 
> "fix" is a middle layer, it's not only for T104xrdb-DIU.

My point is a custom t104x board might not use CORENET_GENERIC.

> > > > > +	default y
> > > >
> > > > No.
> > > >
> > >
> > > Why not? This will not increase any redundant operations if there is not any
> > boards need fix.
> > > You can see my fix.c code.
> > 
> > default y should not be used for hardware specific code.
> > 
> 
> fix.c and hardware no relationship at all. :), It's just a software layer.

No relationship to hardware, yet it depends on CORENET_GENERIC, reads a
Freescale-specific SPR, and lives in arch/powerpc/platforms/85xx. :-)

-Scott
