Return-Path: <benh@kernel.crashing.org>
Subject: Re: TSI ethernet PHY question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andy Fleming <afleming@freescale.com>
In-Reply-To: <396FEEDC-99AB-4E25-9C80-A901923429B0@freescale.com>
References: <1B5F013528140F45B5C671039279CA5701BBBDE3@NANUK.pc.tundra.com>
	<1179960728.32247.953.camel@localhost.localdomain>
	<396FEEDC-99AB-4E25-9C80-A901923429B0@freescale.com>
Content-Type: text/plain
Date: Fri, 25 May 2007 08:51:24 +1000
Message-Id: <1180047084.32247.1070.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> For instance, I think #1 might usually be workable by passing in PHY- 
> specific flags, and letting the PHY driver deal with it in  
> config_init.  This might even be workable for the BCM5461A chip as  
> mentioned above.  You could define a BCM5461A_TXC_RXC_DELAY_DISABLE  
> flag, and have the config_init code check for that flag and perform  
> the necessary disable.

For powerpc, I have a solution at hand, it's the device-tree :-)

Any struct device in the system can have a device node pointer via the
dev_sysdata thingy I added recently. So we can have some code for
powerpc that properly hooks up the PHY to an (optional) device-node
which can then contains properties describing what kind of workarounds
need to be applied.

For example, we can have a txc-rxc-delay-disable property on Holly.

The problem is that of course the PHY driver will need some powerpc
specific code to go fetch that. An option would be to instead use flags
and have a piece of powerpc specific code that translates those
device-tree properties into flags so that other archs can use the flags
using their own ways of passing them in.

I'm not too hot with the flag stuff tho since those really need to be
defined per PHY model/family. But I suppose that's fair enough.

Ben.
