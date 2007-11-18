Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0fd3304ee694b2dc6a8f3055c08dc015@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Revisited, audio codec device tree entries.
Date: Sun, 18 Nov 2007 21:16:12 +0100
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 		ac97@2200 {		// PSC2
> 			compatible = "mpc5200b-psc-ac97","mpc5200-psc-ac97";
> 			cell-index = <1>;
> 			reg = <2200 100>;
> 			interrupts = <2 2 0>;
> 			interrupt-parent = <&mpc5200_pic>;

You need #address-cells, #size-cells here.

> 			codec@0 {
> 				compatible = "idt,stac9766";
> 				reg = <0>;
> 			};
> 		};
>
> 		i2c@3d40 {
> 			compatible = "mpc5200b-i2c","mpc5200-i2c","fsl-i2c";
> 			reg = <3d40 40>;
> 			interrupts = <2 10 0>;
> 			interrupt-parent = <&mpc5200_pic>;
> 			fsl5200-clocking;

And here.

> 			codec@15 {
> 				compatible = "ti,tas5504";
> 				reg = <15>;
> 				i2s-handle = <i2s@2400>;

Should use an alias here (or the full path, if that works).

> 			};
> 		};
> 		
> 		i2s@2400 {		// PSC4
> 			compatible = "mpc5200b-psc-i2s","mpc5200-psc-i2s";
> 			cell-index = <1>;
> 			reg = <2400 100>;
> 			interrupts = <2 3 0>;
> 			interrupt-parent = <&mpc5200_pic>;
> 		};
>
> In the ALSA SOC model the i2s, codec and ac97 drivers are all generic.
> A fabric driver tells specifically how a generic codec is wired into
> the board. What I haven't been able figure out is how to load the
> right fabric driver.

Whatever way works for the platform.

> It is starting to make more sense to me that fabric driver actually
> does represent a physical device - the cluster of wires.

That's only part of it, as far as I understand.

> David Gibson
> made a proposal that a fabric node wrap the codec node. That doesn't
> work very well with the i2c bus where the bus code is walking down the
> nodes and triggering the instantiation of the i2c drivers.

Yeah, doesn't work at all.

> But what about putting the fabric node inside the codec node?

_Which_ codec node?  Having more than one isn't uncommon at all.


There is no way you can describe this fabric stuff in a generic way in
the device tree.  Just hardcode it in your platform support code; if
the platform code supports several variant boards, _it_ can probe that
from the device tree (in whatever way works for that platform).


Segher
