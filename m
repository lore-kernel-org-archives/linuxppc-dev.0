Date: Fri, 30 Mar 2001 17:14:10 -0300
From: Marcio Koch <koch@inf.pucrs.br>
To: LinuxPPC-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Linux 2.4.2 + mtd-snapshot-20010328 doesn't compile with modules enabled
Message-ID: <20010330171410.A5539@sirrah.inf.pucrs.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to compile linux 2.4.2 with patch from mtd-snapshot-20010328 and
modules enabled, exactly like in the MTD-JFFS-HOWTO.

But I aways get this error:

[cut]

make[1]: Entrando no diretório `/usr/local/src/linux-2.4.2/arch/ppc/8xx_io'
make all_targets
make[2]: Entrando no diretório `/usr/local/src/linux-2.4.2/arch/ppc/8xx_io'
/opt/hardhat/devkit/ppc/8xx/bin/ppc_8xx-gcc -D__KERNEL__
-I/usr/local/src/linux-2.4.2/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
-mcpu=860 -I../8xx_io    -c -o commproc.o commproc.c
/opt/hardhat/devkit/ppc/8xx/bin/ppc_8xx-gcc -D__KERNEL__
-I/usr/local/src/linux-2.4.2/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
-mcpu=860 -I../8xx_io    -c -o uart.o uart.c
uart.c: In function `serial_console_setup':
uart.c:2961: warning: zero-length format string
/opt/hardhat/devkit/ppc/8xx/bin/ppc_8xx-gcc -D__KERNEL__
-I/usr/local/src/linux-2.4.2/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
-mcpu=860 -I../8xx_io    -c -o enet.o enet.c
rm -f 8xx_io.o
/opt/hardhat/devkit/ppc/8xx/bin/ppc_8xx-ld  -r -o 8xx_io.o commproc.o
uart.o enet.o
make[2]: Saindo do diretório `/usr/local/src/linux-2.4.2/arch/ppc/8xx_io'
make[1]: Saindo do diretório `/usr/local/src/linux-2.4.2/arch/ppc/8xx_io'
/opt/hardhat/devkit/ppc/8xx/bin/ppc_8xx-ld -T arch/ppc/vmlinux.lds -Ttext
0xc0000000 -Bstatic arch/ppc/kernel/head_8xx.o init/main.o init/version.o \
	--start-group \
	arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/ppc/math-emu/math-emu.o \
	drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o  arch/ppc/8xx_io/8xx_io.o \
	net/network.o \
	/usr/local/src/linux-2.4.2/lib/lib.a \
	--end-group \
	-o vmlinux
arch/ppc/kernel/kernel.o(__ksymtab+0x210): undefined reference to
`sys_ctrler'
arch/ppc/kernel/kernel.o(__ksymtab+0x218): undefined reference to
`kd_mksound'

That's my last .config I used to test, it's very simple, has only the
modules enabled, but no modules selected. And when I use the same .config
but with only the modules disabled :

from this:

CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

to this:

# CONFIG_MODULES is not set

it works!

I would thank any help.

Best regards,

Marcio Koch
koch@inf.pucrs.br
PUCRS/ELinux


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
