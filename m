Return-Path: <love@ccpu.com>
Received: from smtp.ccpu.com (defender.ccpu.com [216.54.134.34])
	by ozlabs.org (Postfix) with ESMTP id 0D83D2BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Dec 2004 13:21:42 +1100 (EST)
Message-ID: <41B7B66D.2000409@ccpu.com>
Date: Wed, 08 Dec 2004 18:20:29 -0800
From: Chris Love <love@ccpu.com>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
References: <41B7A61E.9000602@ccpu.com> <20041208184958.A22430@home.com>
In-Reply-To: <20041208184958.A22430@home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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



Matt Porter wrote:
> On Wed, Dec 08, 2004 at 05:10:54PM -0800, Chris Love wrote:
> 
>>Hi folks,
>>
>>We have an Ocotea reference board (PPC 440GX) w/256M and have
>>tried running both stable 2.4.26 and 2.6.10-rc3 kernels from
>>penguinppc.org.  For now the bootloader is still PIBS, though
>>we'll get U-Boot installed shortly.
>>
>>As a first experiment we've tried installing a legacy card
>>with an Intel 82559 device on it.  The warning seen from
>>pci_setup_device() suggests that PCI config space wasn't
>>read cleanly: a header type of 0x7f is encountered.  Nothing
>>shows up under /proc/bus/pci. The card we'd actually like to
>>install has a transparent bridge (Intel 21152) and other devices
>>behind the bridge.  Both cards are PCI-33 versus PCI-X.
> 
> 
> Sounds like something is wrong with your hardware configuration.
> 
> 
>>To ask some really stupid questions first: what is the state of
>>PCI support with linux on this board?  Have others tried to do
>>something like this with 33/66 Mhz PCI devices or am I in
>>uncharted waters?
> 
> 
> No, this works fine for many other people, so don't get too worried.
> Do verify that you have jumpered for 33Mhz operation since you
> are using a 33Mhz device. PIBS should warn you about this and
> advise to make the change, but maybe you have a different
> version than I've seen. What rev. ocotea board and version of
> PIBS do you have?

Hi Matt,

PIBS version text is "Version 1.80 JUNE/17/2004".
Ocotea rev appears to be rev 5.

Changing the settings for the U80 switches did the trick, at
least as far as silencing the PIBS warning and enumerating the bus
by Linux.

Thanks for the suggestion; this was lurking on the board schematics.

	Chris
-- 
Chris Love      // Continuous Computing Corporation
love@ccpu.com  // http://www.ccpu.com
