Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 75030679E0
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jul 2006 17:08:08 +1000 (EST)
Subject: Re: Problem in PCI with MPC5200B
From: Heiko Schocher <hs@denx.de>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <mailman.656.1149719253.11183.linuxppc-embedded@ozlabs.org>
References: <mailman.656.1149719253.11183.linuxppc-embedded@ozlabs.org>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 09:08:15 +0200
Message-Id: <1152169696.6094.9.camel@Zeus.EmbLux>
Mime-Version: 1.0
Cc: hlrprasad@tataelxsi.co.in
Reply-To: hs@denx.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Ram,

On Wed, 7 Jun 2006 11:05:16 +0530 Ram Prasad H L wrote
> hi all,
> 	We are using a customised board which is based on
> 	the reference design of lite5200B. But our board is customised by adding
> 	a PCI-PCI Bridge on the primary bus. On the secondary bus we have added
> 	a DSP(DM642) along with 2 PCI slots, which are routed through
> 	bridge (PCI2250) to MPC5200B.
> 
> 	As far as software is concerned we are using "mpc5200_lite_K26-BSP-b30"
> 	BSP downloaded from freescale's website for lite5200B. This BSP has a
> 	u-boot-1.1.3 and linux kernel-2.6.11.7. As far as u-boot is concerned
> 	the PCI devices are allocated and assigned with proper resources (BAR's)
> 	which come under the range for Mem region(40000000 - 4fffffff) and I/O
> 	region (50000000 - 50ffffff). But during the boot process of linux we
> 	are getting the following errors:
> 
> 
> ****************************************************************************
> ***
> 	PCI: Probing PCI hardware
> 	PCI: Cannot allocate resource region 1 of PCI bridge 1
> 	PCI: bridge 1 resource 1 moved to 4ff00000..4fffffff
> 	PCI: Cannot allocate resource region 2 of PCI bridge 1
> 	PCI: bridge 1 resource 2 moved to 4fe00000..4fefffff
> 	PCI: Failed to allocate mem resource #0: 400000 @ 50000000 for 0000:01:08.0
> 	PCI: Failed to allocate mem resource #1: 800000 @ 50000000 for 0000:01:08.0
> 	PCI: Failed to allocate I/O resource #2: 10 @ 1000 for 0000:01:08.0
> 
> ****************************************************************************
> ****

I had a similar problem with a 2.4.25 Kernel. I get the following
errors:

PCI: Cannot allocate resource region 0 of device 00:1b.0
PCI: moved device 00:1b.0 resource 0 (200) to e0000000

I solved the problem by adding

hose->last_busno = pciauto_bus_scan(hose, hose->first_busno);

at the end of the function mpc5xxx_find_bridges() in
arch/ppc/kernel/mpc5xxx_pci.c

I didnt looked in the 2.6.11.7 Kernel, but maybe this helps you!

Best regards
Heiko
