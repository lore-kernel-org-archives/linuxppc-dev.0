Return-Path: <love@ccpu.com>
Received: from smtp.ccpu.com (defender.ccpu.com [216.54.134.34])
	by ozlabs.org (Postfix) with ESMTP id 038F92BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Dec 2004 12:37:53 +1100 (EST)
Message-ID: <41B7A61E.9000602@ccpu.com>
Date: Wed, 08 Dec 2004 17:10:54 -0800
From: Chris Love <love@ccpu.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Linux PCI support on Ocotea
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi folks,

We have an Ocotea reference board (PPC 440GX) w/256M and have
tried running both stable 2.4.26 and 2.6.10-rc3 kernels from
penguinppc.org.  For now the bootloader is still PIBS, though
we'll get U-Boot installed shortly.

As a first experiment we've tried installing a legacy card
with an Intel 82559 device on it.  The warning seen from
pci_setup_device() suggests that PCI config space wasn't
read cleanly: a header type of 0x7f is encountered.  Nothing
shows up under /proc/bus/pci. The card we'd actually like to
install has a transparent bridge (Intel 21152) and other devices
behind the bridge.  Both cards are PCI-33 versus PCI-X.

To ask some really stupid questions first: what is the state of
PCI support with linux on this board?  Have others tried to do
something like this with 33/66 Mhz PCI devices or am I in
uncharted waters?

Of the PCI #defines in platforms/ocotea.h I can correlate most
with data from the user's manual, but not the following:

#define OCOTEA_PCI_LOWER_IO     0x00000000
#define OCOTEA_PCI_UPPER_IO     0x0000ffff
#define OCOTEA_PCI_LOWER_MEM    0x80000000
#define OCOTEA_PCI_UPPER_MEM    0xffffefff

Is there some documentation I'm missing on these values?

Thanks in advance for any suggestions,

	Chris
-- 
Chris Love      // Continuous Computing Corporation
love@ccpu.com  // http://www.ccpu.com
