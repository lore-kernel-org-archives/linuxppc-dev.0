Date: Tue, 17 Oct 2000 19:46:31 -0400 (EDT)
From: Jamie Guinan <guinan@bluebutton.com>
Reply-To: guinan@bluebutton.com
To: Yiran Duan <yiranduan@yahoo.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MBX kernel compile error
In-Reply-To: <20001017210229.5208.qmail@web5201.mail.yahoo.com>
Message-ID: <Pine.LNX.4.21.0010171929100.19158-100000@gemini.home.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 17 Oct 2000, Yiran Duan wrote:

> Hi,
>
> I tried to compile linux kernel for MBX board on
> i686-pc-linux. The package I used to built my
> cross-compiler is:
>
>     binutils-2.10
>     glibc-2.1.3
>     gcc-2.95

I've built for MBX with almost the same, only binutils 2.9.5 instead
of 2.10.

> The kernel package I used is
>
>     linux-2.2.17
>
> I passed make xconfig, make dep, make clean, but got
> the following error at make zImage:
>
> powerpc-linux-gcc -D__KERNEL__
> -I/home/compiler/sources/linux/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer
> -fno-strict-aliasing -D__powerpc__ -fsigned-char
> -msoft-float -pipe -fno-builtin -ffixed-r2
> -Wno-uninitialized -mmultiple -mstring -mcpu=860
> -D__ASSEMBLY__ -c head.S -o head.o
> head.S: Assembler messages:
> head.S:1829: Error: unsupported relocation type
> make[1]: *** [head.o] Error 1
> make[1]: Leaving directory
> `/home/compiler/sources/linux/arch/ppc/kernel'
> make: *** [_dir_arch/ppc/kernel] Error 2
>
> Could anyone give me any idea about where I was wrong?

Looking at
  http://lxr.linux.no/source/arch/ppc/kernel/head.S
the problem is apparent:

  255 #ifndef CONFIG_8xx
  256         bl      prom_init
  257         .globl  __secondary_start
  258 __secondary_start:
  ...

  1293 #ifndef CONFIG_8xx
  ..
  1822 #else  /* CONFIG_8xx */
  1823         .globl  giveup_fpu
  1824 giveup_fpu:
  1825         blr
  1826 #endif /* CONFIG_8xx */
  1827
  1828 mmu_off:
  1829         addi    r4, r3, __secondary_start - _start
  1830         mfmsr   r3

__secondary_start is not defined for CONFIG_8xx.  It looks like
head.S changed a bit since 2.2.14, and I wouldn't know which way to go
about fixing it, but I might suggest either backing down to 2.2.14 or
jumping to 2.4.0-test2.

The latest Monta Vista CDK (1.2) appears to include both, and last I
tried their stuff worked quite well with little headaches - I'd recommend
giving it a try,

  http://www.mvista.com/
  ftp://ftp.mvista.com/pub/CDK/

-Jamie

>
> Thank you.
> Yiran.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
