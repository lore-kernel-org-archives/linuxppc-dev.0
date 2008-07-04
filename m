Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9987FDDE0A
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 09:37:23 +1000 (EST)
In-Reply-To: <20080703010308.26187.23037.stgit@trillian.secretlab.ca>
References: <20080703005749.26187.71719.stgit@trillian.secretlab.ca>
	<20080703010308.26187.23037.stgit@trillian.secretlab.ca>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1694b01b1b41f244e565298b430f021c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 3/5] of-bindings: Add binding documentation for SPI
	busses and devices
Date: Sat, 5 Jul 2008 01:36:58 +0200
To: Grant Likely <grant.likely@secretlab.ca>
Cc: david-b@pacbell.net, spi-devel-general@lists.sourceforge.net,
	fabrizio.garetto@gmail.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +    The SPI master node requires the following properties:
> +    - #address-cells  - number of cells required to define a chip 
> select
> +			address on the SPI bus.

Hrm.  Should this (and "reg" in the child node) be required for SPI
masters that have only one chip select?

> +    - max-speed       - (required) Maximum SPI clocking speed of 
> device in Hz

The property name should include something "SPI", it's way too generic
otherwise.

> +    - spi,cpol        - (optional) Device requires inverse clock 
> polarity
> +    - spi,cpha        - (optional) Device requires shifted clock phase

Don't abbr the property names, there's nothing wrong with longer names.
The names shouldn't start with "spi," either, "spi" isn't a vendor;
how about "spi-inverse-clock-polarity" or similar?

> +    - linux,modalias  - (optional, Linux specific) Force binding of 
> SPI device
> +			to a particular spi_device driver.  Useful for changing
> +			driver binding between spidev and a kernel SPI driver.

This is a temporary workaround I hope?


Segher
