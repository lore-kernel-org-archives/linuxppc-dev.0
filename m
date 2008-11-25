Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id B0EEFDDDEE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Nov 2008 23:40:52 +1100 (EST)
Message-ID: <492BD099.9000903@windriver.com>
Date: Tue, 25 Nov 2008 18:16:57 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Benjamin Walsh <walsh.benj@gmail.com>
Subject: Re: NMI and AMD8131/8111 on Maple board
References: <DF6C7BC3780EE44B83430A9F756D43B6086F5441@SJEXCH03.ds.jdsu.net>	<113760FDF39C3E40AAB8DE6E6C64D0A781B747@zch01exm26.fsl.freescale.net>
	<012201c94e74$3dbb55b0$e693e080@corp.ad.wrs.com>
In-Reply-To: <012201c94e74$3dbb55b0$e693e080@corp.ad.wrs.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Benjamin Walsh wrote:
> Hi all,
> 
> I've written EDAC support for the AMD8131/8111 chips that are present on a
> Maple board (PPC970FX with IBM CPC925 memory controller/bridge), currently
> running in poll mode. I am now trying to get this to work in interrupt mode.
> These two chipsets have a feature that enables triggering an NMI when an
> error is detected (PERR and SERR). How can this be hooked into the interrupt
> system on a PPC board ?
> 
>>From what I understand from the doc for these chipsets, the NMI will
> delivered as a HT message to the CPC925 on this board. What I don't get is
> how will this be delivered to the CPU, and on what interrupt line ? The HT
> message sent to the CPC925 is the following:
> 
> MT = NMI
> TM = edge
> DM = physical
> INTRDEST = 'hFF (all)
> VECTOR = 'h00 (does not matter)
> 

The AMD8131/8130 can generate an NMI to the CPC925. There is an interrupt
controller resided in the CPC925. And you know the CPC925 is attached the
PowerPC PPC970FX. The interrupt controller collects and distributes system
interrupts from the PCI Express and HyperTransport blocks. So you should get the
map connection based on the system in detail. Often these information should be
defined in the corresponding dtc.

Best Regards
Tiejun

> Any help appreciated.
> 
> Thanks,
> Ben
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
