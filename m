Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 517A6B6F5D
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jun 2011 20:20:21 +1000 (EST)
Subject: Re: powerpc/4xx: Regression failed on sil24 (and other) drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <ayman@elkhashab.com>
In-Reply-To: <20110625235259.GA18837@crust.elkhashab.com>
References: <20110625235259.GA18837@crust.elkhashab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 27 Jun 2011 20:19:56 +1000
Message-ID: <1309169996.32158.390.camel@pasglop>
Mime-Version: 1.0
Cc: cam@cs.ualberta.ca, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2011-06-25 at 18:52 -0500, Ayman El-Khashab wrote:
> I noticed during a recent development with the 460SX that a
> simple device that once worked stopped.  I did a bisect to
> find the offending commit and it turns out to be this one:
> 
> 0e52247a2ed1f211f0c4f682dc999610a368903f is the first bad
> commit
> commit 0e52247a2ed1f211f0c4f682dc999610a368903f
> Author: Cam Macdonell <cam@cs.ualberta.ca>
> Date:   Tue Sep 7 17:25:20 2010 -0700
> 
>     PCI: fix pci_resource_alignment prototype
> 
> I found it working with 2.6.36 but it seems that it is in
> the current trunk as well.
> 
> I patched my code to take out this commit and (quickly)
> verified it was ok.  I am guessing the patch is ok since it
> converts int types to resource_size_t.  My guess is that the
> problem is in the sil24 driver but I did not see anything 
> obvious in that code.  Any tips on what could be wrong?  Is
> the problem potentially somewhere being called by that code?
> 
> The device driver fails with "error -22" on a 460SX (which 
> has the 36 bit pci space).
> 
> sil24 /drivers/ata/sata_sil24.c

Can you send a dmesg & output of /proc/iomem & ioport with and without
the patch (same kernel otherwise) ?

Also can you try to figure out (printk's) where in the driver does it
fail ? (Which function fails)

It's possible that this changes something in the core resource
assignment code causing something else to fail elsewhere or exposing
another bug elsewhere with the consequence of leaving the SiL with badly
assigned resources.

Cheers,
Ben.
