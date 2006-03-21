Return-Path: <davem@davemloft.net>
Date: Tue, 21 Mar 2006 13:53:59 -0800 (PST)
Message-Id: <20060321.135359.72797865.davem@davemloft.net>
To: maule@sgi.com
Subject: Re: [PATCH 0/3] msi abstractions and support for altix
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060321143444.9913.48372.11324@lnx-maule.americas.sgi.com>
References: <20060321143444.9913.48372.11324@lnx-maule.americas.sgi.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tony.luck@intel.com, linux-ia64@vger.kernel.org, gregkh@suse.de,
	linux-kernel@vger.kernel.org, j-nomura@ce.jp.nec.com,
	linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark Maule <maule@sgi.com>
Date: Tue, 21 Mar 2006 08:34:44 -0600 (CST)

> Mark
> 
> 1/3 msi-ops.patch
> 	Add an msi_arch_init() hook which can be used to perform platform
> 	specific setup prior to msi use.
> 
> 	Define a set of msi ops to implement the platform-specific tasks:
> 
> 	    setup - set up plumbing to get a vector directed at a default
> 		cpu, and return the corresponding MSI bus address and data.
> 	    teardown - inverse of msi_setup
> 	    target - retarget a vector to a given cpu
> 
> 	Define the routine msi_register() called from msi_arch_init()
> 	to set the desired ops.
> 
> 	Move a bunch of apic-specific code out of the msi core .h/.c and
> 	into a new msi-apic.c file.

Mark, thanks for doing this work.  The better abstracted out the
so-called generic MSI support code is, the better.  Several platforms
will benefit from this, such as PPC and Sparc64, both of which
cannot take advantage of MSI support in their PCI controllers because
of how x86 centric the current MSI support layer is.

Thanks again.
