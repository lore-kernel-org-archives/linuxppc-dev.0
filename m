Message-ID: <386B5D49.DF7A9095@mitre.org>
Date: Thu, 30 Dec 1999 08:25:29 -0500
From: Charles Lepple <clepple@mitre.org>
MIME-Version: 1.0
To: dony <dony.he@huawei.com.cn>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Please help me...
References: <386C150F.22B1A3D0@huawei.com.cn> <386ABF52.922267E9@ctam.com.au> <38701F3A.FAD6263E@huawei.com.cn> <386ADE53.D3411F6A@ctam.com.au> <38704D0B.94438516@huawei.com.cn> <386AFFC5.E0134DB8@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brendan J Simon wrote:
> >  Sections:
> > Idx Name          Size      VMA       LMA       File off  Algn
> > 0 .text         00004870  ff801000  ff801000  00001000  2**2
> >                    CONTENTS, ALLOC, LOAD, READONLY, CODE
> >    1 .rodata       00000470  ff805870  ff805870  00005870  2**4
> >                    CONTENTS, ALLOC, LOAD, READONLY, DATA
> >    2 .data         00000300  ff806000  ff806000  00006000  2**2
> >                    CONTENTS, ALLOC, LOAD, DATA
> >    3 .bss          0000bbac  ff807000  ff807000  00007000  2**2
> >                    ALLOC
> >    4 image         00061104  ff807000  ff807000  00007000  2**0
> >                    CONTENTS, ALLOC, LOAD, DATA

       ^^^^^^^ This section (image) could be your problem if you use a
vxWorks bootloader.

Although the vxWorks loader is written with ELF images in mind,
experience (with a DY4 SVME-177 board) tells me that it ignores ELF
sections that would not be present in a vxWorks executable. I did not
have time to investigate this completely, but the indication that tipped
me off was that the sizes of the sections added up to be much larger
than the sum of the numbers that the boot loader reports. All other test
programs (those without added sections) were loaded correctly.

If the sum of the numbers printed on the screen is significantly less
than the size of the file, then you can assume that anything you need to
load should be in either '.text' or '.data'. If you have the whole
vxWorks toolchain, you can try to find out what other section names are
used in executables loaded by the bootloader (maybe a debugging
section?), or you can work on building a special zImage file.

You can get around this limitation by having the zipped kernel image
inserted directly into the data segment of a wrapper program (see
arch/ppc/chrpboot/, especially piggyback.c).

-- 
Charles Lepple
clepple@mitre.org


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
