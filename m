Message-ID: <3DDC81F0.50200@tataelxsi.co.in>
Date: Thu, 21 Nov 2002 12:19:20 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: cannot compile 2.4.19 with kgdb/xmon
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I am a new member in this list.
I am trying to build kernel 2.4.19 for ppc (mpc 8260) on i386 using
ppc_82xx-gcc cross compiler.

The configuration compiles fine when I exclude kernel hacking options.
Once kgdb or xmon options (any of them)  of the kernel hacking options
is included, kernel compilation fails with the following

[root@cosine-ipnos /opt/hardhat/previewkit/ppc/82xx/bin]$ ./ppc_82xx-gcc -v
./ppc_82xx-gcc: Actual path = '/opt/hardhat/previewkit/ppc/82xx/bin/'
         Actual name = 'ppc_82xx-gcc'
         Invoking
/opt/hardhat/previewkit/ppc/82xx/bin/../lib/gcc-lib/powerpc-hardhat-linux/2.95.3/ppc_82xx-gcc
Reading specs from
/opt/hardhat/previewkit/ppc/82xx/bin/../lib/gcc-lib/powerpc-hardhat-linux/2.95.3/specs
gcc version 2.95.3 20010315 (release/MontaVista)


[root@cosine-ipnos /usr/src/linux-2.4.19]# make menuconfig dep bzImage
<snip>
arch/ppc/kernel/kernel.o: In function `getpacket':
arch/ppc/kernel/kernel.o(.text+0x8f58): undefined reference to
`getDebugChar'
arch/ppc/kernel/kernel.o(.text+0x8f58): relocation truncated to fit:
R_PPC_REL24 getDebugChar
<snip>
arch/ppc/kernel/kernel.o: In function `putpacket':
arch/ppc/kernel/kernel.o(.text+0x9078): undefined reference to
`putDebugChar'
arch/ppc/kernel/kernel.o(.text+0x9078): relocation truncated to fit:
R_PPC_REL24 putDebugChar
<snip>
arch/ppc/kernel/kernel.o: In function `handle_exception':
arch/ppc/kernel/kernel.o(.text+0x9340): undefined reference to
`kgdb_interruptible'
arch/ppc/kernel/kernel.o(.text+0x9340): relocation truncated to fit:
R_PPC_REL24 kgdb_interruptible
<snip>
arch/ppc/kernel/kernel.o: In function `pmac_setup_arch':
arch/ppc/kernel/kernel.o(.text.init+0x1e50): undefined reference to
`zs_kgdb_hook'
arch/ppc/kernel/kernel.o(.text.init+0x1e50): relocation truncated to fit:
R_PPC_REL24 zs_kgdb_hookmake: *** [vmlinux] Error 1
[root@cosine-ipnos /usr/src/linux-2.4.19]#

I examined the source code and found out the function is in
/usr/src/linux-2.4.19/arch/ppc/8xx_io/uart.c but not getting compiled.
(no .o files in that dir)

Any suggestions?

Thanks and regards,
Om.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
