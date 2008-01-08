Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 96CF1DDF04
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 01:05:56 +1100 (EST)
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Use <linux/of_{platform,
	device}.h> and not <asm/...> variants.
In-Reply-To: Your message of "Tue, 08 Jan 2008 11:36:37 +1100."
	<20080108113637.5208a0c7.sfr@canb.auug.org.au>
References: <E1JBwNX-0006XF-26@jdl.com>
	<20080108113637.5208a0c7.sfr@canb.auug.org.au>
Date: Tue, 08 Jan 2008 08:05:49 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JCF5S-00043W-0U@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Stephen Rothwell mumbled:
> 
> Hi Jon,
> 
> > Continue to fight the Good Fight by removing
> > old include file references that managed to
> > creep in recently.
> 
> Thanks for doing this.

By $DIETY, I'll obtain Janitorial Karma one way or another!

The question now is, what next?  I'm thinking about
picking on arch/sparc/, then drivers/ and sound/,
and finally pick off /include.

To be honest, I'm not sure what the final /include
structure is supposed to look like or do as both
pairs of these files mutually include their counterpart.
(i/l/of_d.h includes i/a/of_d.h which includes i/l/of_d.h)
(i/l/of_p.h includes i/a/of_p.h which includes i/l/of_p.h)

But, of course, the various asm/of_{platform,device}.h files
are different for each arch/, so I wasn't sure if the longer
term plan had folding the arch variants straight into the
include/linux/ version of the file or not.  Seems there will
come a point when the sparc and powerpc variants will need
to be more unified...


arch/sparc/kernel/ioport.c:#include <asm/of_device.h>
arch/sparc/kernel/time.c:#include <asm/of_device.h>
arch/sparc64/kernel/auxio.c:#include <asm/of_device.h>
arch/sparc64/kernel/ebus.c:#include <asm/of_device.h>
arch/sparc64/kernel/isa.c:#include <asm/of_device.h>
arch/sparc64/kernel/pci_common.c:#include <asm/of_device.h>
arch/sparc64/kernel/pci_psycho.c:#include <asm/of_device.h>
arch/sparc64/kernel/pci_sabre.c:#include <asm/of_device.h>
arch/sparc64/kernel/pci_schizo.c:#include <asm/of_device.h>
arch/sparc64/kernel/power.c:#include <asm/of_device.h>
arch/sparc64/kernel/prom.c:#include <asm/of_device.h>
arch/sparc64/kernel/time.c:#include <asm/of_device.h>

drivers/char/ipmi/ipmi_si_intf.c:#include <asm/of_device.h>
drivers/hwmon/ams/ams.h:#include <asm/of_device.h>
drivers/input/serio/i8042-sparcio.h:#include <asm/of_device.h>
drivers/macintosh/smu.c:#include <asm/of_device.h>
drivers/macintosh/therm_pm72.c:#include <asm/of_device.h>
drivers/net/fs_enet/mac-fcc.c:#include <asm/of_device.h>
drivers/net/fs_enet/mac-fec.c:#include <asm/of_device.h>
drivers/pcmcia/m8xx_pcmcia.c:#include <asm/of_device.h>
drivers/sbus/sbus.c:#include <asm/of_device.h>
drivers/serial/sunhv.c:#include <asm/of_device.h>
drivers/serial/sunsab.c:#include <asm/of_device.h>
drivers/serial/sunsu.c:#include <asm/of_device.h>
drivers/serial/sunzilog.c:#include <asm/of_device.h>
drivers/video/bw2.c:#include <asm/of_device.h>
drivers/video/cg14.c:#include <asm/of_device.h>
drivers/video/cg3.c:#include <asm/of_device.h>
drivers/video/cg6.c:#include <asm/of_device.h>
drivers/video/ffb.c:#include <asm/of_device.h>
drivers/video/leo.c:#include <asm/of_device.h>
drivers/video/p9100.c:#include <asm/of_device.h>
drivers/video/platinumfb.c:#include <asm/of_device.h>
drivers/video/sunxvr2500.c:#include <asm/of_device.h>
drivers/video/sunxvr500.c:#include <asm/of_device.h>
drivers/video/tcx.c:#include <asm/of_device.h>

drivers/ata/pata_mpc52xx.c:#include <asm/of_platform.h>
drivers/char/hw_random/pasemi-rng.c:#include <asm/of_platform.h>
drivers/char/ipmi/ipmi_si_intf.c:#include <asm/of_platform.h>
drivers/hwmon/ams/ams-core.c:#include <asm/of_platform.h>
drivers/macintosh/smu.c:#include <asm/of_platform.h>
drivers/macintosh/therm_adt746x.c:#include <asm/of_platform.h>
drivers/macintosh/therm_pm72.c:#include <asm/of_platform.h>
drivers/macintosh/therm_windtunnel.c:#include <asm/of_platform.h>
drivers/net/fs_enet/fs_enet-main.c:#include <asm/of_platform.h>
drivers/net/fs_enet/mac-scc.c:#include <asm/of_platform.h>
drivers/net/fs_enet/mii-fec.c:#include <asm/of_platform.h>
drivers/net/ibm_newemac/core.h:#include <asm/of_platform.h>
drivers/net/ucc_geth.c:#include <asm/of_platform.h>
drivers/net/ucc_geth_mii.c:#include <asm/of_platform.h>
drivers/pcmcia/electra_cf.c:#include <asm/of_platform.h>
drivers/pcmcia/m8xx_pcmcia.c:#include <asm/of_platform.h>
drivers/serial/mpc52xx_uart.c:#include <asm/of_platform.h>
drivers/serial/of_serial.c:#include <asm/of_platform.h>
drivers/spi/mpc52xx_psc_spi.c:#include <asm/of_platform.h>
drivers/usb/host/ohci-ppc-of.c:#include <asm/of_platform.h>
drivers/video/platinumfb.c:#include <asm/of_platform.h>
drivers/watchdog/mpc5200_wdt.c:#include <asm/of_platform.h>

sound/aoa/soundbus/soundbus.h:#include <asm/of_device.h>

include/asm-powerpc/macio.h:#include <asm/of_device.h>
include/asm-powerpc/pmi.h:#include <asm/of_device.h>
include/asm-sparc/ebus.h:#include <asm/of_device.h>
include/asm-sparc/sbus.h:#include <asm/of_device.h>
include/asm-sparc64/ebus.h:#include <asm/of_device.h>
include/asm-sparc64/isa.h:#include <asm/of_device.h>
include/asm-sparc64/parport.h:#include <asm/of_device.h>
include/asm-sparc64/sbus.h:#include <asm/of_device.h>

include/linux/of_device.h:#include <asm/of_device.h>

include/linux/of_platform.h:#include <asm/of_platform.h>
