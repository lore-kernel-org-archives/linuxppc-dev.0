Message-Id: <199911270059.SAA07621@sun92.texmemsys.com>
Date: Fri, 26 Nov 1999 18:59:52 -0600 (CST)
From: Jonathan Brauer <brauer@texmemsys.com>
Reply-To: Jonathan Brauer <brauer@texmemsys.com>
Subject: New port
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am looking on information on porting linux to a new ppc platform.  The short 
version of my efforts are to port linux to a custom 603 sbc.  I have experiance 
with device driver writing, but at this time limited knowledge of the boot 
architecture of ppc.  Currently we are using ix86 to ppc cross compiler to 
generate the kernels.  The SBC consits of a 603 4MB flash, 128 MBs memory, and 
an FPGA which acts as the serial port/DMA engine, network controller, and 
controls memory accesses.  I guess what I am looking for is where to start.  We 
are currently using an EST Vision Probe to download code into RAM on the SBC and 
starting execution.  There is currently no initialization done before we enter 
arch/ppc/head.S but the EST box complained about the locations of memory being 
beyond the physical limits of the RAM at 0xc0000000, so in the Makefile we 
mapped this to 0, but I am not sure if there is a better way around this.  The 
code and documentation on this are light, so any information on this process, 
and the correct way to go about initializing the board before execution of 
head.S would be greatly appreciated.

Essentialy from this my questions would be
1.  Is there a correct mode to start running head.S in (ie. translation on/off?)
2.  Where should the stack be started at?
3.  Where should the code be downloaded to?
4.  Is an uncompressed kernel better than a compressed one?
5.  If we load the kernel at address 0, should we change KERNELBASE?
6.  It appears that after kludging up to identify machine we tend to die.
7.  Enabling the caching seems to throw us for a loop as well.
8.  What values does the kernel assume are passed in by a boot loader and how?

Thanks in advance to anyone who might be able to help in me understanding this 
code better and how to go about getting a good start on this port.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
