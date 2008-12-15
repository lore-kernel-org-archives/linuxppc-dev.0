Return-Path: <dgibson@ozlabs.org>
Date: Mon, 15 Dec 2008 11:12:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [RFC] Dummy GPIO driver for use with SPI
Message-ID: <20081215001201.GB15327@yookeroo.seuss>
References: <4942738A.80609@harris.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4942738A.80609@harris.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 12, 2008 at 09:22:02AM -0500, Steven A. Falco wrote:
> This patch adds a dummy GPIO driver, which is useful for SPI devices
> that do not have a physical chip select.
> 
> Signed-off-by: Steven A. Falco <sfalco@harris.com>
> ---
> The SPI subsystem requires a chip-select for each connected slave
> device.  I have a custom board with an Atmel "co-processor".  This part
> is reprogrammed via SPI, so it needs a chip select to satisfy the SPI
> subsystem, but my hardware does not have a physical CS connected.
> 
> I could waste a "no-connect" GPIO pin, but I'd rather not.  So, I've
> written a dummy GPIO driver, which behaves exactly like a real GPIO
> device, but with no underlying hardware.  This could also be useful
> as a template for real GPIO drivers.
> 
> I use the following dts entry:
> 
> 	GPIO3: dummy@ef500000 {
> 		compatible = "linux,dummy-gpio";
> 		reg = <ef500000 1>;
> 		gpio-controller;
> 		#gpio-cells = <2>;
> 	};

This is not sane.  I can see reasons it might be useful to have a
dummy gpio driver within the kernel, but since this doesn't represent
any real hardware, it should not appear in the device tree.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
