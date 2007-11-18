Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
Date: Sun, 18 Nov 2007 13:10:10 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "PowerPC dev list" <Linuxppc-dev@ozlabs.org>
Subject: Revisited, audio codec device tree entries.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've been trying to write ALSA SOC code supporting audio codecs and
device trees.

This looks ok for the main device tree entires. Codecs are hung off
from their controlling bus. It may still need a little tweaking.

		ac97@2200 {		// PSC2
			compatible = "mpc5200b-psc-ac97","mpc5200-psc-ac97";
			cell-index = <1>;
			reg = <2200 100>;
			interrupts = <2 2 0>;
			interrupt-parent = <&mpc5200_pic>;
			codec@0 {
				compatible = "idt,stac9766";
				reg = <0>;
			};
		};

		i2c@3d40 {
			compatible = "mpc5200b-i2c","mpc5200-i2c","fsl-i2c";
			reg = <3d40 40>;
			interrupts = <2 10 0>;
			interrupt-parent = <&mpc5200_pic>;
			fsl5200-clocking;

			codec@15 {
				compatible = "ti,tas5504";
				reg = <15>;
				i2s-handle = <i2s@2400>;
			};
		};
		
		i2s@2400 {		// PSC4
			compatible = "mpc5200b-psc-i2s","mpc5200-psc-i2s";
			cell-index = <1>;
			reg = <2400 100>;
			interrupts = <2 3 0>;
			interrupt-parent = <&mpc5200_pic>;
		};

In the ALSA SOC model the i2s, codec and ac97 drivers are all generic.
A fabric driver tells specifically how a generic codec is wired into
the board. What I haven't been able figure out is how to load the
right fabric driver.

It is starting to make more sense to me that fabric driver actually
does represent a physical device - the cluster of wires. David Gibson
made a proposal that a fabric node wrap the codec node. That doesn't
work very well with the i2c bus where the bus code is walking down the
nodes and triggering the instantiation of the i2c drivers.

But what about putting the fabric node inside the codec node?

			codec@15 {
				compatible = "ti,tas5504";
				reg = <15>;
				i2s-handle = <i2s@2400>;
				codec-fabric {
					compatible = "digispeaker,fabric"
				};
			};

			codec@0 {
				compatible = "idt,stac9766";
				reg = <0>;
				codec-fabric {
					compatible = "efika,fabric"
				};
			};

This sort of makes sense, the ac97/i2c bus is connected to the codec,
which is then connected to the fabric.

The example used in the ALSA doc of an ac97 chip needing a fabric
driver was a case where the ac97 chip has an external amp. The fabric
driver uses a GPIO to turn the amp on/off with suspend/resume.


-- 
Jon Smirl
jonsmirl@gmail.com
