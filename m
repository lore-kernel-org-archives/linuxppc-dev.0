Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 42057DDE2A
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 07:39:19 +1100 (EST)
Date: Wed, 22 Oct 2008 15:38:57 -0500 (CDT)
Message-Id: <200810222038.m9MKcvIs020504@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Arnd Bergmann <arnd@arndb.de>
Subject: build break CONFIG_SPU_FS=n CONFIG_CBE_THERM=y
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

as of 4792adbac9eb41cea77a45ab76258ea10d411173

CONFIG_SPU_FS=n
CONFIG_PPC_CELL=y
CONFIG_PPC_CELL_NATIVE=y
CONFIG_PPC_IBM_CELL_BLADE=y
CONFIG_CBE_RAS=y
CONFIG_PPC_IBM_CELL_RESETBUTTON=y
CONFIG_CBE_THERM=y

rest mostly pseries_defconfig.


  MODPOST vmlinux.o
WARNING: modpost: Found 8 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
ld: drivers/built-in.o section .devinit.text exceeds stub group size
ld: drivers/built-in.o section .init.text exceeds stub group size
ld: arch/powerpc/kernel/built-in.o section .init.text exceeds stub group size
ld: init/built-in.o section .init.text exceeds stub group size
ld: net/built-in.o section .text exceeds stub group size
ld: drivers/built-in.o section .text exceeds stub group size
ld: lib/built-in.o section .text exceeds stub group size
ld: block/built-in.o section .text exceeds stub group size
ld: crypto/built-in.o section .text exceeds stub group size
ld: ipc/built-in.o section .text exceeds stub group size
ld: fs/built-in.o section .text exceeds stub group size
ld: mm/built-in.o section .text exceeds stub group size
ld: kernel/built-in.o section .text exceeds stub group size
ld: arch/powerpc/platforms/built-in.o section .text exceeds stub group size
ld: arch/powerpc/kernel/built-in.o section .text exceeds stub group size
ld: arch/powerpc/kernel/head_64.o section .text exceeds stub group size
arch/powerpc/platforms/built-in.o: In function `.get_pmd_regs':
cbe_thermal.c:(.text+0x107e0): undefined reference to `.spu_devnode'
arch/powerpc/platforms/built-in.o: In function `.thermal_init':
cbe_thermal.c:(.init.text+0x4120): undefined reference to `.spu_add_sysdev_attr_group'
arch/powerpc/platforms/built-in.o: In function `.thermal_exit':
cbe_thermal.c:(.exit.text+0x18): undefined reference to `.spu_remove_sysdev_attr_group'
arch/powerpc/oprofile/built-in.o: In function `.get_cached_info':
spu_task_sync.c:(.text+0x4b6c): undefined reference to `.spu_get_profile_private_kref'
arch/powerpc/oprofile/built-in.o: In function `.spu_active_notify':
spu_task_sync.c:(.text+0x4ec0): undefined reference to `.spu_set_profile_private_kref'
arch/powerpc/oprofile/built-in.o: In function `.spu_sync_start':
(.text+0x5470): undefined reference to `.spu_switch_event_register'
arch/powerpc/oprofile/built-in.o: In function `.spu_sync_stop':
(.text+0x55bc): undefined reference to `.spu_switch_event_unregister'
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [sub-make] Error 2
