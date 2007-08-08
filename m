Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id CA42FDDE2B
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 13:16:43 +1000 (EST)
Date: Wed, 8 Aug 2007 13:16:43 +1000
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Device tree aware EMAC driver
Message-ID: <20070808031643.GK10345@bakeyournoodle.com>
References: <20070807062231.GB8351@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070807062231.GB8351@localhost.localdomain>
From: tony@bakeyournoodle.com (Tony Breeds)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 07, 2007 at 04:22:31PM +1000, David Gibson wrote:
> Based on BenH's earlier work, this is a new version of the EMAC driver
> for the built-in ethernet found on PowerPC 4xx embedded CPUs.  The
> same ASIC is also found in the Axon bridge chip.  This new version is
> designed to work in the arch/powerpc tree, using the device tree to
> probe the device, rather than the old and ugly arch/ppc OCP layer.

<snip>

Hi David,
	I had a look over the patch FWIW, asside from the points below
looks good.

Minor nits:
 * Shouldn't ndev->priv accesses, use netdev_priv() ?  if not a comment
   somewhere about why not will keep the janators off your back.
 * c++ style comments
 * in emac_probe():
	+	/* Wait for dependent devices */
	+	err = -ENODEV;
	+	err = emac_wait_deps(dev);
    The initialisation to -ENODEV is pointless right?
 * s/get_property/of_get_property/g  or you'll make sfr grumpy ;P
 * In drivers/net/ibm_newemac/Makefile, I think the preferred method is
   to use ibm_newemac-y rather than ibm_newemac-objs.

Is there any reason to leave config IBM_NEW_EMAC (and IBM_EMAC) in
drivers/net/Kconfig ?  It seems to me they'd be nicer to in the
appropriate drivers/net/*Kconfig.


Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
