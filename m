Date: Wed, 4 Sep 2002 16:23:50 -0500 (CDT)
From: Kumar Gala <kumar.gala@motorola.com>
To: mporter@mvista.com
Cc: linuxppc-booke@source.mvista.com,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: [PATCH] CONFIG_BOOKE patch
Message-ID: <Pine.GSO.4.40.0209041620320.17503-100000@softail.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The following is a bk patch to add in some places that I think we should
have CONFIG_BOOKE turned on.

- kumar

This BitKeeper patch contains the following changesets:
galak@blarg.somerset.sps.mot.com|ChangeSet|20020904191335|20955
galak@blarg.somerset.sps.mot.com|ChangeSet|20020904190824|20366
galak@blarg.somerset.sps.mot.com|ChangeSet|20020904181853|18543

# This is a BitKeeper patch.  What follows are the unified diffs for the
# set of deltas contained in the patch.  The rest of the patch, the part
# that BitKeeper cares about, is below these diffs.
# ID:	cort@ftsoj.fsmlabs.com|ChangeSet|20010106071759|19793|5c81b698cda31832
# User:	galak
# Host:	blarg.somerset.sps.mot.com
# Root:	/local0/bk/linuxppc_2_4_devel

#
#--- 1.71/BitKeeper/etc/logging_ok	Mon Aug 19 21:28:07 2002
#+++ 1.72/BitKeeper/etc/logging_ok	Wed Sep  4 13:17:41 2002
#@@ -58,3 +58,4 @@
# trini@kernel.crashing.org
# trini@opus.bloom.county
# trini@stevedallas.bloom.county
#+galak@blarg.somerset.sps.mot.com
#
#--- 1.36/include/asm-ppc/ppc_asm.h	Tue Aug 13 06:52:58 2002
#+++ 1.37/include/asm-ppc/ppc_asm.h	Wed Sep  4 13:17:34 2002
#@@ -120,7 +120,7 @@
#  * On APUS (Amiga PowerPC cpu upgrade board), we don't know the
#  * physical base address of RAM at compile time.
#  */
#-#ifndef CONFIG_440
#+#ifndef CONFIG_BOOKE
# #define tophys(rd,rs)				\
# 0:	addis	rd,rs,-KERNELBASE@h;		\
# 	.section ".vtop_fixup","aw";		\
#@@ -134,12 +134,12 @@
# 	.align  1;				\
# 	.long   0b;				\
# 	.previous
#-#else /* CONFIG_440 */
#+#else /* CONFIG_BOOKE */
# #define tophys(rd,rs)				\
# 	mr	rd,rs
# #define tovirt(rd,rs)				\
# 	mr	rd,rs
#-#endif /* CONFIG_440 */
#+#endif /* CONFIG_BOOKE */
# #else  /* CONFIG_PPC_ISERIES */
#
# #define tophys(rd,rs)				\
#
#--- 1.39/arch/ppc/kernel/traps.c	Sun Sep  1 21:29:58 2002
#+++ 1.40/arch/ppc/kernel/traps.c	Wed Sep  4 13:17:33 2002
#@@ -310,7 +310,7 @@
# {
# 	int errcode;
#
#-#if defined(CONFIG_4xx)
#+#if defined(CONFIG_4xx) || defined (CONFIG_BOOKE)
# 	unsigned int esr = mfspr(SPRN_ESR);
# 	int isbpt = esr & ESR_PTR;
# 	extern int do_mathemu(struct pt_regs *regs);
#@@ -322,7 +322,7 @@
# 		return;
# #endif /* CONFIG_MATH_EMULATION */
#
#-#else /* ! CONFIG_4xx */
#+#else /* ! CONFIG_4xx && ! CONFIG_BOOKE */
# 	int isbpt = regs->msr & 0x20000;
#
# 	if (regs->msr & 0x100000) {
#@@ -330,7 +330,7 @@
# 		_exception(SIGFPE, regs);
# 		return;
# 	}
#-#endif /* ! CONFIG_4xx */
#+#endif /* ! CONFIG_4xx && ! CONFIG_BOOKE */
#
# 	if (isbpt) {
# 		/* trap exception */
#@@ -426,7 +426,7 @@
# }
# #endif /* CONFIG_8xx */
#
#-#if defined(CONFIG_4xx)
#+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
#
# void DebugException(struct pt_regs *regs)
# {
#@@ -453,7 +453,7 @@
# 		_exception(SIGTRAP, regs);
# 	}
# }
#-#endif /* CONFIG_4xx */
#+#endif /* CONFIG_4xx || CONFIG_BOOKE */
#
# #if !defined(CONFIG_TAU_INT)
# void
#
#--- 1.27/arch/ppc/mm/fault.c	Thu Aug 29 01:03:45 2002
#+++ 1.28/arch/ppc/mm/fault.c	Wed Sep  4 13:17:34 2002
#@@ -70,7 +70,7 @@
# 	struct mm_struct *mm = current->mm;
# 	siginfo_t info;
# 	int code = SEGV_MAPERR;
#-#ifdef CONFIG_4xx
#+#if defined(CONFIG_4xx) || defined (CONFIG_BOOKE)
# 	int is_write = error_code & ESR_DST;
# #else
# 	int is_write = 0;
#@@ -85,7 +85,7 @@
# 		error_code &= 0x48200000;
# 	else
# 		is_write = error_code & 0x02000000;
#-#endif /* CONFIG_4xx */
#+#endif /* CONFIG_4xx || CONFIG_BOOKE */
#
# #if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
# 	if (debugger_fault_handler && regs->trap == 0x300) {
#@@ -138,8 +138,8 @@
# 	if (is_write) {
# 		if (!(vma->vm_flags & VM_WRITE))
# 			goto bad_area;
#-#if defined(CONFIG_4xx)
#-	/* an exec  - 4xx allows for per-page execute permission */
#+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
#+	/* an exec  - 4xx/BookE allows for per-page execute permission */
# 	} else if (regs->trap == 0x400) {
# 		pte_t *ptep;
#
#
#--- 1.15/include/asm-ppc/mmu.h	Fri Apr  5 12:33:38 2002
#+++ 1.16/include/asm-ppc/mmu.h	Wed Sep  4 14:13:30 2002
#@@ -383,5 +383,18 @@
# #define PPC440_TLB_SW		0x00000002      /* Super write */
# #define PPC440_TLB_SR		0x00000001      /* Super read */
#
#+#define BOOKE_PAGESZ_1K		0
#+#define BOOKE_PAGESZ_4K		1
#+#define BOOKE_PAGESZ_16K	2
#+#define BOOKE_PAGESZ_64K	3
#+#define BOOKE_PAGESZ_256K	4
#+#define BOOKE_PAGESZ_1M		5
#+#define BOOKE_PAGESZ_4M		5
#+#define BOOKE_PAGESZ_16M	7
#+#define BOOKE_PAGESZ_64M	8
#+#define BOOKE_PAGESZ_256M	9
#+#define BOOKE_PAGESZ_1GB	10
#+#define BOOKE_PAGESZ_4GB	11
#+
# #endif /* _PPC_MMU_H_ */
# #endif /* __KERNEL__ */
#
#--- 1.71/include/asm-ppc/processor.h	Sun Sep  1 21:29:58 2002
#+++ 1.72/include/asm-ppc/processor.h	Wed Sep  4 13:17:34 2002
#@@ -825,7 +825,7 @@
# 	vector128	vscr;		/* AltiVec status */
# 	unsigned long	vrsave;
# #endif /* CONFIG_ALTIVEC */
#-#if defined(CONFIG_4xx)
#+#if defined(CONFIG_4xx) || defined (CONFIG_BOOKE)
# 	/* Saved 4xx debug registers */
# 	unsigned long dbcr0;
# #endif
#

