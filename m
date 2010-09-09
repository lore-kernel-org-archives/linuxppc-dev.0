Return-Path: <glikely@secretlab.ca>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id 8C160B70D2
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 03:06:50 +1000 (EST)
Received: by pvg16 with SMTP id 16so836971pvg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Sep 2010 10:06:48 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Thu, 9 Sep 2010 11:06:46 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: =?iso-8859-1?Q?Andr=E9?= Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: How to define an I2C-to-SPI bridge device ?
Message-ID: <20100909170646.GD6273@angua.secretlab.ca>
References: <1283502979.17812.22.camel@swa-m460>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1283502979.17812.22.camel@swa-m460>
Cc: LinuxPPC List <linuxppc-dev@ozlabs.org>,
	DevTreeDiscuss <devicetree-discuss@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 03, 2010 at 10:36:19AM +0200, André Schwarz wrote:
> Hi,
> 
> we're about to get new MPC8377 based hardware with various peripherals.
> There are two I2C-to-SPI bridge devices (NXP SC18IS602) and I'm not sure
> how to define a proper dts...
> 
> Of course it's an easy thing creating 2 child nodes on the CPU's I2C
> device - but how can I represent the created SPI bus ?
> 
> Is the (possibly) required driver (of_sc18is60x_spi ?) supposed to be an
> I2C slave or an SPI host driver ?

Both!  The driver would get probed from the i2c bus, and it would
create and register an spi master.  If the spi bus registration
includes a pointer to the device tree node, then the child nodes will
automatically be registered as spi_devices.

The dts is also fairly straight forward:

i2c-bus: i2c@80001000 {
	compatible = <blah>;
	#address-cells = <1>;
	#size-cells = <0>;

	spi-bus: spi@28{
		compatible = "nxp,sc18is602";
		#address-cells = <1>;
		#size-cells = <0x28>;
		reg = <0>;

		spi-device@0 {
			compatible = <blah>;
			reg = <0>;
		};
		spi-device@1 {
			compatible = <blah>;
			reg = <1>;
		};
		spi-device@2 {
			compatible = <blah>;
			reg = <2>;
		};
	};
};

Cheers,
g.

> 
> 
> Any help is welcome.
> 
> 
> -- 
> Mit freundlichen Grüßen / Best regards
> 
> André Schwarz
> 
> ___________________________________________
> 
> MATRIX VISION GmbH
> - Entwicklung / Development -
> Talstraße 16
> D-71570 Oppenweiler
> 
> Fon: ++49-07191-9432-420
> Fax: ++49-07191-9432-288
> eMail: andre.schwarz@matrix-vision.de
> web: www.matrix-vision.de
> 
> 
> MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
> Registergericht: Amtsgericht Stuttgart, HRB 271090
> Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Hans-Joachim Reich
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
