Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC05F66@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: "'Prakash kanthi'" <pkanthi@yahoo.com>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: After Uncompresseing Linux..., what's next
Date: Thu, 19 Dec 2002 11:10:41 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I just went thru this myself ... ;-)

1.) Get a BDM/JTAG tool look halt the processor after you see " Now booting
the kernel" and look for valid asm at 0x0 ... make sure it mathes your
start.s file ...

2.) Veryfy you have your mem map from ppcboot matching requirements for the
kernel i.e ram (physical=0x0, virtual=0xc0000000) and immr (phys 0xff000000
virtual 0xff000000) ... I had my immr in ppc boot at 0x02200000 this screwed
me for quite a while ... otherwise you have no printk ... the memory map is
very important not to screw with some things depend on it (unless your
careful) ...

3.) verify you SMC1 (uart) is getting proper clocking config ... i.e
bus->brg1 and brg1 is 16 times baud rate ... otherwise you have no printk

4.) and always always keep in mind your RAM refesh could be wrong ...
everyone will tell you this even when it has nothing to do with your problem
... try not to ignore them if you are still stuck ;-) But verifying step 1
should prove your ok ...

Best of luck,
Jim


-----Original Message-----
From: Prakash kanthi [mailto:pkanthi@yahoo.com]
Sent: Wednesday, December 18, 2002 7:14 PM
To: LinuxPPC
Subject: After Uncompresseing Linux..., what's next


Hi there,

I was trying to load linuxppc_2_4_devel onto my board.
It goes through the board info read, UART init and
Uncompressing the linux kernel. But after that, i do
not see any messages and board hangs.

Here is the UART output:
------------------------------------
OS Booting...

loaded at:     00400000 0060D1CC
board data at: 00000030 00000044
relocated to:  00405C24 00405C38
zimage at:     00406290 004A08FF
initrd at:     004A1000 006097CA
avail ram:     0060E000 007F8000

Linux/PPC load: console=ttyS0,9600 console=tty1 ip=on
root=/dev/xsysace/disc0/pa
rt3 rw
Uncompressing Linux...done.
Now booting the kernel
-------------------------------------------

After the last line, it hangs. I get a feeling that,
the uncompressing process is not writing in the memory
starting from 0x00000000 and, after uncompressing, it
is jumping into 0x00000000 and is not able to find
anything.

My questions are,
1. How can i make sure that, the uncompressing process
is going to start writing the data from 0x00000000.

2. How big a space this uncompressing process needs?
And also how much overall memory is required for
running linux. I just have 8MB SDRAM.

3. What is the next step in the booting process? Which
Device (eth, pci, ide, ???) Initialization?

Your help is appreciated.

thanks,
Prakash


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
