Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40710222057y58202c8ev4610e045e5e389df@mail.gmail.com>
Date: Mon, 22 Oct 2007 21:57:54 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Audio codec device tree entries
In-Reply-To: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/22/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> Is this what the device tree entries should look like?
>
> First example is ac97 audio:
>
> ac97@2000 {           // PSC1
>       device_type = "sound";
>       compatible = "mpc5200b-psc-ac97\0mpc5200-psc-ac97";

This format is so, like. 3 months ago.  :-)

dtc now supports a comma separated format:  property = "string1",
"string2", "string3"

Embedded nulls no longer needed.

>       cell-index = <0>;
>       reg = <2000 100>;
>       interrupts = <2 1 0>;
>       interrupt-parent = <&mpc5200_pic>;
>       codec-handle = <&codec0>
> };

Isn't this the ac97 bus node?  Can't the ac97 codecs simply be
children of this bus?

>
> pseudo-sound@0 { // use to trigger loading platform specific fabric driver
>       device_type = "pseudo-sound"
> };

I don't think this is a good idea.  The device tree is for describing
your hardware; so the layout should reflect that.  Make the platform
code do the right thing with the real nodes.

>
> codec0:codec@0 {
>       device_type = "codec"
>       compatible = "stac9766\0ac97"
> };
>
> Second is i2s/i2c connected:
> How do I link this to the i2c bus?
>
> i2s@2000 {           // PSC1
>       device_type = "sound";
>       compatible = "mpc5200b-psc-i2s\0mpc5200-psc-i2s";
>       cell-index = <0>;
>       reg = <2000 100>;
>       interrupts = <2 1 0>;
>       interrupt-parent = <&mpc5200_pic>;
>       codec-handle = <&codec0>
> };
>
> i2c@3d00 {
>       device_type = "i2c";
>       compatible = "mpc5200b-i2c\0mpc5200-i2c\0fsl-i2c";
>       cell-index = <0>;
>       reg = <3d00 40>;
>       interrupts = <2 f 0>;
>       interrupt-parent = <&mpc5200_pic>;
>       fsl5200-clocking;
> };
>
> pseudo-sound@0 { // use to trigger loading platform specific fabric driver
>       device_type = "pseudo-sound"
> };
>
> codec0:codec@0 {
>       device_type = "codec"
>       compatible = "tas5508"
> };

I think this is what you want:

ac97@2000 {           // PSC1
      compatible = "fsl,mpc5200b-psc-ac97","fsl,mpc5200-psc-ac97";
      cell-index = <0>;
      reg = <2000 100>;
      #address-cells = <1>;
      #size-cells = <0>;
      interrupts = <2 1 0>;
      interrupt-parent = <&mpc5200_pic>;
      // The following codec stuff could be a little off; It has been
a while since I've looked
      // at ac97 codec interfacing, but if I remember correctly you
can have multiple
      // codecs on an ac97 bus; an audio codec and a modem codec.  The following
      // reflects that understanding...
      ac97-codec@0 {
            // This could be the audio codec
            reg = <0>;
            compatible = "stac9766","ac97-audio"
      };
      ac97-codec@1 {
            // This could be the modem codec
            reg = <1>;
            compatible = "super-sexy-modem-codec","ac97-modem"
      };
};


// Now here's a big example for i2c.
// I've shown 3 audio interfaces; 2 i2s busses and 1 i2c controller.
// This may not be realistic on a 5200, but it is a possible scenario
and this shows
// that it can be handled elegantly.
i2s@2000 {           // PSC1
      compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
      cell-index = <0>;
      reg = <2000 100>;
      interrupts = <2 1 0>;
      interrupt-parent = <&mpc5200_pic>;

      // There are 2 codecs on this i2s bus; either only one at a time
can be used, or
      // (if both the i2s controller and codecs support it) both at
the same time if audio
      // stream interleaving is supported.
      codec-handle = <&codec0 &codec2>;
};

i2s@2200 {           // PSC2
      compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
      cell-index = <0>;
      reg = <2200 100>;
      interrupts = <2 2 0>;
      interrupt-parent = <&mpc5200_pic>;
      codec-handle = <&codec1>;
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

      codec0: i2s-codec@0 {
            compatible = "<mfg>,tas5508";
            reg = <0>;
      };
      codec1: i2s-codec@1 {
            compatible = "<mfg>,tas5508";
            reg = <1>;
      };
      codec2: i2s-codec@2 {
            compatible = "<mfg>,tas5508";
            reg = <2>;
      };
};

So, this scheme describes the hardware, but it does not describe 2 of
your questions:

1. How does the device tree describe the myriad of possible circuits
that an audio codec can get dropped into, and
2. How do the drivers get probed

For question #1, I think the answer is simple... it doesn't try.  :-)

As was described in the previous thread, trying to describe the
circuit is very complex and figuring out what software would do with
such a description is even worse.  Instead, I propose the following:
- as much as possible, make the board firmware and the platform setup
code configure the GPIOs, port_config, and other 'fixed' configuration
- make the driver code look at either the board model/compatible
properties or add a board-unique value to the codec's compatible list.
 Either way the driver can apply board specific tweaks to its
behavious.  (I think the better solution is to add a value to the
front of the codec's compatible list because the same circuit can be
used on a different board and it can then claim compatibility with the
older board for just that part of the circuit).

(Segher, what are your thoughts on my above suggestion?)

As for question #2, I think you make the i2s driver probe on the i2s
bus node and the ac97 driver probe on the ac97 bus node.  In both
cases, the driver can find the link to the codec; determine what kind
of system it is running on, and instantiate the appropriate ASoC
fabric driver.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
