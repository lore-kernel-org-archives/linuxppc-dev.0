Return-Path: <thagen@slb.com>
Received: from mail.slb.com (eurmta01.london.eur.slb.com [134.32.26.55])
	by ozlabs.org (Postfix) with ESMTP id 9F34367B1F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 00:22:19 +1100 (EST)
Received: from pmxchannel_int-daemon.eurmta01.london.eur.slb.com by
	eurmta01.london.eur.slb.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	id <0IUH0000O30WPO@eurmta01.london.eur.slb.com> for
	linuxppc-embedded@ozlabs.org; Fri, 10 Feb 2006 13:05:21 +0000 (GMT)
Received: from gb0135clu01.mail.slb.com
	(gb0135clu01.mail.slb.com [136.250.9.4]) by eurmta01.london.eur.slb.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0IUH00MTE2ZTJX@eurmta01.london.eur.slb.com> for
	linuxppc-embedded@ozlabs.org; Fri, 10 Feb 2006 13:04:41 +0000 (GMT)
Received: from pmxchannel-daemon.gb0135mbx01.mail.slb.com by
	gb0135mbx01.mail.slb.com
	(Sun Java System Messaging Server 6.2-1 (built Feb 24 2005))
	id <0IUH0090V2ZSXZ00@gb0135mbx01.mail.slb.com> for
	linuxppc-embedded@ozlabs.org; Fri, 10 Feb 2006 13:04:40 +0000 (GMT)
Date: Fri, 10 Feb 2006 14:04:38 +0100
From: Tore Martin Hagen <thagen@slb.com>
Subject: Re: HELP! Memory mapping and address space doubts
In-reply-to: <16FD2D70D281D44F9BFCF6ACF9B6117102AD0EED@lisi053a.siemens.pt>
To: =?UTF-8?B?Ikpvc2UgRnJhbsOnYSAoRXh0X0dUQkMpIg==?=
	<Jose.Franca.Ext@siemens.com>
Message-id: <43EC8F66.6040500@slb.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
References: <16FD2D70D281D44F9BFCF6ACF9B6117102AD0EED@lisi053a.siemens.pt>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Vitaly,

It seams that you are mixing virtual addresses and physical addresses. 
You must put RAM at physical address 0 and you can keep the flash and 
fpga as it is. The 0xc0000000 is  the virtual address of the kernel, and 
has nothing to do with the physical address.

Where have you mapped the IMMR?

If you have problems with probing of the CFI flash I would try to find 
out what the problem realy is. I was given a board with what I would 
call SwapEndian, I had to use littleendian for read and bigendian for 
writes.

/Tore Martin Hagen



Jose França (Ext_GTBC) wrote:

>Vitaly,
> 
>     I'm using a linux 2.4.31 kernel. In the present situation I have BRx/ORx well configured and i can boot u-boot normally and without problems. I have a flash eprom with base address 0xD0000000 and a FPGA in 0xE0000000. In linux, i have the mtd driver similar to the rpxlite board. cfi_probe doesn't find my flash eprom. My colleague developped an fpga driver, but he can't access it either... It seem's that all the addresses that we try to access are all mixed-up. In ppc_md.map_io, i'm doing io_block_mapping for the CPM (from 0xf0000000 to the end of memory) , 0x80000000 and 0xa0000000 for PCI address space, both with 256MB of length. We are a bit lost... It seems that we forgot something to do. Can you help me on this?
> 
> 
>Best regards,
>Filipe.
>
>	-----Mensagem original----- 
>	De: linuxppc-embedded-bounces@ozlabs.org em nome de Vitaly Bordug 
>	Enviada: sex 27-01-2006 13:37 
>	Para: Jose França (Ext_GTBC) 
>	Cc: linuxppc-embedded@ozlabs.org 
>	Assunto: Re: HELP! Memory mapping and address space doubts
>	
>	
>
>	Jose,
>	Can you please be a bit more specific in targets you want to achieve?
>	
>	An example how to setup br/or and use the device could be found as a part of PQ2 PCI support,
>	where interrupt controller is implemented as a CPLD device (arch/ppc/syslib/m82xx_pci.{c,h}).
>	
>	
>	On Thu, 26 Jan 2006 14:04:49 -0000
>	Jose França (Ext_GTBC) <Jose.Franca.Ext@siemens.com> wrote:
>	
>	> Hello u all!
>	>
>	>       I need to clarify some aspects of the memory management in ppc linux and i hope that you could help me.
>	>       Lets imagine we have a mpc8272 based board with 3 devices A, B and C.In the bootloader (in my case, i use u-boot), i configured the BRx and Orx so that A has base address X, B has base address Y and C has base address Z. My first doubt arrises here: what address should i use? Being SDRAM base address 0x00000000 and kernel base address 0xC0000000, where will i put these devices mapped on? Above 0xC0000000 or in between the end of physical memory and 0xC0000000? Do i really need to configure the BAT registers in u boot?
>	>       In linux 2.4 kernel, we have ppc_md.setup_io_mappings to map address blocks into the BAT registers... As i observed in the kernel source tree examples, we must map CPM (why?). And what about the other devices A, B and C? How will i setup them in this case and what addresses i can use? Above 0xC0000000 or in between the end of physical memory and 0xC0000000? Is the SDRAM included?
>	>
>	>       Thanks in advance to all contributions! All of them will be most welcomed!
>	>
>	>
>	>
>	>
>	>
>	> Best regards,
>	> Filipe
>	>
>	> _______________________________________________
>	> Linuxppc-embedded mailing list
>	> Linuxppc-embedded@ozlabs.org
>	> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>	>
>	>
>	
>	
>	--
>	Sincerely,
>	Vitaly
>	_______________________________________________
>	Linuxppc-embedded mailing list
>	Linuxppc-embedded@ozlabs.org
>	https://ozlabs.org/mailman/listinfo/linuxppc-embedded 
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
