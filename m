To: Wolfgang Denk <wd@denx.de>
Cc: Stephane Laroche <stephane.laroche@sympatico.ca>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Basic questions about PPC embedded developement under Linux
References: <200004041653.SAA08051@denx.local.net>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 05 Apr 2000 11:02:12 +0200
In-Reply-To: Wolfgang Denk's message of "Tue, 04 Apr 2000 18:53:23 +0200"
Message-ID: <kfyn1n8vs2z.fsf@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk <wd@denx.de> writes:

> In message <38EA0716.47AA17BA@sympatico.ca> you wrote:
> >
> > What do you gain by "understanding" the linux image?
>
> On the MPC8xx a Linux kernel image is usually an ELF binary file with
> several sections, for instance like that:
>
> Sections:
> Idx Name          Size      VMA       LMA       File off  Algn
>   0 .text         00004854  00180000  00180000  00010000  2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
>   1 .rodata       000007bc  00184860  00184860  00014860  2**4
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>   2 .data         0000031c  00186000  00186000  00016000  2**2
>                   CONTENTS, ALLOC, LOAD, DATA
>   3 .data.init    00000000  00187000  00187000  00017000  2**0
>                   CONTENTS
>   4 .bss          000031f8  00187000  00187000  00017000  2**2
>                   ALLOC
>   5 image         0007135d  00000000  00000000  00017000  2**0
>                   CONTENTS, READONLY
>   6 initrd        0008a502  00000000  00000000  0008835d  2**0
>                   CONTENTS, READONLY
>
> Most BDM debuggers I know will load only those sections  into  memory
> (RAM or FLASH) that have the LOAD flag set (which is perfectly OK for
> normal  binaries).  So  they will load only the text, rodata and data
> sections which just contain the boot loader code - they will not load
> the kernel image, nor the initial ramdisk image.

Hmm, sounds like a bug in the zImage linking.
To me it would seem apropriate to have the ALLOC, LOAD and DATA flags
set for data.init, image and initrd sections.

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
