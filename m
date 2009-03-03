Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 786C1DDF8C
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 23:41:31 +1100 (EST)
Date: Tue, 3 Mar 2009 15:41:29 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Dushara Jayasinghe <DusharaJ@optiscan.com>
Subject: Re: Can't load module spi_mpc83xx : No such device
Message-ID: <20090303124129.GA9006@oksana.dev.rtsoft.ru>
References: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40564@mailsvr>
	<20090227125456.GA21435@oksana.dev.rtsoft.ru>
	<DE0CCFFBFF707949BEABD4537A14ACBA0C083C19F8@mailsvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <DE0CCFFBFF707949BEABD4537A14ACBA0C083C19F8@mailsvr>
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

On Tue, Mar 03, 2009 at 03:11:23PM +1100, Dushara Jayasinghe wrote:
> Hi All,
> 
> > Linus' tree is still lacking few patches for spi_mpc83xx driver, the
> > patches makes spi_mpc83xx work with the device tree directly.
> 
> I modified the spi_mpc83xx to work with the device tree using
> mpc52xx_psc_spi.c as a guide. 
> However, the device->dev->platform_data member is NULL (I thought
> the child node would provide that). 
> What am I missing?

As I said, you should use -mm tree
( http://www.kernel.org/patchtypes/mm.html ), particularly these
patches:

http://userweb.kernel.org/~akpm/mmotm/broken-out/spi_mpc83xx-rework-chip-selects-handling.patch
http://userweb.kernel.org/~akpm/mmotm/broken-out/spi_mpc83xx-add-of-platform-driver-bindings.patch

> I'm trying to create the SPI driver as a loadable module which
> will be used by the m25p80 chip driver (drivers/mtd/devices) which
> also will be a loadable module. Am I on the right track?

> > [...]
> > > Part of my device tree is as follows:
> > >
> > > 	soc8349@e0000000 {
> > > 		...
> > > 		spi@7000 {
> > > 			#address-cells = <1>;
> > > 			#size-cells = <0>;
> > > 			compatible = "fsl,spi";
> > > 			reg = <0x7000 0x1000>;
> > > 			interrupts = <0x10 0x8>;
> > > 			interrupt-parent = < &ipic >;
> > 
> > You don't seem to have any chip-selects (i.e. gpios = <>) specified.
> 
> Could you elaborate on this point please? I couldn't find any examples of
> gpios defined within SPI nodes.

Here is MMC SPI slot example for MPC8323E-RDB boards:

http://userweb.kernel.org/~akpm/mmotm/broken-out/powerpc-83xx-add-mmc-spi-support-via-the-device-tree-for-mpc8323e-rdb.patch

And documentation for the MMC SPI bindings:

http://userweb.kernel.org/~akpm/mmotm/broken-out/powerpc-add-mmc-spi-slot-bindings.patch

The OF MMC SPI bindings themselves are in the latest Linus' tree
already:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/mmc/host/of_mmc_spi.c

For m25p80 chip you should do something similar.


Hope this helps,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
