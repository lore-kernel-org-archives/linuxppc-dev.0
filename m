Message-ID: <8D7C5F56B409554D9D46AC22195807F3061C2A@exchwenz01.dmcwave.co.nz>
From: Rod Boyce <rod_boyce@stratexnet.com>
To: "'Jason Park'" <jason@amadeus.kist.re.kr>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Problem with BDI2000 flash programming
Date: Thu, 23 Jan 2003 13:30:55 +1300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="KS_C_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You are going to need to check the settings in your BDI configuration file
(ep8260.cfg.init).  This file is going to need a flash section that details
the address of the flash, the type of flash, and what programming mode to
use.  You do not include that here so I'll assume that you have not added
this section.  Check you BDI manual for the flash settings and set it to
what your board uses.


Regards,
Rod Boyce.



-----Original Message-----
From: Jason Park [mailto:jason@amadeus.kist.re.kr]
Sent: Thursday, 23 January 2003 1:20 p.m.
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem with BDI2000 flash programming


hi, im new to this email list.. but i am having some problems with my board
and don't know where to turn.

target board: ep8260
host distribution: redhat 8.0 (with powerpc cross compilers)
debugger: BDI2000

problem: trying to burn a PPCBOOT image into the flash memory at location
0xFF10 0000

setting up the initial bdi configurations.. i get the following output:

[root@FISH gdbcop21]# ./bdisetup -v -s
BDI Type : BDI2000 Rev.C (SN: 94406634)
Loader   : V1.05
Firmware : V1.14 bdiGDB for PPC6xx/PPC7xx
Logic    : V1.02 PPC6xx/PPC7xx
MAC      : 00-40-49-fa-40-66
IP Addr  : 161.122.32.98
Subnet   : 255.255.255.0
Gateway  : 161.122.32.1
Host IP  : 161.122.32.94
Config   : ep8260.cfg.init

everything looks normal to me... i have the ep8260.cfg.init file in the
/tftpboot directory.  so at this point i will connect to the board with
telnet.

# telnet 161.122.32.98
Trying 161.122.32.98...
Connected to 161.122.32.98.
Escape character is '^]'.
BDI Debugger for Embedded PowerPC
=================================

PHYS  <address>              converts an effective to a physical address
****
****
other stuff here..
****
****
QUIT                         terminate the Telnet session

bdi2000>

since there is not error outputting that it cannot find the original
configuration file ep8260.cfg.init, i conclude that tftp worked properly.
i can read the flash memory, including the existing bootloader i got from
embedded planet. (planetcore at location 0xFFF0 000)
Now i place ppcboot.bin into the /tftpboot directory, and after checking
whats in memory location 0xFF10 0000 (there is nothing there), i proceed
to try and write into the flash:

bdi2000>prog 0xFF100000 ppcboot.bin bin
Programming ppcboot.bin , please wait ....
# Cannot open program file on host
bdi2000>

this is what i can't figure out.  i think that it must be a problem
with the hosts tftp configuration, but i did check the tftp server several
times, even connected it to other computers and swapping files.  could there
be a setting i missed in the BDI2000?


also.. i was wondering if there was more detailed documentation on using
the BDI2000 besides the manual that came with the prooduct and WD's PPCBoot
and Linux Guide.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
