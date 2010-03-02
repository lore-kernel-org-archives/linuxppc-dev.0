Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id D47A6B7D20
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Mar 2010 07:22:29 +1100 (EST)
Received: by gwj20 with SMTP id 20so330084gwj.15
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Mar 2010 12:22:28 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1267467114.2218.0@antares>
References: <1267467114.2218.0@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 2 Mar 2010 13:22:08 -0700
Message-ID: <fa686aa41003021222k2cdb5200vbaaf329c6e505048@mail.gmail.com>
Subject: Re: [Patch] mpc5200b: improve baud rate calculation (reach high baud
	rates, better accuracy)
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Albrecht,

Thanks for this work, comment below...

On Mon, Mar 1, 2010 at 11:11 AM, Albrecht Dre=DF <albrecht.dress@arcor.de> =
wrote:
> On the MPC5200B, select the baud rate prescaler as /4 by default to make =
very
> high baud rates (e.g. 3 MBaud) accessible and to achieve a higher precisi=
on
> for high baud rates in general. For baud rates below ~500 Baud, the code =
will
> automatically fall back to the /32 prescaler. =A0The original MPC5200 doe=
s only
> have a /32 prescaler which is detected only once and stored in a global. =
=A0A
> new chip-dependent method is used to set the divisor.
>
> Tested on a custom 5200B based board, with up to 3 MBaud.
>
> Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
>
> ---
>
> --- linux-2.6.33/drivers/serial/mpc52xx_uart.c.orig =A0 =A0 2010-02-24 19=
:52:17.000000000 +0100
> +++ linux-2.6.33/drivers/serial/mpc52xx_uart.c =A02010-02-26 21:12:51.000=
000000 +0100
> =A0/* Search for bus-frequency property in this node or a parent */
> =A0static unsigned long mpc52xx_getuartclk(void *p)
> =A0{
> =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0* 5200 UARTs have a / 32 prescaler
> - =A0 =A0 =A0 =A0* but the generic serial code assumes 16
> - =A0 =A0 =A0 =A0* so return ipb freq / 2
> + =A0 =A0 =A0 =A0* The 5200 has only /32 prescalers.
> + =A0 =A0 =A0 =A0* 5200B UARTs have a /4 or a /32 prescaler. =A0For highe=
r accuracy, we
> + =A0 =A0 =A0 =A0* do all calculations using the /4 prescaler for this ch=
ip.
> + =A0 =A0 =A0 =A0* The generic serial code assumes /16 so return ipb freq=
 / 2 (5200)
> + =A0 =A0 =A0 =A0* or ipb freq * 4 (5200B).
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 return mpc5xxx_get_bus_frequency(p) / 2;
> + =A0 =A0 =A0 if (is_mpc5200b =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return mpc5xxx_get_bus_frequency(p) * 4;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return mpc5xxx_get_bus_frequency(p) / 2;
> =A0}

Remove this function entirely and the associated .getuartclk() hook
from the psc_ops structure.  Callers can just call
mpc5xxx_get_bus_frequency() directly.  mpc5121 already just passes
back the return value unmodified, and current mpc52xx code uses a /2,
but that would be eliminated if the new set_divisor hook took that
into account.  That way all the chip-specific clock setup calculation
is consolidated into a single function.  I like patches that make
things simpler.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
