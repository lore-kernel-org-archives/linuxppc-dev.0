Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 145042C007E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Aug 2013 20:53:52 +1000 (EST)
Message-ID: <1375699987.12557.46.camel@pasglop>
Subject: Re: therm_pm72 units, interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Mon, 05 Aug 2013 20:53:07 +1000
In-Reply-To: <1375698760.3852.152.camel@thor.local>
References: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
 <1345066616.11751.2.camel@pasglop>
 <alpine.LNX.2.01.1301142240140.30171@nerf07.vanv.qr>
 <1358465885.2782.24.camel@pasglop>
 <20130719174300.GL14385@blackmetal.musicnaut.iki.fi>
 <1374275809.19894.562.camel@pasglop>
 <20130720203346.GM14385@blackmetal.musicnaut.iki.fi>
 <1375437816.3852.12.camel@thor.local> <1375447861.15999.1.camel@pasglop>
 <1375454871.3852.27.camel@thor.local>
 <20130802155818.GB29933@blackmetal.musicnaut.iki.fi>
 <1375462346.3852.42.camel@thor.local> <1375477360.15999.19.camel@pasglop>
 <1375693993.3852.143.camel@thor.local> <1375694554.12557.40.camel@pasglop>
 <1375698760.3852.152.camel@thor.local>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Ben Hutchings <ben@decadent.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-08-05 at 12:32 +0200, Michel Dänzer wrote:
> 
> I did that, sorry should have mentioned that.
> 
> 
> > > @@ -468,5 +478,3 @@ static struct platform_driver
> i2c_powermac_driver
> > > =
> > > {
> > >  };
> > > 
> > >  module_platform_driver(i2c_powermac_driver);
> > > -
> > > -MODULE_ALIAS("platform:i2c-powermac");
> > 
> > Maybe add the module alias back ? It shouldn't be necessary...
> 
> Doesn't help.

Hrm, that might require some more involved debugging, figuring out
what's up with udev etc... that or maybe bisecting.

>From what I can tell, we do attach an OF node to the platform device,
but since the driver has no of match table, we should still fallback to
the old platform matching style.

I think I see... adding Grant.

Grant, something broke the auto-loading the of i2c-powermac module. It's
a platform device, but while it does have a populated "of_node, its
driver doesn't have an OF match table and relies on the old style
platform device matching.

That's broken with newer kernels, platform_uevent() calls
of_device_uevent_modalias() which sees the of_node and thus doesn't
return -ENOMEM, and we don't create a platform modalias anymore.

Is it legit to add several MODALIAS ? If yes we could add both ... if
not, we have a problem. Doing real OF matching with that critter is
tricky at best for various reasons but it needs the of_node because it
uses it to scan for children.

Any suggestion ?

Cheers,
Ben.
