Return-Path: <timur@freescale.com>
Message-ID: <471F5FC4.1040804@freescale.com>
Date: Wed, 24 Oct 2007 10:07:48 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Audio codec device tree entries
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>	<471E12C7.8020509@freescale.com>	<8416ea754e013a67441aec778c81ad73@kernel.crashing.org>	<9e4733910710231529h1089eacdy888306f20af92555@mail.gmail.com>	<471F52ED.10007@freescale.com>
	<9e4733910710240800y24952e70g8c318e35e2e45e2e@mail.gmail.com>
In-Reply-To: <9e4733910710240800y24952e70g8c318e35e2e45e2e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> What I meant was that there is no attempt to describe how the codec is
> connected to the external world. Those connections are described in
> the fabric driver.

Hmmm, I'm not sure I'm okay with that.  We can always add properties to those 
nodes if it's necessary.  However, now you're basically defining some parts of 
the board layout in the DTS, and some parts in the fabric driver.  On PowerPC 
platforms, the fabric driver is supposed to get board layout information from 
the device tree.

> I'm getting conflicting opinions on how the devices should be linked
> into the tree. We should pick one and add it to the documentation.

It's a battle of wills!

> The DTC experts need to tell us which way to make the pointers between
> i2s and i2c for the codec.  Here's a another way it could be done that
> looks more like the ac97 model.
> 
> i2s@2000 {           // PSC1
>      compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
>      cell-index = <0>;
>      reg = <2000 100>;
>      interrupts = <2 1 0>;
>      interrupt-parent = <&mpc5200_pic>;
>      codec0: i2s-codec@0 {
>            compatible = "ti,tas5508";
>            reg = <0>;
>            i2c-handle = <&i2c@3d00>;
>      };
>      codec1: i2s-codec@1 {
>            compatible = "ti,tas5508";
>            reg = <1>;
>            i2c-handle = <&i2c@3d00>;
>      };
> };
> 
> i2s@2200 {           // PSC2
>      compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
>      cell-index = <1>;
>      reg = <2200 100>;
>      interrupts = <2 2 0>;
>      interrupt-parent = <&mpc5200_pic>;
>      codec2: i2s-codec@2 {

This should probably be codec0, since it's the first code on this I2S bus.

>            compatible = "wolson,wm8750";
>            reg = <2>;
>            i2c-handle = <&i2c@3d00>;
>      };
> };
> 
> i2c@3d00 {
>      compatible = "fsl,mpc5200b-i2c", "fsl,mpc5200-i2c", "fsl-i2c";
>      #address-cells = <1>;
>      #size-cells = <0>;
>      cell-index = <0>;
>      reg = <3d00 40>;
>      interrupts = <2 f 0>;
>      interrupt-parent = <&mpc5200_pic>;
>      fsl5200-clocking;
> }

My vote is for this version.  In fact, I think it *has* to be this way.  If 
you're using a CS4270 codec (as I am), the I2C interface is *optional*.  So I 
want the I2S node to point to the I2C node if it exists.
