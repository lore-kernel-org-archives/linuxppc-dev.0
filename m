Return-Path: <dhlii@comcast.net>
Received: from sccrmhc14.comcast.net (sccrmhc14.comcast.net [63.240.76.49])
	by ozlabs.org (Postfix) with ESMTP id 2144F685D7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Oct 2005 18:19:10 +1000 (EST)
Message-ID: <4354AC78.5080206@comcast.net>
Date: Tue, 18 Oct 2005 04:04:08 -0400
From: "David H. Lynch Jr" <dhlii@comcast.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Need help Understanding initial memory conditions.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    What exactly is the minimal startup system state the Linux 2.6.13 
Kernel expects ?

    I am trying to bring up a xilinx V4 ppc 405 board.
    It has flash based at 0x0 and DRAM based at ox98000000.
    I already have a working monitor/program loader and a filesystem of 
the flash. I can fairly easily compile and load onto the filesystem and 
run standalone PPC apps on the board.
    All memory is as configured by the base hardware. The MMU, BAT, ... 
are all at their powerup state.

    I have put together a Linux config based heavily on an abbreviated 
version of the Xilinx ML-300 config.
    If I try to load it it just goes bye-bye.
   
    I am trying to decipher the initial machine state Linux 2.6.13 expects.
    u-boot seems to completely setup the MMU, but also seems to expect 
to start execution from flash or ROM.
    scanning the Linux code seems to indicate that the only entry that 
needs to be setup for the MMU is the one for block Linux starts 
executing out of.
    I am also being somewhat confused by references to physical address 
0 and virtual address 0xc000000.
    I thought Linux executed from virtual address 0, and the actual 
physical address was a function of the hardware.

   

   
   
   
   
   
