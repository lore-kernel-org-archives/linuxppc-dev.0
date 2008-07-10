Return-Path: <lorenzo@alphagolf.com>
Received: from mail26.atl.registeredsite.com (mail26.atl.registeredsite.com
	[216.247.37.21]) by ozlabs.org (Postfix) with ESMTP id 8AC94DDE07
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jul 2008 11:15:09 +1000 (EST)
Message-ID: <487561B4.8050805@alphagolf.com>
Date: Wed, 09 Jul 2008 18:11:16 -0700
From: "Lorenzo T. Flores" <lorenzo@alphagolf.com>
MIME-Version: 1.0
To: David Baird <dhbaird@gmail.com>
Subject: Re: booting an ML405
References: <486D774A.7000102@alphagolf.com>	<440abda90807031902u766eb4dby932e8741e947488e@mail.gmail.com>	<4872C4D0.4060006@alphagolf.com>
	<440abda90807081012g576f66e4p5fac6ae03470e7c8@mail.gmail.com>
In-Reply-To: <440abda90807081012g576f66e4p5fac6ae03470e7c8@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Hey all (David, John, & Grant)

Thanks for the responses! Using the TCL commands to dump memory values 
and a little python script I was able to get a readout of what my kernel 
is doing when it hangs:

<5>[ 0.000000] Linux version 2.6.25-rc9 
(ltflores@buildmachinelinux.ag.com) (gcc version 4.1.2) #9 Thu Jul 3 
15:55:15 EDT 2008
<6>[ 0.000000] Xilinx Generic PowerPC board support package (Xilinx 
ML405) (Virtex-4 FX)
<7>[ 0.000000] Entering add_active_range(0, 0, 196608) 0 entries of 256 used
<4>[ 0.000000] Zone PFN ranges:
<4>[ 0.000000] DMA 0 -> 196608
<4>[ 0.000000] Normal 196608 -> 196608
<4>[ 0.000000] Movable zone start PFN for each node
<4>[ 0.000000] early_node_map[1] active PFN ranges
<4>[ 0.000000] 0: 0 -> 196608
<7>[ 0.000000] On node 0 totalpages: 196608
<7>[ 0.000000] DMA zone: 1536 pages used for memmap
<7>[ 0.000000] DMA zone: 0 pages reserved
<7>[ 0.000000] DMA zone: 195072 pages, LIFO batch:31
<7>[ 0.000000] Normal zone: 0 pages used for memmap
<7>[ 0.000000] Movable zone: 0 pages used for memmap
<4>[ 0.000000] Built 1 zonelists in Zone order, mobility grouping on. 
Total pages: 195072
<5>[ 0.000000] Kernel command line: console=ttyS0,9600 ip=on 
root=/dev/ram rw
<6>[ 0.000000] Xilinx INTC #0 at 0x81800000 mapped to 0xFDFFE000
<4>[ 0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
<4>[ 0.000231] Console: colour dummy device 80x25
<6>[ 0.009326] Dentry cache hash table entries: 131072 (order: 7, 524288 
bytes)
<6>[ 0.023201] Inode-cache hash table entries: 65536 (order: 6, 262144 
bytes)
<4>[ 0.243554] Memory: 776192k available (1768k kernel code, 596k data, 
108k init, 0k highmem)
<4>[ 0.243750] Data machine check in kernel mode.
<4>[ 0.243798] Oops: machine check, sig: 7 [#1]
<4>[ 0.243826] NIP: c00593b0 LR: c005926c CTR: 00000000
<4>[ 0.243864] REGS: c0257f50 TRAP: 0202 Not tainted (2.6.25-rc9)
<4>[ 0.243890] MSR: 00029030 <EE,ME,IR,DR> CR: 24000082 XER: 00000050
<4>[ 0.243945] TASK = c0222518[0] 'swapper' THREAD: c0238000
<6>[ 0.243969] GPR00: 00000000 c0239f00 c0222518 c0ba5000 00000000 
00000000 ffffffff c0225e70
<6>[ 0.244000] GPR08: ffffffff efc000c0 00000001 00000002 c0ba53c0 
ffffffff ffffffff ffffffff
<6>[ 0.244000] GPR16: ffffffff ffffffff ffffffff ffffffff ffffffff 
ffffffff 00000000 00000010
<6>[ 0.244000] GPR24: 00000020 000080d0 c025263c 000000d0 c022693c 
efc00000 000000c0 efc00000
<4>[ 0.244000] NIP [c00593b0] cache_alloc_refill+0x428/0x594
<4>[ 0.244000] LR [c005926c] cache_alloc_refill+0x2e4/0x594
<4>[ 0.244000] Call Trace:
<4>[ 0.244000] [c0239f00] [c005926c] cache_alloc_refill+0x2e4/0x594 
(unreliable)
<4>[ 0.244000] [c0239f30] [c0058f40] kmem_cache_alloc+0x58/0xa0
<4>[ 0.244000] [c0239f50] [c005a2e0] kmem_cache_create+0x1b4/0x418
<4>[ 0.244000] [c0239f90] [c0246b58] kmem_cache_init+0x1a0/0x3c4
<4>[ 0.244000] [c0239fc0] [c023b958] start_kernel+0x244/0x2b4
<4>[ 0.244000] [c0239ff0] [c000225c] start_here+0x44/0xb0
<4>[ 0.244000] Instruction dump:
<4>[ 0.244000] 4bfffb69 2c030000 41820118 7c7f1b78 48000010 801c0034 
7ffdf214 7fde0214
<4>[ 0.244000] 38000000 7d3df214 913f000c 901f0014 <901f0010> 93df0008 
b01f0018 3d20c025
<4>[ 0.244000] Data machine check in kernel mode.
<4>[ 0.244000] Oops: machine check, sig: 7 [#2]
<4>[ 0.244000] NIP: c0003f6c LR: c0002dbc CTR: 00000001
<4>[ 0.244000] REGS: c0257f50 TRAP: 0202 Tainted: G D (2.6.25-rc9)
<4>[ 0.244000] MSR: 00021030 <ME,IR,DR> CR: 48000022 XER: 00000050
<4>[ 0.244000] TASK = c0222518[0] 'swapper' THREAD: c0238000
<6>[ 0.244000] GPR00: 08000000 c0257e70 c0222518 c0257e80 00000001 
00000001 00000000 c0220000
<6>[ 0.244000] GPR08: 00004000 c0002dbc 00021032 c0003f6c 00222728 
ffffffff ffffffff ffffffff
<6>[ 0.244000] GPR16: ffffffff ffffffff ffffffff ffffffff ffffffff 
ffffffff 00000000 00000010
<6>[ 0.244000] GPR24: 00000020 000080d0 c025263c 000000d0 c022693c 
efc00000 c0257f50 00000007
<4>[ 0.244000] NIP [c0003f6c] timer_interrupt+0x0/0x19c
<4>[ 0.244000] LR [c0002dbc] ret_from_except+0x0/0x18
<4>[ 0.244000] Call Trace:
<4>[ 0.244000] Instruction dump:
<4>[ 0.244000] 900960bc 4802dd71 813b62d0 39290001 913b62d0 7f200124 
38600000 80010034
<4>[ 0.244000] bb210014 7c0803a6 38210030 4e800020 <9421ffe0> 7c0802a6 
bf61000c 90010024
<0>[ 0.244000] Kernel panic - not syncing: Attempted to kill the idle task!
<0>[ 0.244000] Rebooting in 180 seconds..

Things just don't look good here...

John mentioned inconsistencies with my available ram, heres what I found 
in my xparameters_ml405.h file -

 From my xparameters_ml405.h file:

/* Definitions for driver MPMC */
#define XPAR_XMPMC_NUM_INSTANCES 1

/* Definitions for peripheral DDR_SDRAM */
#define XPAR_DDR_SDRAM_DEVICE_ID 0
#define XPAR_DDR_SDRAM_MPMC_CTRL_BASEADDR 0xFFFFFFFF
#define XPAR_DDR_SDRAM_INCLUDE_ECC_SUPPORT 0


/******************************************************************/

/* Definitions for peripheral DDR_SDRAM */
#define XPAR_DDR_SDRAM_MPMC_BASEADDR 0x00000000
#define XPAR_DDR_SDRAM_MPMC_HIGHADDR 0x07FFFFFF
#define XPAR_DDR_SDRAM_SDMA_CTRL_BASEADDR 0x84600000
#define XPAR_DDR_SDRAM_SDMA_CTRL_HIGHADDR 0x8460FFFF

Unfortunately I'll have to wait till tomorrow to really dig into my 
memory stuff, I figured I'd include it in case anyone has good info to 
help me avoid walking down the wrong direction here.

I'm very grateful for your responses as they were tremendously helpful. 
Thank you. And as before, any info or tips you guys have is always 
appreciated.

thanks,
Lorenzo

David Baird wrote:
> On Mon, Jul 7, 2008 at 7:37 PM, Lorenzo T. Flores <lorenzo@alphagolf.com> wrote:
>   
>> If I stop the processor after it hangs:
>>
>> XMD% mrd 0xc0259fa4 10
>> C0259FA4:   3C353E5B
>> C0259FA8:   20202020
>> C0259FAC:   302E3030
>> C0259FB0:   30303030
>> C0259FB4:   5D204C69
>> C0259FB8:   6E757820
>> C0259FBC:   76657273
>> C0259FC0:   696F6E20
>> C0259FC4:   322E362E
>> C0259FC8:   32352D72
>>     
>
> Since XMD is also a Tcl shell, you can easily download __log_buf like this:
>
>     set fd [open xmd.log w]
>     puts $fd [mrd  0xc0259fa4 10]
>
> Then, with a little tweaking, you could use xxd or some other tool to
> convert it to ASCII.
>
>   
>> If I cut off the 0xc0000000:
>>
>> XMD% mrd 0x259fa4 10
>>  259FA4:   FFFFFFFF
>>  259FA8:   FFFFFFFF
>>  259FAC:   FFFFFFFF
>>  259FB0:   FFFFFFFF
>>  259FB4:   FFFFFFFF
>>  259FB8:   FFFFFFFF
>>  259FBC:   FFFFFFFF
>>  259FC0:   FFFFFFFF
>>  259FC4:   FFFFFFFF
>>  259FC8:   FFFFFFFF
>>     
>
> My guess is that if you issue a rst (reset) command, I think this will
> take the processor out of virtual mode and then you can strip of the
> 0xc0000000.  But looks like you got what you need anyways, so no need
> for this :-)
>
> -David
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>   
