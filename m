Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A8162DDEBE
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 02:56:02 +1100 (EST)
Message-ID: <4798B4F3.2010101@freescale.com>
Date: Thu, 24 Jan 2008 09:55:31 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH UCC TDM 1/3 Updated] Platform changes for UCC TDM driver
	for MPC8323eRDB. Also includes related QE changes and dts entries.
References: <Pine.LNX.4.64.0801241553270.4984@linux121>
	<20080124154804.GA22178@localhost.localdomain>
In-Reply-To: <20080124154804.GA22178@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Poonam_Aggrwal-b10812 <b10812@freescale.com>,
	michael.barkowski@freescale.com, netdev@vger.kernel.org,
	kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	rubini@vision.unipv.it, linuxppc-dev@ozlabs.org,
	ashish.kalra@freescale.com, rich.cutler@freescale.com,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> Can we not introduce new pio-maps in the device trees? There
> were debates regarding this, and if I understood everything
> correctly, pio-maps considered as a bad taste. Better
> do bunch of par_io_config_pin() in the board file. Better
> yet fixup the firmware (u-boot) to set up dedicated pins
> correctly.

I'm on the fence with respect to pio-maps vs. par_io_config_pin() calls.  The 
problem is that the configuration of these pins is board-specific, but pins are 
used by devices.  A device driver can't call par_io_config_pin(), because the 
calls are different depending on which SoC and which UCC you're using.  The 
platform code can't call par_io_config_pin(), because that configuration depends 
on which drivers are loaded.

In other words, the pin configurations are dependent on the UCC configurations, 
and the UCC configurations are stored in the device tree.  So it makes sense to 
put the pin configurations in the device tree, too.

-- 
Timur Tabi
Linux kernel developer at Freescale
