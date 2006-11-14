Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 36E6667D1A
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 15:19:58 +1100 (EST)
Received: from az33smr01 (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	kAE4Jux6025163
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 21:19:56 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01 (8.13.1/8.13.0) with ESMTP id kAE4JkOp003117
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 22:19:50 -0600 (CST)
Subject: Re: [PATCH 7/32] powerpc: Make pci_read_irq_line the default
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <20061111062522.34CAC68047@ozlabs.org>
References: <20061111062522.34CAC68047@ozlabs.org>
Content-Type: text/plain
Message-Id: <1163478030.3472.9.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 14 Nov 2006 12:20:30 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-11-11 at 14:24, Benjamin Herrenschmidt wrote:
> This patch reworks the way IRQs are fixed up on PCI for arch powerpc.
> 
> It makes pci_read_irq_line() called by default in the PCI code for
> devices that are probed, and add an optional per-device fixup in
> ppc_md for platforms that really need to correct what they obtain
> from pci_read_irq_line().
> 
> It also removes ppc_md.irq_bus_setup which was only used by pSeries
> and should not be needed anymore.
> 
> I've also removed the pSeries s7a workaround as it can't work with
> the current interrupt code anyway. I'm trying to get one of these
> machines working so I can test a proper fix for that problem.
> 
> I also haven't updated the old-style fixup code from 85xx_cds.c
> because it's actually buggy :) It assigns pci_dev->irq hard coded
> numbers which is no good with the new IRQ mapping code. It should
> at least use irq_create_mapping(NULL, hard_coded_number); and possibly
> also set_irq_type() to set them as level low.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 

>  arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |   16 ++-----
>  


Paul
	I checked your updated git tree just now.
	I have seen that you applied Ben's patch on mpc7448hpc2 platform about
the "pci_read_irq_line".
	Could you discard this part in Ben's patch and apply mine:

http://ozlabs.org/pipermail/linuxppc-dev/2006-October/027295.html
http://ozlabs.org/pipermail/linuxppc-dev/2006-October/027340.html
	
	Ben must forget this part of patch in his new serial patches.
	Thanks.
Roy
