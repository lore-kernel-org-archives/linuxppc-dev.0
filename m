Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 42ACADDF90
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 17:49:30 +1000 (EST)
Date: Thu, 5 Jun 2008 09:48:52 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Stefan Roese <sr@denx.de>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080605094852.164f0bc7@hyperion.delvare>
In-Reply-To: <200806050822.00797.sr@denx.de>
References: <200806041706.21557.sr@denx.de>
	<20080604220555.658ab13e@vader.jdub.homelinux.org>
	<20080604231641.786bb2dd@lappy.seanm.ca>
	<200806050822.00797.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 5 Jun 2008 08:22:00 +0200, Stefan Roese wrote:
> On Thursday 05 June 2008, Sean MacLennan wrote:
> > On Wed, 4 Jun 2008 22:05:55 -0500
> >
> > Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> > > I'm not proposing we remove that.  I'm just proposing that it can be
> > > derived from something other than an "index" property.  Fill it in
> > > using a static integer that gets incremented for each new device
> > > found.  It's not like we have an indeterminate probe order, or these
> > > IIC macros can be hot-plugged.
> >
> > That's how it used to work by default. It was decided to drop that and
> > enforce an index. The following is a quote from Jean Delvare from a
> 
> I added Jean to CC now.
> 
> > post from 8/2/16 4:31:
> > > I don't like this static index thing much. Can't you just make the
> > > "index" OF property mandatory? Mixing ways to number things can become
> > > very confusing. In particular as you are using dev->idx later to call
> > > i2c_add_numbered_adapter(), the caller is really supposed to know what
> > > they are doing with the bus numbers.
> >
> > Maybe it is time to remove the index, or maybe we should go back to
> > using both a static and the index. But at the time we decided to enforce
> > an index.
> 
> So what should we do now? Currently I2C doesn't work at all on 4xx since the 
> driver expects the "index" property and no dts sets this property. Personally 
> I would like to move to using cell-index here, since this seems to be more 
> common. But I could also life with removing the index property and using 
> the "static index" if this is preferred and/or acceptable.
> 
> Please advise. Thanks.

As far as I am concerned, it's really up to the maintainers and users
of this platform. All I am asking for is that you do not call
i2c_add_numbered_adapter() on an adapter with an automatically
generated number. This function must only be used for adapter's those
number is well defined. If an adapter doesn't have a well-defined
number then use i2c_add_adapter() (but then you can no longer declare
your I2C devices as part of the platform data.)

Thanks,
-- 
Jean Delvare
