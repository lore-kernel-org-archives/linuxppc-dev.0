Message-ID: <2F67A63DFFB1D31185D90090278CBB2D01D58850@apmail6.chn.agilent.com>
From: "ZHANG,HAI-TAO (A-China,ex1)" <hai-tao_zhang@agilent.com>
To: rabeeh@galileo.co.il
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Page tables
Date: Tue, 2 Jan 2001 22:24:01 +0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Rabeeh,

I have almost the same problem when I tried to boot the Sandpoint board, the
kernel boot hung up at the function padzero() of file binfmt_elf.c. At last
the problem is the wrong memory access in the network card device driver
eepro100.c, so you may check it also.

Haitao


> -----Original Message-----
> From: Rabeeh Khoury [mailto:rabeeh@galileo.co.il]
> Sent: Monday, January 01, 2001 11:21 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Page tables
>
>
>
> Hi All,
>
> I have been able to boot our embedded system (7400 PowerPC and Galileo
> Technology system controller) and mounting NFS throught network.
> Now the system is trying to run the first process - init.
> It starts downloading part of init, then downloads part of ld.so.1 and
> in the function padzero (in fs/binfmt_elf.c), where the user space is
> first accessed at all (address 0x30026328 to be exact), the
> kernel tries
> to zero the bss section.
> Due to that an exception occurs due to not valid page, then the kernel
> allocates succesfully new pte to the process (in function
> do_page_fault
> in file arch/ppc/mm/fault.c) and it is supposed to go back to function
> padzero to resume, but the weird thing is that it doesn't go back and
> stays stuck some where that I couldn't find where.
> One good thing is that the interrupt handling mechainsm is
> still working
> and the kernel still responds to pings.
>
>
> Did any one encounter such a problem ?
> and how can I debug this problem ?
> is there any functions that I can use to search the page tables ?
>
> Any tip would help a lot !
>
>
> Thank you,
> Rabeeh
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
