Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 4ACFD2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Dec 2004 12:50:06 +1100 (EST)
Date: Wed, 8 Dec 2004 18:49:58 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Chris Love <love@ccpu.com>
Message-ID: <20041208184958.A22430@home.com>
References: <41B7A61E.9000602@ccpu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41B7A61E.9000602@ccpu.com>;
	from love@ccpu.com on Wed, Dec 08, 2004 at 05:10:54PM -0800
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux PCI support on Ocotea
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Dec 08, 2004 at 05:10:54PM -0800, Chris Love wrote:
> Hi folks,
> 
> We have an Ocotea reference board (PPC 440GX) w/256M and have
> tried running both stable 2.4.26 and 2.6.10-rc3 kernels from
> penguinppc.org.  For now the bootloader is still PIBS, though
> we'll get U-Boot installed shortly.
> 
> As a first experiment we've tried installing a legacy card
> with an Intel 82559 device on it.  The warning seen from
> pci_setup_device() suggests that PCI config space wasn't
> read cleanly: a header type of 0x7f is encountered.  Nothing
> shows up under /proc/bus/pci. The card we'd actually like to
> install has a transparent bridge (Intel 21152) and other devices
> behind the bridge.  Both cards are PCI-33 versus PCI-X.

Sounds like something is wrong with your hardware configuration.

> To ask some really stupid questions first: what is the state of
> PCI support with linux on this board?  Have others tried to do
> something like this with 33/66 Mhz PCI devices or am I in
> uncharted waters?

No, this works fine for many other people, so don't get too worried.
Do verify that you have jumpered for 33Mhz operation since you
are using a 33Mhz device. PIBS should warn you about this and
advise to make the change, but maybe you have a different
version than I've seen. What rev. ocotea board and version of
PIBS do you have?

> Of the PCI #defines in platforms/ocotea.h I can correlate most
> with data from the user's manual, but not the following:
> 
> #define OCOTEA_PCI_LOWER_IO     0x00000000
> #define OCOTEA_PCI_UPPER_IO     0x0000ffff
> #define OCOTEA_PCI_LOWER_MEM    0x80000000
> #define OCOTEA_PCI_UPPER_MEM    0xffffefff
> 
> Is there some documentation I'm missing on these values?

The code is self-documenting as they say. :) These are the address
ranges used by the pci_auto code to assign base addresses to each
BAR that is encountered.

-Matt
