Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
From: Christophe.LINDHEIMER@fr.thalesgroup.com
Message-ID: <66CE949D18BCB249ABE8D9AF48C4F1CE777849@helios.clb.tcfr.thales>
To: linuxppc-dev@lists.linuxppc.org
Subject: Prob to compile Kernel on mpc860.
Date: Thu, 30 Oct 2003 16:57:36 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi .

prob 1 :
I am trying to compile the linuxppc_2_4_devel_2.4_20-2002_12_04 from Denx.
As I need debug, I replace -O2 by -g in the Makefile.
The kernel doesn't link anymore :[

ppc_8xx-ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic
arch/ppc/kernel/head_8xx.o init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/ppc/kernel/kernel.o arch/ppc/platforms/platform.o
arch/ppc/mm/mm.o
arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/char/char.o drivers/block/block.o
drivers/macintosh/macintosh.o drivers/i2c/i2c.o arch/ppc/8xx_io/8xx_io.o \
        net/network.o \
        /Blinde/linuxppc_2_4_devel-2.4.20-2002_12_04/lib/lib.a \
        --end-group \
        -o vmlinux
arch/ppc/kernel/kernel.o: In function `_switch':
arch/ppc/kernel/entry.S(.text+0x284): relocation truncated to fit:
R_PPC_REL14 syscall_trace
arch/ppc/kernel/kernel.o: In function `emulate_instruction':
/Blinde/linuxppc_2_4_devel-2.4.20-2002_12_04/arch/ppc/kernel/traps.c:293:
undefined reference to `__get_user_bad'
/Blinde/linuxppc_2_4_devel-2.4.20-2002_12_04/arch/ppc/kernel/traps.c:293:
relocation truncated to fit: R_PPC_REL24 __get_user_bad
arch/ppc/kernel/kernel.o: In function `get_irq_list':
/Blinde/linuxppc_2_4_devel-2.4.20-2002_12_04/arch/ppc/kernel/irq.c:386:
undefined reference to `kstat_irqs'
/Blinde/linuxppc_2_4_devel-2.4.20-2002_12_04/arch/ppc/kernel/irq.c:386:
relocation truncated to fit: R_PPC_REL24 kstat_irqs
arch/ppc/kernel/kernel.o: In function `parse_hex_value':
/Blinde/linuxppc_2_4_devel-2.4.20-2002_12_04/arch/ppc/kernel/irq.c:885:
undefined reference to `copy_from_user'
/Blinde/linuxppc_2_4_devel-2.4.20-2002_12_04/arch/ppc/kernel/irq.c:885:
relocation truncated to fit: R_PPC_REL24 copy_from_user
arch/ppc/kernel/kernel.o: In function `do_gettimeofday':
/Blinde/linuxppc_2_4_devel-2.4.20-2002_12_04/arch/ppc/kernel/time.c:241:
undefined reference to `tb_ticks_since'
.....
.....






prob 2 :
Using linux2.4.22 from kernel.org.
I apply the patch for powerpc
the kernel doesn't compile.
Prob with stdarg.h that doesn't exist ( in sched.c )

make[2]: Entre dans le répertoire `/Blinde/linux-2.4.22.Chris/kernel'
ppc_8xx-gcc -D__KERNEL__ -I/Blinde/linux-2.4.22.Chris/include -Wall
-Wstrict-prototypes -Wno-trigraphs -g -fno-strict-aliasing -fno-common
-fomit-frame-pointer
-I/Blinde/linux-2.4.22.Chris/arch/ppc -fsigned-char -msoft-float -pipe
-ffixed-r2 -Wno-uninitialized -mmultiple -mstring -mcpu=860   -nostdinc
-iwithprefix include -DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -c -o
sched.o sched.c
In file included from /Blinde/linux-2.4.22.Chris/include/linux/wait.h:13,
                 from /Blinde/linux-2.4.22.Chris/include/linux/fs.h:12,
                 from
/Blinde/linux-2.4.22.Chris/include/linux/capability.h:17,
                 from /Blinde/linux-2.4.22.Chris/include/linux/binfmts.h:5,
                 from /Blinde/linux-2.4.22.Chris/include/linux/sched.h:9,
                 from /Blinde/linux-2.4.22.Chris/include/linux/mm.h:4,
                 from sched.c:23:
/Blinde/linux-2.4.22.Chris/include/linux/kernel.h:10: stdarg.h: Aucun
fichier ou r?pertoire de ce type
In file included from /Blinde/linux-2.4.22.Chris/include/linux/wait.h:13,
                 from /Blinde/linux-2.4.22.Chris/include/linux/fs.h:12,
                 from
/Blinde/linux-2.4.22.Chris/include/linux/capability.h:17,
                 from /Blinde/linux-2.4.22.Chris/include/linux/binfmts.h:5,
                 from /Blinde/linux-2.4.22.Chris/include/linux/sched.h:9,
                 from /Blinde/linux-2.4.22.Chris/include/linux/mm.h:4,
                 from sched.c:23:
/Blinde/linux-2.4.22.Chris/include/linux/kernel.h:74: parse error before
`va_list'
/Blinde/linux-2.4.22.Chris/include/linux/kernel.h:74: warning: function
declaration isn't a prototype
/Blinde/linux-2.4.22.Chris/include/linux/kernel.h:77: parse error before
`va_list'
/Blinde/linux-2.4.22.Chris/include/linux/kernel.h:77: warning: function
declaration isn't a prototype
/Blinde/linux-2.4.22.Chris/include/linux/kernel.h:81: parse error before
`va_list'
/Blinde/linux-2.4.22.Chris/include/linux/kernel.h:81: warning: function
declaration isn't a prototype
make[2]: *** [sched.o] Erreur 1
make[2]: Quitte le répertoire `/Blinde/linux-2.4.22.Chris/kernel'
make[1]: *** [first_rule] Erreur 2
make[1]: Quitte le répertoire `/Blinde/linux-2.4.22.Chris/kernel'
make: *** [_dir_kernel] Erreur 2



Chris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
