Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id A6173B6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Dec 2009 17:02:52 +1100 (EST)
Received: by yxe9 with SMTP id 9so595204yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 22:02:50 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <10228901.1260376093135.JavaMail.ngmail@webmail18.arcor-online.net>
References: <10228901.1260376093135.JavaMail.ngmail@webmail18.arcor-online.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Dec 2009 23:02:30 -0700
Message-ID: <fa686aa40912102202q38f787bei26bac38666702ee3@mail.gmail.com>
Subject: Re: Q: how to access the MPC5200B's timer gipo's?
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 9, 2009 at 9:28 AM, Albrecht Dre=DF <albrecht.dress@arcor.de> w=
rote:
> Hi all,
>
> I have a (probably dumb) question regarding the access to the MPC5200B's =
timer gpio's. =A0I added e.g.
>
> timer@640 { =A0 =A0 // General Purpose Timer 4
> =A0 =A0 =A0 =A0compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> =A0 =A0 =A0 =A0reg =3D <0x640 0x10>;
> =A0 =A0 =A0 =A0interrupts =3D <1 13 0>;
> =A0 =A0 =A0 =A0interrupt-parent =3D <&mpc5200_pic>;
> =A0 =A0 =A0 =A0gpio-controller;
> =A0 =A0 =A0 =A0#gpio-cells =3D <2>;
> };
>
> in the DTS file to several timers. =A0Several gpiochipxxx folders are now=
 present in /sys/class/gpio/.
>
> In my code, I grab the node by calling of_find_node_by_path("/soc5200@f00=
00000/timer@640"), which returns the proper node. =A0Then I try to get the =
gpio number (for a call to gpio_set_value()) by calling of_get_gpio(node, 0=
) with the node found above. =A0However, this call always dumps
>
> of_get_gpio_flags: can't parse gpios property
> of_get_gpio_flags exited with status -2
>
> What would be the proper way to determine the gpio number for a timer's g=
pio pin from the node name or path?

The existing API (of_get_gpio()) doesn't operate on gpio-controller
nodes.  It operates on a node that uses the gpio (has a 'gpios'
property as documented in
Documentation/powerpc/dts-bindings/gpio/gpio.txt).

Therefore, you need a node to describe the *user* of the GPIO pin, and
call of_get_gpio() on that.  If you want to resolve the GPIO number
from the timer node itself, then you'll need to refactor the API a bit
to expose what you want.  Nobody has asked to do it that way until
now.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
