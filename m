Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C3897DF02B
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 04:35:42 +1000 (EST)
Message-ID: <484831E6.8090509@freescale.com>
Date: Thu, 05 Jun 2008 13:35:18 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
References: <200806041706.21557.sr@denx.de>	<4846B39F.3010601@freescale.com>	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>	<20080604211942.2bddc860@zod.rchland.ibm.com>	<4848028B.5060105@freescale.com>	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>	<48480987.1070701@freescale.com>	<fa686aa40806050900i40f0aa62o4bab3b8c7409b15f@mail.gmail.com>	<484810A3.5070301@freescale.com>	<20080605112122.0381a338@zod.rchland.ibm.com>	<48481373.8010706@freescale.com>
	<20080605132735.3433f2af@zod.rchland.ibm.com>
In-Reply-To: <20080605132735.3433f2af@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, Stefan Roese <sr@denx.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:

> I don't understand this statement.  Are your I2C macros hot-pluggable?
> Can you dynamically add/remove an I2C engine on your hardware somehow?
> Are you mucking about with the DTB and randomly moving around the I2C
> node blobs so they probe order differs from boot to boot?
> 
> If not, then the probe order will be static for every boot. 

You're making two assumptions:

1) That every I2C adapter will be present in the device tree.  Some device trees
don't list I2C adapters if there are no devices on them.
2) That the nodes in the device tree are put in order

Besides, let's say I have a pointer to a specific I2C device node in the tree.
How do I find out the bus number it's on?  With my way, it's easy:

iprop = of_get_property(of_get_parent(codec_np), "cell-index", NULL);
bus = *iprop;

With your way, I'll need to scan the entire device tree, poking inside each I2C
adapter node looking for my I2C device node while keeping track of the I2C adapters.

> You can
> assign the index 

Assign it to where?  When the fabric driver goes to find codec nodes, the only
information it has is the device tree.  So when I assign this index to some
random variable that you're talking about, my fabric driver will know nothing
about that.

> using a static int that is incremented after each node
> is discovered and the ordering of the devices will never change.  Can
> you explain why something like that isn't possible or sufficient?

Yes, I just did.

> (And I'm talking about I2C, not DMA.  I don't care about DMA because
> this conversation will go off into the weeds if we start talking about
> cell-index and every possible device out there.)

But we are talking about every device.  It's the same problem for every device.
 Making this problem I2C-specific is not going to solve anything.


-- 
Timur Tabi
Linux kernel developer at Freescale
