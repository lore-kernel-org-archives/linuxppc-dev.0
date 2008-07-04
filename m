Return-Path: <G.Chen@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 604CBDDEDC
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 13:59:16 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m643xAfS008538
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 20:59:11 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m643x9SP018235
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 22:59:09 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH v2 3/5] of-bindings: Add binding documentation for SPI
	bussesand devices
Date: Fri, 4 Jul 2008 11:59:07 +0800
Message-ID: <58A20A281BAF1047B4EAE68DE5C0BDC2010121B9@zch01exm21.fsl.freescale.net>
In-Reply-To: <20080703010308.26187.23037.stgit@trillian.secretlab.ca>
References: <20080703005749.26187.71719.stgit@trillian.secretlab.ca>
	<20080703010308.26187.23037.stgit@trillian.secretlab.ca>
From: "Chen Gong" <G.Chen@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>, <linuxppc-dev@ozlabs.org>,
	<spi-devel-general@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Cc: david-b@pacbell.net, fabrizio.garetto@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: linuxppc-dev-bounces+b11801=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+b11801=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Grant Likely
> Sent: 2008?7?3? 9:03
> To: linuxppc-dev@ozlabs.org;=20
> spi-devel-general@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Cc: david-b@pacbell.net; fabrizio.garetto@gmail.com
> Subject: [PATCH v2 3/5] of-bindings: Add binding=20
> documentation for SPI bussesand devices
>=20
> From: Grant Likely <grant.likely@secretlab.ca>
>=20
> Add documentation about how to describe SPI busses in the device tree.
>=20
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>=20
>  Documentation/powerpc/booting-without-of.txt |   60=20
> ++++++++++++++++++++++++++
>  1 files changed, 60 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/powerpc/booting-without-of.txt=20
> b/Documentation/powerpc/booting-without-of.txt
> index 1d2a772..7d3564f 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -58,6 +58,7 @@ Table of Contents
>        o) Xilinx IP cores
>        p) Freescale Synchronous Serial Interface
>  	  q) USB EHCI controllers
> +      t) SPI busses
> =20
>    VII - Marvell Discovery mv64[345]6x System Controller chips
>      1) The /system-controller node
> @@ -2870,6 +2871,65 @@ platforms are moved over to use the=20
> flattened-device-tree model.
>  		reg =3D <0xe8000000 32>;
>  	};
> =20
> +    t) SPI (Serial Peripheral Interface) busses
> +
> +    SPI busses can be described with a node for the SPI master device
> +    and a set of child nodes for each SPI slave on the bus.  For this
> +    discussion, it is assumed that the system's SPI controller is in
> +    SPI master mode.  This binding does not describe SPI controllers
> +    in slave mode.
> +
> +    The SPI master node requires the following properties:
> +    - #address-cells  - number of cells required to define a=20
> chip select
> +			address on the SPI bus.
> +    - #size-cells     - should be zero.
> +    - compatible      - name of SPI bus controller following=20
> generic names
> +			recommended practice.
> +    No other properties are required in the SPI bus node. =20
> It is assumed
> +    that a driver for an SPI bus device will understand that=20
> it is an SPI bus.
> +    However, the binding does not attempt to define the=20
> specific method for
> +    assigning chip select numbers.  Since SPI chip select=20
> configuration is
> +    flexible and non-standardized, it is left out of this=20
> binding with the
> +    assumption that board specific platform code will be=20
> used to manage
> +    chip selects.  Individual drivers can define additional=20
> properties to
> +    support describing the chip select layout.
> +
> +    SPI slave nodes must be children of the SPI master node and can
> +    contain the following properties.
> +    - reg             - (required) chip select address of device.
> +    - compatible      - (required) name of SPI device=20
> following generic names
> +			recommended practice
> +    - max-speed       - (required) Maximum SPI clocking=20
> speed of device in Hz
> +    - spi,cpol        - (optional) Device requires inverse=20
> clock polarity
> +    - spi,cpha        - (optional) Device requires shifted=20
> clock phase
> +    - linux,modalias  - (optional, Linux specific) Force=20
> binding of SPI device
> +			to a particular spi_device driver. =20
> Useful for changing
> +			driver binding between spidev and a=20
> kernel SPI driver.
> +

How about adding a "model" property to describe actual devie type.
Such as using a "sst25vf040b" device with spi-interface, we can
use model=3D"sst25vf040b" to describe it.
