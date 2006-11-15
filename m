Return-Path: <mateo_anderson@hotmail.com>
Received: from bay0-omc3-s13.bay0.hotmail.com (bay0-omc3-s13.bay0.hotmail.com
	[65.54.246.213]) by ozlabs.org (Postfix) with ESMTP id 7B01A67CCD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Nov 2006 07:26:58 +1100 (EST)
Message-ID: <BAY18-F85AD859772314814F219AECEA0@phx.gbl>
From: "Mateo Anderson" <mateo_anderson@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Adding 16c752 to MPC5200
Date: Wed, 15 Nov 2006 21:14:47 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

I am trying to add additional UART controller (TL16C752B) to MPC5200B
(even though it has six of them, but PSCs are used for different functions)
using kernel 2.6.18-rc5. I am (still) using arch/ppc.

The board is very simillar to Lite5200B, so I defined a structure in
arch/ppc/platforms/lite5200.c as:

static struct plat_serial8250_port additional_serial_ports[] = {
        [0] =   {
                /* UART 6 */
                        .uartclk = 115200*16,
                        .iotype = UPIO_MEM,
                        .mapbase = 0x30000000,
                        .irq = MPC52xx_IRQ0,
                        .flags = UPF_BOOT_AUTOCONF,
                },
        [1] =   {
...

and

static struct platform_device additional_serial_device = {
                .name = "serial16c752",
                .id = -1,
                .num_resources = 2,
                .dev.platform_data = &additional_serial_ports,
};


at the end of the function platform_init I added:
platform_device_register(&additional_serial_device);

However the kernel does not work.

If I comment out a call to platform_device_register, the kernel boots
fine. If I use in a working kernel tool devmem2, I can see the values
of the registers in the UART controller.

What am I doing wrong?

BR,
Mateo

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar - get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/
