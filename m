Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807311403o63c37366ldae30e873f33a21e@mail.gmail.com>
Date: Thu, 31 Jul 2008 17:03:07 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
In-Reply-To: <48922715.2000304@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080731182810.GB29097@secretlab.ca>
	<48921888.3020900@grandegger.com> <48921954.4020103@freescale.com>
	<48921DED.6010403@grandegger.com>
	<9e4733910807311332q611b43b3y26f64b5269ccb657@mail.gmail.com>
	<fa686aa40807311335t1dd123d0mc385234ebe55248@mail.gmail.com>
	<48922273.6070801@freescale.com> <20080731204838.GA29834@secretlab.ca>
	<9e4733910807311355q3394b4bfg66c37055384451f7@mail.gmail.com>
	<48922715.2000304@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, Linux I2C <i2c@lm-sensors.org>,
	Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/31/08, Timur Tabi <timur@freescale.com> wrote:
> Jon Smirl wrote:
>
>  > Isn't there a single global divider that generates all the i2c source
>  > clocks? You don't want to copy a global value into each i2c node.
>
>
> Why not?  There are only two I2C devices, and it's theoretically possible for
>  them to have different input clock frequencies.   Keeping it in the I2C node
>  allows the I2C driver to reference a property directly in the node that its probing.

But that's the same as saying we should copy the system clock
frequency into all of the PSC nodes because we might implement
hardware where they aren't all clocked off from the same input clock
source.

>  > Aren't we talking about the /2 or /3 or /1 divider that appears to be
>  > randomly implemented on various members of the mpc8xxx family?

I don't this these dividers or clocks need to be exposed at all if
you'd just put that ugly code snippet into your platform driver.


>
>
> Yes.
>
>
>  --
>  Timur Tabi
>  Linux kernel developer at Freescale
>


-- 
Jon Smirl
jonsmirl@gmail.com
