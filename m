Content-Type: text/plain;
  charset="iso-8859-1"
From: Praveen Madhavan <praveenb@intotoinc.com>
Reply-To: praveenb@intotoinc.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Cross compiling 2.4 kernel: Error:missing operand !
Date: Mon, 26 Nov 2001 10:36:10 +0530
Cc: praveenb@intotoinc.com
MIME-Version: 1.0
Message-Id: <01112610361000.00908@praveen>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
  I am building kernel image for my Power pc 823 board using intel x86 as my
  host.
   When i try to build the kernel 2.4.14 image using gcc cross compiler, its
stops on its half way !!  Reporting  MISSING OPERAND ERROR.

    Even i tried to build 2.2.20 powerpc kernel, following compilation errors
are being reported for this as well.

mbx_setup.c: In function `mbx_calibrate_decr':
mbx_setup.c:159: `MBX_IMAP_ADDR' undeclared (first use in this function)
mbx_setup.c:159: (Each undeclared identifier is reported only once
mbx_setup.c:159: for each function it appears in.)
mbx_setup.c: In function `mbx_set_rtc_time':
mbx_setup.c:189: `MBX_IMAP_ADDR' undeclared (first use in this function)
mbx_setup.c: At top level:
mbx_setup.c:197: parse error before `{'
mbx_setup.c:205: parse error before `immap_t'
mbx_setup.c:210: parse error before `immap_t'
mbx_setup.c:218: parse error before `immap_t'
mbx_setup.c: In function `mbx_halt':
mbx_setup.c:247: parse error before `}'
mbx_setup.c: In function `mbx_do_IRQ':
mbx_setup.c:278: `ppc8xx_pic' undeclared (first use in this function)
mbx_setup.c:284: `spurious_interrupts' undeclared (first use in this function)
mbx_setup.c: In function `mbx_i8259_action':
mbx_setup.c:314: `i8259_pic' undeclared (first use in this function)
mbx_setup.c: In function `mbx_init_IRQ':
mbx_setup.c:328: `ppc8xx_pic' undeclared (first use in this function)
mbx_setup.c:334: `i8259_pic' undeclared (first use in this function)
mbx_setup.c:335: warning: implicit declaration of function `i8259_init'
mbx_setup.c: In function `mbx_init':
mbx_setup.c:423: warning: implicit declaration of function
`mbx_setup_pci_ptrs'

Here are the utilities i am using for cross compilation !

binutils : version 2.11.92.0.7
gcc-core: version 2.95.3
powerpc-kernel : 2.4.14

Host environment:
 Red Hat 7.1
 Linux kernel: 2.4.14


I have enclosed below , the complete compilation logs for 2.4 & 2.2 kernels!


Please help me

Note : I am not the member of ppc embedded list. please reply me.
Thanks.

***************************************************************
Cross compiling 2.4 kernel for mpc823 board.

[root@praveen src-linuxppc_2_4]# make bzImage
. scripts/mkversion > .tmpversion
powerpc-linux-gcc -D__KERNEL__ -I/home/praveen/ppc/src-linuxppc_2_4/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char -msoft-float
-pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -mcpu=860
-DUTS_MACHINE='"ppc"' -c -o init/version.o init/version.c
make CFLAGS="-D__KERNEL__ -I/home/praveen/ppc/src-linuxppc_2_4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
-mcpu=860 " -C  kernel
make[1]: Entering directory `/home/praveen/ppc/src-linuxppc_2_4/kernel'
make all_targets
make[2]: Entering directory `/home/praveen/ppc/src-linuxppc_2_4/kernel'
powerpc-linux-gcc -D__KERNEL__ -I/home/praveen/ppc/src-linuxppc_2_4/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char -msoft-float
-pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -mcpu=860
-fno-omit-frame-pointer -c -o sched.o sched.c
{standard input}: Assembler messages:
{standard input}:281: Error: missing operand
{standard input}:359: Error: missing operand
{standard input}:400: Error: missing operand
{standard input}:723: Error: missing operand
{standard input}:769: Error: missing operand
{standard input}:803: Error: missing operand
{standard input}:854: Error: missing operand
{standard input}:890: Error: missing operand
{standard input}:934: Error: missing operand
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory `/home/praveen/ppc/src-linuxppc_2_4/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/home/praveen/ppc/src-linuxppc_2_4/kernel'
make: *** [_dir_kernel] Error 2
*****************************************************************

