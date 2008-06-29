Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910806281905l61714e33h8b26870e2c93539e@mail.gmail.com>
Date: Sat, 28 Jun 2008 22:05:28 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>,
	"Grant Likely" <grant.likely@secretlab.ca>,
	"Timur Tabi" <timur@freescale.com>
Subject: Re: [i2c] [PATCH] Convert i2c-mpc from a platform driver to an
	of_platform one
In-Reply-To: <20080625155825.43d07d20@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910806101940o7f2f9863jb5e556ee2fc39a7e@mail.gmail.com>
	<20080625155825.43d07d20@hyperion.delvare>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Wolfram Sang <w.sang@pengutronix.de>, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 6/25/08, Jean Delvare <khali@linux-fr.org> wrote:
>  >
>  >       i2c->adap = mpc_ops;
>  > -     i2c->adap.nr = pdev->id;
>  >       i2c_set_adapdata(&i2c->adap, i2c);
>  > -     i2c->adap.dev.parent = &pdev->dev;
>  > -     if ((result = i2c_add_numbered_adapter(&i2c->adap)) < 0) {
>  > +     i2c->adap.dev.parent = &op->dev;
>  > +
>  > +     result = i2c_add_adapter(&i2c->adap);
>
>
> The driver was previously using i2c_add_numbered_adapter(), giving MPC
>  platform the possibility to use new-style i2c drivers:
>  http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1469fa263870acd890a4b9f6ef557acc5d673b44
>  You're breaking this, I doubt it's on purpose?

Grant, what do you want here? You're the one who converted it to
i2c_add_numbered_adapter. But in other posts you've said that the
device tree should have nothing to do with bus numbering.

Once this driver is converted to an OF one it shouldn't need bus ids
since all of the i2c devices will be children of the bus node. We can
just let the i2c subsystem assign a bus number.

Timur has some issues with the i2c bus number in his ALSA driver. The
problem is locating the i2c device when the i2s driver loads. Parsing
the device tree to extract an i2c bus and device number is not a good
solution.

codec-handle should give you the i2c device node. But then we can't
use of_find_device_by_node because the i2c device is not an of_device,
it's a cross platform i2c_device. Should of_find_device_by_node()
return a 'struct device' instead of a 'struct of_device' and leave it
as a user exercise to cast up? It is used nine times in the kernel,
mostly sparc.

		i2s@2000 { /* PSC1 in i2s mode */
			device_type = "sound";
			compatible = "mpc5200b-psc-i2s","fsl,mpc5200b-psc-i2s";
			cell-index = <0>;
			reg = <0x2000 0x100>;
			interrupts = <0x2 0x2 0x0>;
			interrupt-parent = <&mpc5200_pic>;
			codec-handle = <&tas0>;
		};
		i2c@3d00 {
			#address-cells = <1>;
			#size-cells = <0>;
			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
			cell-index = <0>;
			reg = <0x3d00 0x40>;
			interrupts = <0x2 0xf 0x0>;
			interrupt-parent = <&mpc5200_pic>;
			fsl5200-clocking;
			
			tas0:codec@1b {
				compatible = "ti,tas5504";
				reg = <0x1b>;
			};
		};

-- 
Jon Smirl
jonsmirl@gmail.com
