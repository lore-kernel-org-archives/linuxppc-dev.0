Return-Path: <randy.dunlap@oracle.com>
Received: from agminet02.oracle.com (agminet02.oracle.com [141.146.126.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9F365DE385
	for <linuxppc-dev@ozlabs.org>; Sat, 17 May 2008 07:50:17 +1000 (EST)
Received: from agminet01.oracle.com (agminet01.oracle.com [141.146.126.228])
	by agminet02.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id
	m4GKmcA1004381
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 15:48:38 -0500
Date: Fri, 16 May 2008 13:47:20 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for SPI busses
Message-Id: <20080516134720.22d0569b.randy.dunlap@oracle.com>
In-Reply-To: <20080516193613.28030.13950.stgit@trillian.secretlab.ca>
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516193613.28030.13950.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: fabrizio.garetto@gmail.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 16 May 2008 13:36:13 -0600 Grant Likely wrote:

> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index 1d2a772..452c242 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -2870,6 +2871,66 @@ platforms are moved over to use the flattened-device-tree model.
>  		reg = <0xe8000000 32>;
>  	};
>  
> +    s) SPI (Serial Peripheral Interface) busses
> +
> +    SPI busses can be described with a node for the SPI master device
> +    and a set of child nodes for each SPI slave on the bus.  For this
> +    discussion, it is assumed that the system's SPI controller is in
> +    SPI master mode.  This binding does not describe SPI controllers
> +    in slave mode.
> +
> +    The SPI master node requires the following properties:
> +    - #address-cells  - number of cells required to define a chip select
> +			address on the SPI bus.
> +    - #size-cells     - should be zero.
> +    - compatible      - name of SPI bus controller following generic names
> +			recommended practice.
> +    No other properties are required in the spi bus node.  It is assumed
                                               ~~~

> +    that a driver for an SPI bus device will understand that it is an SPI bus.
> +    However, the binding does not attempt to define the specific method for
> +    assigning chip select numbers.  Since SPI chip select configuration is
> +    flexible and non-standardized, it is left out of this binding with the
> +    assumption that board specific platform code will be used to manage
> +    chip selects.  Individual drivers can define additional properties to
> +    support describing the chip select layout.
> +
> +    SPI slave nodes must be children of the spi master node and can
                                               ~~~

> +    contain the following properties.
> +    - reg             - (required) chip select address of device.
> +    - compatible      - (required) name of SPI device following generic names
> +			recommended practice
> +    - max-speed       - (optional) Maximum SPI clocking speed of device in Hz
> +    - spi,cpol        - (optional) Device requires inverse clock polarity
> +    - spi,cpha        - (optional) Device requires shifted clock phase
> +    - linux,modalias  - (optional, Linux specific) Force binding of SPI device
> +			to a particular spi_device driver.  Useful for changing
> +			driver binding between spidev and a kernel spi driver.
                                                                   ~~~

Hi,
You mostly capitalize "SPI" in sentences (i.e., when it's not part of
a function name or OF data), so could the 3 underlined instances of it
also be all caps?

Thanks,
---
~Randy
