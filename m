Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id B9EA7679F4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 May 2005 02:13:21 +1000 (EST)
In-Reply-To: <4288C4FD.8080104@246tNt.com>
References: <0.20050516_092837.tnt@patchsend.246tNt.com>
	<5fe12cfac05d60b8af016382594e50db@freescale.com>
	<4288C4FD.8080104@246tNt.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <1daddfc798ee70a790e31b92d58ebdd7@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 17 May 2005 11:12:53 -0500
To: "Sylvain Munaut" <tnt@246tNt.com>
Cc: Asier Llano Palacios <a.llano@usyscom.com>,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] i2c: Race fix for i2c-mpc.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sylvain,

Looks reasonable to me.  Add a Signed-off-by: Kumar Gala=20
<kumar.gala@freescale.com> line and sent to GregKH, lm-sensors guys. =20
CC me if you would.

- kumar

On May 16, 2005, at 11:06 AM, Sylvain Munaut wrote:

> Kumar Gala wrote:
>  > Sylvain,
>  >
> > Are you really still using the OCP side of the driver?=A0 Do we need =
a
> > similar fix for the platform driver side?
>
> /me hits himself with a hammer
>
> Damn I included the wrong diff ... Sorry about that, the good one is
>  in attachment.
>
>
>
> No I don't use the OCP side but I changed both to stay coherent. I=20
> don't
> experience the problem myself, it's Asier who reported it and it
> apparently mostly shows up on the second i2c bus (where I have nothing
> on my hardware and anyway my bootloader init I2C beforehand ...).
>
> But the patch looks correct, when a bus is added, it should be ready =
to
> be used.
>
>
>
> =A0=A0=A0=A0=A0=A0=A0 Sylvain
>
>
>
> ---
>  i2c: Race fix for i2c-mpc.c
>
> The problem was that the clock speed and driver data is
>  initialized after the i2c adapter was added. This caused
>  the i2c bus to start working at a wrong speed. (Mostly
> noticable on the second bus on mpc5200)
>
> With this patch we've tried to keep the i2c adapter
>  working perfectly all the time it is included in the system.
>  Initialize before added, Remove garbage after deleleted.
>
>
>
> Submitted-by: Asier Llano Palacios
>  Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
> ---
> <i2c-mpc-racefix.diff>=
