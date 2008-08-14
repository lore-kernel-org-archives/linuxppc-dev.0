Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C2149DDF79
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Aug 2008 02:31:39 +1000 (EST)
Message-ID: <48A45DC9.2060601@freescale.com>
Date: Thu, 14 Aug 2008 11:31:05 -0500
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Vince Asbridge <vasbridge@sanblaze.com>
Subject: Re: [PATCH] RE: Some memory (DDR2 ECC Dual Rank) just doesn't work!
	Can anyone pointme to how to debug this hang?
References: <0b1f01c8fe27$81d6b250$4b01a8c0@sanblaze.com>
In-Reply-To: <0b1f01c8fe27$81d6b250$4b01a8c0@sanblaze.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: u-boot@lists.denx.de, 'Stephen Shirron' <sshirron@sanblaze.com>,
	'linuxppc-embedded' <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Vince Asbridge wrote:
> Stephane,
> 
> Thanks so much for your prompt reply.
> 
> We will pursue your suggestions, and let the forum know what we find.  We're
> at 1.3.0 uboot version.
> 
> Vince
> 
>> -----Original Message-----
>> From: Fillod Stephane [mailto:stephane.fillod@thomson.net] 
>> Sent: Thursday, August 14, 2008 8:06 AM
>> To: Vince Asbridge; linuxppc-embedded
>> Cc: u-boot@lists.denx.de
>> Subject: [PATCH] RE: Some memory (DDR2 ECC Dual Rank) just 
>> doesn't work! Can anyone pointme to how to debug this hang?
>>
>> Vince Asbridge wrote:
>>> We have an 8548 design, which implements a DDR2 on a SODIMM 
>> We have an 
>>> issue with dual rank memory (specific part number Viking 
>> VR5DR287218EBSS1), which is a 1G ECC Registered SODIMM part, 
>> with two ranks.
>>> Our platform wires CS0 and CS1 to the SODIMM slot. 
>>> At uBoot, all is well.  Memory is discovered as ECC 533, 1G 
>> DDR2 64Bit 4 beat bursts, and mtest can read and write all 1G 
>> of the SODIMM.
>> [...]
>>> Other DDR2s (identical except for vendor and # of ranks), 
>> work perfectly! 
>>> Anyone got a clue what I could look at to try to figure this out? 
>>> We've tried enable / disable ECC at uboot We've tried 
>> enable / disable 
>>> Interleaving at uboot uboot always works (and can read/write entire 
>>> DDR), Linux always hangs on boot!
>> U-Boot is too gentle when testing SDRAM. Make sure the caches 
>> are enabled under U-Boot, and put on heavy stress with DMA, 
>> pipelined prefetch's, etc.
>> This is what your CPU is enduring under Linux. 
>>
>> Your question is definitely a question for the U-Boot mailing list.
>> BTW, what is the version of U-Boot in use? U-Boot is still 
>> missing the following patch:
>>
>> MPC85xx BA bits not set for 3-bit bank address DIMM of CS1
>>
>> The current implementation set the number of bank address bits
>> (BA) in the processor for CS0 but not for CS1. 
>>
>> Signed-off-by: Stephane Fillod <stephane.fillod@thomson.net>
>>
>> --- u-boot/cpu/mpc85xx/spd_sdram.c
>> +++ u-boot/cpu/mpc85xx/spd_sdram.c
>> @@ -365,6 +365,7 @@
>>                 ddr->cs1_config = ( 1<<31
>>                                     | (odt_rd_cfg << 20)
>>                                     | (odt_wr_cfg << 16)
>> +                                   | (ba_bits << 14)
>>                                     | (spd.nrow_addr - 12) << 8
>>                                     | (spd.ncol_addr - 8) );
>>                 debug("DDR: cs1_bnds   = 0x%08x\n", ddr->cs1_bnds);
>>
>>
>>
>> Otherwise, recompile with -DDEBUG and CFG_CMD_SDRAM, grab the 
>> Viking datasheet and a scope, and a full cup of coffee/tea 
>> much needed during cross-checking :-)
>>


That bug fix, along with many, many others, as well as some
new support for multiple controllers and such are all present
in the DDR re-write patch set that Kumar just posted.  You may
want to try that code too.  It will be replacing the entire
85xx/86xx and eventually the 83xx line of memory controller
initialization.  It also contains some support for a pretty
useful interactive DDR configuration setup mechanism too.

jdl
