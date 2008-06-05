Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 118E9DDFBB
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 18:45:54 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Date: Thu, 5 Jun 2008 10:45:42 +0200
References: <200806041706.21557.sr@denx.de> <200806050822.00797.sr@denx.de>
	<20080605094852.164f0bc7@hyperion.delvare>
In-Reply-To: <20080605094852.164f0bc7@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806051045.42966.sr@denx.de>
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

On Thursday 05 June 2008, Jean Delvare wrote:
> > > Maybe it is time to remove the index, or maybe we should go back to
> > > using both a static and the index. But at the time we decided to
> > > enforce an index.
> >
> > So what should we do now? Currently I2C doesn't work at all on 4xx since
> > the driver expects the "index" property and no dts sets this property.
> > Personally I would like to move to using cell-index here, since this
> > seems to be more common. But I could also life with removing the index
> > property and using the "static index" if this is preferred and/or
> > acceptable.
> >
> > Please advise. Thanks.
>
> As far as I am concerned, it's really up to the maintainers and users
> of this platform. All I am asking for is that you do not call
> i2c_add_numbered_adapter() on an adapter with an automatically
> generated number. This function must only be used for adapter's those
> number is well defined. If an adapter doesn't have a well-defined
> number then use i2c_add_adapter() (but then you can no longer declare
> your I2C devices as part of the platform data.)

Full ack from me. So I suggest to use "cell-index" if available and otherwise 
use an incremented number, same as the FSL i2c driver does now:

http://ozlabs.org/pipermail/linuxppc-dev/2008-June/057254.html

If nobody objects I'll send a patch to add the cell-index to all 4xx dts files 
in a short while.

Best regards,
Stefan
