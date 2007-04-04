Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id 608D0DDE30
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Apr 2007 23:32:24 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1HZ5Uy-0006nZ-Ja
	for linuxppc-embedded@ozlabs.org; Wed, 04 Apr 2007 15:26:04 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Using Linux 2.6.19 with Xilinx ML405
References: <46125216.2080903@computing.dundee.ac.uk>
	<46128E70.50503@ru.mvista.com>
	<46139148.1080308@computing.dundee.ac.uk>
Date: Wed, 04 Apr 2007 15:26:04 +0200
In-Reply-To: <46139148.1080308@computing.dundee.ac.uk> (Peter Mendham's
	message of "Wed, 04 Apr 2007 12:51:36 +0100")
Message-ID: <878xd8qnir.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "PM" == Peter Mendham <petermendham@computing.dundee.ac.uk> writes:

Hi,

PM> Brilliant!  Thanks.  The code your patch produces expects there to
PM> be an 8250 compatible UART around.  What happens if I only have a
PM> UARTlite?  What do I need to fill in to a platform_device
PM> structure for a UARTlite?

Something like:

static struct resource myboarduartlite_resources[] = {
	[0] = {
		.start  = 0xa1000003,
		.end    = 0xa1000012,
		.flags  = IORESOURCE_MEM,
	},
	[1] = {
		.start	= 2,
		.end	= 2,
		.flags	= IORESOURCE_IRQ,
	},
};

static struct platform_device myboard_uartlite = {
	.name			= "uartlite",
	.id			= 0,
	.num_resources		= ARRAY_SIZE(myboarduartlite_resources),
	.resource		= myboarduartlite_resources,
};

static struct platform_device *myboard_devices[] __initdata = {
	..
	&myboard_uartlite,
        ..
};

static int __init
myboard_platform_add_devices(void)
{
	return platform_add_devices(myboard_devices,
                ARRAY_SIZE(myboard_devices));

}
arch_initcall(myboard_platform_add_devices);

Notice the +3 for the base address as the registers are accessed using
8bit I/O.

PM> I have just moved to 2.6.20 kernel in the hope of using the
PM> mainline uartlite driver - was this a stupid thing to do?

Not if you ask me ;)

PM> Do you know if I can use it for early serial in the same way as an
PM> 8250?

Unfortunately not. I started working on some patches for this some
months ago, but got stalled doing other stuff. I doubt it will get
integrated before the move to arch/powerpc.

-- 
Bye, Peter Korsgaard
