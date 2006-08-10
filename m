Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id EF993679E2
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 04:18:19 +1000 (EST)
Received: from localhost.localdomain (shorty@debby1-6 [127.0.0.1])
	by localhost.localdomain (8.13.7/8.13.7/Debian-2) with ESMTP id
	k7AIBt0w025425
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 20:11:56 +0200
Received: (from shorty@localhost)
	by localhost.localdomain (8.13.7/8.13.7/Submit) id k7AIBsnU025424
	for linuxppc-dev@ozlabs.org; Thu, 10 Aug 2006 20:11:54 +0200
Date: Thu, 10 Aug 2006 20:11:54 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: linux-ppc <linuxppc-dev@ozlabs.org>
Subject: latest git: compile error: arch/powerpc/kernel/built-in.o
Message-ID: <20060810181154.GA3668@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Hi All

I'm trying to compile a fresh git kernel, with latest sources pulled today,
Aug. 10. To no avail so far. 

OS is Debian/unstable, last time I upgraded the system as far as the
dependencies allowed doing that was yesterday, Aug. 10.

---------------------
$ cat /proc/cpuinfo 
processor       : 0
cpu             : 7447A, altivec supported
clock           : 833.333000MHz
revision        : 0.5 (pvr 8003 0105)
bogomips        : 16.57
timebase        : 8320000
platform        : PowerMac
machine         : PowerBook5,8
motherboard     : PowerBook5,8 MacRISC3 Power Macintosh 
detected as     : 287 (PowerBook G4 15")
pmac flags      : 00000019
L2 cache        : 512K unified
pmac-generation : NewWorld
-----------------------------

Here's the config I used:

http://wolfgangpfeiffer.com/config.060810.txt

The compile messages:

--------------------------------
time MAKEFLAGS="CC=gcc-4.1"  fakeroot make-kpkg --append-to-version=-060810 kernel_image

results in [excerpts]:

  CC      lib/sha1.o
  CC      lib/string.o
  CC      lib/vsprintf.o
  AR      lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/powerpc/kernel/built-in.o: In function `__restore_cpu_setup':
(.text+0xcd34): undefined reference to `kexec_sr_activated'
arch/powerpc/kernel/built-in.o: In function `__restore_cpu_setup':
(.text+0xcd44): undefined reference to `crash_kexec_secondary'
arch/powerpc/kernel/built-in.o: In function `early_init_devtree':
(.init.text+0x1cdc): undefined reference to `reserve_crashkernel'
arch/powerpc/kernel/built-in.o: In function `early_init_devtree':
(.init.text+0x1e1c): undefined reference to `overlaps_crashkernel'
make[1]: *** [.tmp_vmlinux1] Error 1
make[1]: Leaving directory `/home/shorty/kernel-factory/git.08102006/linux-2.6'
make: *** [debian/stamp-build-kernel] Error 2

real    9m39.089s
user    8m21.904s
sys     0m59.167s

------------------------------------------------------------

and with gcc-4.0 the same:

time MAKEFLAGS="CC=gcc-4.0"  fakeroot make-kpkg --append-to-version=-060810 kernel_image

results in [excerpts]:

  CC      lib/vsprintf.o
  AR      lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/powerpc/kernel/built-in.o: In function `__restore_cpu_setup':
(.text+0xcccc): undefined reference to `kexec_sr_activated'
arch/powerpc/kernel/built-in.o: In function `__restore_cpu_setup':
(.text+0xccdc): undefined reference to `crash_kexec_secondary'
arch/powerpc/kernel/built-in.o: In function `early_init_devtree':
(.init.text+0x15d0): undefined reference to `reserve_crashkernel'
arch/powerpc/kernel/built-in.o: In function `early_init_devtree':
(.init.text+0x1710): undefined reference to `overlaps_crashkernel'
make[1]: *** [.tmp_vmlinux1] Error 1
make[1]: Leaving directory `/home/shorty/kernel-factory/git.08102006/linux-2.6'
make: *** [debian/stamp-build-kernel] Error 2

--------------------------------------

Please let me know if you need more details.

Thanks in anticipation

Best Regards
Wolfgang Pfeiffer

-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