# Diff checksum=f91b7d3f


# Patch vers:	1.3
# Patch type:	REGULAR

== ChangeSet ==
cort@ftsoj.fsmlabs.com|ChangeSet|20010106071759|19793|5c81b698cda31832
trini@kernel.crashing.org|ChangeSet|20020903232952|11220
D 1.1104.1.1 02/09/04 13:18:53-05:00 galak@blarg.somerset.sps.mot.com +5 -0
B cort@ftsoj.fsmlabs.com|ChangeSet|20010106071759|19793|5c81b698cda31832
C
c Modifications to places that are not 4xx specific but also apply to BOOKE processors
K 18543
P ChangeSet
------------------------------------------------

0a0
> cort@ftsoj.fsmlabs.com|arch/ppc/kernel/ppc_asm.h|20010106073008|23478|8255526b487a80cc galak@blarg.somerset.sps.mot.com|include/asm-ppc/ppc_asm.h|20020904181734|10747
> cort@ftsoj.fsmlabs.com|include/asm-ppc/processor.h|20010106072646|29258|bf9de2face866fcb galak@blarg.somerset.sps.mot.com|include/asm-ppc/processor.h|20020904181734|09113
> cort@ftsoj.fsmlabs.com|arch/ppc/mm/fault.c|20010106073007|25794|57cf8749514acb14 galak@blarg.somerset.sps.mot.com|arch/ppc/mm/fault.c|20020904181734|55022
> cort@ftsoj.fsmlabs.com|arch/ppc/kernel/traps.c|20010106073007|59482|a197725432ca2496 galak@blarg.somerset.sps.mot.com|arch/ppc/kernel/traps.c|20020904181733|58765
> cort@ftsoj.fsmlabs.com|BitKeeper/etc/logging_ok|20010106073834|64358|2442203aaaa98f galak@blarg.somerset.sps.mot.com|BitKeeper/etc/logging_ok|20020904181741|06691

