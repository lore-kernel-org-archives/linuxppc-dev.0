Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8CCCDDDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jan 2008 20:31:42 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JHFSS-0003TM-9E
	for linuxppc-embedded@ozlabs.org; Tue, 22 Jan 2008 01:30:16 -0800
Message-ID: <15015244.post@talk.nabble.com>
Date: Tue, 22 Jan 2008 01:30:16 -0800 (PST)
From: greenlean <jmgomez@atc.ugr.es>
To: linuxppc-embedded@ozlabs.org
Subject: RE: Generated xilinx linux 2.6  image sections
In-Reply-To: <20080121184553.569BF179805C@mail212-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <14997109.post@talk.nabble.com>
	<20080121184553.569BF179805C@mail212-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I've got two DDR memories declared on my EDK xparameters_ml300.h file 

/* Definitions for driver DDR */
#define XPAR_XDDR_NUM_INSTANCES 1

/* Definitions for peripheral DDR_512MB_64MX64_RANK2_ROW13_COL10_CL2_5 */
#define XPAR_DDR_512MB_64MX64_RANK2_ROW13_COL10_CL2_5_ECC_BASEADDR
0xFFFFFFFF
#define XPAR_DDR_512MB_64MX64_RANK2_ROW13_COL10_CL2_5_ECC_HIGHADDR
0x00000000
#define XPAR_DDR_512MB_64MX64_RANK2_ROW13_COL10_CL2_5_DEVICE_ID 0
#define XPAR_DDR_512MB_64MX64_RANK2_ROW13_COL10_CL2_5_INCLUDE_ECC_INTR 0


/******************************************************************/

/* Definitions for peripheral DDR_512MB_64MX64_RANK2_ROW13_COL10_CL2_5 */
#define XPAR_DDR_512MB_64MX64_RANK2_ROW13_COL10_CL2_5_MEM0_BASEADDR
0x00000000
#define XPAR_DDR_512MB_64MX64_RANK2_ROW13_COL10_CL2_5_MEM0_HIGHADDR
0x0FFFFFFF
#define XPAR_DDR_512MB_64MX64_RANK2_ROW13_COL10_CL2_5_MEM1_BASEADDR
0x10000000
#define XPAR_DDR_512MB_64MX64_RANK2_ROW13_COL10_CL2_5_MEM1_HIGHADDR
0x1FFFFFFF
/******************************************************************/

/* Definitions for peripheral PLB_BRAM_IF_CNTLR_1 */
#define XPAR_PLB_BRAM_IF_CNTLR_1_BASEADDR 0xfffe0000
#define XPAR_PLB_BRAM_IF_CNTLR_1_HIGHADDR 0xffffffff

/******************************************************************/

And my .config file is using this configuration for the memory:

CONFIG_HIGHMEM_START=0xfe000000
CONFIG_LOWMEM_SIZE=0x30000000
CONFIG_KERNEL_START=0xc0000000
CONFIG_TASK_SIZE=0x80000000
CONFIG_CONSISTENT_START=0xff100000
CONFIG_CONSISTENT_SIZE=0x00200000
CONFIG_BOOT_LOAD=0x00400000

