Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 0A253DDDE3
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2008 02:09:22 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so404454ywh.39
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 07:09:20 -0800 (PST)
Message-ID: <fa686aa40811210709x4b8d10a3p568a1a4dbb8c7a8a@mail.gmail.com>
Date: Fri, 21 Nov 2008 08:09:20 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Juergen Beisert" <jbe@pengutronix.de>, "John Rigby" <jcrigby@gmail.com>
Subject: Re: [U-Boot] MPC5200B: Trouble with config pins
In-Reply-To: <200811211336.41159.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200811211336.41159.jbe@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, u-boot@lists.denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Juergen, I haven't seen this behaviour.  Have you asked you Freescale FAE?

Hey John, have you ever seen this sort of issue?

g.

On Fri, Nov 21, 2008 at 5:36 AM, Juergen Beisert <jbe@pengutronix.de> wrote:
> Hi all,
>
> we have trouble with the eth based config pins (ETH0...ETH6) of the MPC5200B
> CPU. These pins act as the interface to an external phy and also act as
> configurations pins to configure the size of the flash and other things.
> While the reset is active these pins should be in their high impedance state
> and the externally connected pull down resistors should define wire's voltage
> level. With the rising edge of the reset signal these levels will be latched
> into internal config registers.
> We are in trouble when we want to reboot the system (also watchdog based) or
> the internal watchdog barks and generates the CPU internal reset signal. In
> these cases these config pins will not change their level! So the wrong
> settings are latched in and our CPU is dead (misconfigured), sometimes a
> second reset helps, but most of the time only power cycling helps.
>
> What we see is:
>  - at the pins ETH_0 and ETH_3 (both are output only, when used for
>   ethernet)
>
>  * With an external 10k pulldown these lines never change their 3.3V level
>   even if the reset is active!
>  * With an external 1k pulldown these lines change their 3.3V level down to
>   something about 2.5V when the falling edge of the reset signal occurs.
>  * This level decreases slowly to 1.2V in about 1.2ms and than a falling edge
>   to 0V occures. Problem here is, the internal watchdog's generated reset
>   signal is much shorter, so the rising edge of this reset signal also
>   latches in the wrong settings and the CPU is dead.
>
> Some other things we see. A reset while:
>  - a running tftp command in U-Boot with disconnected network
>    -> system is always dead
>  - a running tftp command in U-Boot with connected network
>    -> system restarts
>   We can see in this case, the ETH_0 and ETH_3 are switching to low
>   level *immediatly* with the falling edge of the reset signal
>  - an activated interface ("ifconfig up") in Linux with *disconnected* network
>    -> system is always dead
>  - an activated interface ("ifconfig up") in Linux with *connected* network
>    -> system is always dead
>
> Does anybody see a behaviour like ours on his/her MPC5200B based system?
> Does anybody have an idea what the difference between U-Boot und Linux could
> be? Bug? Feature?
>
> Regards,
> Juergen
>
> --
> Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
>  Pengutronix - Linux Solutions for Science and Industry
>     Handelsregister: Amtsgericht Hildesheim, HRA 2686
>          Vertretung Sued/Muenchen, Germany
>   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
> _______________________________________________
> U-Boot mailing list
> U-Boot@lists.denx.de
> http://lists.denx.de/mailman/listinfo/u-boot
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
