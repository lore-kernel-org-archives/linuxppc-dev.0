Date: Sat, 21 Jul 2001 11:53:21 +0100
From: Iain Young <iain@g7iii.junglelink.co.uk>
To: linuxppc-embedded@lists.linuxppc.org
Subject: process.c Assembler Message Error: unsupported relocation type
Message-ID: <20010721115321.A484@g7iii.junglelink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

Hopefully someone can tell me I have made a silly mistake here.

I am attempting to cross compile .2.4.7pre9 from a SPARC to a 403 board.

Both the toolchain, and gcc compiled with no problems, and the kernel
gets most of the way there. It stops at arch/ppc/kernel/process.c,
with the following output from make:

make CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4-sparc/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -mcpu=403 " -C  arch/ppc/kernel
make[1]: Entering directory `/usr/src/linux-2.4-sparc/arch/ppc/kernel'
powerpc-linux-gcc -D__KERNEL__ -I/usr/src/linux-2.4-sparc/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -mcpu=403    -c -o process.o process.c
process.c: In function `copy_thread':
process.c:327: warning: unused variable `msr'
{standard input}: Assembler messages:
{standard input}:394: Error: unsupported relocation type
{standard input}:395: Error: unsupported relocation type
{standard input}:396: Error: unsupported relocation type
{standard input}:400: Error: unsupported relocation type
{standard input}:401: Error: unsupported relocation type
{standard input}:402: Error: unsupported relocation type
make[1]: *** [process.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4-sparc/arch/ppc/kernel'
make: *** [_dir_arch/ppc/kernel] Error 2

powerpc-linux-gcc -v reports:

Reading specs from /usr/local/lib/gcc-lib/powerpc-linux/2.95.3/specs
gcc version 2.95.3 20010315 (release)


while powerpc-linux-as -v reports:

GNU assembler version 2.10.91 (powerpc-linux) using BFD version 2.10.91.0.2


My question is have I been silly, and got a compiler/toolchain mismatch ?
(I was under the impression these were particular versions were OK
together)

Or is this a known issue ? Or something that has just turned up in 2.4.7pre ?
(Although I noticed that aarch/ppc/kernel/process.c doesnt seem to have
been changed in a while.

Any help/assistance would be most gratefully recieved. It is frustrating
to be so close, yet so far.


All the Best

Iain


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
