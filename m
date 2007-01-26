Return-Path: <mh@omnisys.se>
Received: from mail.omnisys.se (static-213-115-84-26.sme.bredbandsbolaget.se
	[213.115.84.26]) by ozlabs.org (Postfix) with ESMTP id 2B32FDDFC0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Jan 2007 22:53:48 +1100 (EST)
Message-ID: <45B9EBC8.9080509@omnisys.se>
Date: Fri, 26 Jan 2007 12:53:44 +0100
From: Magnus Hjorth <mh@omnisys.se>
MIME-Version: 1.0
To: Rick Moleres <rick.moleres@xilinx.com>
Subject: Re: ML403 hard Ethernet under Linux 2.6.18
References: <689CB232690D8D4E97DA6C76DA098E6C03A7A14D@XCO-EXCHVS1.xlnx.xilinx.com>
In-Reply-To: <689CB232690D8D4E97DA6C76DA098E6C03A7A14D@XCO-EXCHVS1.xlnx.xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Thanks!

I managed to get Ethernet working by changing to version hard_temac 
3.00.a (manual edit of the .mhs file). I also had to hack in a MAC 
address in adapter.c, as it was set to zero in the net_device struct.

I must say that I am very impressed with the level of support I've 
received from Xilinx this far.

Cheers,
/Magnus

Rick Moleres wrote:
> Magnus,
>
> Hard_temac_v3_00_b was created to fix a compatibility problem in the MDIO interface for V4FX production silicon (CES4 or later).  Unfortunately, it does not work well with silicon that is pre-CES4, which is true of all ML403 boards.
>
> The bottom line is that you should adhere to the following comment:
>
>  * Note also a silicon issue with Xilinx V4FX with regards to MDIO access:
>  * 	pre-CES4 chips (ML403, pre-production ML405/ML410)
>  *		use hard_temac_v3_00_a
>  *	CES4 or later chips (production ML405, ML410 boards)
>  *		use hard_temac_v3_00_b
>
> I've also attached a new adapter.c that does a slightly better job with the PHY speed negotiation.  This one will be shipped in EDK 9.1.1.
>
> Thanks,
> Rick
>
>
> -----Original Message-----
> From: linuxppc-embedded-bounces+moleres=xilinx.com@ozlabs.org [mailto:linuxppc-embedded-bounces+moleres=xilinx.com@ozlabs.org] On Behalf Of Magnus Hjorth
> Sent: Thursday, January 25, 2007 8:58 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: Re: ML403 hard Ethernet under Linux 2.6.18
>
> jozsef imrek wrote:
>   
>> On Thu, 25 Jan 2007, Magnus Hjorth wrote:
>>
>>   
>>     
>>> Hi,
>>>
>>> I'm trying to get Linux 2.6.18.6 working on an ML403 board with a basic
>>> EDK design with a hard_temac and uart. I've generated the BSP for
>>> linux_2_6, copied the drivers and twiddled a little to make it all compile.
>>>
>>> The TEMAC driver seems to find the hardware, but the speed negotiation
>>> seems not to work. I can see the speed LEDs first go to 100 Mbit, then
>>> ...
>>>     
>>>       
>> i suppose you are using plb_temac 3.00, with the corresponding driver.
>>   
>>     
>
> plb_temac 3.00.a and hard_temac 3.00.b. The driver is the one that was 
> generated in the BSP using Xilinx EDK 8.2, adapter.c says v2.00b.
>
> The only code that I have added myself is a header file xio.h containing:
> #include <asm/io.h>
> #define XIo_In32(p) in_be32((volatile void *)p)
> #define XIo_Out32(p,v) out_be32((volatile void *)p,v)
> #define XIo_Out8(p,v) out_8((volatile void *)p,v)
>
>   
>> did you try to uncomment #define XILINX_PLB_TEMAC_3_00A_ML403_PHY_SUPPORT
>> in adapter.c ?
>>
>>   
>>     
> I did try that, and it seems to work even worse. It claims the speed is 
> set to 10Mbit but the LEDs show it's still in 100Mbit operation as it is 
> directly after programming the FPGA... The transmit LED is on for a 
> short while before the Link carrier lost message. Startup messages shown 
> below.
>
> loaded at:     00400000 004B613C
> board data at: 004B4124 004B413C
> relocated to:  00404094 004040AC
> zimage at:     00404EA7 004B3CFC
> avail ram:     004B7000 03D09000
>
> Linux/PPC load: console=ttyS0,9600 ip=on
> Uncompressing Linux...done.
> Now booting the kernel
> Linux version 2.6.18.6mh1 (labb@dynamic035.omnisys.se) (gcc version 
> 3.4.1) #14 7
> Xilinx ML403 Reference System (Virtex-4 FX)
> Built 1 zonelists.  Total pages: 15625
> Kernel command line: console=ttyS0,9600 ip=on
> Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000
> PID hash table entries: 256 (order: 8, 1024 bytes)
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 60184k available (1148k kernel code, 448k data, 68k init, 0k 
> highmem)
> Mount-cache hash table entries: 512
> NET: Registered protocol family 16
> NET: Registered protocol family 2
> IP route cache hash table entries: 512 (order: -1, 2048 bytes)
> TCP established hash table entries: 2048 (order: 1, 8192 bytes)
> TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
> TCP: Hash tables configured (established 2048 bind 1024)
> TCP reno registered
> Initializing Cryptographic API
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> serial8250.0: ttyS0 at MMIO 0x40401003 (irq = 1) is a 16550A
> XTemac: using FIFO direct interrupt driven mode.
> eth0: Xilinx TEMAC #0 at 0x81200000 mapped to 0xC4000000, irq=0
> eth0: XTemac id 1.0f, block id 5, type 8
> TCP bic registered
> NET: Registered protocol family 1
> eth0: XTemac: Options: 0xb8f2
> eth0: XTemac: speed set to 10Mb/s
> Sending DHCP requests .<6>eth0: XTemac: PHY Link carrier lost.
> ..... timed out!
> IP-Config: Reopening network devices...
> eth0: XTemac: Options: 0xb8f2
> eth0: XTemac: speed set to 10Mb/s
> Sending DHCP requests ...... timed out!
> IP-Config: Reopening network devices...
> eth0: XTemac: Options: 0xb8f2
>
>   


-- 

Magnus Hjorth, M.Sc.
Omnisys Instruments AB
Gruvgatan 8
SE-421 30  Västra Frölunda, SWEDEN
Phone: +46 31 734 34 09
Fax: +46 31 734 34 29
http://www.omnisys.se 
