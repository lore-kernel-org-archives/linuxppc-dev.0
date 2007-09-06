Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 16774DDEFA
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 00:35:37 +1000 (EST)
Message-ID: <46E01031.9090608@freescale.com>
Date: Thu, 06 Sep 2007 09:35:29 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v7 3/3] [POWERPC] MPC832x_RDB: update dts to use SPI1in
	QE, register mmc_spi stub
References: <46D73166.6080103@freescale.com>
	<989B956029373F45A0B8AF02970818900147BD4D@zch01exm26.fsl.freescale.net>
	<ac803797588b40e3d33bbd6f758a5663@kernel.crashing.org>
	<46DC126C.9060603@freescale.com>
	<20070903151319.GA24840@localhost.localdomain>
	<fdaf530168b099fcb5a3fbbe45e38271@kernel.crashing.org>
	<20070904104750.GA32451@localhost.localdomain>
	<6242650d3fca3afaff242518972bc494@kernel.crashing.org>
In-Reply-To: <6242650d3fca3afaff242518972bc494@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>>> _and system GPIOs_ :-)
>>
>> Yup, firmware should set up gpios, to make initial kernel boot.
>> After that, kernel can and should manage GPIOs.
> 
> Sure.  But only the GPIOs it _does_ need to toggle, not the ones
> that have to be fixed to a certain value (like everything that is
> described in the par_io nodes now).

Some history:

The par_io nodes are statically defined because the we don't support the 
concept of moving devices from one UCC to another.  When the boards are 
designed, typically the external PHYs (UART, Ethernet, whatever) are 
hard-wired to a particular UCC, and so its par_io configuration is static.

This works only because there are usually more than enough UCCs for every 
device.  The 8360, for instance, has 8 UCCs, but the MPC8360EMDS only uses two 
of them, for Ethernet.

So having the par_io nodes in the device tree is very convenient, because it

A) Is simple and compact
B) Doesn't require full-blown GPIO support
C) The device drivers can ignore par_io programming - they can just assume 
that the pins are configured correctly.
D) It makes it easy for U-Boot and/or Linux to configure the pins.

There are some drawbacks.  For instance on UART, in loopback mode, the par_io 
pins should be reconfigured.  Since loopback mode is a configurable option for 
serial drivers, that means that a UCC UART driver (which I'm working on) needs 
to be aware of the par_io pins.  It would be nice if there were a way I could 
tag a par_io node as being for loopback.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
