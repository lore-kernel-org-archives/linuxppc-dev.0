From: Ruedi.Hofer@ascom.ch
Date: Fri, 29 Sep 2000 16:15:29 +0100 (CED)
Subject: Antwort: Re: VxWorks bootloader & PowerQUICC II, Booting the kernel
To: dan@mvista.com
Cc: linuxppc-embedded@lists.linuxppc.org, kernel@linux01.hasler.ascom.ch
Message-id: <0G1N00BGQJM2C8@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_6gpcopXaTAFJkbffCefQyQ)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_6gpcopXaTAFJkbffCefQyQ)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi Dan

Thank you for the correct link.

Unfortunately, all vxhack produces is a crash...

# ./vxhack zImage
Segmentation fault
#

My zImage looks like this:

# ppc_82xx-objdump -h zvmlinux
zvmlinux:     file format elf32-powerpc
Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         000041ac  00400000  00400000  00010000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .rodata       00000470  004041b0  004041b0  000141b0  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .data         0000030c  00405000  00405000  00015000  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  3 .data.init    00000000  00406000  00406000  00016000  2**0
                  CONTENTS
  4 .bss          00005274  00406000  00406000  00016000  2**2
                  ALLOC
  5 image         0007110b  00000000  00000000  00016000  2**0
                  CONTENTS, READONLY
#

I built the tool in the follwoing way:

# gcc vxhack.c -g -o vxhack
#

The gdb tells me:

  75         shp = (Elf32_Shdr *) dbuf;
  76         sp = (char *)shp;
  77         for (i=0; i<nsscns; i++) {
> 78                 if (shp->sh_addr)
  79                         shp->sh_addr += 0x500000;
  80                 if (i == 5)
  81                         imagesize = shp->sh_size;

Program received signal SIGSEGV, Segmentation fault.
0x8048753 in main (argc=2, argv=0xbffff664) at vxhack.c:78
(gdb) print shp
$1 = (Elf32_Shdr *) 0x806b3a0
(gdb) graph display shp
(gdb) graph display *shp dependent on 1
(gdb)
Cannot access memory at address 0x806b3a0.
Disabling display 2 to avoid infinite recursion.
(gdb)

I tried to play around with vxhack.c but I didn't succeed...

Any ideas??

\Ruedi






dan@mvista.com on 28.09.2000 17:02:04
An: Ruedi.Hofer@ascom.ch @ MailGate
Kopie: linuxppc-embedded@lists.linuxppc.org @ MailGate, kernel@linux01.hasler.ascom.ch @ MailGate
Thema: Re: VxWorks bootloader & PowerQUICC II, Booting the kernel


Ruedi.Hofer@ascom.ch wrote:

> Unfortunately, this link doesn't work anymore! Do you mind sending
> a copy of this file directly to me?

Sorry, try ftp.mvista.com/pub/Area51/ppc-8xx/vxhack.c


        -- Dan





--Boundary_(ID_6gpcopXaTAFJkbffCefQyQ)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
