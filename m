To: "Williams, Kevin M." <kevin.m.williams@marconi.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Abatron BDI2000 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 20 Nov 2001 13:04:51 EST."
             <A3E34B558F5CD211B4980008C7A4A99003C5853B@sparrow.gso.mcs.marconi.com>
Date: Tue, 20 Nov 2001 19:54:12 +0100
Message-Id: <20011120185417.83553F9B9@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <A3E34B558F5CD211B4980008C7A4A99003C5853B@sparrow.gso.mcs.marconi.com> you wrote:
>
> That is covered in the [INIT] section.  I have that correct or I would not
> have been able to debug my bootrom using gdb, read/write memory, etc.  I can
> do all that without any problem, and if all I wanted was to debug the
> bootrom I would be all set.

Umm... this depends a lot on how you work. Many people  tend  to  put
full initialization (for instance including the memory controller) in
the config file. Istead, I use always minimal config files.

> What I am having trouble with is getting it to download the compressed
> kernel image.

You should be aware that it's not a trivial task to boot  Linux  from
the  BDI2000;  you  not  only need to get all hardware initialization
correct, you also have to prepare and pass a data structure with  all
necessary  parameters  (board  info struct, ramdisk address and size,
command line etc.) to the Linux kernel.

Why are you trying to do this? Use your firmware  to  initialize  the
hardware,  and  to  load  and  boot  the  Linux  kernel. This is MUCH
easier...

> Specifically, I was hoping to see what was in the [TARGET], [FLASH], and
> [HOST] sections of a correct .cnf file for debugging the kernel. I must
> either have an offset incorrect, or not have something enabled, or something
> similar. That seems to be where my problem is....in that dozen or so lines
> at the end of the cnf file.

OK, here is a generic config file I use on many MPC8xx systems:

----- cut here -----
[INIT]
; init core register
WREG	MSR		0x00001002	;MSR  : ME,RI
WSPR	27		0x00001002	;SRR1 : ME,RI
WSPR	149		0x2002000F	;DER  : set debug enable register
WSPR	638		0xFFF00000	;IMMR : internal memory at 0xFFF00000
WSPR	158		0x00000007	;ICTRL:

; init SIU register
WM32	0xFFF00000	0x00010400	;SIUMCR
WM32	0xFFF00004	0xFFFFFF89	;SYPCR

[TARGET]
MMU	    XLAT	; support virtual addresses (for Linux!)
PTBASE	    0x000000F0	; ptr to page table pointers
CPUCLOCK    45000000	;the CPU clock rate after processing the init list
BDIMODE	    AGENT	;the BDI working mode (LOADONLY | AGENT)
BREAKMODE   HARD	;SOFT or HARD, HARD uses PPC hardware breakpoints

[HOST]
IP	    10.0.0.8
LOAD	    MANUAL	;load code MANUAL or AUTO after reset
DEBUGPORT   2001
START	    0x0100

[FLASH]
CHIPTYPE    AM29BX16	;Flash type (AM29LV160B)
CHIPSIZE    0x200000	;The size of one flash chip in bytes
BUSWIDTH    32		;The width of the flash memory bus in bits (8 | 16 | 32)
WORKSPACE   0xFFF02000	; RAM buffer for fast flash programming

[REGS]
DMM1	0xFFF00000
FILE	BDI2000/reg8xx.def
----- cut here -----

As you can see, it does not contain any specific  stuff  to  load  or
program  files (I always feed those in manually, or using some expect
scripts).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It usually takes more than three weeks to prepare  a  good  impromptu
speech.                                                  - Mark Twain

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
