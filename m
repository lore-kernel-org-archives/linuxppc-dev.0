Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910710231529h1089eacdy888306f20af92555@mail.gmail.com>
Date: Tue, 23 Oct 2007 18:29:04 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Audio codec device tree entries
In-Reply-To: <8416ea754e013a67441aec778c81ad73@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
	<471E12C7.8020509@freescale.com>
	<8416ea754e013a67441aec778c81ad73@kernel.crashing.org>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is this consensus on how the tree should look?

There is no attempt to describe the codec connections inside the
device tree. Instead ASoC handles this by loading a platform specific
fabric driver. A simple example of this is that it is some codecs can
assign the six channel outputs under software control, the platform
specific driver tells which output is wired to the physical output
jacks so that alsa can label them correctly.

I'm still not clear on how to trigger the load of the fabric driver.
Right now I have a single kernel that works on Efika and my target
hardware.  This gets sorted out by define_machine(xxxx). I'll write
some code tonight to figure out how to load drivers and match on
codec0, codec1, etc. But how do I probe for the fabric driver I need
to figure out whether to load the Efika one or my target one.

ac97@2000 {           // PSC1
      compatible = "fsl,mpc5200b-psc-ac97","fsl,mpc5200-psc-ac97";
      cell-index = <0>;
      reg = <2000 100>;
      #address-cells = <1>;
      #size-cells = <0>;
      interrupts = <2 1 0>;
      interrupt-parent = <&mpc5200_pic>;
      sound@0 {
            reg = <0>;
            compatible = "idt,stac9766","ac97-audio"
      };
      modem@1 {
            reg = <1>;
            compatible = "idt,modem-codec","ac97-modem"
      };
};

------------------------

i2s@2000 {           // PSC1
      compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
      cell-index = <0>;
      reg = <2000 100>;
      interrupts = <2 1 0>;
      interrupt-parent = <&mpc5200_pic>;
};

i2s@2200 {           // PSC2
      compatible = "fsl,mpc5200b-psc-i2s","fsl,mpc5200-psc-i2s";
      cell-index = <1>;
      reg = <2200 100>;
      interrupts = <2 2 0>;
      interrupt-parent = <&mpc5200_pic>;
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
            compatible = "ti,tas5508";
            reg = <0>;
            i2s-handle = <&i2s@2000>;
      };
      codec1: i2s-codec@1 {
            compatible = "ti,tas5508";
            reg = <1>;
            i2s-handle = <&i2s@2000>;
      };
      codec2: i2s-codec@2 {
            compatible = "wolson,wm8750";
            reg = <2>;
            i2s-handle = <&i2s@2200>;
      };
};




-- 
Jon Smirl
jonsmirl@gmail.com
