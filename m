Return-Path: <khali@linux-fr.org>
Date: Sun, 29 Jun 2008 18:35:40 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [i2c] [PATCH] Convert i2c-mpc from a platform driver to an
	of_platform one
Message-ID: <20080629183540.4860a51a@hyperion.delvare>
In-Reply-To: <20080629122439.6295d63c@lappy.seanm.ca>
References: <9e4733910806101940o7f2f9863jb5e556ee2fc39a7e@mail.gmail.com>
	<20080625155825.43d07d20@hyperion.delvare>
	<9e4733910806281905l61714e33h8b26870e2c93539e@mail.gmail.com>
	<20080629044940.GC13658@secretlab.ca>
	<20080629083143.7f39b3c1@hyperion.delvare>
	<20080629065812.GO13876@secretlab.ca>
	<20080629091725.291974e9@hyperion.delvare>
	<20080629122439.6295d63c@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Brownell <david-b@pacbell.net>, Wolfram Sang <w.sang@pengutronix.de>,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>, Linux@ozlabs.org, Timur
	Tabi <timur@freescale.com>, I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 29 Jun 2008 12:24:39 -0400, Sean MacLennan wrote:
> On Sun, 29 Jun 2008 09:17:25 +0200
> "Jean Delvare" <khali@linux-fr.org> wrote:
> 
> > Ah, OK. If you use i2c_new_device() then it's alright.
> 
> Correct.
> 
> I have done the same thing for the i2c-ibm_iic.c driver. Jean, I think
> you will like this. It gets rid of the index and the numbered drivers.
> And the walking of the device tree is very clean because the dts knows
> all the devices.
> 
> For example here is the relevant portion of the dts for the Warp:
> 
> IIC0: i2c@ef600700 {
> 	compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic";
> 	reg = <ef600700 14>;
> 	interrupt-parent = <&UIC0>;
> 	interrupts = <2 4>;
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 
> 	ad7414@4a {
> 		compatible = "adi,ad7414";
> 		reg = <4a>;
> 		interrupts = <19 8>;
> 		interrupt-parent = <&UIC0>;
> 	};
> };
> 
> It clearly shows that first i2c controller (IIC0) contains one ad7414 device at address 4A.

That's fine with me. I expected the dts to be converted to platform
initialization data (i2c_board_info structures) being registered with
i2c_register_board_info() and numbered adapters. But if you prefer
unnumbered adapters and the platform code or the bus driver itself
calls i2c_new_device() based on the dts, that should work too.

-- 
Jean Delvare
