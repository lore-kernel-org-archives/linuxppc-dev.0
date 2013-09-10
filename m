Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 652422C00D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 09:47:41 +1000 (EST)
Message-ID: <1378856847.12204.380.camel@snotra.buserror.net>
Subject: Re: [RFC PATCH v2 1/1] powerpc/embedded6xx: Add support for
 Motorola/Emerson MVME5100.
From: Scott Wood <scottwood@freescale.com>
To: Stephen Chivers <schivers@csc.com>
Date: Tue, 10 Sep 2013 18:47:27 -0500
In-Reply-To: <20130905055122.F256EE07B6@canberra.localdomain>
References: <20130905055122.F256EE07B6@canberra.localdomain>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, cproctor@csc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-09-05 at 15:51 +1000, Stephen Chivers wrote:
> Add support for the Motorola/Emerson MVME5100 Single Board Computer.
> 
> The MVME5100 is a 6U form factor VME64 computer with:
> 
> 	- A single MPC7410 or MPC750 CPU
> 	- A HAWK Processor Host Bridge (CPU to PCI) and
> 	  MultiProcessor Interrupt Controller (MPIC)
> 	- Up to 500Mb of onboard memory
> 	- A M48T37 Real Time Clock (RTC) and Non-Volatile Memory chip
> 	- Two 16550 compatible UARTS
> 	- Two Intel E100 Fast Ethernets
> 	- Two PCI Mezzanine Card (PMC) Slots
> 	- PPCBug Firmware
> 
> The HAWK PHB/MPIC is compatible with the MPC10x devices.
> 
> There is no onboard disk support. This is usually provided by
> installing a PMC in the first PMC slot.
> 
> This patch revives the board support, it was present in early 2.6
> series kernels. The board support in those days was by Matt Porter of
> MontaVista Software.
> 
> CSC Australia has around 31 of these boards in service. The kernel in use
> for the boards is based on 2.6.31. The boards are operated without disks
> from a file server. 
> 
> This patch is based on linux-3.11-rc7 and has been boot tested.
> 
> V1->V2:
> 	Address comments by Kular Gama and Scott Wood.
> 	Minor adjustment to platforms/embedded6xx/Kconfig to ensure
> 		correct indentation where possible.
> 
> Signed-off-by: Stephen Chivers <schivers@csc.com>
> ---

Some comments below, and please run checkpatch.pl, but the next version
can probably be non-RFC if you're happy with it.

> +		PowerPC,7410 {
> +			device_type = "cpu";
> +			reg = <0x0>;
> +			/* Following required by dtc but not used */
> +			d-cache-line-size = <32>;
> +			i-cache-line-size = <32>;
> +			i-cache-size = <32768>;
> +			d-cache-size = <32768>;
> +			timebase-frequency = <25000000>;
> +			clock-frequency = <500000000>;
> +                        bus-frequency = <100000000>;
> +		};

Whitespace on bus-frequency

> +		mpic: interrupt-controller@f3f80000 {
> +			#interrupt-cells = <2>;
> +			#address-cells = <0>;
> +			device_type = "open-pic";
> +			compatible = "chrp,open-pic";
> +			interrupt-controller;
> +			reg = <0xf3f80000 0x40000>;
> +		};
> +
> +	};

No blank line before }

> +CONFIG_CMDLINE_BOOL=y
> +CONFIG_CMDLINE="console=ttyS0,9600 ip=dhcp root=/dev/nfs"

I take it there's no way to pass a command line in from whatever loader
this board uses... but you could put it in the dts instead.

Did you ever figure out the problem with the combined defconfig?

> +	help
> +          This option enables support for the Motorola (now Emerson) MVME5100
> +	  board.

Whitespace

> +/* Board register addresses. */
> +#define	BOARD_STATUS_REG	0xfef88080
> +#define	BOARD_MODFAIL_REG	0xfef88090
> +#define	BOARD_MODRST_REG	0xfef880a0
> +#define	BOARD_TBEN_REG		0xfef880c0
> +#define BOARD_SW_READ_REG	0xfef880e0
> +#define	BOARD_GEO_ADDR_REG	0xfef880e8
> +#define	BOARD_EXT_FEATURE1_REG	0xfef880f0
> +#define	BOARD_EXT_FEATURE2_REG	0xfef88100

Use a space rather than a tab after #define.

> +static unsigned int pci_membase;

phys_addr_t

> +static void mvme5100_restart(char *cmd)
> +{
> +	u_char			*restart;

Is all that tabbing before "*restart" really necessary?

> +	restart = ioremap(BOARD_MODRST_REG, 4);
> +	local_irq_disable();
> +	mtmsr(mfmsr() | MSR_IP);
> +
> +	out_8((u_char *) restart, 0x01);

If ioremap() fails you'll panic here.

In any case, you should map things at boot time.

-Scott
