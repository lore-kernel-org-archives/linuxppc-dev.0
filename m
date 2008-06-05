Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 9D284DDE23
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 16:28:38 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Date: Thu, 5 Jun 2008 08:22:00 +0200
References: <200806041706.21557.sr@denx.de>
	<20080604220555.658ab13e@vader.jdub.homelinux.org>
	<20080604231641.786bb2dd@lappy.seanm.ca>
In-Reply-To: <20080604231641.786bb2dd@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806050822.00797.sr@denx.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Jean Delvare <khali@linux-fr.org>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 05 June 2008, Sean MacLennan wrote:
> On Wed, 4 Jun 2008 22:05:55 -0500
>
> Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> > I'm not proposing we remove that.  I'm just proposing that it can be
> > derived from something other than an "index" property.  Fill it in
> > using a static integer that gets incremented for each new device
> > found.  It's not like we have an indeterminate probe order, or these
> > IIC macros can be hot-plugged.
>
> That's how it used to work by default. It was decided to drop that and
> enforce an index. The following is a quote from Jean Delvare from a

I added Jean to CC now.

> post from 8/2/16 4:31:
> > I don't like this static index thing much. Can't you just make the
> > "index" OF property mandatory? Mixing ways to number things can become
> > very confusing. In particular as you are using dev->idx later to call
> > i2c_add_numbered_adapter(), the caller is really supposed to know what
> > they are doing with the bus numbers.
>
> Maybe it is time to remove the index, or maybe we should go back to
> using both a static and the index. But at the time we decided to enforce
> an index.

So what should we do now? Currently I2C doesn't work at all on 4xx since the 
driver expects the "index" property and no dts sets this property. Personally 
I would like to move to using cell-index here, since this seems to be more 
common. But I could also life with removing the index property and using 
the "static index" if this is preferred and/or acceptable.

Please advise. Thanks.

Best regards,
Stefan
