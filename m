Return-Path: <DWatkins@tranzeo.com>
Received: from mail.tranzeo.com (unknown [64.114.87.10])
	by ozlabs.org (Postfix) with ESMTP id C879EDF033
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Mar 2008 08:28:27 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: I Need to Reset a PPC405EP PCI Bridge From a Kernel Driver Without
	Reboot
Date: Tue, 25 Mar 2008 14:28:18 -0700
Message-ID: <D61182AC8012EA4EBC531B3AF23BE109582DC0@tranzeo-mail2.12stewart.tranzeo.com>
In-Reply-To: <47E8F836.9060603@coritel.it>
References: <47E8B19B.10705@coritel.it><7F2C28B9-9B87-4F46-9C57-3666BB8F7EFD@kernel.crashing.org>
	<47E8F836.9060603@coritel.it>
From: "Darcy Watkins" <DWatkins@tranzeo.com>
To: "LinuxPPC-Embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I have a peculiar problem dealing with an mPCI wireless network card on
an AMCC405EP based system (spin-off of a Taihu).  The task is to load
the FPGA firmware in the card, reset the PCI card (to reset an ASIC, get
it to reload from EEPROM but without resetting the PowerPC and of course
without clearing the firmware in the FPGA), then to rescan (using a fake
hotplug scheme) to find the PCI device, then finally upload a secondary
firmware file to a flash device on the card.

I need this for two reasons.  One is to solve a chicken-and-egg type
problem to recover a failed radio card after a botched up upgrade.  The
other is to avoid reboots (and wasted time per radio card) as they are
programmed and calibrated in a jig on a manufacturing production line.

I tried setting and then clearing the CPC0_SRR (software reset register)
bit to reset the PCI bridge.  I think that this wipes out the PCI bus
completely.  Since PCI is initialized by U-Boot, the kernel doesn't
appear to know what to do.  I get a data machine check oops at the point
where the device drivers load up and start.

I tried simply saving the 16 words of PCIL0 register content before
toggling the SRR bit, and then restoring them afterwards.  No
difference.  Next I notice a whole bank of configuration registers and
am wondering just what needs to explicitly be preserved.

Before I go into saving and restoring more registers, or cloning the
4xx_pci.c code from u-Boot into my fake hotplug rescan driver to
reinitialize the PCI subsystem, does anyone have suggestions?


Regards,

Darcy
