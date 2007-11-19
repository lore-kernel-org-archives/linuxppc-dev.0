Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 829C8DDE9E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Nov 2007 04:02:08 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Oops: of_platform_serial_probe
Date: Mon, 19 Nov 2007 17:56:54 +0100
References: <474193B8.9060007@anagramm.de>
In-Reply-To: <474193B8.9060007@anagramm.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200711191756.55165.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 19 November 2007, Clemens Koller wrote:
> Unable to handle kernel paging request for data at address 0x00000000
> Faulting instruction address: 0xc018f03c
> Oops: Kernel access of bad area, sig: 11 [#1]
> MPC85xx ADS
> Modules linked in:
> NIP: c018f03c LR: c018f00c CTR: c00127b4
> REGS: c0821cf0 TRAP: 0300 =A0 Not tainted =A0(2.6.24-rc2-ge6a5c27f)
> MSR: 00029000 <EE,ME> =A0CR: 42022088 =A0XER: 20000000
> DEAR: 00000000, ESR: 00000000
> TASK =3D c081e000[1] 'swapper' THREAD: c0820000
> GPR00: b1000000 c0821da0 c081e000 c0833e10 00000004 c0821d80 c03d3064 c05=
eea80
> GPR08: 00000200 00000002 0000002a 13ab6680 82022042 00000000 c03318a4 c03=
3188c
> GPR16: c0331908 c03318f0 c03a0e30 c0331930 c033191c 007fff00 0ffeccbc c03=
a0000
> GPR24: c0821dc4 00000000 00000003 c0934cf8 cffffba8 00000000 c0833e00 c07=
fdc6c
> NIP [c018f03c] of_platform_serial_probe+0x118/0x1e4
> LR [c018f00c] of_platform_serial_probe+0xe8/0x1e4
> Call Trace:

Ok, that is a NULL pointer access, probably somewhere in the
of_platform_serial_setup that can be inlined. Please post the
device tree entries for your serial ports so we can see what
goes wrong there.

One potential problem that I can see is a missing 'current-speed'
property in your tree, which would cause this behavior. It looks
like many device trees set this, but it is not required by all
bindings. If that's the case, the patch below should fix your
problem, but you probably want to set the current-speed anyway,
according to your boot loader settings.

	Arnd <><

=2D-- a/drivers/serial/of_serial.c
+++ b/drivers/serial/of_serial.c
@@ -56,7 +56,8 @@ static int __devinit of_platform_serial_setup(struct of_d=
evice *ofdev,
 	port->flags =3D UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
 		| UPF_FIXED_PORT;
 	port->dev =3D &ofdev->dev;
=2D	port->custom_divisor =3D *clk / (16 * (*spd));
+	if (spd)
+		port->custom_divisor =3D *clk / (16 * (*spd));

 	return 0;
 }
