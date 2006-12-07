Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 97D9667CDE
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 06:36:06 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/4] powerpc: Call of_register_i2c_devices() for fsl-i2c.
Date: Thu, 7 Dec 2006 20:35:55 +0100
References: <20061207173541.GG22989@ld0162-tx32.am.freescale.net>
In-Reply-To: <20061207173541.GG22989@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612072035.56514.arnd@arndb.de>
Cc: i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 07 December 2006 18:35, Scott Wood wrote:
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -345,6 +345,8 @@ static int __init fsl_i2c_of_init(void)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0 =A0fsl_i2c_platform_data));
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (ret)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0g=
oto unreg;
> +
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0of_register_i2c_devices(np,=
 i);
> =A0=A0=A0=A0=A0=A0=A0=A0}

I get the impression that this fsl_i2c_of_init function is doing the
probing in the opposite way it should. Instead of searching the
whole device tree for type=3D"i2c" devices to call=20
platform_device_register_simple, can't you use of_platform_bus_probe
to create the i2c device in the first place, and then have a
of_platform_driver that calls of_register_i2c_devices() in its probe
function?

	Arnd <><
