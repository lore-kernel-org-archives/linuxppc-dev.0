Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B40092C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Aug 2013 02:45:58 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sat, 10 Aug 2013 10:45:55 -0600
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 30A9738C8027
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Aug 2013 12:45:51 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7AGjqaS116382
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Aug 2013 12:45:52 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7AGjp0D010115
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Aug 2013 12:45:51 -0400
Date: Sat, 10 Aug 2013 09:45:27 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Build errors on mainline kernel
Message-ID: <20130810164526.GA11718@us.ibm.com>
References: <20130809182446.GA26711@us.ibm.com>
 <EA801718-CA2E-4F85-AF6B-29119911038E@kernel.crashing.org>
 <20130810010119.GA29407__43692.6458766267$1376096568$gmane$org@us.ibm.com>
 <m2y58axbi8.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m2y58axbi8.fsf@linux-m68k.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andreas Schwab [schwab@linux-m68k.org] wrote:
| Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
| 
| > {standard input}: Assembler messages:
| > {standard input}:244: Error: junk at end of line: `1'
| > make[2]: *** [arch/powerpc/platforms/85xx/smp.o] Error 1
| > make[1]: *** [arch/powerpc/platforms/85xx/smp.o] Error 2
| > make: *** [sub-make] Error 2
| 
| Run "make arch/powerpc/platforms/85xx/smp.s" to create the assembler
| file.

Ok. Here are few lines around 244, the whole file is below. I can't
find the junk '1'. There is a '1' at EOL on 240 but that is also
on several lines in the file.

	239 #APP
	240  # 161 "/root/tmp/linux.git/arch/powerpc/include/asm/io.h" 1
	241         sync;lwz 0,112(9);twi 0,0,0;isync        #, tmp171
	242  # 0 "" 2
	243 #NO_APP
	244         cmpdi 7,31,0     #, tmp172, flags
	245         beq 7,.L23       #
	246         bl .trace_hardirqs_on    #
	247         nop
	248         mr 3,31  #, flags
	249         bl .arch_local_irq_restore       #
	250         nop

---
	.file	"smp.c"

 # rs6000/powerpc options: -mcpu=power4 -mtune=power7 -msdata=none
	.section	".toc","aw"
	.section	".text"
 # GNU C (GCC) version 4.4.6 20120305 (Red Hat 4.4.6-4) (ppc64-redhat-linux)
 #	compiled by GNU C version 4.4.6 20120305 (Red Hat 4.4.6-4), GMP version 4.3.1, MPFR version 2.4.1.
 # GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
 # options passed:  -nostdinc -I/root/tmp/linux.git/arch/powerpc/include
 # -Iarch/powerpc/include/generated -I/root/tmp/linux.git/include -Iinclude
 # -I/root/tmp/linux.git/arch/powerpc/include/uapi
 # -Iarch/powerpc/include/generated/uapi -I/root/tmp/linux.git/include/uapi
 # -Iinclude/generated/uapi
 # -I/root/tmp/linux.git/arch/powerpc/platforms/85xx
 # -Iarch/powerpc/platforms/85xx -I/root/tmp/linux.git/arch/powerpc
 # -Iarch/powerpc -I/root/tmp/linux.git/arch/powerpc -Iarch/powerpc
 # -D__unix__ -D__gnu_linux__ -D__linux__ -Dunix -D__unix -Dlinux -D__linux
 # -Asystem=linux -Asystem=unix -Asystem=posix -D__KERNEL__
 # -DCC_HAVE_ASM_GOTO -DKBUILD_STR(s)=#s -DKBUILD_BASENAME=KBUILD_STR(smp)
 # -DKBUILD_MODNAME=KBUILD_STR(smp) -isystem
 # /usr/lib/gcc/ppc64-redhat-linux/4.4.6/include -include
 # /root/tmp/linux.git/include/linux/kconfig.h -MD
 # arch/powerpc/platforms/85xx/.smp.s.d
 # /root/tmp/linux.git/arch/powerpc/platforms/85xx/smp.c -mbig -msecure-plt
 # -m64 -msoft-float -mtraceback=no -mcall-aixdesc -mcmodel=medium
 # -mtune=power7 -mno-altivec -mno-vsx -mno-spe -mspe=no -mno-string
 # -mcpu=power4 -auxbase-strip arch/powerpc/platforms/85xx/smp.s -O2 -Wall
 # -Wundef -Wstrict-prototypes -Wno-trigraphs
 # -Werror-implicit-function-declaration -Wno-format-security
 # -Wframe-larger-than=2048 -Wno-unused-but-set-variable
 # -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-aliasing
 # -fno-common -fno-delete-null-pointer-checks -funit-at-a-time
 # -fno-dwarf2-cfi-asm -fno-stack-protector -fomit-frame-pointer
 # -fno-strict-overflow -fconserve-stack -fverbose-asm
 # options enabled:  -falign-loops -fargument-alias -fauto-inc-dec
 # -fbranch-count-reg -fcaller-saves -fcprop-registers -fcrossjumping
 # -fcse-follow-jumps -fdefer-pop -fearly-inlining
 # -feliminate-unused-debug-types -fexpensive-optimizations
 # -fforward-propagate -ffunction-cse -fgcse -fgcse-lm
 # -fguess-branch-probability -fident -fif-conversion -fif-conversion2
 # -findirect-inlining -finline -finline-functions-called-once
 # -finline-small-functions -fipa-cp -fipa-pure-const -fipa-reference
 # -fira-share-save-slots -fira-share-spill-slots -fivopts
 # -fkeep-static-consts -fleading-underscore -fmath-errno -fmerge-constants
 # -fmerge-debug-strings -fmove-loop-invariants -fomit-frame-pointer
 # -foptimize-register-move -foptimize-sibling-calls -fpeephole -fpeephole2
 # -freg-struct-return -fregmove -freorder-blocks -freorder-functions
 # -frerun-cse-after-loop -fsched-interblock -fsched-spec
 # -fsched-stalled-insns-dep -fschedule-insns -fschedule-insns2
 # -fsection-anchors -fsigned-zeros -fsplit-ivs-in-unroller
 # -fsplit-wide-types -fthread-jumps -ftoplevel-reorder -ftrapping-math
 # -ftree-builtin-call-dce -ftree-ccp -ftree-ch -ftree-coalesce-vars
 # -ftree-copy-prop -ftree-copyrename -ftree-cselim -ftree-dce
 # -ftree-dominator-opts -ftree-dse -ftree-fre -ftree-loop-im
 # -ftree-loop-ivcanon -ftree-loop-optimize -ftree-parallelize-loops=
 # -ftree-pre -ftree-reassoc -ftree-scev-cprop -ftree-sink -ftree-sra
 # -ftree-switch-conversion -ftree-ter -ftree-vect-loop-version -ftree-vrp
 # -funit-at-a-time -fverbose-asm -fzero-initialized-in-bss -m64
 # -maix-struct-return -malign-branch-targets -malways-hint -mbig
 # -mbig-endian -mfp-in-toc -mfused-madd -mgen-cell-microcode -mglibc
 # -mmfcrf -mnew-mnemonics -mpowerpc -mpowerpc-gfxopt -mpowerpc-gpopt
 # -mpowerpc64 -msched-groups -msched-prolog -msecure-plt -msoft-float
 # -mupdate -mvectorize-builtins -mvrsave -mvsx-scalar-double

 # Compiler executable checksum: ada2cddef4477a14790d56c4372eb769

	.align 2
	.p2align 4,,15
	.section	".opd","aw"
	.align 3
mpc85xx_take_timebase:
	.quad	.mpc85xx_take_timebase,.TOC.@tocbase
	.previous
	.size	mpc85xx_take_timebase,24
	.type	.mpc85xx_take_timebase,@function
.mpc85xx_take_timebase:
	mflr 0	 #,
	std 31,-8(1)	 #,
	std 0,16(1)	 #,
	stdu 1,-128(1)	 #,,
#APP
 # 59 "/root/tmp/linux.git/arch/powerpc/include/asm/hw_irq.h" 1
	li 0,0; lbz 31,850(13); stb 0,850(13)	 # zero, flags,
 # 0 "" 2
#NO_APP
	bl .trace_hardirqs_off	 #
	nop
	addis 11,2,.LANCHOR0@toc@ha	 # tmp143,,
	addi 9,11,.LANCHOR0@toc@l	 # tmp144, tmp143,
	lwz 0,4(9)	 # tb_valid,
	cmpwi 7,0,0	 #, tmp128, tb_valid
	li 0,1	 # tmp124,
	stw 0,.LANCHOR0@toc@l(11)	 # tb_req, tmp124
	bne 7,.L2	 #
	.p2align 4,,15
.L7:
	lwz 0,4(9)	 # tb_valid,
	cmpwi 7,0,0	 #, tmp132, tb_valid
	beq 7,.L7	 #
.L2:
	ld 11,8(9)	 # timebase, timebase.511
	li 0,0	 # tmp135,
#APP
 # 131 "/root/tmp/linux.git/arch/powerpc/include/asm/time.h" 1
	mtspr 0x11C,0	 # tmp135
 # 0 "" 2
#NO_APP
	srdi 10,11,32	 # tmp137, timebase.511,
#APP
 # 132 "/root/tmp/linux.git/arch/powerpc/include/asm/time.h" 1
	mtspr 0x11D,10	 # tmp137
 # 0 "" 2
#NO_APP
	rldicl 11,11,0,32	 # timebase.511, timebase.511
#APP
 # 133 "/root/tmp/linux.git/arch/powerpc/include/asm/time.h" 1
	mtspr 0x11C,11	 # timebase.511
 # 0 "" 2
 # 25 "/root/tmp/linux.git/arch/powerpc/include/asm/synch.h" 1
	isync
 # 0 "" 2
#NO_APP
	cmpdi 7,31,0	 #, tmp142, flags
	stw 0,4(9)	 # tb_valid, tmp135
	beq 7,.L10	 #
	bl .trace_hardirqs_on	 #
	nop
	mr 3,31	 #, flags
	bl .arch_local_irq_restore	 #
	nop
	addi 1,1,128	 #,,
	ld 0,16(1)	 #,
	ld 31,-8(1)	 #,
	mtlr 0	 #,
	blr	 #
	.p2align 4,,15
.L10:
	li 3,0	 #,
	bl .arch_local_irq_restore	 #
	nop
	bl .trace_hardirqs_off	 #
	nop
	addi 1,1,128	 #,,
	ld 0,16(1)	 #,
	ld 31,-8(1)	 #,
	mtlr 0	 #,
	blr	 #
	.size	.mpc85xx_take_timebase,.-.mpc85xx_take_timebase
	.align 2
	.p2align 4,,15
	.section	".opd","aw"
	.align 3
mpc85xx_give_timebase:
	.quad	.mpc85xx_give_timebase,.TOC.@tocbase
	.previous
	.size	mpc85xx_give_timebase,24
	.type	.mpc85xx_give_timebase,@function
.mpc85xx_give_timebase:
	mflr 0	 #,
	std 31,-8(1)	 #,
	std 0,16(1)	 #,
	stdu 1,-128(1)	 #,,
#APP
 # 59 "/root/tmp/linux.git/arch/powerpc/include/asm/hw_irq.h" 1
	li 0,0; lbz 31,850(13); stb 0,850(13)	 # zero, flags,
 # 0 "" 2
#NO_APP
	bl .trace_hardirqs_off	 #
	nop
	addis 11,2,.LANCHOR0@toc@ha	 # tmp173,,
	lwz 0,.LANCHOR0@toc@l(11)	 # tb_req,
	cmpwi 7,0,0	 #, tmp135, tb_req
	bne 7,.L22	 #
	addi 9,11,.LANCHOR0@toc@l	 # tmp174, tmp173,
	.p2align 4,,15
.L13:
	lwz 0,0(9)	 # tb_req,
	cmpwi 7,0,0	 #, tmp139, tb_req
	beq 7,.L13	 #
.L12:
	li 0,0	 # tmp142,
	stw 0,.LANCHOR0@toc@l(11)	 # tb_req, tmp142
	ld 11,16(9)	 # guts, guts
#APP
 # 161 "/root/tmp/linux.git/arch/powerpc/include/asm/io.h" 1
	sync;lwz 0,112(11);twi 0,0,0;isync	 #, tmp146
 # 0 "" 2
#NO_APP
	ori 0,0,20480	 #, tmp147, tmp146,
	rldicl 0,0,0,32	 # D.32947, tmp147
#APP
 # 167 "/root/tmp/linux.git/arch/powerpc/include/asm/io.h" 1
	sync;stw 0,112(11)	 #, D.32947
 # 0 "" 2
#NO_APP
	li 0,1	 # tmp148,
	stb 0,852(13)	 # <variable>.io_sync, tmp148
	ld 11,16(9)	 # guts, guts
#APP
 # 161 "/root/tmp/linux.git/arch/powerpc/include/asm/io.h" 1
	sync;lwz 0,112(11);twi 0,0,0;isync	 #, tmp152
 # 0 "" 2
 # 107 "/root/tmp/linux.git/arch/powerpc/include/asm/time.h" 1
	mftb 0	 # rval
 # 0 "" 2
#NO_APP
	std 0,8(9)	 # timebase, rval
#APP
 # 73 "/root/tmp/linux.git/arch/powerpc/platforms/85xx/smp.c" 1
	sync
 # 0 "" 2
#NO_APP
	li 0,1	 # tmp157,
	mr 11,9	 # tmp177, tmp174
	stw 0,4(9)	 # tb_valid, tmp157
	.p2align 4,,15
.L14:
	lwz 0,4(9)	 # tb_valid,
	cmpwi 7,0,0	 #, tmp161, tb_valid
	bne 7,.L14	 #
	ld 9,16(11)	 # guts, guts
#APP
 # 161 "/root/tmp/linux.git/arch/powerpc/include/asm/io.h" 1
	sync;lwz 10,112(9);twi 0,10,0;isync	 #, tmp165
 # 0 "" 2
#NO_APP
	lis 0,0xffff	 # tmp166,
	ori 0,0,45055	 #, tmp166, tmp166,
	rldicl 0,0,0,32	 # tmp166, tmp166
	and 0,0,10	 # D.32963, tmp166, tmp165
#APP
 # 167 "/root/tmp/linux.git/arch/powerpc/include/asm/io.h" 1
	sync;stw 0,112(9)	 #, D.32963
 # 0 "" 2
#NO_APP
	li 0,1	 # tmp167,
	stb 0,852(13)	 # <variable>.io_sync, tmp167
	ld 9,16(11)	 # guts, guts
#APP
 # 161 "/root/tmp/linux.git/arch/powerpc/include/asm/io.h" 1
	sync;lwz 0,112(9);twi 0,0,0;isync	 #, tmp171
 # 0 "" 2
#NO_APP
	cmpdi 7,31,0	 #, tmp172, flags
	beq 7,.L23	 #
	bl .trace_hardirqs_on	 #
	nop
	mr 3,31	 #, flags
	bl .arch_local_irq_restore	 #
	nop
	addi 1,1,128	 #,,
	ld 0,16(1)	 #,
	ld 31,-8(1)	 #,
	mtlr 0	 #,
	blr	 #
	.p2align 4,,15
.L23:
	li 3,0	 #,
	bl .arch_local_irq_restore	 #
	nop
	bl .trace_hardirqs_off	 #
	nop
	addi 1,1,128	 #,,
	ld 0,16(1)	 #,
	ld 31,-8(1)	 #,
	mtlr 0	 #,
	blr	 #
.L22:
	addi 9,11,.LANCHOR0@toc@l	 # tmp174, tmp173,
	b .L12	 #
	.size	.mpc85xx_give_timebase,.-.mpc85xx_give_timebase
	.section	".toc","aw"
.LC0:
	.tc paca[TC],paca
.LC4:
	.tc high_memory[TC],high_memory
.LC5:
	.tc generic_secondary_smp_init[TC],generic_secondary_smp_init
	.section	".text"
	.align 2
	.p2align 4,,15
	.section	".opd","aw"
	.align 3
smp_85xx_kick_cpu:
	.quad	.smp_85xx_kick_cpu,.TOC.@tocbase
	.previous
	.size	smp_85xx_kick_cpu,24
	.type	.smp_85xx_kick_cpu,@function
.smp_85xx_kick_cpu:
	mflr 0	 #,
	std 28,-32(1)	 #,
	mfcr 12	 #
	std 29,-24(1)	 #,
	std 31,-8(1)	 #,
	std 30,-16(1)	 #,
	addis 9,2,.LC0@toc@ha	 # tmp140,,
	ld 9,.LC0@toc@l(9)	 #, tmp139
	cmplwi 7,3,31	 #, tmp146,
	mr 31,3	 # nr, nr
	std 0,16(1)	 #,
	sldi 0,3,10	 # tmp141, nr,
	stw 12,8(1)	 #,
	stdu 1,-144(1)	 #,,
	ld 9,0(9)	 # paca, paca
	add 9,9,0	 # tmp142, paca, tmp141
	lha 30,48(9)	 # <variable>.hw_cpu_id, D.32974
	mfcr 0,1	 # tmp145, tmp146
	rlwinm 0,0,30,1	 # tmp145,
#APP
 # 154 "/root/tmp/linux.git/arch/powerpc/platforms/85xx/smp.c" 1
	1:	tdnei 	0,0	 # tmp145
.section __bug_table,"a"
2:	.llong 1b, .LC1	 #
	.short 154, 2305	 #,
.org 2b+24	 #
.previous

 # 0 "" 2
#NO_APP
	li 4,0	 #,
	bl .of_get_cpu_node	 #
	nop
	addis 4,2,.LC2@toc@ha	 # tmp148,,
	li 5,0	 #,
	addi 4,4,.LC2@toc@l	 #, tmp148,
	bl .of_get_property	 #
	nop
	cmpdi 0,3,0	 # tmp149, D.29375
	beq- 0,.L34	 #
	addis 9,2,.LC4@toc@ha	 # tmp153,,
	lis 0,0x4000	 # tmp155,
	ld 3,0(3)	 #* D.29375, D.29379
	ld 9,.LC4@toc@l(9)	 #, tmp152
	sldi 0,0,32	 # tmp155, tmp155,
	ld 9,0(9)	 # high_memory, high_memory
	add 9,9,0	 # tmp154, high_memory, tmp155
	subfc 9,3,9	 # ioremappable, D.29379, tmp154
	subfe 9,9,9	 # ioremappable
	neg 9,9	 # ioremappable, ioremappable
	cmpdi 4,9,0	 #, tmp171, ioremappable
	bne 4,.L35	 #
	subf 29,0,3	 # spin_table, tmp155, D.29379
.L28:
#APP
 # 59 "/root/tmp/linux.git/arch/powerpc/include/asm/hw_irq.h" 1
	li 0,0; lbz 28,850(13); stb 0,850(13)	 # zero, flags,
 # 0 "" 2
#NO_APP
	bl .trace_hardirqs_off	 #
	nop
	mr 3,31	 #, nr
	addi 31,29,24	 # D.32994, spin_table,
	rldicl 30,30,0,32	 # hw_cpu.520, D.32974
	bl .smp_generic_kick_cpu	 #
	nop
	mr 3,29	 #, spin_table
	mr 4,31	 #, D.32994
	bl .flush_dcache_range	 #
	nop
#APP
 # 167 "/root/tmp/linux.git/arch/powerpc/include/asm/io.h" 1
	sync;stw 30,20(29)	 #, hw_cpu.520
 # 0 "" 2
#NO_APP
	li 9,1	 # tmp162,
	addis 11,2,.LC5@toc@ha	 # tmp164,,
	stb 9,852(13)	 # <variable>.io_sync, tmp162
	ld 11,.LC5@toc@l(11)	 #, tmp163
	lis 0,0x4000	 # tmp165,
	sldi 0,0,32	 # tmp165, tmp165,
	ld 11,0(11)	 #, tmp166
	add 0,0,11	 # D.29395, tmp165, tmp166
#APP
 # 172 "/root/tmp/linux.git/arch/powerpc/include/asm/io.h" 1
	sync;std 0,0(29)	 #* spin_table, D.29395
 # 0 "" 2
#NO_APP
	stb 9,852(13)	 # <variable>.io_sync, tmp162
	mr 4,31	 #, D.32994
	mr 3,29	 #, spin_table
	bl .flush_dcache_range	 #
	nop
	cmpdi 7,28,0	 #, tmp168, flags
	bne 7,.L29	 #
	li 3,0	 #,
	bl .arch_local_irq_restore	 #
	nop
	bl .trace_hardirqs_off	 #
	nop
	bne 4,.L31	 #
.L33:
	li 3,0	 # ret,
.L26:
	addi 1,1,144	 #,,
	ld 0,16(1)	 #,
	lwz 12,8(1)	 #,
	ld 28,-32(1)	 #,
	ld 29,-24(1)	 #,
	mtlr 0	 #,
	ld 30,-16(1)	 #,
	ld 31,-8(1)	 #,
	mtcrf 8,12	 #,
	blr	 #
	.p2align 4,,15
.L29:
	bl .trace_hardirqs_on	 #
	nop
	mr 3,28	 #, flags
	bl .arch_local_irq_restore	 #
	nop
	beq 4,.L33	 #
.L31:
	mr 3,29	 #, spin_table
	bl .iounmap	 #
	nop
	b .L33	 #
	.p2align 4,,15
.L35:
	li 4,24	 #,
	lis 5,0x20	 #,
	bl .ioremap_prot	 #
	nop
	mr 29,3	 # spin_table,
	b .L28	 #
.L34:
	addis 3,2,.LC3@toc@ha	 # tmp151,,
	mr 4,31	 #, nr
	addi 3,3,.LC3@toc@l	 #, tmp151,
	bl .printk	 #
	nop
	li 3,-2	 # ret,
	b .L26	 #
	.size	.smp_85xx_kick_cpu,.-.smp_85xx_kick_cpu
	.section	".toc","aw"
.LC7:
	.tc smp_mpic_probe[TC],smp_mpic_probe
.LC8:
	.tc smp_mpic_message_pass[TC],smp_mpic_message_pass
.LC9:
	.tc doorbell_cause_ipi[TC],doorbell_cause_ipi
.LC11:
	.tc smp_ops[TC],smp_ops
	.section	.init.text,"ax",@progbits
	.align 2
	.globl mpc85xx_smp_init
	.section	".opd","aw"
	.align 3
mpc85xx_smp_init:
	.quad	.mpc85xx_smp_init,.TOC.@tocbase
	.previous
	.size	mpc85xx_smp_init,24
	.type	.mpc85xx_smp_init,@function
	.globl	.mpc85xx_smp_init
.mpc85xx_smp_init:
	mflr 0	 #,
	std 31,-8(1)	 #,
	addis 9,2,smp_85xx_setup_cpu@toc@ha	 # tmp125,,
	addis 31,2,.LANCHOR1@toc@ha	 # tmp123,,
	std 30,-16(1)	 #,
	addi 30,31,.LANCHOR1@toc@l	 # tmp122, tmp123,
	std 28,-32(1)	 #,
	std 29,-24(1)	 #,
	addis 4,2,.LC6@toc@ha	 # tmp127,,
	li 3,0	 #,
	std 0,16(1)	 #,
	addi 0,9,smp_85xx_setup_cpu@toc@l	 # tmp124, tmp125,
	stdu 1,-144(1)	 #,,
	std 0,32(30)	 # smp_85xx_ops.setup_cpu, tmp124
	addi 4,4,.LC6@toc@l	 #, tmp127,
	bl .of_find_node_by_type	 #
	nop
	cmpdi 7,3,0	 #, tmp128,
	beq 7,.L37	 #
	addis 11,2,.LC8@toc@ha	 # tmp136,,
	addis 9,2,.LC7@toc@ha	 # tmp132,,
	ld 9,.LC7@toc@l(9)	 #, tmp131
	ld 0,.LC8@toc@l(11)	 #, tmp135
	std 9,16(30)	 # smp_85xx_ops.probe, tmp131
	std 0,.LANCHOR1@toc@l(31)	 # smp_85xx_ops.message_pass, tmp135
.L37:
	addis 9,2,.LC9@toc@ha	 # tmp143,,
	addis 30,2,.LANCHOR2@toc@ha	 # tmp145,,
	ld 0,.LC9@toc@l(9)	 #, tmp142
	addis 9,2,.LANCHOR1@toc@ha	 # tmp138,,
	addi 30,30,.LANCHOR2@toc@l	 # tmp144, tmp145,
	addi 31,9,.LANCHOR1@toc@l	 # tmp137, tmp138,
	li 11,0	 # tmp139,
	std 0,8(31)	 # smp_85xx_ops.cause_ipi, tmp142
	li 3,0	 #,
	mr 4,30	 #, tmp144
	li 5,0	 #,
	std 11,.LANCHOR1@toc@l(9)	 # smp_85xx_ops.message_pass, tmp139
	bl .of_find_matching_node_and_match	 #
	nop
	mr. 29,3	 # np.619,
	beq 0,.L38	 #
	li 4,0	 #,
	addis 28,2,.LANCHOR0@toc@ha	 # tmp148,,
	bl .of_iomap	 #
	nop
	addi 28,28,.LANCHOR0@toc@l	 # tmp147, tmp148,
	std 3,16(28)	 # guts,
	mr 3,29	 #, np.619
	bl .of_node_put	 #
	nop
	ld 0,16(28)	 # guts, guts
	cmpdi 7,0,0	 #, tmp152, guts
	bne+ 7,.L39	 #
	addis 3,2,.LC10@toc@ha	 # tmp154,,
	addi 4,30,1400	 #, tmp144,
	addi 3,3,.LC10@toc@l	 #, tmp154,
	bl .printk	 #
	nop
	b .L41	 #
.L39:
	addis 9,2,mpc85xx_take_timebase@toc@ha	 # tmp165,,
	addis 11,2,mpc85xx_give_timebase@toc@ha	 # tmp161,,
	addi 0,11,mpc85xx_give_timebase@toc@l	 # tmp160, tmp161,
	addi 9,9,mpc85xx_take_timebase@toc@l	 # tmp164, tmp165,
	std 9,48(31)	 # smp_85xx_ops.take_timebase, tmp164
	std 0,56(31)	 # smp_85xx_ops.give_timebase, tmp160
.L38:
	addis 9,2,.LC11@toc@ha	 # tmp167,,
	addis 11,2,.LANCHOR1@toc@ha	 # tmp169,,
	ld 9,.LC11@toc@l(9)	 #, tmp166
	addi 0,11,.LANCHOR1@toc@l	 # tmp168, tmp169,
	std 0,0(9)	 # smp_ops, tmp168
.L41:
	addi 1,1,144	 #,,
	ld 0,16(1)	 #,
	ld 28,-32(1)	 #,
	ld 29,-24(1)	 #,
	ld 30,-16(1)	 #,
	mtlr 0	 #,
	ld 31,-8(1)	 #,
	blr	 #
	.size	.mpc85xx_smp_init,.-.mpc85xx_smp_init
	.section	".toc","aw"
	.set .LC12,.LC7
	.section	".text"
	.align 2
	.p2align 4,,15
	.section	".opd","aw"
	.align 3
smp_85xx_setup_cpu:
	.quad	.smp_85xx_setup_cpu,.TOC.@tocbase
	.previous
	.size	smp_85xx_setup_cpu,24
	.type	.smp_85xx_setup_cpu,@function
.smp_85xx_setup_cpu:
	mflr 0	 #,
	addis 9,2,.LANCHOR1@toc@ha	 # tmp121,,
	addi 9,9,.LANCHOR1@toc@l	 # tmp120, tmp121,
	addis 11,2,.LC12@toc@ha	 # tmp123,,
	std 0,16(1)	 #,
	ld 0,.LC12@toc@l(11)	 #, tmp122
	stdu 1,-112(1)	 #,,
	ld 9,16(9)	 # smp_85xx_ops.probe, smp_85xx_ops.probe
	cmpd 7,9,0	 # tmp122, tmp125, smp_85xx_ops.probe
	beq 7,.L45	 #
	bl .doorbell_setup_this_cpu	 #
	nop
	addi 1,1,112	 #,,
	ld 0,16(1)	 #,
	mtlr 0	 #,
	blr	 #
	.p2align 4,,15
.L45:
	bl .mpic_setup_this_cpu	 #
	nop
	bl .doorbell_setup_this_cpu	 #
	nop
	addi 1,1,112	 #,,
	ld 0,16(1)	 #,
	mtlr 0	 #,
	blr	 #
	.size	.smp_85xx_setup_cpu,.-.smp_85xx_setup_cpu
	.globl smp_85xx_ops
	.section	.rodata
	.align 3
	.set	.LANCHOR2,. + 0
	.type	mpc85xx_smp_guts_ids, @object
	.size	mpc85xx_smp_guts_ids, 1400
mpc85xx_smp_guts_ids:
 # compatible:
	.zero	64
	.string	"fsl,mpc8572-guts"
	.zero	111
	.zero	8
 # compatible:
	.zero	64
	.string	"fsl,p1020-guts"
	.zero	113
	.zero	8
 # compatible:
	.zero	64
	.string	"fsl,p1021-guts"
	.zero	113
	.zero	8
 # compatible:
	.zero	64
	.string	"fsl,p1022-guts"
	.zero	113
	.zero	8
 # compatible:
	.zero	64
	.string	"fsl,p1023-guts"
	.zero	113
	.zero	8
 # compatible:
	.zero	64
	.string	"fsl,p2020-guts"
	.zero	113
	.zero	8
	.zero	200
	.type	__func__.29417, @object
	.size	__func__.29417, 17
__func__.29417:
	.string	"mpc85xx_smp_init"
	.section	".data"
	.align 3
	.set	.LANCHOR1,. + 0
	.type	smp_85xx_ops, @object
	.size	smp_85xx_ops, 88
smp_85xx_ops:
 # kick_cpu:
	.zero	24
	.quad	smp_85xx_kick_cpu
	.zero	56
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 3
.LC1:
	.string	"/root/tmp/linux.git/arch/powerpc/platforms/85xx/smp.c"
	.zero	2
.LC2:
	.string	"cpu-release-addr"
	.zero	7
.LC3:
	.string	"\0013No cpu-release-addr for cpu %d\n"
	.zero	6
.LC6:
	.string	"open-pic"
	.zero	7
.LC10:
	.string	"\0013%s: Could not map guts node address\n"
	.section	".bss"
	.align 3
	.set	.LANCHOR0,. + 0
	.type	tb_req, @object
	.size	tb_req, 4
tb_req:
	.zero	4
	.type	tb_valid, @object
	.size	tb_valid, 4
tb_valid:
	.zero	4
	.type	timebase, @object
	.size	timebase, 8
timebase:
	.zero	8
	.type	guts, @object
	.size	guts, 8
guts:
	.zero	8
	.ident	"GCC: (GNU) 4.4.6 20120305 (Red Hat 4.4.6-4)"
	.section	.note.GNU-stack,"",@progbits
