Date: Sun, 4 May 2003 18:51:16 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.5 and serial console
Message-ID: <20030504165116.GA22339@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Morning,

is there a fix for this? It seems to involve Makefile tweaking, at least.

ld -T arch/ppc/boot/ld.script -Ttext 0x00800000 -Bstatic -o arch/ppc/boot/prep/zImage arch/ppc/boot/prep/head.o arch/ppc/boot/prep/misc.o arch/ppc/boot/prep
/vreset.o arch/ppc/boot/prep/kbd.o arch/ppc/boot/simple/legacy.o  arch/ppc/boot/prep/image.o arch/ppc/boot/common/lib.a arch/ppc/boot/lib/lib.a
arch/ppc/boot/common/lib.a(misc-common.o)(.text+0x92): In function `tstc':
: undefined reference to `com_port'
arch/ppc/boot/common/lib.a(misc-common.o)(.text+0x96): In function `tstc':
: undefined reference to `com_port'
arch/ppc/boot/common/lib.a(misc-common.o)(.text+0x98): In function `tstc':
: undefined reference to `serial_tstc'
arch/ppc/boot/common/lib.a(misc-common.o)(.text+0xaa): In function `tstc':
: undefined reference to `com_port'
arch/ppc/boot/common/lib.a(misc-common.o)(.text+0xae): In function `tstc':
: undefined reference to `com_port'
arch/ppc/boot/common/lib.a(misc-common.o)(.text+0xb0): In function `tstc':
: undefined reference to `serial_tstc'
arch/ppc/boot/common/lib.a(misc-common.o)(.text+0xca): In function `getc':
: undefined reference to `com_port'
arch/ppc/boot/common/lib.a(misc-common.o)(.text+0xd2): In function `getc':
: undefined reference to `com_port'
arch/ppc/boot/common/lib.a(misc-common.o)(.text+0xd4): In function `getc':
: undefined reference to `serial_tstc'
arch/ppc/boot/common/lib.a(misc-common.o)(.text+0x112): In function `getc':
: undefined reference to `com_port'
arch/ppc/boot/common/lib.a(misc-common.o)(.text+0x114): In function `getc':
: undefined reference to `serial_getc'
arch/ppc/boot/common/lib.a(misc-common.o)(.text+0x13a): In function `putc':
: undefined reference to `com_port'
arch/ppc/boot/common/lib.a(misc-common.o)(.text+0x142): In function `putc':
: undefined reference to `com_port'
arch/ppc/boot/common/lib.a(misc-common.o)(.text+0x148): In function `putc':
: undefined reference to `serial_putc'
arch/ppc/boot/common/lib.a(misc-common.o)(.text+0x212): In function `putc':
: undefined reference to `com_port'
arch/ppc/boot/common/lib.a(misc-common.o)(.text+0x218): In function `putc':
: undefined reference to `serial_putc'
arch/ppc/boot/common/lib.a(misc-common.o)(.text+0x252): In function `puts':
: undefined reference to `com_port'
arch/ppc/boot/common/lib.a(misc-common.o)(.text+0x25e): In function `puts':
: undefined reference to `com_port'
arch/ppc/boot/common/lib.a(misc-common.o)(.text+0x264): In function `puts':
: undefined reference to `serial_putc'
arch/ppc/boot/common/lib.a(misc-common.o)(.text+0x312): In function `puts':
: undefined reference to `com_port'
arch/ppc/boot/common/lib.a(misc-common.o)(.text+0x31c): In function `puts':
: undefined reference to `serial_putc'
make[2]: *** [arch/ppc/boot/images/zImage.prep] Error 1
make[1]: *** [prep] Error 2
make: *** [zImage] Error 2
builds@ibook:~/linux-2.5.68> grep -wlr serial_tstc .
./arch/ppc/boot/simple/m8xx_tty.c
./arch/ppc/boot/simple/m8260_tty.c
./arch/ppc/boot/simple/gt64260_tty.c
./arch/ppc/boot/common/misc-common.c
./arch/ppc/boot/common/ns16550.c
./arch/ppc/boot/common/misc-common.o
./arch/ppc/boot/common/lib.a


--
USB is for mice, FireWire is for men!

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
