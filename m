Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id A8BA5DDD1C
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Feb 2009 00:17:30 +1100 (EST)
Date: Fri, 27 Feb 2009 15:54:56 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Dushara Jayasinghe <DusharaJ@optiscan.com>
Subject: Re: Can't load module spi_mpc83xx : No such device
Message-ID: <20090227125456.GA21435@oksana.dev.rtsoft.ru>
References: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40564@mailsvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40564@mailsvr>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 27, 2009 at 03:56:41PM +1100, Dushara Jayasinghe wrote:
> Hi all,
> 
> I'm using linux version 2.6.29-rc5.

Linus' tree is still lacking few patches for spi_mpc83xx driver, the
patches makes spi_mpc83xx work with the device tree directly.

You should use -mm kernels.

[...]
> Part of my device tree is as follows:
> 
> 	soc8349@e0000000 {
> 		...
> 		spi@7000 {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			compatible = "fsl,spi";
> 			reg = <0x7000 0x1000>;
> 			interrupts = <0x10 0x8>;
> 			interrupt-parent = < &ipic >;

You don't seem to have any chip-selects (i.e. gpios = <>) specified.

If the chip-select is always asserted (i.e. there is only one
device on the SPI bus), then..

> 
> 			m25p40@2 {
> 				compatible = "m25p80";
> 				spi-max-frequency = <25000000>;
> 				reg = <2>;

..there is no point in specifying reg = <> for the device.


Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