trini@kernel.crashing.org|ChangeSet|20020904153231|13043
D 1.1107 02/09/04 14:08:24-05:00 galak@blarg.somerset.sps.mot.com +0 -0
B cort@ftsoj.fsmlabs.com|ChangeSet|20010106071759|19793|5c81b698cda31832
C
c Merge http://ppc.bkbits.net/linuxppc_2_4_devel
c into blarg.somerset.sps.mot.com:/local0/bk/linuxppc_2_4_devel
i galak@blarg.somerset.sps.mot.com|ChangeSet|20020904181853|18543
K 20366
M galak@blarg.somerset.sps.mot.com|ChangeSet|20020904181853|18543
P ChangeSet
------------------------------------------------


galak@blarg.somerset.sps.mot.com|ChangeSet|20020904190824|20366
D 1.1108 02/09/04 14:13:35-05:00 galak@blarg.somerset.sps.mot.com +1 -0
B cort@ftsoj.fsmlabs.com|ChangeSet|20010106071759|19793|5c81b698cda31832
C
c Added more generic BOOKE specified page sizes rather then have processor specific page size defines
K 20955
P ChangeSet
------------------------------------------------

0a0
> cort@ftsoj.fsmlabs.com|include/asm-ppc/mmu.h|20010106072646|21322|ea18e1cb3a8b0bc6 galak@blarg.somerset.sps.mot.com|include/asm-ppc/mmu.h|20020904191330|45298

== BitKeeper/etc/logging_ok ==
cort@ftsoj.fsmlabs.com|BitKeeper/etc/logging_ok|20010106073834|64358|2442203aaaa98f
paulus@au1.ibm.com|BitKeeper/etc/logging_ok|20020820022807|03522
D 1.72 02/09/04 13:17:41-05:00 galak@blarg.somerset.sps.mot.com +1 -0
B cort@ftsoj.fsmlabs.com|ChangeSet|20010106071759|19793|5c81b698cda31832
C
c Logging to logging@openlogging.org accepted
K 6691
O -rw-rw-r--
P BitKeeper/etc/logging_ok
------------------------------------------------

I60 1
galak@blarg.somerset.sps.mot.com

== include/asm-ppc/ppc_asm.h ==
cort@ftsoj.fsmlabs.com|arch/ppc/kernel/ppc_asm.h|20010106073008|23478|8255526b487a80cc
paulus@samba.org|include/asm-ppc/ppc_asm.h|20020813115258|10099
D 1.37 02/09/04 13:17:34-05:00 galak@blarg.somerset.sps.mot.com +3 -3
B cort@ftsoj.fsmlabs.com|ChangeSet|20010106071759|19793|5c81b698cda31832
C
c For any BOOKE processor phys will map to virt address one-to-one
K 10747
O -rw-rw-r--
P include/asm-ppc/ppc_asm.h
------------------------------------------------

D123 1
I123 1
#ifndef CONFIG_BOOKE
D137 1
I137 1
#else /* CONFIG_BOOKE */
D142 1
I142 1
#endif /* CONFIG_BOOKE */

