Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 806E967D77
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Aug 2005 23:24:51 +1000 (EST)
In-Reply-To: <op.suvg7mug0c7u6q@clj.sysgo.com>
References: <op.suvg7mug0c7u6q@clj.sysgo.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <47D369BD-BFD1-40A6-8A2A-9DC628DBB9CD@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 2 Aug 2005 08:24:51 -0500
To: Carl Ljungmark <carl.ljungmark@sysgo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8245+2.6.12=oops
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This looks like an issue with the MEN port.  without that code its  
difficult to comment on what exactly may be wrong.

- kumar

On Aug 2, 2005, at 3:44 AM, Carl Ljungmark wrote:

> Hello everyone!
> Trying to boot linux 2.6.12 on an MPC8245 board from MEN (a12) with  
> MenMon
> firmware. Nothing is printed to the console (ttyS0), but the __log_buf
> contains this:
>
> <4>entering platform_init.
> <4>MENMON parameter string: MPAR brd=A012a brdrev=01.04.00 brdmod=00
> sernbr=74 cbr=38400 cons=COM1 mem0=262144 cpu=MPC8245  
> cpuclk=250memclk=100
> vmeirqenb=FEclun=02dlun=00 mm=smm
> MMST=_00+_12+_1B+_1C+_0C+_17+_1A+_1D+_1E-SPD+RTC+LM75+WDOG+CHKS+ALL+.
> <4>Command line now console=ttyS0,38400.
> <4>Using memory size from MENMON 0x10000000.
> <3>Non-recoverable exception at PC=c0007af0 MSR=b930.
> <4>Oops: nonrecoverable exception,sig: 9 [#1].
> <4>NIP: C0007AF0 LR:C000E474 SP: C00F7F70 REGS: c00f7ec0 TRAP: 0600  
> Not
> tainted.
> <4>MSR: 0000b930 EE: 1 PR: 0 FP:1 ME: 1 IR/DR:11.
> <4>DAR: C0138000, DSISR: 00017C00.
> <4>TASK = c00dda10[0] 'swapper' THREAD: c00f6000.
> <4>Last syscall: 0 .
> <6>GPR00: 00000080 C00F7F70 C00DDA10 C0138000 0000000000001000  
> 00000001
> 00000001 .
> <6>GPR08: 0000000200000000 00000001 00000000 00000000 00000000  
> 00008081
> 2A090A86 .
> <6>GPR16: 10588403 1E21D063 21218986 50022502 3C0185B8  
> 011368CA00FFF010
> 00FFF024 .
> <6>GPR24: 00000000 01F8FA68 40000000 C00DC000000005A9 FD000000  
> FD000000
> C0138000 .
> <4>NIP [c0007af0] clear_pages+0x10/0x1c.
> <4>LR [c000e474] pte_alloc_one_kernel+0x60/0x78.
> <4>Call trace:.
> <4> [c003e948] pte_alloc_kernel+0x54/0x84.
> <4> [c000e5e4] map_page+0x3c/0xdc.
> <4> [c00ff61c] io_block_mapping+0x78/0xdc.
> <4> [c00fe560] men824xali_map_io+0x20/0x44.
> <4> [c00fec38] MMU_init+0x194/0x204.
> <4> [c00032a4]start_here+0x48/0x80.
> 0>Kernelpanic - not syncing: Attempted to kill the idletask!.
> <4> ......
>
> adding 'nobats' to the command line changes the boot output  
> slightly (I
> then get two oops).
>
> In order to get the whole output I had to turn off caching, maybe  
> this has
> influenced the boot process.. with dcache on, the __log_buf is  
> practically
> empty.
>
> Has anyone managed to boot 6.12 on this board successfully?
>
> Thanks in advance,
> Carl.
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
