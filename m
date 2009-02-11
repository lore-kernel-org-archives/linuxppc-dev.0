Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE9A8DDDA1
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 16:02:56 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n1B52nR1015094
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 23:02:50 -0600
Subject: next branch update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 11 Feb 2009 16:02:49 +1100
Message-Id: <1234328569.29851.9.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

The powerpc.git next branch has now been updated with the following
patches. The "test" branch has been reset.

commit 6071ed0487c6ea8dcfadd9844b9b90944cd9de1e
Author: Michael Ellerman <michael@ellerman.id.au>
Date:   Thu Jan 22 20:54:33 2009 +0000

    powerpc/pseries: Return the number of MSIs we could allocate
    
    If we can't allocate the requested number of MSIs, we can still tell the
    generic code how many we were able to allocate. That can then be passed
    onto the driver, allowing it to request that many in future, and
    probably succeeed.
    
    Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 649781f82782d142443d895b98edbd8be4e75c56
Author: Michael Ellerman <michael@ellerman.id.au>
Date:   Thu Jan 22 20:54:32 2009 +0000

    powerpc/pseries: Check for MSI-X also in rtas_msi_pci_irq_fixup()
    
    We also need to check that the device isn't using MSI-X in the irq fixup
    routine, otherwise we might leave MSI-Xs configured at boot.
    
    Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 3a51c0cbea947dc9194e18f11661eaa4dbfc5c13
Author: Michael Ellerman <michael@ellerman.id.au>
Date:   Thu Jan 22 20:54:31 2009 +0000

    powerpc/pseries: Add support for ibm,req#msi-x
    
    Firmware encodes the number of MSI-X requested by a device in a
    
    different property than for MSI. Pull the property name out as a
    parameter and share the logic for both cases.
    
    Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit e27ed698b88b3387d326e84c0bbe9f83e19c747b
Author: Michael Ellerman <michael@ellerman.id.au>
Date:   Thu Jan 22 20:54:31 2009 +0000

    powerpc/pseries: Fix MSI-X interrupt querying
    
    We need to increment i in the loop that queries what interrupts firmware
    gave us, otherwise we'll incorrectly use the first value over and over.
    
    Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit c37682d907a615c9a8751748b58e9ba47d415429
Author: Michael Ellerman <michael@ellerman.id.au>
Date:   Wed Jan 14 20:46:02 2009 +0000

    lmb: Rework lmb_dump_all() output
    
    The lmb_dump_all() output didn't include the RMO size, which is
    interesting on powerpc. The output was also a bit spacey and not well
    aligned, and didn't show you the end addresses.
    
    Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
    Acked-by: David S. Miller <davem@davemloft.net>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 059f134f844ec52772353c95693fcb5b86e80193
Author: Michael Ellerman <michael@ellerman.id.au>
Date:   Wed Jan 14 20:46:01 2009 +0000

    powerpc: Allow debugging of LMBs with lmb=debug
    
    The lmb debugging can be turned on at boottime with lmb=debug on the
    command line. However on powerpc that doesn't work, because we don't
    necessarily call lmb_dump_all().
    
    So always call lmb_dump_all() after lmb_analyze(), no output is
    generated unless lmb=debug is found on the command line.
    
    Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
    Acked-by: David S. Miller <davem@davemloft.net>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 33642d31d19c967b9739253912cdd48885509805
Author: Michael Ellerman <michael@ellerman.id.au>
Date:   Wed Jan 14 20:43:15 2009 +0000

    powerpc: Remove unused ppc64_terminate_msg()
    
    Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 7ce14a315db866605e6ac0b17fb33d10d7e49ab4
Author: Milton Miller <miltonm@bga.com>
Date:   Thu Jan 8 02:19:49 2009 +0000

    powerpc/pseries: Remove write only variable in PCI DLPAR
    
    Since we never hotplug add an isa bus, we never need to set primary.
    Delete this write-only variable.
    
    Signed-off-by: Milton Miller <miltonm@bga.com>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 8b16cd238d414b8942a23f0f753cdc57b17c231a
Author: Milton Miller <miltonm@bga.com>
Date:   Thu Jan 8 02:19:45 2009 +0000

    powerpc/numa: Remove redundant find_cpu_node()
    
    Use of_get_cpu_node, which is a superset of numa.c's find_cpu_node in
    a less restrictive section (text vs cpuinit).
    
    Signed-off-by: Milton Miller <miltonm@bga.com>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 20fcefe5a0a354b0cc78ec4634d9f72dab5f1ee9