== arch/ppc/kernel/traps.c ==
cort@ftsoj.fsmlabs.com|arch/ppc/kernel/traps.c|20010106073007|59482|a197725432ca2496
paulus@au1.ibm.com|arch/ppc/kernel/traps.c|20020902022958|51282
D 1.40 02/09/04 13:17:33-05:00 galak@blarg.somerset.sps.mot.com +5 -5
B cort@ftsoj.fsmlabs.com|ChangeSet|20010106071759|19793|5c81b698cda31832
C
c ProgramExceptions and DebugExceptions are handled the same way for 4xx and BOOKE processors
K 58765
O -rw-rw-r--
P arch/ppc/kernel/traps.c
------------------------------------------------

D313 1
I313 1
#if defined(CONFIG_4xx) || defined (CONFIG_BOOKE)
D325 1
I325 1
#else /* ! CONFIG_4xx && ! CONFIG_BOOKE */
D333 1
I333 1
#endif /* ! CONFIG_4xx && ! CONFIG_BOOKE */
D429 1
I429 1
#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
D456 1
I456 1
#endif /* CONFIG_4xx || CONFIG_BOOKE */

== arch/ppc/mm/fault.c ==
cort@ftsoj.fsmlabs.com|arch/ppc/mm/fault.c|20010106073007|25794|57cf8749514acb14
paulus@au1.ibm.com|arch/ppc/mm/fault.c|20020829060345|48743
D 1.28 02/09/04 13:17:34-05:00 galak@blarg.somerset.sps.mot.com +4 -4
B cort@ftsoj.fsmlabs.com|ChangeSet|20010106071759|19793|5c81b698cda31832
C
c BOOKE processors handle faults in the same general manor as 4xx
K 55022
O -rw-rw-r--
P arch/ppc/mm/fault.c
------------------------------------------------

D73 1
I73 1
#if defined(CONFIG_4xx) || defined (CONFIG_BOOKE)
D88 1
I88 1
#endif /* CONFIG_4xx || CONFIG_BOOKE */
D141 2
I142 2
#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
	/* an exec  - 4xx/BookE allows for per-page execute permission */

== include/asm-ppc/mmu.h ==
cort@ftsoj.fsmlabs.com|include/asm-ppc/mmu.h|20010106072646|21322|ea18e1cb3a8b0bc6
mporter@beef.az.mvista.com|include/asm-ppc/mmu.h|20020405183338|21812
D 1.16 02/09/04 14:13:30-05:00 galak@blarg.somerset.sps.mot.com +13 -0
B cort@ftsoj.fsmlabs.com|ChangeSet|20010106071759|19793|5c81b698cda31832
C
c Added BOOKE specified page sizes
K 45298
O -rw-rw-r--
P include/asm-ppc/mmu.h
------------------------------------------------

I385 13
#define BOOKE_PAGESZ_1K		0
#define BOOKE_PAGESZ_4K		1
#define BOOKE_PAGESZ_16K	2
#define BOOKE_PAGESZ_64K	3
#define BOOKE_PAGESZ_256K	4
#define BOOKE_PAGESZ_1M		5
#define BOOKE_PAGESZ_4M		5
#define BOOKE_PAGESZ_16M	7
#define BOOKE_PAGESZ_64M	8
#define BOOKE_PAGESZ_256M	9
#define BOOKE_PAGESZ_1GB	10
#define BOOKE_PAGESZ_4GB	11
\

== include/asm-ppc/processor.h ==
cort@ftsoj.fsmlabs.com|include/asm-ppc/processor.h|20010106072646|29258|bf9de2face866fcb
paulus@au1.ibm.com|include/asm-ppc/processor.h|20020902022958|07068
D 1.72 02/09/04 13:17:34-05:00 galak@blarg.somerset.sps.mot.com +1 -1
B cort@ftsoj.fsmlabs.com|ChangeSet|20010106071759|19793|5c81b698cda31832
C
c DBCR0 handling for single step is the same for 4xx and BOOKE processors
K 9113
O -rw-rw-r--
P include/asm-ppc/processor.h
------------------------------------------------

D828 1
I828 1
#if defined(CONFIG_4xx) || defined (CONFIG_BOOKE)

# Patch checksum=985280dd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
