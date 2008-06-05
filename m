Return-Path: <dgibson@ozlabs.org>
Date: Thu, 5 Jun 2008 20:57:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Roese <sr@denx.de>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080605105707.GB30980@yookeroo.seuss>
References: <200806041706.21557.sr@denx.de> <200806050822.00797.sr@denx.de>
	<20080605094852.164f0bc7@hyperion.delvare>
	<200806051045.42966.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200806051045.42966.sr@denx.de>
Cc: Jean Delvare <khali@linux-fr.org>, Scott Wood <scottwood@freescale.com>,
	Sean MacLennan <smaclennan@pikatech.com>,
	Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 05, 2008 at 10:45:42AM +0200, Stefan Roese wrote:
> On Thursday 05 June 2008, Jean Delvare wrote:
> > > > Maybe it is time to remove the index, or maybe we should go back to
> > > > using both a static and the index. But at the time we decided to
> > > > enforce an index.
> > >
> > > So what should we do now? Currently I2C doesn't work at all on 4xx since
> > > the driver expects the "index" property and no dts sets this property.
> > > Personally I would like to move to using cell-index here, since this
> > > seems to be more common. But I could also life with removing the index
> > > property and using the "static index" if this is preferred and/or
> > > acceptable.
> > >
> > > Please advise. Thanks.
> >
> > As far as I am concerned, it's really up to the maintainers and users
> > of this platform. All I am asking for is that you do not call
> > i2c_add_numbered_adapter() on an adapter with an automatically
> > generated number. This function must only be used for adapter's those
> > number is well defined. If an adapter doesn't have a well-defined
> > number then use i2c_add_adapter() (but then you can no longer declare
> > your I2C devices as part of the platform data.)
> 
> Full ack from me. So I suggest to use "cell-index" if available and otherwise 
> use an incremented number, same as the FSL i2c driver does now:
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2008-June/057254.html
> 
> If nobody objects I'll send a patch to add the cell-index to all 4xx
> dts files in a short while.

Do *not* add cell-index unless it is used to correlate to a global
register somewhere.  Although, for the 4xx IIC adaptor, I think there
usually will be shared registers, and a cell-index property.

The proper device tree mechanism for providing a standard numbering
for similar devices is the /aliases node.  So instead, what you should
do is:
	- If a suitable alias exists pointing to this device, use that
number
	- Otherwise, if cell-index is present, use that (this is a
fallback heuristic, not recommended practice)
	- Otherwise, use i2c_add_adapter() instead of
i2c_add_numbered_adapter()

If a platform has a conventional way of numbering the i2c busses,
which you want to represent in the device tree, you should add
aliases, not cell-index.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
