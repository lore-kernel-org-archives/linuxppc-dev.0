Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D1EC2DDE20
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 04:20:40 +1000 (EST)
Date: Tue, 4 Sep 2007 13:20:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v7 3/3] [POWERPC] MPC832x_RDB: update dts to use SPI1in QE,
	register mmc_spi stub
Message-ID: <20070904182028.GC18280@ld0162-tx32.am.freescale.net>
References: <46D73166.6080103@freescale.com>
	<989B956029373F45A0B8AF02970818900147BD4D@zch01exm26.fsl.freescale.net>
	<ac803797588b40e3d33bbd6f758a5663@kernel.crashing.org>
	<46DC126C.9060603@freescale.com>
	<20070903151319.GA24840@localhost.localdomain>
	<fdaf530168b099fcb5a3fbbe45e38271@kernel.crashing.org>
	<20070904104750.GA32451@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070904104750.GA32451@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 04, 2007 at 02:47:50PM +0400, Anton Vorontsov wrote:
> > _and system GPIOs_ :-)
> 
> Yup, firmware should set up gpios, to make initial kernel boot.

No, it should set all pins and similar setup-once type initialization
that is board-specific rather than device-specific -- there's no reason
for the kernel to need to care about that sort of thing.

> After that, kernel can and should manage GPIOs. Few examples.
> 
> Say units (like USB or SPI) can work in very different modes. And
> it's okay if user want to change device mode in the runtime.

This is a special case that warrants kernel involvement.  It should not
be used as justification for the bootloader leaving pins unconfigured in
the majority of cases where it does not make sense to change them at
runtime.

> Another example, power management - if some unit temporarily unused,
> to save power GPIOs should be set up differently. Say if SPI unit
> turned off (unused just now), it's wise to bring their dedicated
> GPIOs to "power saving" state (be it output0/1 or input, it
> depends).

The kernel is of course welcome to do so -- and this may be a valid
reason to attach pin information to specific device nodes, if it actually
saves a non-negligible amount of power -- but it's not a reason to force
the kernel to have to care by not setting things up in the firmware.

-Scott
