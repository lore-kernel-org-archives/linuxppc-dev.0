Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4693ADDF4D
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 16:22:08 +1000 (EST)
Date: Fri, 6 Jun 2008 08:21:50 +0200
From: Jean Delvare <khali@linux-fr.org>
To: benh@kernel.crashing.org
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080606082150.691da6a4@hyperion.delvare>
In-Reply-To: <1212725783.12464.13.camel@pasglop>
References: <200806041706.21557.sr@denx.de>
	<20080604220555.658ab13e@vader.jdub.homelinux.org>
	<20080604231641.786bb2dd@lappy.seanm.ca>
	<200806050822.00797.sr@denx.de>
	<20080605094852.164f0bc7@hyperion.delvare>
	<1212725783.12464.13.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, Timur Tabi <timur@freescale.com>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

On Fri, 06 Jun 2008 14:16:23 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2008-06-05 at 09:48 +0200, Jean Delvare wrote:
> > As far as I am concerned, it's really up to the maintainers and users
> > of this platform. All I am asking for is that you do not call
> > i2c_add_numbered_adapter() on an adapter with an automatically
> > generated number. This function must only be used for adapter's those
> > number is well defined. If an adapter doesn't have a well-defined
> > number then use i2c_add_adapter() (but then you can no longer declare
> > your I2C devices as part of the platform data.)
> 
> Can't we just give those things -names- instead of numbers ?

Good question. These i2c adapters already have names
(i2c_adapter.name), which are set by their respective drivers with more
or less grace depending on the driver [1]. What we don't have though is
the possibility to instantiate i2c devices by adapter name.

We could certainly add a busname field to struct i2c_devinfo and
implement i2c_register_board_info_by_name() if it seems to be worth the
extra code and memory. I am open to the idea if it solves a problem
with no other clean solution.

[1] radeonfb is notoriously bad at that ;)

-- 
Jean Delvare
