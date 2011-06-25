Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 41FCEB6F82
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 26 Jun 2011 09:53:03 +1000 (EST)
Date: Sat, 25 Jun 2011 18:52:59 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: powerpc/4xx: Regression failed on sil24 (and other) drivers
Message-ID: <20110625235259.GA18837@crust.elkhashab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cam@cs.ualberta.ca
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I noticed during a recent development with the 460SX that a
simple device that once worked stopped.  I did a bisect to
find the offending commit and it turns out to be this one:

0e52247a2ed1f211f0c4f682dc999610a368903f is the first bad
commit
commit 0e52247a2ed1f211f0c4f682dc999610a368903f
Author: Cam Macdonell <cam@cs.ualberta.ca>
Date:   Tue Sep 7 17:25:20 2010 -0700

    PCI: fix pci_resource_alignment prototype

I found it working with 2.6.36 but it seems that it is in
the current trunk as well.

I patched my code to take out this commit and (quickly)
verified it was ok.  I am guessing the patch is ok since it
converts int types to resource_size_t.  My guess is that the
problem is in the sil24 driver but I did not see anything 
obvious in that code.  Any tips on what could be wrong?  Is
the problem potentially somewhere being called by that code?

The device driver fails with "error -22" on a 460SX (which 
has the 36 bit pci space).

sil24 /drivers/ata/sata_sil24.c

Thanks
Ayman
