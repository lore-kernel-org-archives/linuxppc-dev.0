Message-ID: <386AFFC5.E0134DB8@ctam.com.au>
Date: Thu, 30 Dec 1999 17:46:29 +1100
From: Brendan J Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
To: dony <dony.he@huawei.com.cn>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Please help me...
References: <386C150F.22B1A3D0@huawei.com.cn> <386ABF52.922267E9@ctam.com.au> <38701F3A.FAD6263E@huawei.com.cn> <386ADE53.D3411F6A@ctam.com.au> <38704D0B.94438516@huawei.com.cn>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


dony wrote:

> > > > Can you send the output of "objcopy --headers zImage" to the list.
> > >
> > > The "powerpc-linux-objcopy --headers zImage" cannot work. Maybe the semantics
> > > is wrong?
> >
> > My mistake.  It should be objdump instead of objcopy.
>
> Now you remind me that "objdump --headers zImage" can produce the following results
> directly which I ask you how to do before:
>
> ***********************************************************
>  Sections:
> Idx Name          Size      VMA       LMA       File off  Algn
> 0 .text         00004870  ff801000  ff801000  00001000  2**2
>                    CONTENTS, ALLOC, LOAD, READONLY, CODE
>    1 .rodata       00000470  ff805870  ff805870  00005870  2**4
>                    CONTENTS, ALLOC, LOAD, READONLY, DATA
>    2 .data         00000300  ff806000  ff806000  00006000  2**2
>                    CONTENTS, ALLOC, LOAD, DATA
>    3 .bss          0000bbac  ff807000  ff807000  00007000  2**2
>                    ALLOC
>    4 image         00061104  ff807000  ff807000  00007000  2**0
>                    CONTENTS, ALLOC, LOAD, DATA
> *************************************************************

Is this the dump of YOUR zImage ?
I chose 0xFF800000 for the base address of Flash memory on our system.  If you are
downloading into RAM then you will have to change the script I sent you so that the
base address is at 0x200000.  This assumes that the DRAM controller is setup by your
bootloader.  I also had problems with the caches so I went through the source code and
disabled all the caches.  I think this is because my bootloader doesn't setup the
UPM correctly and it goes a little crazy on burst accesses.  I recommend that you do
something similar for now.  I also had to change the NFS transfer size from 4096 to
1024 in one of the header files so that I could have a root filesystem on NFS.  Don't
worry about the NFS stuff for now, lets just get the kernel booting.

Good luck,
Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
