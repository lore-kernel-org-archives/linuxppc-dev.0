Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id F24E8DDDEB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Nov 2007 23:49:34 +1100 (EST)
Message-ID: <4742D7DD.9040308@anagramm.de>
Date: Tue, 20 Nov 2007 13:49:33 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Oops: of_platform_serial_probe
References: <474193B8.9060007@anagramm.de> <200711191756.55165.arnd@arndb.de>
	<4742BC57.7020305@anagramm.de> <200711201305.47753.arnd@arndb.de>
In-Reply-To: <200711201305.47753.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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

 >> @@ -36,6 +36,10 @@ static int __devinit of_platform_serial_setup(struct of_device *ofdev,
 >>         memset(port, 0, sizeof *port);
 >>         spd = of_get_property(np, "current-speed", NULL);
 >>         clk = of_get_property(np, "clock-frequency", NULL);
 >> +       if (!spd) {
 >> +               dev_warn(&ofdev->dev, "no current-speed property set\n");
 >> +               return -ENODEV;
 >> +       }
 >>         if (!clk) {
 >>                 dev_warn(&ofdev->dev, "no clock-frequency property set\n");
 >>                 return -ENODEV;
 >
 > This looks wrong. Since the current-speed property is not mandated by open firmware,
 > we should not error out here, but simply use the setting from the command line
 > or whatever other defaults can be used. Not setting port->custom_divisor at all
 > should do the job.

Understood... but then, my console just stops / gets reinitialized to some unknown
baudrate when I get to of_serial.c. :-(

Regards,

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
