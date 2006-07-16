Return-Path: <ammubhai@gmail.com>
Received: from mailgw.cs.york.ac.uk (mailgw.cs.york.ac.uk [144.32.40.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1D93867B7C
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Jul 2006 19:43:31 +1000 (EST)
Message-ID: <44BA09A1.50908@gmail.com>
Date: Sun, 16 Jul 2006 10:40:49 +0100
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
To: Ming Liu <eemingliu@hotmail.com>
Subject: Re: some problems on the SystemACE driver.
References: <BAY110-F25F8A5EDC3636ADA072960B26F0@phx.gbl>
In-Reply-To: <BAY110-F25F8A5EDC3636ADA072960B26F0@phx.gbl>
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Ming,
   I know this might be very tedious for you. But its the same for me
especially when there is no need for me to do it. Anyway, could please
do a fresh start: untar linux kernel, apply all the TEMAC patches and
then apply my only 1 xx-after-TEMAC.patch

I have updated the patch. Make sure you download the new one.

The key is: When you compile this time the file xbasic_types.c in
drivers/bloxk/xilinx_sysace/ should not be compiled.

i.e.
>  CC      drivers/block/xilinx_sysace/xbasic_types.o
should not be shown!
Send a fresh log if this doesnot work!

-Ameet

Ming Liu wrote:
> Dear Ameet,
> Here is the normal log without -d when make zImage. Please check it. 
> Waiting for your result. Have fun in the weekend. :)
> 
>> I appreciate you testing the patch. Don't worry... we will solve it. And
>> I am not an expert either... you probably know more than me!
> 
> Thanks for your encouraging. Let's do it! Hopefully we can finish it 
> a.s.a.p. Good luck for us! 
> Regards
> Ming
> 
> _________________________________________________________________
> 享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
>  CHK     include/linux/version.h
>  HOSTCC  scripts/basic/fixdep
>  HOSTCC  scripts/basic/split-include
>  HOSTCC  scripts/basic/docproc
>  HOSTCC  scripts/kconfig/conf.o
>  HOSTCC  scripts/kconfig/kxgettext.o
>  HOSTCC  scripts/kconfig/mconf.o
>  HOSTCC  scripts/kconfig/zconf.tab.o
>  HOSTLD  scripts/kconfig/conf
> scripts/kconfig/conf -s arch/ppc/Kconfig
> #
> # using defaults found in .config
> #
>  SPLIT   include/linux/autoconf.h -> include/config/*
>  CC      arch/ppc/kernel/asm-offsets.s
>  GEN     include/asm-ppc/asm-offsets.h
>  HOSTCC  scripts/kallsyms
>  HOSTCC  scripts/conmakehash
>  CC      init/main.o
>  CHK     include/linux/compile.h
>  UPD     include/linux/compile.h
>  CC      init/version.o
>  CC      init/do_mounts.o
>  LD      init/mounts.o
>  CC      init/initramfs.o
>  CC      init/calibrate.o
>  LD      init/built-in.o
>  HOSTCC  usr/gen_init_cpio
>  GEN     usr/initramfs_data.cpio.gz
>  AS      usr/initramfs_data.o
>  LD      usr/built-in.o
>  AS      arch/ppc/kernel/entry.o
>  CC      arch/ppc/kernel/traps.o
>  CC      arch/ppc/kernel/time.o
>  AS      arch/ppc/kernel/misc.o
>  CC      arch/ppc/kernel/setup.o
>  CC      arch/ppc/kernel/ppc_htab.o
>  CC      arch/ppc/kernel/dma-mapping.o
>  LD      arch/ppc/kernel/built-in.o
>  AS      arch/ppc/kernel/head_4xx.o
>  LDS     arch/ppc/kernel/vmlinux.lds
>  CC      arch/powerpc/kernel/semaphore.o
>  CC      arch/powerpc/kernel/cputable.o
>  CC      arch/powerpc/kernel/ptrace.o
>  CC      arch/powerpc/kernel/syscalls.o
>  CC      arch/powerpc/kernel/irq.o
>  CC      arch/powerpc/kernel/align.o
>  CC      arch/powerpc/kernel/signal_32.o
>  CC      arch/powerpc/kernel/pmc.o
>  CC      arch/powerpc/kernel/vdso.o
>  CC      arch/powerpc/kernel/init_task.o
>  CC      arch/powerpc/kernel/process.o
>  AS      arch/powerpc/kernel/systbl.o
>  CC      arch/powerpc/kernel/idle.o
>  LDS     arch/powerpc/kernel/vdso32/vdso32.lds
>  VDSO32A arch/powerpc/kernel/vdso32/sigtramp.o
>  VDSO32A arch/powerpc/kernel/vdso32/gettimeofday.o
>  VDSO32A arch/powerpc/kernel/vdso32/datapage.o
>  VDSO32A arch/powerpc/kernel/vdso32/cacheflush.o
>  VDSO32A arch/powerpc/kernel/vdso32/note.o
>  VDSO32L arch/powerpc/kernel/vdso32/vdso32.so
>  AS      arch/powerpc/kernel/vdso32/vdso32_wrapper.o
>  LD      arch/powerpc/kernel/vdso32/built-in.o
>  LD      arch/powerpc/kernel/built-in.o
>  LD      arch/ppc/platforms/built-in.o
>  CC      arch/ppc/mm/fault.o
>  CC      arch/ppc/mm/init.o
>  CC      arch/ppc/mm/mem_pieces.o
>  CC      arch/ppc/mm/mmu_context.o
>  CC      arch/ppc/mm/pgtable.o
>  CC      arch/ppc/mm/4xx_mmu.o
>  LD      arch/ppc/mm/built-in.o
>  AS      arch/ppc/lib/checksum.o
>  AS      arch/ppc/lib/string.o
>  CC      arch/ppc/lib/strcase.o
>  AS      arch/ppc/lib/div64.o
>  LD      arch/ppc/lib/built-in.o
>  CC      arch/ppc/syslib/xilinx_pic.o
>  CC      arch/ppc/syslib/ppc_sys.o
>  CC      arch/ppc/syslib/ppc4xx_setup.o
>  LD      arch/ppc/syslib/built-in.o
>  AS      arch/powerpc/sysdev/dcr.o
>  LD      arch/powerpc/sysdev/built-in.o
>  CC      arch/powerpc/lib/bitops.o
>  LD      arch/powerpc/lib/built-in.o
>  CC      arch/ppc/platforms/4xx/xilinx_ml403.o
>  CC      arch/ppc/platforms/4xx/virtex.o
>  LD      arch/ppc/platforms/4xx/built-in.o
>  CC      arch/powerpc/math-emu/math.o
> arch/powerpc/math-emu/math.c:56: warning: conflicting types for built-in 
> function 'fabs'
>  CC      arch/powerpc/math-emu/fmr.o
>  CC      arch/powerpc/math-emu/lfd.o
>  CC      arch/powerpc/math-emu/stfd.o
>  CC      arch/powerpc/math-emu/fabs.o
> arch/powerpc/math-emu/fabs.c:7: warning: conflicting types for built-in 
> function 'fabs'
>  CC      arch/powerpc/math-emu/fadd.o
> arch/powerpc/math-emu/fadd.c: In function `fadd':
> arch/powerpc/math-emu/fadd.c:31: warning: right shift count is negative
> arch/powerpc/math-emu/fadd.c:31: warning: left shift count >= width of type
> arch/powerpc/math-emu/fadd.c:13: warning: 'R_e' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fadd.c:13: warning: 'R_f0' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fadd.c:13: warning: 'R_f1' might be used 
> uninitialized in this function
>  CC      arch/powerpc/math-emu/fadds.o
> arch/powerpc/math-emu/fadds.c: In function `fadds':
> arch/powerpc/math-emu/fadds.c:32: warning: right shift count is negative
> arch/powerpc/math-emu/fadds.c:32: warning: left shift count >= width of 
> type
> arch/powerpc/math-emu/fadds.c:14: warning: 'R_e' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fadds.c:14: warning: 'R_f0' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fadds.c:14: warning: 'R_f1' might be used 
> uninitialized in this function
>  CC      arch/powerpc/math-emu/fcmpo.o
>  CC      arch/powerpc/math-emu/fcmpu.o
>  CC      arch/powerpc/math-emu/fctiw.o
> arch/powerpc/math-emu/fctiw.c: In function `fctiw':
> arch/powerpc/math-emu/fctiw.c:15: warning: left shift count >= width of 
> type
> arch/powerpc/math-emu/fctiw.c:15: warning: left shift count >= width of 
> type
> arch/powerpc/math-emu/fctiw.c:12: warning: 'r' might be used 
> uninitialized in this function
>  CC      arch/powerpc/math-emu/fctiwz.o
> arch/powerpc/math-emu/fctiwz.c: In function `fctiwz':
> arch/powerpc/math-emu/fctiwz.c:20: warning: left shift count >= width of 
> type
> arch/powerpc/math-emu/fctiwz.c:20: warning: left shift count >= width of 
> type
> arch/powerpc/math-emu/fctiwz.c:13: warning: 'r' might be used 
> uninitialized in this function
>  CC      arch/powerpc/math-emu/fdiv.o
> arch/powerpc/math-emu/fdiv.c: In function `fdiv':
> arch/powerpc/math-emu/fdiv.c:46: warning: left shift count is negative
> arch/powerpc/math-emu/fdiv.c:13: warning: 'R_e' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fdiv.c:13: warning: 'R_f0' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fdiv.c:13: warning: 'R_f1' might be used 
> uninitialized in this function
>  CC      arch/powerpc/math-emu/fdivs.o
> arch/powerpc/math-emu/fdivs.c: In function `fdivs':
> arch/powerpc/math-emu/fdivs.c:48: warning: left shift count is negative
> arch/powerpc/math-emu/fdivs.c:14: warning: 'R_e' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fdivs.c:14: warning: 'R_f0' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fdivs.c:14: warning: 'R_f1' might be used 
> uninitialized in this function
>  CC      arch/powerpc/math-emu/fmadd.o
> arch/powerpc/math-emu/fmadd.c: In function `fmadd':
> arch/powerpc/math-emu/fmadd.c:36: warning: right shift count is negative
> arch/powerpc/math-emu/fmadd.c:36: warning: left shift count >= width of 
> type
> arch/powerpc/math-emu/fmadd.c:41: warning: right shift count is negative
> arch/powerpc/math-emu/fmadd.c:41: warning: left shift count >= width of 
> type
> arch/powerpc/math-emu/fmadd.c:11: warning: 'R_e' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fmadd.c:11: warning: 'R_f0' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fmadd.c:11: warning: 'R_f1' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fmadd.c:15: warning: 'T_e' might be used 
> uninitialized in this function
>  CC      arch/powerpc/math-emu/fmadds.o
> arch/powerpc/math-emu/fmadds.c: In function `fmadds':
> arch/powerpc/math-emu/fmadds.c:37: warning: right shift count is negative
> arch/powerpc/math-emu/fmadds.c:37: warning: left shift count >= width of 
> type
> arch/powerpc/math-emu/fmadds.c:42: warning: right shift count is negative
> arch/powerpc/math-emu/fmadds.c:42: warning: left shift count >= width of 
> type
> arch/powerpc/math-emu/fmadds.c:12: warning: 'R_e' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fmadds.c:12: warning: 'R_f0' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fmadds.c:12: warning: 'R_f1' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fmadds.c:16: warning: 'T_e' might be used 
> uninitialized in this function
>  CC      arch/powerpc/math-emu/fmsub.o
> arch/powerpc/math-emu/fmsub.c: In function `fmsub':
> arch/powerpc/math-emu/fmsub.c:36: warning: right shift count is negative
> arch/powerpc/math-emu/fmsub.c:36: warning: left shift count >= width of 
> type
> arch/powerpc/math-emu/fmsub.c:44: warning: right shift count is negative
> arch/powerpc/math-emu/fmsub.c:44: warning: left shift count >= width of 
> type
> arch/powerpc/math-emu/fmsub.c:11: warning: 'R_e' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fmsub.c:11: warning: 'R_f0' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fmsub.c:11: warning: 'R_f1' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fmsub.c:15: warning: 'T_e' might be used 
> uninitialized in this function
>  CC      arch/powerpc/math-emu/fmsubs.o
> arch/powerpc/math-emu/fmsubs.c: In function `fmsubs':
> arch/powerpc/math-emu/fmsubs.c:37: warning: right shift count is negative
> arch/powerpc/math-emu/fmsubs.c:37: warning: left shift count >= width of 
> type
> arch/powerpc/math-emu/fmsubs.c:45: warning: right shift count is negative
> arch/powerpc/math-emu/fmsubs.c:45: warning: left shift count >= width of 
> type
> arch/powerpc/math-emu/fmsubs.c:12: warning: 'R_e' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fmsubs.c:12: warning: 'R_f0' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fmsubs.c:12: warning: 'R_f1' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fmsubs.c:16: warning: 'T_e' might be used 
> uninitialized in this function
>  CC      arch/powerpc/math-emu/fmul.o
> arch/powerpc/math-emu/fmul.c: In function `fmul':
> arch/powerpc/math-emu/fmul.c:34: warning: right shift count is negative
> arch/powerpc/math-emu/fmul.c:34: warning: left shift count >= width of type
> arch/powerpc/math-emu/fmul.c:13: warning: 'R_e' might be used 
> uninitialized in this function
>  CC      arch/powerpc/math-emu/fmuls.o
> arch/powerpc/math-emu/fmuls.c: In function `fmuls':
> arch/powerpc/math-emu/fmuls.c:35: warning: right shift count is negative
> arch/powerpc/math-emu/fmuls.c:35: warning: left shift count >= width of 
> type
> arch/powerpc/math-emu/fmuls.c:14: warning: 'R_e' might be used 
> uninitialized in this function
>  CC      arch/powerpc/math-emu/fnabs.o
>  CC      arch/powerpc/math-emu/fneg.o
>  CC      arch/powerpc/math-emu/types.o
> arch/powerpc/math-emu/types.c: In function `fp_unpack_d':
> arch/powerpc/math-emu/types.c:13: warning: left shift count is negative
> arch/powerpc/math-emu/types.c: In function `fp_pack_d':
> arch/powerpc/math-emu/types.c:28: warning: right shift count is negative
> arch/powerpc/math-emu/types.c:28: warning: right shift count is negative
> arch/powerpc/math-emu/types.c:28: warning: left shift count is negative
> arch/powerpc/math-emu/types.c:28: warning: right shift count is negative
> arch/powerpc/math-emu/types.c: In function `fp_pack_ds':
> arch/powerpc/math-emu/types.c:41: warning: right shift count is negative
> arch/powerpc/math-emu/types.c:45: warning: left shift count is negative
> arch/powerpc/math-emu/types.c:46: warning: right shift count is negative
> arch/powerpc/math-emu/types.c:46: warning: right shift count is negative
> arch/powerpc/math-emu/types.c:46: warning: left shift count is negative
> arch/powerpc/math-emu/types.c:46: warning: right shift count is negative
>  CC      arch/powerpc/math-emu/fnmadd.o
> arch/powerpc/math-emu/fnmadd.c: In function `fnmadd':
> arch/powerpc/math-emu/fnmadd.c:36: warning: right shift count is negative
> arch/powerpc/math-emu/fnmadd.c:36: warning: left shift count >= width of 
> type
> arch/powerpc/math-emu/fnmadd.c:41: warning: right shift count is negative
> arch/powerpc/math-emu/fnmadd.c:41: warning: left shift count >= width of 
> type
> arch/powerpc/math-emu/fnmadd.c:11: warning: 'R_e' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fnmadd.c:11: warning: 'R_f0' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fnmadd.c:11: warning: 'R_f1' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fnmadd.c:15: warning: 'T_e' might be used 
> uninitialized in this function
>  CC      arch/powerpc/math-emu/fnmadds.o
> arch/powerpc/math-emu/fnmadds.c: In function `fnmadds':
> arch/powerpc/math-emu/fnmadds.c:37: warning: right shift count is negative
> arch/powerpc/math-emu/fnmadds.c:37: warning: left shift count >= width 
> of type
> arch/powerpc/math-emu/fnmadds.c:42: warning: right shift count is negative
> arch/powerpc/math-emu/fnmadds.c:42: warning: left shift count >= width 
> of type
> arch/powerpc/math-emu/fnmadds.c:12: warning: 'R_e' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fnmadds.c:12: warning: 'R_f0' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fnmadds.c:12: warning: 'R_f1' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fnmadds.c:16: warning: 'T_e' might be used 
> uninitialized in this function
>  CC      arch/powerpc/math-emu/fnmsub.o
> arch/powerpc/math-emu/fnmsub.c: In function `fnmsub':
> arch/powerpc/math-emu/fnmsub.c:36: warning: right shift count is negative
> arch/powerpc/math-emu/fnmsub.c:36: warning: left shift count >= width of 
> type
> arch/powerpc/math-emu/fnmsub.c:44: warning: right shift count is negative
> arch/powerpc/math-emu/fnmsub.c:44: warning: left shift count >= width of 
> type
> arch/powerpc/math-emu/fnmsub.c:11: warning: 'R_e' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fnmsub.c:11: warning: 'R_f0' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fnmsub.c:11: warning: 'R_f1' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fnmsub.c:15: warning: 'T_e' might be used 
> uninitialized in this function
>  CC      arch/powerpc/math-emu/fnmsubs.o
> arch/powerpc/math-emu/fnmsubs.c: In function `fnmsubs':
> arch/powerpc/math-emu/fnmsubs.c:37: warning: right shift count is negative
> arch/powerpc/math-emu/fnmsubs.c:37: warning: left shift count >= width 
> of type
> arch/powerpc/math-emu/fnmsubs.c:45: warning: right shift count is negative
> arch/powerpc/math-emu/fnmsubs.c:45: warning: left shift count >= width 
> of type
> arch/powerpc/math-emu/fnmsubs.c:12: warning: 'R_e' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fnmsubs.c:12: warning: 'R_f0' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fnmsubs.c:12: warning: 'R_f1' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fnmsubs.c:16: warning: 'T_e' might be used 
> uninitialized in this function
>  CC      arch/powerpc/math-emu/fres.o
>  CC      arch/powerpc/math-emu/frsp.o
>  CC      arch/powerpc/math-emu/frsqrte.o
>  CC      arch/powerpc/math-emu/fsel.o
>  CC      arch/powerpc/math-emu/lfs.o
> arch/powerpc/math-emu/lfs.c: In function `lfs':
> arch/powerpc/math-emu/lfs.c:30: warning: left shift count is negative
>  CC      arch/powerpc/math-emu/fsqrt.o
> arch/powerpc/math-emu/fsqrt.c: In function `fsqrt':
> arch/powerpc/math-emu/fsqrt.c:30: warning: left shift count is negative
> arch/powerpc/math-emu/fsqrt.c:30: warning: left shift count is negative
> arch/powerpc/math-emu/fsqrt.c:30: warning: left shift count is negative
> arch/powerpc/math-emu/fsqrt.c:30: warning: left shift count is negative
> arch/powerpc/math-emu/fsqrt.c:30: warning: right shift count is negative
> arch/powerpc/math-emu/fsqrt.c:12: warning: 'R_c' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fsqrt.c:12: warning: 'R_s' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fsqrt.c:12: warning: 'R_e' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fsqrt.c:12: warning: 'R_f0' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fsqrt.c:12: warning: 'R_f1' might be used 
> uninitialized in this function
>  CC      arch/powerpc/math-emu/fsqrts.o
> arch/powerpc/math-emu/fsqrts.c: In function `fsqrts':
> arch/powerpc/math-emu/fsqrts.c:31: warning: left shift count is negative
> arch/powerpc/math-emu/fsqrts.c:31: warning: left shift count is negative
> arch/powerpc/math-emu/fsqrts.c:31: warning: left shift count is negative
> arch/powerpc/math-emu/fsqrts.c:31: warning: left shift count is negative
> arch/powerpc/math-emu/fsqrts.c:31: warning: right shift count is negative
> arch/powerpc/math-emu/fsqrts.c:13: warning: 'R_c' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fsqrts.c:13: warning: 'R_s' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fsqrts.c:13: warning: 'R_e' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fsqrts.c:13: warning: 'R_f0' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fsqrts.c:13: warning: 'R_f1' might be used 
> uninitialized in this function
>  CC      arch/powerpc/math-emu/fsub.o
> arch/powerpc/math-emu/fsub.c: In function `fsub':
> arch/powerpc/math-emu/fsub.c:34: warning: right shift count is negative
> arch/powerpc/math-emu/fsub.c:34: warning: left shift count >= width of type
> arch/powerpc/math-emu/fsub.c:13: warning: 'R_e' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fsub.c:13: warning: 'R_f0' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fsub.c:13: warning: 'R_f1' might be used 
> uninitialized in this function
>  CC      arch/powerpc/math-emu/fsubs.o
> arch/powerpc/math-emu/fsubs.c: In function `fsubs':
> arch/powerpc/math-emu/fsubs.c:35: warning: right shift count is negative
> arch/powerpc/math-emu/fsubs.c:35: warning: left shift count >= width of 
> type
> arch/powerpc/math-emu/fsubs.c:14: warning: 'R_e' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fsubs.c:14: warning: 'R_f0' might be used 
> uninitialized in this function
> arch/powerpc/math-emu/fsubs.c:14: warning: 'R_f1' might be used 
> uninitialized in this function
>  CC      arch/powerpc/math-emu/mcrfs.o
>  CC      arch/powerpc/math-emu/mffs.o
>  CC      arch/powerpc/math-emu/mtfsb0.o
>  CC      arch/powerpc/math-emu/mtfsb1.o
>  CC      arch/powerpc/math-emu/mtfsf.o
>  CC      arch/powerpc/math-emu/mtfsfi.o
>  CC      arch/powerpc/math-emu/stfiwx.o
>  CC      arch/powerpc/math-emu/stfs.o
> arch/powerpc/math-emu/stfs.c: In function `stfs':
> arch/powerpc/math-emu/stfs.c:27: warning: right shift count is negative
>  CC      arch/powerpc/math-emu/udivmodti4.o
>  LD      arch/powerpc/math-emu/built-in.o
>  CC      kernel/sched.o
>  CC      kernel/fork.o
>  CC      kernel/exec_domain.o
>  CC      kernel/panic.o
>  CC      kernel/printk.o
>  CC      kernel/profile.o
>  CC      kernel/exit.o
>  CC      kernel/itimer.o
>  CC      kernel/time.o
>  CC      kernel/softirq.o
>  CC      kernel/resource.o
>  CC      kernel/sysctl.o
>  CC      kernel/capability.o
>  CC      kernel/ptrace.o
>  CC      kernel/timer.o
>  CC      kernel/user.o
>  CC      kernel/signal.o
>  CC      kernel/sys.o
>  CC      kernel/kmod.o
>  CC      kernel/workqueue.o
>  CC      kernel/pid.o
>  CC      kernel/rcupdate.o
>  CC      kernel/extable.o
>  CC      kernel/params.o
>  CC      kernel/posix-timers.o
>  CC      kernel/kthread.o
>  CC      kernel/wait.o
>  CC      kernel/kfifo.o
>  CC      kernel/sys_ni.o
>  CC      kernel/posix-cpu-timers.o
>  CC      kernel/mutex.o
>  CC      kernel/hrtimer.o
>  CC      kernel/futex.o
>  CC      kernel/intermodule.o
>  CC      kernel/kallsyms.o
>  CC      kernel/ksysfs.o
>  CC      kernel/softlockup.o
>  CC      kernel/irq/handle.o
>  CC      kernel/irq/manage.o
>  CC      kernel/irq/spurious.o
>  CC      kernel/irq/proc.o
>  LD      kernel/irq/built-in.o
>  CC      kernel/seccomp.o
>  LD      kernel/built-in.o
>  CC      mm/bootmem.o
>  CC      mm/filemap.o
>  CC      mm/mempool.o
>  CC      mm/oom_kill.o
>  CC      mm/fadvise.o
>  CC      mm/page_alloc.o
>  CC      mm/page-writeback.o
>  CC      mm/pdflush.o
>  CC      mm/readahead.o
>  CC      mm/swap.o
>  CC      mm/truncate.o
>  CC      mm/vmscan.o
>  CC      mm/prio_tree.o
>  CC      mm/util.o
>  CC      mm/mmzone.o
>  CC      mm/fremap.o
>  CC      mm/highmem.o
>  CC      mm/madvise.o
>  CC      mm/memory.o
>  CC      mm/mincore.o
>  CC      mm/mlock.o
>  CC      mm/mmap.o
>  CC      mm/mprotect.o
>  CC      mm/mremap.o
>  CC      mm/msync.o
>  CC      mm/rmap.o
>  CC      mm/vmalloc.o
>  CC      mm/page_io.o
>  CC      mm/swap_state.o
>  CC      mm/swapfile.o
>  CC      mm/thrash.o
>  CC      mm/shmem.o
>  CC      mm/slab.o
>  CC      mm/filemap_xip.o
>  LD      mm/built-in.o
>  CC      fs/open.o
>  CC      fs/read_write.o
>  CC      fs/file_table.o
>  CC      fs/buffer.o
>  CC      fs/bio.o
>  CC      fs/super.o
>  CC      fs/block_dev.o
>  CC      fs/char_dev.o
>  CC      fs/stat.o
>  CC      fs/exec.o
>  CC      fs/pipe.o
>  CC      fs/namei.o
>  CC      fs/fcntl.o
>  CC      fs/ioctl.o
>  CC      fs/readdir.o
>  CC      fs/select.o
>  CC      fs/fifo.o
>  CC      fs/locks.o
>  CC      fs/dcache.o
>  CC      fs/inode.o
>  CC      fs/attr.o
>  CC      fs/bad_inode.o
>  CC      fs/file.o
>  CC      fs/filesystems.o
>  CC      fs/namespace.o
>  CC      fs/aio.o
>  CC      fs/seq_file.o
>  CC      fs/xattr.o
>  CC      fs/libfs.o
>  CC      fs/fs-writeback.o
>  CC      fs/mpage.o
>  CC      fs/direct-io.o
>  CC      fs/ioprio.o
>  CC      fs/pnode.o
>  CC      fs/drop_caches.o
>  CC      fs/splice.o
>  CC      fs/sync.o
>  CC      fs/inotify.o
>  CC      fs/eventpoll.o
>  CC      fs/binfmt_script.o
>  CC      fs/binfmt_elf.o
>  CC      fs/mbcache.o
>  CC      fs/posix_acl.o
>  CC      fs/xattr_acl.o
>  CC      fs/dnotify.o
>  CC      fs/autofs/dirhash.o
>  CC      fs/autofs/init.o
>  CC      fs/autofs/inode.o
>  CC      fs/autofs/root.o
>  CC      fs/autofs/symlink.o
>  CC      fs/autofs/waitq.o
>  LD      fs/autofs/autofs.o
>  LD      fs/autofs/built-in.o
>  CC      fs/autofs4/init.o
>  CC      fs/autofs4/inode.o
>  CC      fs/autofs4/root.o
>  CC      fs/autofs4/symlink.o
>  CC      fs/autofs4/waitq.o
>  CC      fs/autofs4/expire.o
>  LD      fs/autofs4/autofs4.o
>  LD      fs/autofs4/built-in.o
>  CC      fs/devpts/inode.o
>  LD      fs/devpts/devpts.o
>  LD      fs/devpts/built-in.o
>  CC      fs/ext2/balloc.o
>  CC      fs/ext2/bitmap.o
>  CC      fs/ext2/dir.o
>  CC      fs/ext2/file.o
>  CC      fs/ext2/fsync.o
>  CC      fs/ext2/ialloc.o
>  CC      fs/ext2/inode.o
>  CC      fs/ext2/ioctl.o
>  CC      fs/ext2/namei.o
>  CC      fs/ext2/super.o
>  CC      fs/ext2/symlink.o
>  CC      fs/ext2/xattr.o
>  CC      fs/ext2/xattr_user.o
>  CC      fs/ext2/xattr_trusted.o
>  CC      fs/ext2/acl.o
>  CC      fs/ext2/xattr_security.o
>  CC      fs/ext2/xip.o
>  LD      fs/ext2/ext2.o
>  LD      fs/ext2/built-in.o
>  CC      fs/nls/nls_base.o
>  LD      fs/nls/built-in.o
>  CC      fs/partitions/check.o
>  CC      fs/partitions/msdos.o
>  LD      fs/partitions/built-in.o
>  CC      fs/proc/mmu.o
>  CC      fs/proc/task_mmu.o
>  CC      fs/proc/inode.o
>  CC      fs/proc/root.o
>  CC      fs/proc/base.o
>  CC      fs/proc/generic.o
>  CC      fs/proc/array.o
>  CC      fs/proc/kmsg.o
>  CC      fs/proc/proc_tty.o
>  CC      fs/proc/proc_misc.o
>  CC      fs/proc/kcore.o
>  LD      fs/proc/proc.o
>  LD      fs/proc/built-in.o
>  CC      fs/ramfs/inode.o
>  CC      fs/ramfs/file-mmu.o
>  LD      fs/ramfs/ramfs.o
>  LD      fs/ramfs/built-in.o
>  CC      fs/sysfs/inode.o
>  CC      fs/sysfs/file.o
>  CC      fs/sysfs/dir.o
>  CC      fs/sysfs/symlink.o
>  CC      fs/sysfs/mount.o
>  CC      fs/sysfs/bin.o
>  CC      fs/sysfs/group.o
>  LD      fs/sysfs/built-in.o
>  LD      fs/built-in.o
>  CC      ipc/util.o
>  CC      ipc/msgutil.o
>  CC      ipc/msg.o
>  CC      ipc/sem.o
>  CC      ipc/shm.o
>  LD      ipc/built-in.o
>  CC      security/commoncap.o
>  LD      security/built-in.o
>  LD      crypto/built-in.o
>  CC      block/elevator.o
>  CC      block/ll_rw_blk.o
>  CC      block/ioctl.o
>  CC      block/genhd.o
>  CC      block/scsi_ioctl.o
>  CC      block/noop-iosched.o
>  CC      block/as-iosched.o
>  CC      block/deadline-iosched.o
>  CC      block/cfq-iosched.o
>  LD      block/built-in.o
>  CC      drivers/base/core.o
>  CC      drivers/base/sys.o
>  CC      drivers/base/bus.o
>  CC      drivers/base/dd.o
>  CC      drivers/base/driver.o
>  CC      drivers/base/class.o
>  CC      drivers/base/platform.o
>  CC      drivers/base/cpu.o
>  CC      drivers/base/firmware.o
>  CC      drivers/base/init.o
>  CC      drivers/base/map.o
>  CC      drivers/base/dmapool.o
>  CC      drivers/base/attribute_container.o
>  CC      drivers/base/transport_class.o
>  CC      drivers/base/power/shutdown.o
>  LD      drivers/base/power/built-in.o
>  LD      drivers/base/built-in.o
>  CC      drivers/block/loop.o
>  CC      drivers/block/xilinx_sysace/adapter.o
> drivers/block/xilinx_sysace/adapter.c:221: warning: 'xsysace_restart' 
> defined but not used
>  CC      drivers/block/xilinx_sysace/xbasic_types.o
>  CC      drivers/block/xilinx_sysace/xsysace.o
>  CC      drivers/block/xilinx_sysace/xsysace_g.o
>  CC      drivers/block/xilinx_sysace/xsysace_intr.o
>  CC      drivers/block/xilinx_sysace/xsysace_l.o
>  CC      drivers/block/xilinx_sysace/xsysace_compactflash.o
>  CC      drivers/block/xilinx_sysace/xsysace_jtagcfg.o
>  LD      drivers/block/xilinx_sysace/xilinx_sysace.o
>  LD      drivers/block/xilinx_sysace/built-in.o
>  LD      drivers/block/built-in.o
>  LD      drivers/cdrom/built-in.o
>  CC      drivers/char/mem.o
>  CC      drivers/char/random.o
>  CC      drivers/char/tty_io.o
>  CC      drivers/char/n_tty.o
>  CC      drivers/char/tty_ioctl.o
>  CC      drivers/char/pty.o
>  CC      drivers/char/misc.o
>  CC      drivers/char/vt_ioctl.o
>  CC      drivers/char/vc_screen.o
>  CC      drivers/char/consolemap.o
>  CONMK   drivers/char/consolemap_deftbl.c
>  CC      drivers/char/consolemap_deftbl.o
>  CC      drivers/char/selection.o
>  CC      drivers/char/keyboard.o
>  CC      drivers/char/vt.o
>  SHIPPED drivers/char/defkeymap.c
>  CC      drivers/char/defkeymap.o
>  LD      drivers/char/built-in.o
>  LD      drivers/firmware/built-in.o
>  CC      drivers/hwmon/hwmon.o
>  LD      drivers/hwmon/built-in.o
>  CC      drivers/input/input.o
>  CC      drivers/input/mousedev.o
>  LD      drivers/input/built-in.o
>  CC      drivers/input/serio/serio.o
>  CC      drivers/input/serio/i8042.o
>  CC      drivers/input/serio/serport.o
>  LD      drivers/input/serio/built-in.o
>  LD      drivers/media/common/built-in.o
>  LD      drivers/media/built-in.o
>  LD      drivers/mfd/built-in.o
>  LD      drivers/misc/built-in.o
>  CC      drivers/mtd/mtdcore.o
>  CC      drivers/mtd/mtdpart.o
>  CC      drivers/mtd/redboot.o
> drivers/mtd/redboot.c: In function `parse_redboot_partitions':
> drivers/mtd/redboot.c:103: warning: passing arg 1 of `__swab32s' from 
> incompatible pointer type
> drivers/mtd/redboot.c:104: warning: passing arg 1 of `__swab32s' from 
> incompatible pointer type
> drivers/mtd/redboot.c:105: warning: passing arg 1 of `__swab32s' from 
> incompatible pointer type
> drivers/mtd/redboot.c:106: warning: passing arg 1 of `__swab32s' from 
> incompatible pointer type
> drivers/mtd/redboot.c:107: warning: passing arg 1 of `__swab32s' from 
> incompatible pointer type
> drivers/mtd/redboot.c:108: warning: passing arg 1 of `__swab32s' from 
> incompatible pointer type
> drivers/mtd/redboot.c:109: warning: passing arg 1 of `__swab32s' from 
> incompatible pointer type
>  CC      drivers/mtd/mtdchar.o
>  CC      drivers/mtd/mtdblock.o
>  CC      drivers/mtd/mtd_blkdevs.o
>  CC      drivers/mtd/chips/chipreg.o
>  CC      drivers/mtd/chips/cfi_probe.o
>  CC      drivers/mtd/chips/cfi_util.o
>  CC      drivers/mtd/chips/cfi_cmdset_0002.o
> drivers/mtd/chips/cfi_cmdset_0002.c: In function `cfi_amdstd_init':
> drivers/mtd/chips/cfi_cmdset_0002.c:1766: warning: 
> `inter_module_register' is deprecated (declared at 
> include/linux/module.h:563)
> drivers/mtd/chips/cfi_cmdset_0002.c: In function `cfi_amdstd_exit':
> drivers/mtd/chips/cfi_cmdset_0002.c:1773: warning: 
> `inter_module_unregister' is deprecated (declared at 
> include/linux/module.h:564)
>  CC      drivers/mtd/chips/gen_probe.o
>  LD      drivers/mtd/chips/built-in.o
>  LD      drivers/mtd/devices/built-in.o
>  LD      drivers/mtd/maps/built-in.o
>  LD      drivers/mtd/nand/built-in.o
>  LD      drivers/mtd/onenand/built-in.o
>  LD      drivers/mtd/built-in.o
>  CC      drivers/net/Space.o
>  CC      drivers/net/loopback.o
>  CC      drivers/net/xilinx_temac/adapter.o
>  CC      drivers/net/xilinx_temac/xtemac.o
>  CC      drivers/net/xilinx_temac/xtemac_intr.o
>  CC      drivers/net/xilinx_temac/xtemac_intr_sgdma.o
>  CC      drivers/net/xilinx_temac/xtemac_sgdma.o
>  CC      drivers/net/xilinx_temac/xtemac_intr_fifo.o
>  CC      drivers/net/xilinx_temac/xtemac_fifo.o
>  CC      drivers/net/xilinx_temac/xtemac_l.o
>  CC      drivers/net/xilinx_temac/xtemac_control.o
>  LD      drivers/net/xilinx_temac/xilinx_temac.o
>  LD      drivers/net/xilinx_temac/built-in.o
>  LD      drivers/net/built-in.o
>  CC      drivers/serial/serial_core.o
>  CC      drivers/serial/8250.o
>  CC      drivers/serial/8250_early.o
>  LD      drivers/serial/built-in.o
>  LD      drivers/video/backlight/built-in.o
>  CC      drivers/video/console/dummycon.o
>  LD      drivers/video/console/built-in.o
>  LD      drivers/video/built-in.o
>  CC      drivers/xilinx_edk/xilinx_syms.o
>  CC      drivers/xilinx_edk/xbasic_types.o
>  CC      drivers/xilinx_edk/xpacket_fifo_v2_00_a.o
>  CC      drivers/xilinx_edk/xpacket_fifo_l_v2_00_a.o
>  CC      drivers/xilinx_edk/xdmav2.o
>  CC      drivers/xilinx_edk/xdmav2_intr.o
>  CC      drivers/xilinx_edk/xdmav2_sg.o
>  CC      drivers/xilinx_edk/xdmav2_simple.o
>  LD      drivers/xilinx_edk/built-in.o
>  LD      drivers/built-in.o
> drivers/xilinx_edk/built-in.o(.sdata+0x0): In function `XAssert':
> drivers/xilinx_edk/xbasic_types.c:105: multiple definition of 
> `XWaitInAssert'
> drivers/block/built-in.o(.sdata+0x0):drivers/block/loop.c:91: first 
> defined here
> drivers/xilinx_edk/built-in.o(.sbss+0x4): In function `XAssert':
> drivers/xilinx_edk/xbasic_types.c:105: multiple definition of 
> `XAssertStatus'
> drivers/block/built-in.o(.sbss+0x38):drivers/block/loop.c:98: first 
> defined here
> drivers/xilinx_edk/built-in.o(.text+0x44): In function 
> `XAssertSetCallback':
> drivers/xilinx_edk/xbasic_types.c:134: multiple definition of 
> `XAssertSetCallback'
> drivers/block/built-in.o(.text+0x24bc):drivers/block/xilinx_sysace/xbasic_types.c:134: 
> first defined here
> drivers/xilinx_edk/built-in.o(.text+0x0): In function `XAssert':
> drivers/xilinx_edk/xbasic_types.c:105: multiple definition of `XAssert'
> drivers/block/built-in.o(.text+0x2478):drivers/block/xilinx_sysace/xbasic_types.c:105: 
> first defined here
> drivers/xilinx_edk/built-in.o(.text+0x50): In function `XNullHandler':
> drivers/xilinx_edk/xbasic_types.c:153: multiple definition of 
> `XNullHandler'
> drivers/block/built-in.o(.text+0x24c8):drivers/block/xilinx_sysace/xbasic_types.c:153: 
> first defined here
> make[1]: *** [drivers/built-in.o] Error 1
> make: *** [drivers] Error 2
> 
