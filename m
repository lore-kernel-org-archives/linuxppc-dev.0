Message-ID: <3FB2D757.1010304@g-house.de>
Date: Thu, 13 Nov 2003 01:59:03 +0100
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: trini@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc32 lockups with 2.6
References: <3FA5698A.9000905@g-house.de> <3FAABE62.4090804@g-house.de> <20031110125044.A22030@forte.austin.ibm.com> <3FB01392.60500@g-house.de> <20031110175740.A32176@forte.austin.ibm.com> <3FB02C85.6090400@g-house.de> <20031111153658.GH8584@ip68-0-152-218.tc.ph.cox.net>
In-Reply-To: <20031111153658.GH8584@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:
>>
>>CONFIG_DEBUG_KERNEL=y
>>CONFIG_DEBUG_SLAB=y
>>CONFIG_MAGIC_SYSRQ=y
>>CONFIG_KGDB=y
>>CONFIG_KGDB_TTYS1=y
>>CONFIG_XMON=y
>>CONFIG_DEBUG_INFO=y
>>CONFIG_BOOTX_TEXT=y
>
> Note that with XMON and KGDB both enabled, you'll get xmon instead,
> which again I _think_ works on PReP (but it was long ago when I tested)
> and here I think you'll be better off with KGDB.

so little time, so much to compile, so slow processors :-)
and my compile fails with CONFIG_KGDB=y. i have unpacked a fresh
2.6.0-test9, did "make oldconfig", then only enabled KGDB, but compile
bails out with:

evil@sheep:/usr/src/linux-2.6$ make bzImage
make[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.
   CHK     include/asm-ppc/offsets.h
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   GEN     .version
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1
arch/ppc/kernel/built-in.o(.init.text+0x81c): In function `setup_arch':
arch/ppc/kernel/setup.c:635: undefined reference to `kgdb_map_scc'
make: *** [.tmp_vmlinux1] Error 1
evil@sheep:/usr/src/linux-2.6$


so, it seems to depend on "SCC_CONSOLE", but this is only available when
  "MPC8260 CPM Options" is set. but this "MPC8260" is a different
platform. ok, when i choose a different platform, say PRPMC800, i still
can select 6xx/7xx/74xx/8260 as cpu-type (i have 604). no, i don't seem
to understand this, and in-kernel documentation of the different
platforms is not so clear :-(

the .config is on http://www.nerdbynature.de/bits/sheep/network/config_new

anyway, i'm about to setup a cross-compile environment on my AMD-K7
(i386), will see what it gives. oh, i noticed, that on i386 we don't
have CONFIG_KGDB at all, right?

thanks for reading,
Christian.

PS: oh, played around with .config (yes, the above config-new is still
correct) i got:

evil@sheep:/usr/src/linux-2.6$ make bzImage
make[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.
   CHK     include/asm-ppc/offsets.h
   CHK     include/linux/compile.h
   GEN     .version
   CHK     include/linux/compile.h
   UPD     include/linux/compile.h
   CC      init/version.o
   LD      init/built-in.o
   LD      .tmp_vmlinux1
arch/ppc/kernel/built-in.o(.text+0xa628): In function `getpacket':
arch/ppc/kernel/ppc-stub.c:350: undefined reference to `getDebugChar'
arch/ppc/kernel/built-in.o(.text+0xa640):arch/ppc/kernel/ppc-stub.c:359:
undefined reference to `getDebugChar'
arch/ppc/kernel/built-in.o(.text+0xa6b0):arch/ppc/kernel/ppc-stub.c:373:
undefined reference to `getDebugChar'
arch/ppc/kernel/built-in.o(.text+0xa6c0):arch/ppc/kernel/ppc-stub.c:374:
undefined reference to `getDebugChar'
arch/ppc/kernel/built-in.o(.text+0xa6e4):arch/ppc/kernel/ppc-stub.c:376:
undefined reference to `putDebugChar'
arch/ppc/kernel/built-in.o(.text+0xa6f0):arch/ppc/kernel/ppc-stub.c:378:
undefined reference to `putDebugChar'
arch/ppc/kernel/built-in.o(.text+0xa704):arch/ppc/kernel/ppc-stub.c:381:
undefined reference to `putDebugChar'
arch/ppc/kernel/built-in.o(.text+0xa70c):arch/ppc/kernel/ppc-stub.c:382:
undefined reference to `putDebugChar'
arch/ppc/kernel/built-in.o(.text+0xa768): In function `putpacket':
arch/ppc/kernel/ppc-stub.c:402: undefined reference to `putDebugChar'
arch/ppc/kernel/built-in.o(.text+0xa780):arch/ppc/kernel/ppc-stub.c:412:
more undefined references to `putDebugChar' follow
arch/ppc/kernel/built-in.o(.text+0xa79c): In function `putpacket':
arch/ppc/kernel/ppc-stub.c:415: undefined reference to `getDebugChar'
arch/ppc/kernel/built-in.o(.text+0xa7c8):arch/ppc/kernel/ppc-stub.c:407:
undefined reference to `putDebugChar'
arch/ppc/kernel/built-in.o(.text+0xa9bc): In function `handle_exception':
arch/ppc/kernel/ppc-stub.c:589: undefined reference to `kgdb_interruptible'
arch/ppc/kernel/built-in.o(.text+0xae18):arch/ppc/kernel/ppc-stub.c:781:
undefined reference to `kgdb_interruptible'
arch/ppc/kernel/built-in.o(.init.text+0x81c): In function `setup_arch':
arch/ppc/kernel/setup.c:635: undefined reference to `kgdb_map_scc'
arch/ppc/platforms/built-in.o(.init.text+0x930): In function
`pmac_setup_arch':
arch/ppc/platforms/pmac_setup.c:301: undefined reference to `zs_kgdb_hook'
make: *** [.tmp_vmlinux1] Error 1
--
BOFH excuse #380:

Operators killed when huge stack of backup tapes fell over.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
