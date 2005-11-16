Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9035E68743
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2005 02:24:33 +1100 (EST)
In-Reply-To: <1132136755.21643.40.camel@hades.cambridge.redhat.com>
References: <1131357857.27347.28.camel@baythorne.infradead.org>
	<20051107160939.GD3839@smtp.west.cox.net>
	<1131380422.27347.72.camel@baythorne.infradead.org>
	<20051107165453.GA29111@lst.de>
	<1131382971.27347.79.camel@baythorne.infradead.org>
	<1132131116.28963.75.camel@baythorne.infradead.org>
	<17274.63508.501761.748278@cargo.ozlabs.ibm.com>
	<1132136755.21643.40.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8CE48849-147D-4140-96B4-9727E1E509C7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 16 Nov 2005 09:24:51 -0600
To: David Woodhouse <dwmw2@infradead.org>
Cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix 8250 probe on ppc32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 16, 2005, at 4:25 AM, David Woodhouse wrote:

> On Wed, 2005-11-16 at 20:12 +1100, Paul Mackerras wrote:
>> Yes, it works on newworld (at least it does on my G4 powerbook).  It
>> should work on 32-bit CHRP with any luck, but for oldworld we'll have
>> to generate a COFF file.
>
> I'll try it on Pegasos some time tonight or tomorrow. AFAICT I'm going
> to need the patch which started this thread, if I want any serial  
> ports
> on my Pegasos. The newly-created asm-powerpc/serial.h file is  
> devoid of
> serial port definitions.
>
> Here it is again, with Tom's three criticisms addressed, deliberately
> ignored, and addressed. In that order.
>
> It no longer touches asm-ppc/serial.h, so doesn't break the legacy
> zImage.
>
> ---
> [PATCH] Fix 8250 probe on ppc32
>
> There are no serial ports defined in the new asm-powerpc/serial.h, and
> rightly so. The 64-bit setup code has a routine to look in the device
> tree for them and register a platform_device for any we find there;  
> this
> patch steals that routine and makes it available on 32-bit machines
> too...
>
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>
>

[snip]

> --- linux-2.6.13/drivers/serial/Kconfig.sof	2005-10-20  
> 12:54:48.000000000 +0100
> +++ linux-2.6.13/drivers/serial/Kconfig	2005-10-20  
> 13:05:39.000000000 +0100
> @@ -77,6 +77,11 @@ config SERIAL_8250_CS
>
>  	  If unsure, say N.
>
> +config SERIAL_8250_OF
> +       bool
> +       default y
> +       depends on PPC_OF && SERIAL_8250 && PPC_MERGE
> +
>  config SERIAL_8250_ACPI
>  	bool "8250/16550 device discovery via ACPI namespace"
>  	default y if IA64

[snip]

Should this really depend on PPC_OF?  Does it require true  
OpenFirmware or just a flat dev tree to work?

I ask because I'd like to extended this in the future to handle 8250  
serial ports that aren't on a PCI or ISA bus, but on SoCs like 83xx,  
85xx, 86xx, 4xx?  These will most likely not be running with true OF  
but I've got a flat dev tree working today.

The following is what I've been toying with for an description of the  
8250 node (in .dts format):

                 serial@4500 {
                         device_type = "serial";
                         compatible = "ns16550";
                         reg = <4500 100>;
                         clock-frequency = <0>;
                         interrupts = <1a 3>;
                         interrupt-parent = <40000>;
                 };


- kumar
