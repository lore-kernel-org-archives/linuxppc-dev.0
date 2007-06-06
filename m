Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 42E58DDE16
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Jun 2007 03:51:19 +1000 (EST)
Message-ID: <4666F598.2000004@ru.mvista.com>
Date: Wed, 06 Jun 2007 21:57:44 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] Simple driver for Xilinx SPI controler.
References: <20070606160329.A8A719E0060@mail81-sin.bigfish.com>
In-Reply-To: <20070606160329.A8A719E0060@mail81-sin.bigfish.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Steve,

Stephen Neuendorffer wrote:
> In order to anticipate future Microblaze support with most of these
> drivers,
> we've been moving towards having all of the Kconfig dependencies on
> XILINX_EDK,

There is no XILINX_EDK in the ko tree.

> rather than XILINX_VIRTEX...

Using XILINX_VIRTEX seems to be a common thing:

> -------- Original Message --------
> Subject: [RFC] Xilinx SystemACE device driver
> Date: Sat, 14 Apr 2007 19:23:14 -0600
> From: Grant Likely <grant.likely@secretlab.ca>
> To: linuxppc-embedded@ozlabs.org, Andrei Konovalov <akonovalov@ru.mvista.com>,	Peter Korsgaard <jacmet@sunsite.dk>,	Rick Moleres <Rick.Moleres@xilinx.com>, Stefan Roese <sr@denx.de>
> 
> Add support for block device access to the Xilinx SystemACE Compact
> flash interface
<snip>
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 17ee97f..08ad23c 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -453,6 +453,12 @@ config ATA_OVER_ETH
>  	This driver provides Support for ATA over Ethernet block
>  	devices like the Coraid EtherDrive (R) Storage Blade.
>  
> +config XILINX_SYSACE
> +	tristate "Xilinx SystemACE support"
> +	depends on XILINX_VIRTEX
> +	help
> +	  Include support for the Xilinx SystemACE CompactFlash interface
> +

BTW the SystemACE has been successfully tested with ppc440 based
board. So XILINX_VIRTEX doesn't imply ppc405.

On the other side,
UART Lite driver (in the ko tree) doesn't depend on both XILINX_EDK and XILINX_VIRTEX

Couldn't Microblaze port use XILINX_VIRTEX too?
IMHO XILINX_VIRTEX is more general name for something inside the Virtex chip (ppc405
core, Microblaze softcore, IP blocks from EDK or elsewhere).

I've recently added XILINX_EDK to linux-xilinx-26.git repository at source.mvista.com,
but to include the level 1 drivers (aka OS independent drivers) from EDK. Haven't
planned to use XILINX_EDK for drivers not using EDK code.
Here is the relevant snippet from arch/ppc/platforms/4xx/Kconfig
(from linux-xilinx-26.git @ source.mvista.com, ko doesn't have XILINX_EDK and the
rest below):

===8<=====================================
config XILINX_VIRTEX_II_PRO
	bool
	select XILINX_VIRTEX

config XILINX_VIRTEX_4_FX
	bool
	select XILINX_VIRTEX

config XILINX_VIRTEX
	bool

# The options selected by EDK based drivers. Not visible from [menu]config.
config XILINX_EDK
	bool
config XILINX_IPIF_V123B
	bool
config XILINX_FIFO_V200A
	bool
config XILINX_DMA_V300A
	bool
===8<=====================================

If we do something like
   config XILINX_MICROBLAZE
	bool
	select XILINX_VIRTEX
in arch/microblaze/Kconfig
would it work?


Thanks,
Andrei
