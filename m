Return-Path: <hollis@penguinppc.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by ozlabs.org (Postfix) with ESMTP id 9E88167C26
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 06:20:23 +1000 (EST)
Subject: Re: [PATCH] Add MPC8641 HPCN Device Tree Source file.
From: Hollis Blanchard <hollis@penguinppc.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1154544503.19994.42.camel@cashmere.sps.mot.com>
References: <1154544503.19994.42.camel@cashmere.sps.mot.com>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 14:50:17 -0500
Message-Id: <1154548217.32357.27.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-02 at 13:48 -0500, Jon Loeliger wrote:
> 
> +               PowerPC,8641@0 {
> +                       device_type = "cpu";
> +                       reg = <0>;
> +                       d-cache-line-size = <20>;       // 32 bytes
> +                       i-cache-line-size = <20>;       // 32 bytes
> +                       d-cache-size = <8000>;          // L1, 32K
> +                       i-cache-size = <8000>;          // L1, 32K
> +                       timebase-frequency = <0>;       // 33 MHz,
> from uboot
> +                       bus-frequency = <0>;            // From uboot
> +                       clock-frequency = <0>;          // From uboot
> +                       32-bit;
> +                       linux,boot-cpu;
> +               }; 

I need to do something similar for Xen, so I was curious: I guess the
preferred way for runtime software to fill in values is by *overwriting*
bogus values inserted at compile time?

The other alternative would be for the runtime code to insert new
properties (presumably via memmove()), but overwriting definitely seems
simpler.

-Hollis
