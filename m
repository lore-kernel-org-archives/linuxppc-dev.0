Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 25B9FDDDE9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Nov 2007 21:52:06 +1100 (EST)
Message-ID: <4742BC57.7020305@anagramm.de>
Date: Tue, 20 Nov 2007 11:52:07 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Oops: of_platform_serial_probe
References: <474193B8.9060007@anagramm.de> <200711191756.55165.arnd@arndb.de>
In-Reply-To: <200711191756.55165.arnd@arndb.de>
Content-Type: multipart/mixed; boundary="------------010403080101010901020306"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010403080101010901020306
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Arnd!

Arnd Bergmann schrieb:
 > On Monday 19 November 2007, Clemens Koller wrote:
 >> Unable to handle kernel paging request for data at address 0x00000000
 >> Faulting instruction address: 0xc018f03c
 >> Oops: Kernel access of bad area, sig: 11 [#1]
 >> MPC85xx ADS
 >> Modules linked in:
 >> NIP: c018f03c LR: c018f00c CTR: c00127b4
 >> REGS: c0821cf0 TRAP: 0300   Not tainted  (2.6.24-rc2-ge6a5c27f)
 >> MSR: 00029000 <EE,ME>  CR: 42022088  XER: 20000000
 >> DEAR: 00000000, ESR: 00000000
 >> TASK = c081e000[1] 'swapper' THREAD: c0820000
 >> GPR00: b1000000 c0821da0 c081e000 c0833e10 00000004 c0821d80 c03d3064 c05eea80
 >> GPR08: 00000200 00000002 0000002a 13ab6680 82022042 00000000 c03318a4 c033188c
 >> GPR16: c0331908 c03318f0 c03a0e30 c0331930 c033191c 007fff00 0ffeccbc c03a0000
 >> GPR24: c0821dc4 00000000 00000003 c0934cf8 cffffba8 00000000 c0833e00 c07fdc6c
 >> NIP [c018f03c] of_platform_serial_probe+0x118/0x1e4
 >> LR [c018f00c] of_platform_serial_probe+0xe8/0x1e4
 >> Call Trace:
 >
 > Ok, that is a NULL pointer access, probably somewhere in the
 > of_platform_serial_setup that can be inlined. Please post the
 > device tree entries for your serial ports so we can see what
 > goes wrong there.

The device tree is the default one which comes with the kernel:
paulus.git/arch/powerpc/boot/dts/mpc8540ads.dts
which contains:

                 serial@4500 {
                         device_type = "serial";
                         compatible = "ns16550";
                         reg = <4500 100>;       // reg base, size
                         clock-frequency = <0>;  // should we fill in in uboot?
                         interrupts = <2a 2>;
                         interrupt-parent = <&mpic>;
                 };

                 serial@4600 {
                         device_type = "serial";
                         compatible = "ns16550";
                         reg = <4600 100>;       // reg base, size
                         clock-frequency = <0>;  // should we fill in in uboot?
                         interrupts = <2a 2>;
                         interrupt-parent = <&mpic>;
                 };

 > One potential problem that I can see is a missing 'current-speed'
 > property in your tree, which would cause this behavior.

That's correct. Should be fixed in all .dts' ?

 > It looks
 > like many device trees set this, but it is not required by all
 > bindings.

How should someone know, when it's really needed and when not?

 > If that's the case, the patch below should fix your
 > problem, but you probably want to set the current-speed anyway,
 > according to your boot loader settings.

I think there was no need to set it again, because of: console=ttyS0,115200
But I'll verify...

 > --- a/drivers/serial/of_serial.c
 > +++ b/drivers/serial/of_serial.c
 > @@ -56,7 +56,8 @@ static int __devinit of_platform_serial_setup(struct of_device *ofdev,
 >  	port->flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
 >  		| UPF_FIXED_PORT;
 >  	port->dev = &ofdev->dev;
 > -	port->custom_divisor = *clk / (16 * (*spd));
 > +	if (spd)
 > +		port->custom_divisor = *clk / (16 * (*spd));
 >
 >  	return 0;
 >  }
 >

Ack! However, I changed it similar to the available code.
No idea what's better here. At least it should tell the user:

Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 42) is a 16550A
console [ttyS0] enabled
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 42) is a 16550A
of_serial e0004500.serial: no current-speed property set
of_serial e0004600.serial: no current-speed property set

Patch attached.

Regards,

-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com


--------------010403080101010901020306
Content-Type: text/plain;
 name="of_serial-check-current-speed.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="of_serial-check-current-speed.patch"

Warn user when current-speed property isn't set and exit.

Signed-off-by: Clemens Koller <clemens.koller@anagramm.de>
CC: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
index a64d858..e035cb2 100644
--- a/drivers/serial/of_serial.c
+++ b/drivers/serial/of_serial.c
@@ -36,6 +36,10 @@ static int __devinit of_platform_serial_setup(struct of_device *ofdev,
 	memset(port, 0, sizeof *port);
 	spd = of_get_property(np, "current-speed", NULL);
 	clk = of_get_property(np, "clock-frequency", NULL);
+	if (!spd) {
+		dev_warn(&ofdev->dev, "no current-speed property set\n");
+		return -ENODEV;
+	}
 	if (!clk) {
 		dev_warn(&ofdev->dev, "no clock-frequency property set\n");
 		return -ENODEV;

--------------010403080101010901020306--
