Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B36C1DDF8C
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 00:19:47 +1000 (EST)
In-Reply-To: <20070904104750.GA32451@localhost.localdomain>
References: <46D73166.6080103@freescale.com>
	<989B956029373F45A0B8AF02970818900147BD4D@zch01exm26.fsl.freescale.net>
	<ac803797588b40e3d33bbd6f758a5663@kernel.crashing.org>
	<46DC126C.9060603@freescale.com>
	<20070903151319.GA24840@localhost.localdomain>
	<fdaf530168b099fcb5a3fbbe45e38271@kernel.crashing.org>
	<20070904104750.GA32451@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6242650d3fca3afaff242518972bc494@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v7 3/3] [POWERPC] MPC832x_RDB: update dts to use SPI1in QE,
	register mmc_spi stub
Date: Thu, 6 Sep 2007 16:19:45 +0200
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> _and system GPIOs_ :-)
>
> Yup, firmware should set up gpios, to make initial kernel boot.
> After that, kernel can and should manage GPIOs.

Sure.  But only the GPIOs it _does_ need to toggle, not the ones
that have to be fixed to a certain value (like everything that is
described in the par_io nodes now).

Devices that really _use_ some GPIO, should use some generic GPIO
binding in the device tree, and the generic GPIO subsystem in the
kernel.

> Few examples.

[some good examples of why GPIOs can be useful at runtime snipped]

> At the same time I agree: doing gpio setup in the board file isn't a
> great solution, just like doing it in the device tree. But hard-code
> gpio setup in the firmware is much worse and short-sighted approach.

It is the correct solution for 99.99% of GPIOs: every GPIO needs to
either be set to some fixed configuration (and value), dictated by
the board design; or at least it needs to be initialised to something
that results in a stable system ;-)


Segher
