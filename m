Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910710240800y24952e70g8c318e35e2e45e2e@mail.gmail.com>
Date: Wed, 24 Oct 2007 11:00:51 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Audio codec device tree entries
In-Reply-To: <471F52ED.10007@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
	<471E12C7.8020509@freescale.com>
	<8416ea754e013a67441aec778c81ad73@kernel.crashing.org>
	<9e4733910710231529h1089eacdy888306f20af92555@mail.gmail.com>
	<471F52ED.10007@freescale.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/24/07, Timur Tabi <timur@freescale.com> wrote:
> Jon Smirl wrote:
> > Is this consensus on how the tree should look?
> >
> > There is no attempt to describe the codec connections inside the
> > device tree.
>
> I don't think I agree with that.  The device tree should indicate which codec is
> connected to which I2S/AC97 device.

What I meant was that there is no attempt to describe how the codec is
connected to the external world. Those connections are described in
the fabric driver.

I'm getting conflicting opinions on how the devices should be linked
into the tree. We should pick one and add it to the documentation.

The DTC experts need to tell us which way to make the pointers between
i2s and i2c for the codec.  Here's a another way it could be done that
looks more like the ac97 model.

i2s@2000 {           // PSC1
     compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
     cell-index = <0>;
     reg = <2000 100>;
     interrupts = <2 1 0>;
     interrupt-parent = <&mpc5200_pic>;
     codec0: i2s-codec@0 {
           compatible = "ti,tas5508";
           reg = <0>;
           i2c-handle = <&i2c@3d00>;
     };
     codec1: i2s-codec@1 {
           compatible = "ti,tas5508";
           reg = <1>;
           i2c-handle = <&i2c@3d00>;
     };
};

i2s@2200 {           // PSC2
     compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
     cell-index = <1>;
     reg = <2200 100>;
     interrupts = <2 2 0>;
     interrupt-parent = <&mpc5200_pic>;
     codec2: i2s-codec@2 {
           compatible = "wolson,wm8750";
           reg = <2>;
           i2c-handle = <&i2c@3d00>;
     };
};

i2c@3d00 {
     compatible = "fsl,mpc5200b-i2c", "fsl,mpc5200-i2c", "fsl-i2c";
     #address-cells = <1>;
     #size-cells = <0>;
     cell-index = <0>;
     reg = <3d00 40>;
     interrupts = <2 f 0>;
     interrupt-parent = <&mpc5200_pic>;
     fsl5200-clocking;
}

----- or would this be better? ---------------------

i2s@2000 {           // PSC1
     compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
     cell-index = <0>;
     reg = <2000 100>;
     interrupts = <2 1 0>;
     interrupt-parent = <&mpc5200_pic>;
     i2s-codec@0 {
           compatible = "ti,tas5508";
           reg = <0>;
     };
     i2s-codec@1 {
           compatible = "ti,tas5508";
           reg = <1>;
     };
};

i2s@2200 {           // PSC2
     compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
     cell-index = <1>;
     reg = <2200 100>;
     interrupts = <2 2 0>;
     interrupt-parent = <&mpc5200_pic>;
     i2s-codec@2 {
           compatible = "wolson,wm8750";
           reg = <2>;
     };
};

i2c@3d00 {
     compatible = "fsl,mpc5200b-i2c", "fsl,mpc5200-i2c", "fsl-i2c";
     #address-cells = <1>;
     #size-cells = <0>;
     cell-index = <0>;
     reg = <3d00 40>;
     interrupts = <2 f 0>;
     interrupt-parent = <&mpc5200_pic>;
     fsl5200-clocking;
     i2c-handle = <&i2s-codec@0 &i2s-codec@1 &i2s-codec@2>
}



>
> I see that you do that for the AC97 node, but not the I2S node.  Why?
>
> > I'm still not clear on how to trigger the load of the fabric driver.
> > Right now I have a single kernel that works on Efika and my target
> > hardware.  This gets sorted out by define_machine(xxxx). I'll write
> > some code tonight to figure out how to load drivers and match on
> > codec0, codec1, etc. But how do I probe for the fabric driver I need
> > to figure out whether to load the Efika one or my target one.
>
> I've been struggling with that one, too.  To keep it simple, I have the fabric
> driver just search for all the I2S nodes in my tree, and create ASoC objects for
> each one it finds.  There's some hackery there, but I don't think we need to
> solve all the problems at once.  The only thing that *has* to be right the first
> time is the device tree.
>
> > i2s@2200 {           // PSC2
> >       compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
> >       cell-index = <1>;
> >       reg = <2200 100>;
> >       interrupts = <2 2 0>;
> >       interrupt-parent = <&mpc5200_pic>;
> > };
> >
> > i2c@3d00 {
> >       compatible = "fsl,mpc5200b-i2c", "fsl,mpc5200-i2c", "fsl-i2c";
> >       #address-cells = <1>;
> >       #size-cells = <0>;
> >       cell-index = <0>;
> >       reg = <3d00 40>;
> >       interrupts = <2 f 0>;
> >       interrupt-parent = <&mpc5200_pic>;
> >       fsl5200-clocking;
> >
> >       codec0: i2s-codec@0 {
> >             compatible = "ti,tas5508";
> >             reg = <0>;
> >             i2s-handle = <&i2s@2000>;
> >       };
>
> I'd do this the other way around -- that is:
>
> i2s@2200 {           // PSC2
>         compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
>         ...
>         i2c-handle = <&codec0>;  /* Or something like that */
> };
>
> The reason is because I think the I2S driver will be instantiated *first* as an
> I2S driver and then it will create the I2C instantiation.
>


-- 
Jon Smirl
jonsmirl@gmail.com