Should I change this options to make the kernel CONFIG_BOOT_LOAD start in
the seccond MEM1?, or is the problem caused by CONFIG_CONSISTENT_START?? How
are used this variables?? Is the kernel start address out of the memory ((
0xC0000000 > 0x1FFFFFFF?? 

I'm using a DDR 256 from Kingston KVR266X64C25/256 and when I run the
TestApp_Memory it fails at

-- Entering main() --                                                     
Starting MemoryTest for DDR_512MB_64Mx64_rank2_row13_col10_cl2_5:         
  Running 32-bit test...FAILED!                                           
  Running 16-bit test...FAILED!                                           
  Running 8-bit test...FAILED!                                            
Starting MemoryTest for DDR_512MB_64Mx64_rank2_row13_col10_cl2_5:         
  Running 32-bit test...PASSED!                                           
  Running 16-bit test...PASSED!                                           
  Running 8-bit test...PASSED!                                            
-- Exiting main() -- 

I thought that this didn't mind but the first test is form Mem0
(XUtil_MemoryTest32((Xuint32*)XPAR_DDR_512MB_64MX64_RANK2_ROW13_COL10_CL2_5_MEM0_BASEADDR)

and the second one is for mem1 (
XUtil_MemoryTest32((Xuint32*)XPAR_DDR_512MB_64MX64_RANK2_ROW13_COL10_CL2_5_MEM1_BASEADDR,
1024, 0xAAAA5555, XUT_ALLMEMTESTS);)

and the first one is failing so if the kernel is trying to boot from mem0
(CONFIG_BOOT_LOAD=0x00400000) i shouldn't boot, or should it?

Please, can someone confirm me this, while I try myself... I'm not sure how
this addresses works!!!



Stephen Neuendorffer wrote:
> 
> The testapps are generated using a different linker script.
> 
> Based on what you sent out, it looks like your EDK design has a memory
> at 0x10000000, but this is
> not reflected in the linux image you've generated.  This makes me
> suspect that you haven't generated the BSP and copied the appropriate
> xparameters file over xparameters_xup.h (assuming you are using
> CONFIG_XILINX_XUPV2P).
> 
> Steve
> 
>> -----Original Message-----
>> From: linuxppc-embedded-bounces+stephen=neuendorffer.name@ozlabs.org
> [mailto:linuxppc-embedded-
>> bounces+stephen=neuendorffer.name@ozlabs.org] On Behalf Of greenlean
>> Sent: Monday, January 21, 2008 5:06 AM
>> To: linuxppc-embedded@ozlabs.org
>> Subject: Generated xilinx linux 2.6 image sections
>> 
>> 
>> Hi all,
>> 
>> I'm trying to boot the 2.6 xilinx kernel downloaded from their git
> server in
>> the XUPV2P board I'm really having troubles (I can't see anything in
> the
>> minicom console terminal). I'm not seeing anything, neither the
> ucompressing
>> kernel string nor the prompt with the memory addresses that kernel
> prompt at
>> first time, so I have started to distrust of anything.
>> 
>> When I download the kernel using xmd, I see:
>> 
>> XMD% dow imagen_UART16550_ml300.elf
>>         section, .text: 0x00400000-0x0040387b
>>         section, .data: 0x00404000-0x004e6fff
>>         section, .bss: 0x004e7000-0x004e919f
>> Downloaded Program imagen_UART16550_ml300.elf
>> Setting PC with Program Start Address 0x00400000
>> 
>> and when I download some of the TestApp generated by EDK I see:
>> 
>> XMD% dow perif.elf
>>         section, .vectors: 0xfffe0000-0xfffe20c3
>>         section, .text: 0x10000000-0x10003b7b
>>         section, .init: 0x10003b7c-0x10003b9f
>>         section, .fini: 0x10003ba0-0x10003bbf
>>         section, .boot0: 0xfffe20c4-0xfffe20d3
>>         section, .boot: 0xfffffffc-0xffffffff
>>         section, .rodata: 0x10003bc0-0x10004111
>>         section, .sdata2: 0x10004114-0x10004113
>>         section, .sbss2: 0x10004114-0x10004113
>>         section, .data: 0x10004114-0x10004243
>>         section, .got: 0x10004244-0x10004243
>>         section, .got1: 0x10004244-0x10004243
>>         section, .got2: 0x10004244-0x1000425f
>>         section, .ctors: 0x10004260-0x10004267
>>         section, .dtors: 0x10004268-0x1000426f
>>         section, .fixup: 0x10004270-0x1000426f
>>         section, .eh_frame: 0x10004270-0x10004277
>>         section, .jcr: 0x10004278-0x1000427b
>>         section, .gcc_except_table: 0x1000427c-0x100042
>>         section, .sdata: 0x1000427c-0x10004293
>>         section, .sbss: 0x10004294-0x100042a3
>>         section, .bss: 0x100042a4-0x10004473
>>         section, .stack: 0x10004474-0x1000647f
>>         section, .heap: 0x10006480-0x1000847f
>> Downloaded Program perif.elf
>> Setting PC with Program Start Address 0xfffffffc
>> 
>> Does anybody know why the kernel elf don't have a boot section like
> the
>> TestApp generated by EDK?
>> 
>> I suppossed this is because the image kernel is compressed, but
> despite
>> beeing compressed it should have a boot section or something similar
> ???
>> It's right that the kernel start address is set to the 0x00400000??
>> 
>> Or does the section .text  contains all the kernel code to uncompresse
> the
>> code of the kernel??
>> 
>> 
>> 
>> --
>> View this message in context:
> http://www.nabble.com/Generated-xilinx-linux-2.6--image-sections-
>> tp14997109p14997109.html
>> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>> 
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/Generated-xilinx-linux-2.6--image-sections-tp14997109p15015244.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
