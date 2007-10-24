Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40710240828p532e8e4axf1f9b9ad4cd324f8@mail.gmail.com>
Date: Wed, 24 Oct 2007 09:28:42 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Audio codec device tree entries
In-Reply-To: <471F5FC4.1040804@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
	<471E12C7.8020509@freescale.com>
	<8416ea754e013a67441aec778c81ad73@kernel.crashing.org>
	<9e4733910710231529h1089eacdy888306f20af92555@mail.gmail.com>
	<471F52ED.10007@freescale.com>
	<9e4733910710240800y24952e70g8c318e35e2e45e2e@mail.gmail.com>
	<471F5FC4.1040804@freescale.com>
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
>
> > What I meant was that there is no attempt to describe how the codec is
> > connected to the external world. Those connections are described in
> > the fabric driver.
>
> Hmmm, I'm not sure I'm okay with that.  We can always add properties to those
> nodes if it's necessary.  However, now you're basically defining some parts of
> the board layout in the DTS, and some parts in the fabric driver.  On PowerPC
> platforms, the fabric driver is supposed to get board layout information from
> the device tree.

No, not always; if the description is too complex (like gpio's for
instance) then it is perfectly valid to build the knowledge into the
platform code.  It should be avoided; but the device tree doesn't need
to describe *everything*.

>
> > i2s@2200 {           // PSC2
> >      compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
> >      cell-index = <1>;
> >      reg = <2200 100>;
> >      interrupts = <2 2 0>;
> >      interrupt-parent = <&mpc5200_pic>;
> >      codec2: i2s-codec@2 {
>
> This should probably be codec0, since it's the first code on this I2S bus.
>
> >            compatible = "wolson,wm8750";
> >            reg = <2>;
> >            i2c-handle = <&i2c@3d00>;
> >      };
> > };
> >
> > i2c@3d00 {
> >      compatible = "fsl,mpc5200b-i2c", "fsl,mpc5200-i2c", "fsl-i2c";
> >      #address-cells = <1>;
> >      #size-cells = <0>;
> >      cell-index = <0>;
> >      reg = <3d00 40>;
> >      interrupts = <2 f 0>;
> >      interrupt-parent = <&mpc5200_pic>;
> >      fsl5200-clocking;
> > }
>
> My vote is for this version.  In fact, I think it *has* to be this way.  If
> you're using a CS4270 codec (as I am), the I2C interface is *optional*.  So I
> want the I2S node to point to the I2C node if it exists.

It doesn't have to be this way.  If the codec does not have a control
interface, then it can happily be a child of the i2s node.  But if it
*does*; don't break convention by separating it from it's control
interface.

I strongly recommend following the lead of ethernet phys and mdio busses here.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
