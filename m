Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.245])
	by ozlabs.org (Postfix) with ESMTP id 1F09EDDF1D
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 17:47:53 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so3054387agc.0
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Jun 2008 00:47:51 -0700 (PDT)
Message-ID: <fa686aa40806060047n7b8b8e6flee193d46d4e3dd24@mail.gmail.com>
Date: Fri, 6 Jun 2008 01:47:50 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
In-Reply-To: <20080606082150.691da6a4@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200806041706.21557.sr@denx.de>
	<20080604220555.658ab13e@vader.jdub.homelinux.org>
	<20080604231641.786bb2dd@lappy.seanm.ca>
	<200806050822.00797.sr@denx.de>
	<20080605094852.164f0bc7@hyperion.delvare>
	<1212725783.12464.13.camel@pasglop>
	<20080606082150.691da6a4@hyperion.delvare>
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>,
	Scott Wood <scottwood@freescale.com>, Stefan Roese <sr@denx.de>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 6, 2008 at 12:21 AM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Ben,
>
> On Fri, 06 Jun 2008 14:16:23 +1000, Benjamin Herrenschmidt wrote:
>> On Thu, 2008-06-05 at 09:48 +0200, Jean Delvare wrote:
>> > As far as I am concerned, it's really up to the maintainers and users
>> > of this platform. All I am asking for is that you do not call
>> > i2c_add_numbered_adapter() on an adapter with an automatically
>> > generated number. This function must only be used for adapter's those
>> > number is well defined. If an adapter doesn't have a well-defined
>> > number then use i2c_add_adapter() (but then you can no longer declare
>> > your I2C devices as part of the platform data.)
>>
>> Can't we just give those things -names- instead of numbers ?
>
> Good question. These i2c adapters already have names
> (i2c_adapter.name), which are set by their respective drivers with more
> or less grace depending on the driver [1]. What we don't have though is
> the possibility to instantiate i2c devices by adapter name.
>
> We could certainly add a busname field to struct i2c_devinfo and
> implement i2c_register_board_info_by_name() if it seems to be worth the
> extra code and memory. I am open to the idea if it solves a problem
> with no other clean solution.

Even this isn't necessary.  In arch/powerpc we don't really need to
register the board info separately from the bus driver so we don't
need to jump through hoops to match a board_info with an i2c bus.  The
device tree data structure already links the i2c devices with the bus
they are on, so an OF-aware i2c bus driver will match against a node
in the device tree and then use all the child nodes to register i2c
devices against itself.

This, of course, only applies to platform level i2c busses described
in the device tree.  Plugin devices like PCI cards still can create
their own i2c busses in the usual way.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
