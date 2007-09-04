Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D0D53DDE09
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 07:28:49 +1000 (EST)
Date: Wed, 5 Sep 2007 00:15:51 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v7 3/3] [POWERPC] MPC832x_RDB: update dts to use SPI1in
	QE, register mmc_spi stub
Message-ID: <20070905001551.7b92da0a@localhost.localdomain>
In-Reply-To: <20070904182028.GC18280@ld0162-tx32.am.freescale.net>
References: <46D73166.6080103@freescale.com>
	<989B956029373F45A0B8AF02970818900147BD4D@zch01exm26.fsl.freescale.net>
	<ac803797588b40e3d33bbd6f758a5663@kernel.crashing.org>
	<46DC126C.9060603@freescale.com>
	<20070903151319.GA24840@localhost.localdomain>
	<fdaf530168b099fcb5a3fbbe45e38271@kernel.crashing.org>
	<20070904104750.GA32451@localhost.localdomain>
	<20070904182028.GC18280@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 4 Sep 2007 13:20:28 -0500
Scott Wood wrote:

> > > _and system GPIOs_ :-)  
> > 
> > Yup, firmware should set up gpios, to make initial kernel boot.  
> 
> No, it should set all pins and similar setup-once type initialization
> that is board-specific rather than device-specific -- there's no
> reason for the kernel to need to care about that sort of thing.
> 
> > After that, kernel can and should manage GPIOs. Few examples.
> > 
> > Say units (like USB or SPI) can work in very different modes. And
> > it's okay if user want to change device mode in the runtime.  
> 
> This is a special case that warrants kernel involvement.  It should
> not be used as justification for the bootloader leaving pins
> unconfigured in the majority of cases where it does not make sense to
> change them at runtime.
> 

This argue is useless: both opinions have same weight. Firmware is able to provide meaningful default gpio setup, and nobody
will object. The point is, that blindly assume all the low-level  stuff is fine, you are able only in case you've developed respective bits in the firmware.

More usual case is additional overhead of checking if the firmware not attempting to do something not really wanted, so we'll
always have a tradeoff. 


-- 
Sincerely, Vitaly