Author: Milton Miller <miltonm@bga.com>
Date:   Thu Jan 8 02:19:43 2009 +0000

    powerpc/numa: Avoid possible reference beyond prop. length in find_min_common_depth()
    
    find_min_common_depth() was checking the property length incorrectly.
    The value is in bytes not cells, and it is using the second entry.
    
    Signed-off-By: Milton Miller <miltonm@bga.com>
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit a0e8618c71b9b685977c1407dee928d86c5bdc2c
Author: Anton Vorontsov <avorontsov@ru.mvista.com>
Date:   Thu Feb 5 22:04:59 2009 +0300

    powerpc/83xx: Add FSL eSDHC support for MPC837x-RDB boards
    
    Simply add appropriate sdhci nodes.
    
    Note that U-Boot should configure pin multiplexing for eSDHC prior
    to Linux could use it. U-Boot should also fill-in the clock-frequency
    property (eSDHC clock depends on board-specific SCCR[ESDHCCM] bits).
    
    Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 766d2826728e7233ce6728ee8a8b822ac655af3a
Author: Anton Vorontsov <avorontsov@ru.mvista.com>
Date:   Thu Feb 5 22:04:51 2009 +0300

    powerpc/83xx: Convert existing sdhc nodes to new bindings
    
    - sdhc node renamed to sdhci ("sdhc" name is confusing since SDHC is
      used to name Secure Digital High Capacity cards, while SDHCI is an
      interface).
    
    - Get rid of "fsl,esdhc" compatible entry, it's replaced by the
      "fsl,<chip>-esdhc" scheme;
    
    - Get rid of `model' property.
    
    Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 34bcda616e5308a0633d5bfabcc090d7aa09b494
Author: Anton Vorontsov <avorontsov@ru.mvista.com>
Date:   Thu Feb 5 22:04:47 2009 +0300

    powerpc: Document FSL eSDHC bindings
    
    This patch documents OF bindings for the Freescale Enhanced Secure
    Digital Host Controller.
    
    Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit bdad05489fe5f7487c7a22ef311f005cb62ebbb6
Author: Grzegorz Bernacki <gjb@semihalf.com>
Date:   Wed Feb 4 13:39:17 2009 -0700

    powerpc/5200: Add support for the digsy MTC board.
    
    Board support for the InterControl Digsy-MTC device based on the MPC5200B SoC.
    
    Signed-off-by: Grzegorz Bernacki <gjb@semihalf.com>
    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

commit bfee95bb830ff0260f3e2e0b1aa6b7492573fe4d
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Wed Feb 4 13:39:17 2009 -0700

    powerpc/5200: Add support for the Media5200 board from Freescale
    
    This patch adds board support for the Media5200 platform.  Changes are:
    - add the media5200 device tree
    - add the media5200 platform support code and cascaded interrupt controller
    - add media5200 to the build targets.
    
    Note: this patch also includes a minor tweak to the lite5200(b) target
    images list to add the .dtb files to the image list.
    
    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

commit 5496eab2434f2a2dfe0d35496fd9605d548b7fbc
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Wed Feb 4 13:35:42 2009 -0700

    powerpc/5200: Rework GPT driver to also be an IRQ controller
    
    This patch adds IRQ controller support to the MPC5200 General
    Purpose Timer (GPT) device driver.  With this patch the mpc5200-gpt
    driver supports both GPIO and IRQ functions.
    
    The GPT driver was contained within the mpc52xx_gpio.c file, but this
    patch moves it out into a new file (mpc52xx_gpt.c) since it has more
    than just GPIO functionality now and it was only grouped with the
    mpc52xx-gpio drivers as a matter of convenience before.  Also, this
    driver will most likely get extended again to also provide support
    for the timer function.
    
    Implementation note: Alternately, I could have tried to implement
    the IRQ support as a separate driver and left the GPIO portion alone.
    However, multiple functions of this device (ie. GPIO input+interrupt
    controller, or timer+GPIO) can be active at the same time and the
    registers are shared so it is safer to contain all functionality
    within a single driver.
    
    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
    Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

commit 8f2558ded599c10d96a56fbf12849a27f6ab7997
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Wed Feb 4 13:33:20 2009 -0700

    powerpc/5200: Refactor mpc5200 interrupt controller driver
    
    Rework the mpc5200-pic driver to simplify it and fix up the setting
    of desc->status when set_type is called for internal IRQs (so they
    are reported as level, not edge).  The simplification is due to
    splitting off the handling of external IRQs into a separate block
    so they don't need to be handled as exceptions in the normal
    CRIT, MAIN and PERP paths.
    
    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

commit bc4346fe2733dcca723d6b8f188bc44b54eac847
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Wed Feb 4 11:23:56 2009 -0700

    powerpc/5200: Remove pr_debug() from hot paths in irq driver
    
    pr_debug() calls in the 'hot' *_mask(), *_unmask(), *_ack() and
    get_irq() makes adding #define DEBUG pretty much useless.  Remove
    these calls because they completely swamp the output.
    
    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
    Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

commit d9f0c5f9bc74f16d0ea0f6c518b209e48783a796
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Wed Feb 4 11:23:56 2009 -0700

    powerpc/5200: Don't specify IRQF_SHARED in PSC UART driver
    
    The MPC5200 PSC device is wired up to a dedicated interrupt line
    which is never shared.  This patch removes the IRQF_SHARED flag
    from the request_irq() call which eliminates the "IRQF_DISABLED
    is not guaranteed on shared IRQs" warning message from the console
    output.
    
    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
    Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

commit b8842451079a3034363320b932205d9cea791e9d
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Tue Feb 3 12:30:26 2009 -0700

    powerpc/5200: Trim cruft from device trees
    
    Trim out obsolete/extraneous properties and tighten up some usage
    conventions.  Changes include:
    - removal of device_type properties
    - removal of cell-index properties
    - Addition of gpio-controller and #gpio-cells properties to gpio
      nodes
    - Move common interrupt-parent property out of device nodes and
      into top level parent node.
    
    This patch also include what looks to be just trivial editorial
    whitespace/format changes, but there is real method in this
    madness.  Editorial changes were made to keep the all the
    mpc5200 board device trees as similar as possible so that diffs
    between them only show the real differences between the boards.
    The pcm030 device tree was most affected by this because many
    of the comments had been changed from // to /* */ style and
    some cell values where changed from decimal to hex format when
    it was cloned from one of the other 5200 device trees.
    
    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
    Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

commit 3b5ebf8e1ac88babf60772d54bc81b180b5f53b0
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Tue Feb 3 12:30:25 2009 -0700

    powerpc/5200: Stop using device_type and port-number properties
    
    There is no reason for the PSC UART driver or the Ethernet driver
    to require a device_type property.  The compatible value is sufficient
    to uniquely identify the device.  Remove it from the driver.
    
    The whole 'port-number' scheme for assigning numbers to PSC uarts was
    always rather half baked and just adds complexity.  Remove it from the
    driver.  After this patch is applied, PSC UART numbers are simply
    assigned from the order they are found in the device tree (just like
    all the other devices).  Userspace can query sysfs to determine what
    ttyPSC number is assigned to each PSC instance.
    
    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
    Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

commit 960d82aa5ba971aa9da86a41881cb8dc8f96e397
Author: Reynes Philippe <philippe.reynes@isismpp.fr>
Date:   Mon Feb 2 16:59:01 2009 +0100

    powerpc/83xx: Add lm75 to MPC837x RDB dts
    
    Signed-off-by: Philippe Reynes <philippe.reynes@isismpp.fr>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 0f73a449a649acfca91404a98a35353a618b9555
Author: Wolfgang Grandegger <wg@grandegger.com>
Date:   Thu Jan 29 13:49:17 2009 +0100

    powerpc/85xx: TQM85xx - add i2c device nodes for LM75
    
    Automatic I2C device probing is not done any more. Therefore we need
    proper DTS device node definitions for the I2C LM75 thermal sensor on
    the TQM85xx modules.
    
    Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 7a3852417c0c9bdfebc1b37bf43d4798883867e0
Author: Wolfgang Grandegger <wg@grandegger.com>
Date:   Thu Jan 29 14:23:21 2009 +0100

    powerpc/85xx: TQM85xx - fix sensitivity of CAN interrupts
    
    Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 9e7d95c1976fddfb4a3cf82a170a49e6fb0e8440
Author: Reynes Philippe <philippe.reynes@isismpp.fr>
Date:   Mon Feb 2 15:52:39 2009 +0100

    powerpc/83xx: Add gpio to MPC837x RDB
    
    Signed-off-by: Philippe Reynes <philippe.reynes@isismpp.fr>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit b1dd62f7f108a593abfc4bf425a3dd0885994680
Author: Martyn Welch <martyn.welch@gefanuc.com>
Date:   Mon Jan 19 11:33:34 2009 +0000

    powerpc/86xx: Extend GE Fanuc GPIO driver for the SBC310
    
    This patch adds basic support for the 6 GPIO lines found on GE Fanucs SBC310 to the GE Fanuc GPIO driver.
    
    Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit d2a82b12989d0531ce93cff0553cdd1c93155d24
Author: Martyn Welch <martyn.welch@gefanuc.com>
Date:   Mon Jan 19 11:33:04 2009 +0000

    powerpc/86xx: Default configutation for GE Fanuc's SBC310
    
    Support for the SBC310 VPX Single Board Computer from GE Fanuc (PowerPC
    MPC8641D).
    
    This is the default config file for GE Fanuc's SBC310, a 3U single board
    computer, based on Freescale's MPC8641D.
    
    Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit bb2b66dca1c4cbe16d8208d4b2910cf0eb6e9f75
Author: Martyn Welch <martyn.welch@gefanuc.com>
Date:   Mon Jan 19 11:33:24 2009 +0000

    powerpc/86xx: Board support for GE Fanuc SBC310
    
    Support for the SBC310 VPX Single Board Computer from GE Fanuc (PowerPC
    MPC8641D).
    
    This is the basic board support for GE Fanuc's SBC310, a 3U single board
    computer, based on Freescale's MPC8641D.
    
    Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit d0839118f396f6d7af553e99ad204aa2b3209cde
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Wed Jan 28 13:25:29 2009 -0600

    powerpc/fsl: Ensure PCI_QUIRKS are enabled for FSL_PCI
    
    The FSL PCI code depends on PCI quirks being enabled to function
    properly.  We can ensure this by doing a select in Kconfig of
    PCI_QUIRKS.
    
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit f7a0be456f1bdcb6dec81c1e4e47e2b7205eba95
Author: Reynes Philippe <philippe.reynes@isismpp.fr>
Date:   Wed Jan 28 11:07:44 2009 +0100

    powerpc/83xx: Add i2c eeprom to dts for MPC837x RDB
    
    Signed-off-by: Philippe Reynes <philippe.reynes@isismpp.fr>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit b4f7ec46b6c151d31c068e46278efef7e43b5043
Author: Peter Korsgaard <jacmet@sunsite.dk>
Date:   Wed Jan 14 15:52:41 2009 +0100

    powerpc: convert dts-bindings/fsl/dma.txt to dts-v1 syntax
    
    Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 7b8909940a524d67b4352c29256ada476f50fbba
Author: Laurent Pinchart <laurentp@cse-semaphore.com>
Date:   Thu Nov 20 13:32:23 2008 +0100

    cpm2: Round the baud-rate clock divider to the nearest integer.
    
    Instead of rounding the divider down, improve the baud-rate generators
    accuracy by rounding to the nearest integer.
    
    Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 96051465fdc29e00dd14b484a45daac089c657f8
Author: Trent Piepho <tpiepho@freescale.com>
Date:   Mon Dec 8 19:34:58 2008 -0800

    powerpc/fsl-booke: Make CAM entries used for lowmem configurable
    
    On booke processors, the code that maps low memory only uses up to three
    CAM entries, even though there are sixteen and nothing else uses them.
    
    Make this number configurable in the advanced options menu along with max
    low memory size.  If one wants 1 GB of lowmem, then it's typically
    necessary to have four CAM entries.
    
    Signed-off-by: Trent Piepho <tpiepho@freescale.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit c8f3570b7e2dd070ba6da41f3ed4ffb4e1d296af
Author: Trent Piepho <tpiepho@freescale.com>
Date:   Mon Dec 8 19:34:59 2008 -0800

    powerpc/fsl-booke: Allow larger CAM sizes than 256 MB
    
    The code that maps kernel low memory would only use page sizes up to 256
    MB.  On E500v2 pages up to 4 GB are supported.
    
    However, a page must be aligned to a multiple of the page's size.  I.e.
    256 MB pages must aligned to a 256 MB boundary.  This was enforced by a
    requirement that the physical and virtual addresses of the start of lowmem
    be aligned to 256 MB.  Clearly requiring 1GB or 4GB alignment to allow
    pages of that size isn't acceptable.
    
    To solve this, I simply have adjust_total_lowmem() take alignment into
    account when it decides what size pages to use.  Give it PAGE_OFFSET =
    0x7000_0000, PHYSICAL_START = 0x3000_0000, and 2GB of RAM, and it will map
    pages like this:
    PA 0x3000_0000 VA 0x7000_0000 Size 256 MB
    PA 0x4000_0000 VA 0x8000_0000 Size 1 GB
    PA 0x8000_0000 VA 0xC000_0000 Size 256 MB
    PA 0x9000_0000 VA 0xD000_0000 Size 256 MB
    PA 0xA000_0000 VA 0xE000_0000 Size 256 MB
    
    Because the lowmem mapping code now takes alignment into account,
    PHYSICAL_ALIGN can be lowered from 256 MB to 64 MB.  Even lower might be
    possible.  The lowmem code will work down to 4 kB but it's possible some of
    the boot code will fail before then.  Poor alignment will force small pages
    to be used, which combined with the limited number of TLB1 pages available,
    will result in very little memory getting mapped.  So alignments less than
    64 MB probably aren't very useful anyway.
    
    Signed-off-by: Trent Piepho <tpiepho@freescale.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit f88747e7f68866f2f82cef1363c5b8e7aa13b0a3
Author: Trent Piepho <tpiepho@freescale.com>
Date:   Mon Dec 8 19:34:57 2008 -0800

    powerpc/fsl-booke: Remove code duplication in lowmem mapping
    
    The code to map lowmem uses three CAM aka TLB[1] entries to cover it.  The
    size of each is stored in three globals named __cam0, __cam1, and __cam2.
    All the code that uses them is duplicated three times for each of the three
    variables.
    
    We have these things called arrays and loops....
    
    Once converted to use an array, it will be easier to make the number of
    CAMs configurable.
    
    Signed-off-by: Trent Piepho <tpiepho@freescale.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 105c31df6fc5a424b480321763b5598cf3817821
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Thu Jan 8 08:31:20 2009 -0600

    powerpc/fsl-booke: Cleanup init/exception setup to be runtime
    
    We currently have a few variants of fsl-booke processors (e500v1, e500v2,
    e500mc, and e200).  They all have minor differences that we had previously
    been handling via ifdefs.
    
    To move towards having this support the following changes have been made:
    
    * PID1, PID2 only exist on e500v1 & e500v2 and should not be accessed on
      e500mc or e200.  We use MMUCFG[NPIDS] to determine which case we are
      since we only touch PID1/2 in extremely early init code.
    
    * Not all IVORs exist on all the processors so introduce cpu_setup
      functions for each variant to setup the proper IVORs that are either
      unique or exist but have some variations between the processors
    
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 0585a155a7318e69d43ef20636c2f072ad17d03f
Author: Anton Vorontsov <avorontsov@ru.mvista.com>
Date:   Thu Jan 8 04:31:41 2009 +0300

    powerpc/83xx: Add PCI-E support for all MPC83xx boards with PCI-E
    
    This patch adds pcie nodes to the appropriate dts files, plus adds
    some probing code for the boards.
    
    Also, remove of_device_is_avaliable() check from the mpc837x_mds.c
    board file, as mpc83xx_add_bridge() has the same check now.
    
    Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 598804cd041c395ce87302af9088b2f227196185
Author: Anton Vorontsov <avorontsov@ru.mvista.com>
Date:   Fri Jan 9 00:55:39 2009 +0300

    powerpc/fsl_pci: Add MPC83xx PCI-E controller RC mode support
    
    This patch adds support for PCI-Express controllers as found on the
    newer MPC83xx chips.
    
    The work is loosely based on the Tony Li's patch[1], but unlike the
    original patch, this patch implements sliding window for the Type 1
    transactions using outbound window translations, so we don't have to
    ioremap the whole PCI-E configuration space.
    
    [1] http://ozlabs.org/pipermail/linuxppc-dev/2008-January/049028.html
    
    Signed-off-by: Tony Li <tony.li@freescale.com>
    Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
