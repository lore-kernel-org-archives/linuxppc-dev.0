Return-Path: <ml@iridescent.org>
Received: from mail.iridescent.org (adsl-63-193-117-152.dsl.snfc21.pacbell.net
	[63.193.117.152]) by ozlabs.org (Postfix) with SMTP id 0D9FF67ACB
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Feb 2005 21:49:22 +1100 (EST)
Mime-Version: 1.0
Message-Id: <p0611041bbe2f959b9dda@mail.iridescent.org>
In-Reply-To: <OF307335B1.8C256DF4-ON87256F98.005EDF72-85256F98.00648315@us.ibm.com>
References: <OF307335B1.8C256DF4-ON87256F98.005EDF72-85256F98.00648315@us.ibm.com>
Date: Wed, 9 Feb 2005 02:34:11 -0800
To: John F Davis <johndavi@us.ibm.com>, linuxppc-embedded@ozlabs.org
From: "Lawrence E. Bakst" <ml@iridescent.org>
Content-Type: text/plain; charset="us-ascii"
Subject: Re: ppc405 core, VIA VT82C686A chipset, linux_2.4.22_pre5, 	and
 IDE DMA woes
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

1. Can you say exactly which 405 core you are using?

2. Is it Xilinx?

3. Have you read all the eratta for your core?

4. How is the VIA VT82C686A hooked to the 405? Via a bus mastering EBC?

Best,

leb