Cross compilation for 2.2.20 kenel .
make[1]: Entering directory
`/home/praveen/download/src-linuxppc_2_2/arch/ppc/kernel'
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860 -S mk_defs.c
cp ppc_defs.head ppc_defs.h
chmod 755 ppc_defs.h
grep '^#define' mk_defs.s >> ppc_defs.h
rm mk_defs.s
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860 -D__ASSEMBLY__ -c head.S -o head.o
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -DEXPORT_SYMTAB -c ppc_ksyms.c
In file included from ppc_ksyms.c:29:
pci.h:12: warning: `struct pci_dev' declared inside parameter list
pci.h:12: warning: its scope is only this definition or declaration, which is
probably not what you want.
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -DEXPORT_SYMTAB -c setup.c
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o traps.o traps.c make[1]: Circular
/home/praveen/download/src-linuxppc_2_2/include/asm/pci.h <-
/home/praveen/download/src-linuxppc_2_2/include/linux/pci.h dependency
dropped.
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o irq.o irq.c
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o idle.o idle.c
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o time.o time.c
time.c: In function `time_init':
time.c:215: warning: implicit declaration of function `do_sys_settimeofday'
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o process.o process.c
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o signal.o signal.c
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o syscalls.o syscalls.c
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860 -D__ASSEMBLY__ -c misc.S -o misc.o
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o bitops.o bitops.c
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o ptrace.o ptrace.c
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o align.o align.c powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o ppc_htab.o ppc_htab.c
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o pci.o pci.c
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860 -D__ASSEMBLY__ -c sleep.S -o sleep.o
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o mbx_setup.o mbx_setup.c
mbx_setup.c: In function `mbx_calibrate_decr':
mbx_setup.c:159: `MBX_IMAP_ADDR' undeclared (first use in this function)
mbx_setup.c:159: (Each undeclared identifier is reported only once
mbx_setup.c:159: for each function it appears in.)
mbx_setup.c: In function `mbx_set_rtc_time':
mbx_setup.c:189: `MBX_IMAP_ADDR' undeclared (first use in this function)
mbx_setup.c: At top level:
mbx_setup.c:197: parse error before `{'
mbx_setup.c:205: parse error before `immap_t'
mbx_setup.c:210: parse error before `immap_t'
mbx_setup.c:218: parse error before `immap_t'
mbx_setup.c: In function `mbx_halt':
mbx_setup.c:247: parse error before `}'
mbx_setup.c: In function `mbx_do_IRQ':
mbx_setup.c:278: `ppc8xx_pic' undeclared (first use in this function)
mbx_setup.c:284: `spurious_interrupts' undeclared (first use in this function)
mbx_setup.c: In function `mbx_i8259_action':
mbx_setup.c:314: `i8259_pic' undeclared (first use in this function)
mbx_setup.c: In function `mbx_init_IRQ':
mbx_setup.c:328: `ppc8xx_pic' undeclared (first use in this function)
mbx_setup.c:334: `i8259_pic' undeclared (first use in this function)
mbx_setup.c:335: warning: implicit declaration of function `i8259_init'
mbx_setup.c: In function `mbx_init':
mbx_setup.c:423: warning: implicit declaration of function
`mbx_setup_pci_ptrs'
make[1]: *** [mbx_setup.o] Error 1
make[1]: Leaving directory
`/home/praveen/download/src-linuxppc_2_2/arch/ppc/kernel'
make: *** [_dir_arch/ppc/kernel] Error 2make[1]: Entering directory
`/home/praveen/download/src-linuxppc_2_2/arch/ppc/kernel'
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860 -S mk_defs.c
cp ppc_defs.head ppc_defs.h
chmod 755 ppc_defs.h
grep '^#define' mk_defs.s >> ppc_defs.h
rm mk_defs.s
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860 -D__ASSEMBLY__ -c head.S -o head.o
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -DEXPORT_SYMTAB -c ppc_ksyms.c
In file included from ppc_ksyms.c:29:
pci.h:12: warning: `struct pci_dev' declared inside parameter list
pci.h:12: warning: its scope is only this definition or declaration, which is
probably not what you want.
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -DEXPORT_SYMTAB -c setup.c
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o traps.o traps.c make[1]: Circular
/home/praveen/download/src-linuxppc_2_2/include/asm/pci.h <-
/home/praveen/download/src-linuxppc_2_2/include/linux/pci.h dependency
dropped.
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o irq.o irq.c
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o idle.o idle.c
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o time.o time.c
time.c: In function `time_init':
time.c:215: warning: implicit declaration of function `do_sys_settimeofday'
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o process.o process.c
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o signal.o signal.c
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o syscalls.o syscalls.c
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860 -D__ASSEMBLY__ -c misc.S -o misc.o
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o bitops.o bitops.c
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o ptrace.o ptrace.c
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o align.o align.c powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o ppc_htab.o ppc_htab.c
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o pci.o pci.c
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860 -D__ASSEMBLY__ -c sleep.S -o sleep.o
powerpc-linux-gcc -D__KERNEL__
-I/home/praveen/download/src-linuxppc_2_2/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple
-mstring -mcpu=860   -c -o mbx_setup.o mbx_setup.c
mbx_setup.c: In function `mbx_calibrate_decr':
mbx_setup.c:159: `MBX_IMAP_ADDR' undeclared (first use in this function)
mbx_setup.c:159: (Each undeclared identifier is reported only once
mbx_setup.c:159: for each function it appears in.)
mbx_setup.c: In function `mbx_set_rtc_time':
mbx_setup.c:189: `MBX_IMAP_ADDR' undeclared (first use in this function)
mbx_setup.c: At top level:
mbx_setup.c:197: parse error before `{'
mbx_setup.c:205: parse error before `immap_t'
mbx_setup.c:210: parse error before `immap_t'
mbx_setup.c:218: parse error before `immap_t'
mbx_setup.c: In function `mbx_halt':
mbx_setup.c:247: parse error before `}'
mbx_setup.c: In function `mbx_do_IRQ':
mbx_setup.c:278: `ppc8xx_pic' undeclared (first use in this function)
mbx_setup.c:284: `spurious_interrupts' undeclared (first use in this function)
mbx_setup.c: In function `mbx_i8259_action':
mbx_setup.c:314: `i8259_pic' undeclared (first use in this function)
mbx_setup.c: In function `mbx_init_IRQ':
mbx_setup.c:328: `ppc8xx_pic' undeclared (first use in this function)
mbx_setup.c:334: `i8259_pic' undeclared (first use in this function)
mbx_setup.c:335: warning: implicit declaration of function `i8259_init'
mbx_setup.c: In function `mbx_init':
mbx_setup.c:423: warning: implicit declaration of function
`mbx_setup_pci_ptrs'
make[1]: *** [mbx_setup.o] Error 1
make[1]: Leaving directory
`/home/praveen/download/src-linuxppc_2_2/arch/ppc/kernel'
make: *** [_dir_arch/ppc/kernel] Error 2

-------------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