At 1:12 PM -0500 1/29/05, John F Davis wrote:
>Hello
>
>I am trying to get DMA working on a ppc405 core on a custom SOC with IDE
>DMA using a VIA VT82C686A southbridge.  I apologize for the length of this
>note.
>
>Here is my environment, configuration, attempts at fixing the system, what
>works, and what doesn't.
>
>o  Using linux 2.4.22 pre5 kernel from ppc devel bitkeeper tree.  Using
>cross compiler gcc version 3.2.3
>
>o  On this box non dma IDE works flawlessy with and without 405 data
>caching.
>
>o  DMA IDE works when caching is disabled.  When caching is enabled and
>DMA ide is enabled, the system works for a while and then it gets a Data
>Storage Exception when it tries to do a write.  The exception is usually
>involves writing to a very similar address no matter how and when the
>exception occurs.
>
>o  I am using hdparm to enable and disable the IDE DMA at the command
>line.  I ususally cause the oops by running consecutive hdparm tests from
>two different TTY logins.  If that does not cause it to oops then starting
>X windows, playing a movie from disk and then issuing the hdparm test most
>certainly will.
>
>o  Here are some sample oops messages and ksymoops interpetations.  (There
>is more info after the oops messages.)
>
># Oops: kernel access of bad area, sig: 11
>NIP: A002EC04 XER: 20000000 LR: A002EB84 SP: ACBC5D60 REGS: acbc5cb0 TRAP:
>0800    Tainted: P
>MSR: 00001030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
>DEAR: 5459545D, ESR: 00800000
>TASK = acbc4000[156] 'xine' Last syscall: 4
>last math 00000000 last altivec 00000000
>PLB0: bear= 0x00000000 acr=   0x00000000 besr=  0x00000000
>PLB0 to OPB: bear= 0xc27e3183 besr0= 0xc0000000 besr1= 0x00000000
> 
>GPR00: 00000000 ACBC5D60 ACBC4000 00000001 00009030 00000001 000009B0
>AB126000
>GPR08: FFFFFFFF AB14F020 54595459 A02E9DDC 24044082 10115790 00000000
>100E10B0
>GPR16: ACBC5EA0 AB0FE000 A007ACA8 ACBC5E08 AEB3F080 AEB3F080 000009B0
>00001000
>GPR24: 00000000 A04D2BA8 00000001 00000000 00001000 000000F0 AB126F60
>A02E9DD4
>Call backtrace: 
>00000003 A002E3E4 A003A084 A003A1C0 A003A504 A003AC90 A003B4D8
>A007B000 A002A874 A002AECC A0037564 A000279C 0FECCD18 0EFC53BC
>0FF50A48 0FEC7914 0FC0B408
> 
>produces:*************************
>>>NIP; a002ec04 <kmem_find_general_cachep+6ec/2614>   <=====
>
>>>GPR1; acbc5d60 <_end+c925038/12618420>
>>>GPR2; acbc4000 <_end+c9232d8/12618420>
>>>GPR7; ab126000 <_end+ae852d8/12618420>
>>>GPR9; ab14f020 <_end+aeae2f8/12618420>
>>>GPR11; a02e9ddc <_end+490b4/12618420>
>>>GPR16; acbc5ea0 <_end+c925178/12618420>
>>>GPR17; ab0fe000 <_end+ae5d2d8/12618420>
>>>GPR18; a007aca8 <journal_blocks_per_page+4340/87fc>
>>>GPR19; acbc5e08 <_end+c9250e0/12618420>
>>>GPR20; aeb3f080 <_end+e89e358/12618420>
>>>GPR21; aeb3f080 <_end+e89e358/12618420>
>>>GPR25; a04d2ba8 <_end+231e80/12618420>
>>>GPR30; ab126f60 <_end+ae86238/12618420>
>>>GPR31; a02e9dd4 <_end+490ac/12618420>
>
>Trace; 00000003 Before first symbol
>Trace; a002e3e4 <kmem_cache_alloc+10/20>
>Trace; a003a084 <get_unused_buffer_head+68/c8>
>Trace; a003a1c0 <set_bh_page+dc/334>
>Trace; a003a504 <create_empty_buffers+24/908>
>Trace; a003ac90 <create_empty_buffers+7b0/908>
>Trace; a003b4d8 <block_prepare_write+34/a8>
>Trace; a007b000 <journal_blocks_per_page+4698/87fc>
>Trace; a002a874 <read_cache_page+5f4/aac>
>Trace; a002aecc <generic_file_write+1a0/2400>
>Trace; a0037564 <default_llseek+490/e10>
>Trace; a000279c <set_context+3b4/5e0>
>Trace; 0feccd18 Before first symbol
>Trace; 0efc53bc Before first symbol
>Trace; 0ff50a48 Before first symbol
>Trace; 0fec7914 Before first symbol
>Trace; 0fc0b408 Before first symbol
>
>
>5 warnings and 2 errors issued.  Results may not be reliable.
>
>===========================================================
>
>
>>>NIP; a002ec40 <kmem_find_general_cachep+728/2614>   <=====
>
>>>GPR1; ab53dd10 <_end+b29cfe8/125fe420>
>>>GPR2; ab53c000 <_end+b29b2d8/125fe420>
>>>GPR7; ad4f0000 <_end+d24f2d8/125fe420>
>>>GPR8; a0270000 <ide_register_driver+9e3c/be50>
>>>GPR9; a02e9ddc <_end+490b4/125fe420>
>>>GPR11; a02e9de4 <_end+490bc/125fe420>
>>>GPR18; a00284d0 <do_generic_file_read+73c/804>
>>>GPR19; ada5ff60 <_end+d7bf238/125fe420>
>>>GPR20; ab53ded8 <_end+b29d1b0/125fe420>
>>>GPR21; a003ea04 <sb_min_blocksize+60/4c8>
>>>GPR25; a052bd04 <_end+28afdc/125fe420>
>>>GPR30; a02e9ddc <_end+490b4/125fe420>
>>>GPR31; a02e9dd4 <_end+490ac/125fe420>
>
>Trace; 00000000 Before first symbol
>Trace; a002e3e4 <kmem_cache_alloc+10/20>
>Trace; a003a084 <get_unused_buffer_head+68/c8>
>Trace; a003a1c0 <set_bh_page+dc/334>
>Trace; a003a504 <create_empty_buffers+24/908>
>Trace; a003b094 <block_read_full_page+2ac/2d8>
>Trace; a003ead0 <sb_min_blocksize+12c/4c8>
>Trace; a00272b4 <filemap_fdatawait+414/4dc>
>Trace; a0027c40 <grab_cache_page_nowait+22c/380>
>Trace; a0028108 <do_generic_file_read+374/804>
>Trace; a0028640 <generic_file_read+a8/9d4>
>Trace; a0037414 <default_llseek+340/e10>
>Trace; a000279c <set_context+3b8/5e4>
>Trace; 00000000 Before first symbol
>Trace; 10001dcc Before first symbol
>Trace; 10002ba4 Before first symbol
>Trace; 10003f94 Before first symbol
>Trace; 0fee4920 Before first symbol
>Trace; 00000000 Before first symbol
>
>
>
>=======================================================
>
>
>Trace; a00190dc <__tasklet_hi_schedule+204/250>
>Trace; a002e3e4 <kmem_cache_alloc+10/20>
>Trace; a003a084 <get_unused_buffer_head+68/c8>
>Trace; a003a1c0 <set_bh_page+dc/334>
>Trace; a003a504 <create_empty_buffers+24/908>
>Trace; a003b094 <block_read_full_page+2ac/2d8>
>Trace; a003ead0 <sb_min_blocksize+12c/4c8>
>Trace; a00272b4 <filemap_fdatawait+414/4dc>
>Trace; a0027c40 <grab_cache_page_nowait+22c/380>
>Trace; a0027f3c <do_generic_file_read+1a8/804>
>Trace; a0028640 <generic_file_read+a8/9d4>
>Trace; a0037414 <default_llseek+340/e10>
>Trace; a000279c <set_context+3b8/5e4>
>Trace; 00000000 Before first symbol
>Trace; 10001dcc Before first symbol
>Trace; 10002ba4 Before first __ide_dma_write
>symbol
>Trace; 1__ide_dma_write
>0003f94 Before first symbol
>Trace; 0fee4920 Before first symbol
>Trace; 00000000 Before first symbol
>
>
>i========================================
># Oops: kernel access of bad area, sig: 11
>NIP: A002EC40 XER: 20000000 LR: A002EB84 SP: AF40BD10 REGS: af40bc60 TRAP:
>0800    Tainted: P
>MSR: 00001030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
>DEAR: 54D954DD, ESR: 00800000
>TASK = af40a000[292] 'hdparm' Last syscall: 3
>last math 00000000 last altivec 00000000
>PLB0: bear= 0x60000000 acr=   0x00000000 besr=  0x00000000
>PLB0 to OPB: bear= 0xc27e3183 besr0= 0xc0000000 besr1= 0x00000000
> 
>GPR00: 00000000 AF40BD10 AF40A000 00000001 00009030 00000001 0000000A
>AC091000
>GPR08: A0270000 A02E9DDC 54D954D9 A02E9DE4 84002082 101EDDE4 00000000
>00000000
>GPR16: 00000000 00000000 A00284D0 ADC0E760 AF40BED8 A003EA04 00000001
>00000000
>GPR24: 00000C00 A045BBA0 00000001 00000000 00000400 000000F0 A02E9DDC
>A02E9DD4
>Call backtrace: 
>A045FED4 A002E3E4 A003A084 A003A1C0 A003A504 A003B094 A003EAD0
>A00272B4 A0027C40 A0028108 A0028640 A0037414 A000279C 00000000
>10001DCC 10002BA4 10003F94 0FEE4920 00000000
># Oops: kernel access of bad area, sig: 11
>NIP: A002EC40 XER: 20000000 LR: A002EB84 SP: AF40BD10 REGS: af40bc60 TRAP:
>0800    Tainted: P
>MSR: 00001030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
>DEAR: 54D954DD, ESR: 00800000
>TASK = af40a000[292] 'hdparm' Last syscall: 3
>last math 00000000 last altivec 00000000
>PLB0: bear= 0x60000000 acr=   0x00000000 besr=  0x00000000
>PLB0 to OPB: bear= 0xc27e3183 besr0= 0xc0000000 besr1= 0x00000000
> 
>GPR00: 00000000 AF40BD10 AF40A000 00000001 00009030 00000001 0000000A
>AC091000
>GPR08: A0270000 A02E9DDC 54D954D9 A02E9DE4 84002082 101EDDE4 00000000
>00000000
>GPR16: 00000000 00000000 A00284D0 ADC0E760 AF40BED8 A003EA04 00000001
>00000000
>GPR24: 00000C00 A045BBA0 00000001 00000000 00000400 000000F0 A02E9DDC
>A02E9DD4
>Call backtrace: 
>A045FED4 A002E3E4 A003A084 A003A1C0 A003A504 A003B094 A003EAD0
>A00272B4 A0027C40 A0028108 A0028640 A0037414 A000279C 00000000
>10001DCC 10002BA4 10003F94 0FEE4920 00000000
>
>>>NIP; a002ec40 <kmem_find_general_cachep+728/2614>   <=====
>
>>>GPR1; af40bd10 <_end+f16afe8/125fe420>
>>>GPR2; af40a000 <_end+f1692d8/125fe420>
>>>GPR7; ac091000 <_end+bdf02d8/125fe420>
>>>GPR8; a0270000 <ide_register_driver+9e3c/be50>
>>>GPR9; a02e9ddc <_end+490b4/125fe420>
>>>GPR11; a02e9de4 <_end+490bc/125fe420>
>>>GPR18; a00284d0 <do_generic_file_read+73c/804>
>>>GPR19; adc0e760 <_end+d96da38/125fe420>
>>>GPR20; af40bed8 <_end+f16b1b0/125fe420>
>>>GPR21; a003ea04 <sb_min_blocksize+60/4c8>
>>>GPR25; a045bba0 <_end+1bae78/125fe420>
>>>GPR30; a02e9ddc <_end+490b4/125fe420>
>>>GPR31; a02e9dd4 <_end+490ac/125fe420>
>
>Trace; a045fed4 <_end+1bf1ac/125fe420>
>Trace; a002e3e4 <kmem_cache_alloc+10/20>
>Trace; a003a084 <get_unused_buffer_head+68/c8>
>Trace; a003a1c0 <set_bh_page+dc/334>
>Trace; a003a504 <create_empty_buffers+24/908>
>Trace; a003b094 <block_read_full_page+2ac/2d8>
>Trace; a003ead0 <sb_min_blocksize+12c/4c8>
>Trace; a00272b4 <filemap_fdatawait+414/4dc>
>Trace; a0027c40 <grab_cache_page_nowait+22c/380>
>Trace; a0028108 <do_generic_file_read+374/804>
>Trace; a0028640 <generic_file_read+a8/9d4>
>Trace; a0037414 <default_llseek+340/e10>
>Trace; a000279c <set_context+3b8/5e4>
>Trace; 00000000 Before first symbol
>Trace; 10001dcc Before first symbol
>Trace; 10002ba4 Before first symbol
>Trace; 10003f94 Before first symbol
>Trace; 0fee4920 Before first symbol
>Trace; 00000000 Before first symbol
>
>==========================================================
>
>added the debug code to drivers/block/ll_rw_blk.c
>#Oops: kernel access of bad area, sig: 11
>NIP: A002EC04 XER: 20000000 LR: A002EB84 SP: ACF25D60 REGS: acf25cb0 TRAP:
>0800    Tainted: P
>MSR: 00001030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
>DEAR: 54D954DD, ESR: 00800000
>TASK = acf24000[139] 'xine' Last syscall: 4
>last math 00000000 last altivec 00000000
>PLB0: bear= 0x60000000 acr=   0x00000000 besr=  0x00000000
>PLB0 to OPB: bear= 0xc27e3183 besr0= 0xc0000000 besr1= 0x00000000
> 
>GPR00: 00000000 ACF25D60 ACF24000 00000001 00009030 00000001 0000042C
>AB9F1000
>GPR08: FFFFFFFF ABA1A020 54D954D9 A02E9DDC 24044082 10115790 00000000
>100E10B0
>GPR16: ACF25EA0 AB9CE000 A007ACA8 ACF25E08 AC58F680 AC58F680 0000042C
>00001000
>GPR24: 00000000 A04EAF68 00000001 00000000 00001000 000000F0 AB9F1F60
>A02E9DD4
>Call backtrace: 
>00000003 A002E3E4 A003A084 A003A1C0 A003A504 A003AC90 A003B4D8
>A007B000 A002A874 A002AECC A0037564 A000279C 0FECCD18 0EFC53BC
>0FF50A48 0FEC7914 0FC0B408
>
>Was so hosed I could not run ksymoops.
>================================
>
> Timing buffered disk reads:  Oops: kernel access of bad area, sig: 11
>NIP: A002EC28 XER: 20000000 LR: A002EB84 SP: AE1F7D10 REGS: ae1f7c60 TRAP:
>0800    Tainted: P
>MSR: 00001030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
>DEAR: 54D954D9, ESR: 00000000
>TASK = ae1f6000[131] 'hdparm' Last syscall: 3
>last math 00000000 last altivec 00000000
>PLB0: bear= 0x60000000 acr=   0x00000000 besr=  0x00000000
>PLB0 to OPB: bear= 0xc27e3183 besr0= 0xc0000000 besr1= 0x00000000
> 
>GPR00: A02E9DE4 AE1F7D10 AE1F6000 00000001 00009030 00000002 00000003
>54D954D9
>GPR08: A0270000 00000000 A0270000 00000001 84002042 10025468 00000000
>00000000
>GPR16: 00000000 00000000 A00284D0 AC3CE760 AE1F7ED8 A003EA1C 00000000
>00000000
>GPR24: 00000C00 A054755C 00000001 00000000 00000400 000000F0 A02E9DDC
>A02E9DD4
>Call backtrace: 
>A00190DC A002E3E4 A003A09C A003A1D8 A003A51C A003B0AC A003EAE8
>A00272B4 A0027C40 A0027F3C A0028640 A0037414 A000279C 00000000
>10001DCC 10002BA4 10003F94 0FEE4920 00000000
>Segmentation fault
>
>Warning (Oops_read): Code line not seen, dumping what data is available
>
>
>>>NIP; a002ec28 <kmem_find_general_cachep+710/2614>   <=====
>
>>>GPR0; a02e9de4 <_end+490bc/125fe420>
>>>GPR1; ae1f7d10 <_end+df56fe8/125fe420>
>>>GPR2; ae1f6000 <_end+df552d8/125fe420>
>>>GPR8; a0270000 <ide_register_driver+9e3c/be50>
>>>GPR10; a0270000 <ide_register_driver+9e3c/be50>
>>>GPR18; a00284d0 <do_generic_file_read+73c/804>
>>>GPR19; ac3ce760 <_end+c12da38/125fe420>
>>>GPR20; ae1f7ed8 <_end+df571b0/125fe420>
>>>GPR21; a003ea1c <sb_min_blocksize+60/4c8>
>>>GPR25; a054755c <_end+2a6834/125fe420>
>>>GPR30; a02e9ddc <_end+490b4/125fe420>
>>>GPR31; a02e9dd4 <_end+490ac/125fe420>
>
>Trace; a00190dc <__tasklet_hi_schedule+204/250>
>Trace; a002e3e4 <kmem_cache_alloc+10/20>
>Trace; a003a09c <get_unused_buffer_head+80/e0>
>Trace; a003a1d8 <set_bh_page+dc/334>
>Trace; a003a51c <create_empty_buffers+24/908>
>Trace; a003b0ac <block_read_full_page+2ac/2d8>
>Trace; a003eae8 <sb_min_blocksize+12c/4c8>
>Trace; a00272b4 <filemap_fdatawait+414/4dc>
>Trace; a0027c40 <grab_cache_page_nowait+22c/380>
>Trace; a0027f3c <do_generic_file_read+1a8/804>
>Trace; a0028640 <generic_file_read+a8/9d4>
>Trace; a0037414 <default_llseek+340/e10>
>Trace; a000279c <set_context+3b8/5e4>
>Trace; 00000000 Before first symbol
>Trace; 10001dcc Before first symbol
>Trace; 10002ba4 Before first symbol
>Trace; 10003f94 Before first symbol
>Trace; 0fee4920 Before first symbol
>
>
>
>
>Here is a dump of the configuration space for the isa bridge and ide
>interface on the VIA chipset in both human readable form and raw form.
>
> The ISA bridge:
>0000:00:01.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super
>South] (rev 40)
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>ParErr- Stepping+ SERR- FastB2B-
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
><TAbort- <MAbort- >SERR- <PERR-
>        Latency: 0
>        Interrupt: pin ? routed to IRQ 46
>        Capabilities: [c0] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
>PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
>and in raw form
>0000:00:01.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super
>South] (rev 40)
>00: 06 11 86 06 87 00 10 02 40 00 01 06 00 00 80 00
>10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00
>40: 08 01 00 00 00 00 00 00 05 01 84 00 00 00 00 03
>50: 0e 00 34 00 0f 90 ba 00 00 04 bf 00 00 00 00 00
>60: d8 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>70: 00 00 00 00 00 00 00 88 00 00 00 00 00 00 00 00
>80: 00 00 00 00 00 01 00 00 00 60 00 00 00 00 00 00
>90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
>d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>f0: 00 00 00 00 00 00 42 00 00 00 00 00 00 00 00 00
>
>
>The IDE Interface:
>0000:00:01.1 IDE interface: VIA Technologies, Inc.
>VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if
>8f [Master SecP SecO PriP PriO])
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
><TAbort- <MAbort- >SERR- <PERR-
>        Latency: 128
>        Interrupt: pin ? routed to IRQ 46
>        Region 0: I/O ports at fff8 [size=8]
>        Region 1: I/O ports at fff4 [size=4]
>        Region 2: I/O ports at ffe8 [size=8]
>        Region 3: I/O ports at ffe4 [size=4]
>        Region 4: I/O ports at ffd0 [size=16]
>        Capabilities: [c0] Power Management version 2
>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
>PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
>
>and in raw form
>0000:00:01.1 IDE interface: VIA Technologies, Inc.
>VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
>00: 06 11 71 05 07 00 90 02 06 8f 01 01 00 80 00 00
>10: f9 ff 00 00 f5 ff 00 00 e9 ff 00 00 e5 ff 00 00
>20: d1 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>30: 00 00 00 00 c0 00 00 00 00 00 00 00 0e 00 00 00
>40: 0b 02 c9 3a 08 00 c0 00 a8 a8 a8 20 3f 00 ff 20
>50: 07 07 07 e4 04 00 00 00 a8 a8 a8 a8 00 00 00 00
>60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
>70: 02 01 00 00 00 00 00 00 02 01 00 00 00 00 00 00
>80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
>d0: 06 00 71 05 00 00 00 00 00 00 00 00 00 00 00 00
>e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>
>Here is a summary of what I have tried in the kernel code.
>
>o  I tried the unaligned buffer patch to see if I had alignment problems.
>I dont.
>o  I tried to flush the cache instead of invalidating it in the
>consistent_sync PCI_DMA_FROMDEVICE case.
>o  I tried to flush the consistent sync the memory in the ide_build_sglist
>routine in a manner similar to Dan Malek in his 4xx OCP IDE driver.
>o  I tried to flush the cache based upon the dma table after the
>ide_build_dmatable call as done in the Amiga One port which also uses the
>VIA chipset.
>o  I tried converting the kmalloc calls for the sg_table to non cacheable
>as well.
>
>Here is the cleaned up diff with the debug printk's and my comments
>removed.
>
>diff -Naur orig/arch/ppc/mm/cachemap.c mod/arch/ppc/mm/cachemap.c
>--- orig/arch/ppc/mm/cachemap.c 2005-01-29 13:06:41.000000000 -0500
>+++ mod/arch/ppc/mm/cachemap.c  2005-01-29 13:04:10.000000000 -0500
>@@ -146,10 +146,28 @@
>        unsigned long start = (unsigned long)vaddr;
>        unsigned long end   = start + size;
> 
>        switch (direction) {
>        case PCI_DMA_NONE:
>                BUG();
>        case PCI_DMA_FROMDEVICE:        /* invalidate only */
>+//             printk("consistent sync: PCI_DMA_FROMDEVICE\n");
>+
>+#ifdef CONFIG_DEBUG_CONSISTENT_SYNC
>+       if (unlikely(start & (L1_CACHE_LINE_SIZE - 1)) ||
>+           unlikely(end & (L1_CACHE_LINE_SIZE - 1)))
>+       {
>+           static unsigned int count = 0;
>+           if (++count < 10)
>+               //printk(KERN_WARNING
>+               printk(
>+                   "consistent_sync: 0x%08lx-0x%08lx "
>+                   "is not properly aligned, lr 0x%p\n",
>+                   start, end, __builtin_return_address(0));
>+       }
>+#endif
>+
>                flush_dcache_range(start, end);
>+//             invalidate_dcache_range(start, end);
> 
>                break;
>        case PCI_DMA_TODEVICE:          /* writeback only */
>+//             printk("consistent sync: PCI_DMA_TODEVICE\n");
>                clean_dcache_range(start, end);
>                break;
>        case PCI_DMA_BIDIRECTIONAL:     /* writeback and invalidate */
>+//             printk("consistent sync: PCI_DMA_BIDIRECTIONAL\n");
>                flush_dcache_range(start, end);
>                break;
>        }
>diff -Naur orig/drivers/ide/ide-dma.c mod/drivers/ide/ide-dma.c
>--- orig/drivers/ide/ide-dma.c  2005-01-29 13:06:53.000000000 -0500
>+++ mod/drivers/ide/ide-dma.c   2005-01-29 12:55:15.000000000 -0500
> static int ide_build_sglist (ide_hwif_t *hwif, struct request *rq, int
>ddir)
> {
>        struct buffer_head *bh;
>        unsigned long lastdataend = ~0UL;
>        int nents = 0;
> 
>        if (hwif->sg_dma_active)
>                BUG();
> 
>@@ -270,6 +291,17 @@
>                }
> 
>                if (contig) {
>+                       unsigned int size, addr;
>+
>+                       addr = virt_to_bus(bh->b_data);
>+                       size = bh->b_size;
>+                       if (ddir)
>+                               consistent_sync(bh->b_data, size,
>PCI_DMA_TODEVICE);
>+                       else
>+                               consistent_sync(bh->b_data, size,
>PCI_DMA_FROMDEVICE);
>+
>+
>+
>                        sg[nents - 1].length += bh->b_size;
>                        lastdataend += bh->b_size;
>                        continue;
>@@ -281,10 +313,26 @@
>                memset(&sg[nents], 0, sizeof(*sg));
> 
>                if (bh->b_page) {
>+                       unsigned int size, addr;
>+
>+
>+                       addr = virt_to_bus(bh->b_data);
>+                       size = bh->b_size;
>+                       if (ddir)
>+                               consistent_sync(bh->b_data, size,
>PCI_DMA_TODEVICE);
>+                       else
>+                               consistent_sync(bh->b_data, size,
>PCI_DMA_FROMDEVICE);
>+
>+
>                        sg[nents].page = bh->b_page;
>                        sg[nents].offset = bh_offset(bh);
>                        lastdataend = bh_phys(bh) + bh->b_size;
>+                       //printk("we are using pages\n");
>+
>+
>+
>                } else {
>+                       printk("we are using datas\n");
>                        if ((unsigned long) bh->b_data < PAGE_SIZE)
>                                BUG();
> 
>@@ -300,6 +348,8 @@
>                BUG();
> 
>        hwif->sg_dma_direction = ddir;
>        return pci_map_sg(hwif->pci_dev, sg, nents, ddir);
> }
> 
>@@ -686,9 +751,18 @@
>        u8 dma_stat = 0, lba48 = (drive->addressing == 1) ? 1 : 0;
>        task_ioreg_t command    = WIN_NOP;
> 
>        if (!(count = ide_build_dmatable(drive, rq, PCI_DMA_FROMDEVICE)))
>                /* try PIO instead of DMA */
>                return 1;
>+#if 1   /* MAI: make sure RAM's copy of dma table is up to date */
>+       /* flush (start, stop) */
>+//     printk("ide_dma_read\n");
>+//     printk("\tflush_dcache_range start=%x
>size=%x\n",hwif->dmatable_cpu, hwif->dmatable_cpu +(count << 3));
>+       flush_dcache_range (hwif->dmatable_cpu, hwif->dmatable_cpu +
>(count << 3));
>+#endif
>        /* PRD table */
>        hwif->OUTL(hwif->dmatable_dma, hwif->dma_prdtable);
>        /* specify r/w */
>@@ -732,9 +806,18 @@
>        u8 dma_stat = 0, lba48  = (drive->addressing == 1) ? 1 : 0;
>        task_ioreg_t command    = WIN_NOP;
> 
>+//     printk("__ide_dma_write\n");
>+
>+
>        if (!(count = ide_build_dmatable(drive, rq, PCI_DMA_TODEVICE)))
>                /* try PIO instead of DMA */
>                return 1;
>+#if 1   /* MAI: make sure RAM's copy of dma table is up to date */
>+       // This is flushing the virt address table.
>+//     printk("ide_dma_write\n");
>+//     printk("\tflush_dcache_range start=%x
>size=%x\n",hwif->dmatable_cpu, hwif->dmatable_cpu +(count << 3));
>+       flush_dcache_range (hwif->dmatable_cpu, hwif->dmatable_cpu +
>(count << 3));
>+#endif
>        /* PRD table */
>        hwif->OUTL(hwif->dmatable_dma, hwif->dma_prdtable);
>        /* specify r/w */
>@@ -994,12 +1077,14 @@
>                hwif->dmatable_cpu = NULL;
>        }
>        if (hwif->sg_table) {
>-               kfree(hwif->sg_table);
>+/* jfd                 kfree(hwif->sg_table);  */
>+               pci_free_consistent(NULL, sizeof(struct scatterlist) *
>PRD_ENTRIES, hwif->sg_table,NULL);
>                hwif->sg_table = NULL;
>        }
>        return 1;
> }
> 
>+
> int ide_release_mmio_dma (ide_hwif_t *hwif)
> {
>        if ((hwif->dma_extra) && (hwif->channel == 0))
>@@ -1039,11 +1124,26 @@
> 
> int ide_allocate_dma_engine (ide_hwif_t *hwif)
> {
>+
>+       printk("ide_allocate_dma_engine\n");
>+
>        hwif->dmatable_cpu = pci_alloc_consistent(hwif->pci_dev,
>                                                  PRD_ENTRIES * PRD_BYTES,
>                                                  &hwif->dmatable_dma);
>+
>+       printk("\t dma table bus addr %x\n",hwif->dmatable_dma);
>+       printk("\t dma table virt addr %x\n",hwif->dmatable_cpu);
>+       printk("\t size
>%x*%x=%x\n",PRD_ENTRIES,PRD_BYTES,PRD_ENTRIES*PRD_BYTES);
>+
>+
>+
>+       hwif->sg_table = pci_alloc_consistent(NULL,sizeof(struct
>scatterlist) * PRD_ENTRIES,
>+                               &hwif->sg_table);
>+#if 0
>        hwif->sg_table = kmalloc(sizeof(struct scatterlist) * PRD_ENTRIES,
>                                GFP_KERNEL);
>+jfd
>+#endif
>
>
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
