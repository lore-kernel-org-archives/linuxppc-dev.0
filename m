To: Eisenzopf Thomas <thomas.eisenzopf@siemens.at>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: crash loadin bash after booting linux on a MPC860ADS
References: <D53137D1F3DDD211A3750800060DA313017023B4@viee122a.erd.siemens.at>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 05 Apr 2000 11:12:56 +0200
In-Reply-To: Eisenzopf Thomas's message of "Wed, 5 Apr 2000 10:56:04 +0200"
Message-ID: <kfyitxwvrl3.fsf@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eisenzopf Thomas <thomas.eisenzopf@siemens.at> writes:

> Hello,
>
> thank you for your patches!
>
> I applied them, but unfortunately I get the following error when compiling:
>
> make -C  arch/ppc/kernel
> make[1]: Entering directory `/home/eisenzopft/ppc/tmplinux/arch/ppc/kernel'
> powerpc-linux-gcc -D__KERNEL__ -I/home/eisenzopft/ppc/tmplinux/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
> -D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2
> -Wno-uninitialized -mmultiple -mstring -mcpu=860 -I../8xx_io -D__ASSEMBLY__
> -c head.S -o head.o
> head.S: Assembler messages:
> head.S:888: Error: unsupported relocation type
> head.S:896: Error: unsupported relocation type
> head.S:918: Error: unsupported relocation type
> head.S:922: Error: unsupported relocation type
> head.S:950: Error: unsupported relocation type
> head.S:1051: Error: unsupported relocation type
> head.S:1069: Error: unsupported relocation type
> head.S:1094: Error: unsupported relocation type
> head.S:1150: Error: unsupported relocation type
> head.S:1175: Error: unsupported relocation type
> head.S:1207: Error: unsupported relocation type
> head.S:2301: Error: unsupported relocation type
> head.S:2305: Error: unsupported relocation type
> make[1]: *** [head.o] Error 1
> make[1]: Leaving directory `/home/eisenzopft/ppc/tmplinux/arch/ppc/kernel'
> make: *** [_dir_arch/ppc/kernel] Error 2
>
>
> Do you have an idea, what´s wrong? The lines with errors in head.S are:
>
>  888:	li	r3, M_TW_ADDR
>  922:	li	r3, MD_TWC_ADDR
>  950:	li	r3, MI_RPN_ADDR
> 1051:	li	r3, M_TW_ADDR
> ...

Ah, sorry. These are the missing defines (most are not used):

/*
  MPC860* CPU6 workaround defines
*/
#define IMMR_ADDR	0x3d30
#define IC_CST_ADDR	0x2110
#define IC_ADR_ADDR	0x2310
#define IC_DAT_ADDR	0x2510
#define DC_CST_ADDR	0x3110
#define DC_ADR_ADDR	0x3310
#define DC_DAT_ADDR	0x3510
#define MI_CTR_ADDR	0x2180
#define MI_AP_ADDR	0x2580
#define MI_EPN_ADDR	0x2780
#define MI_TWC_ADDR	0x2b80
#define MI_RPN_ADDR	0x2d80
#define MI_DBCAM_ADDR	0x2190
#define MI_DBRAM0_ADDR	0x2390
#define MI_DBRAM1_ADDR	0x2590
#define MD_CTR_ADDR	0x3180
#define M_CASID_ADDR	0x3380
#define MD_AP_ADDR	0x3580
#define MD_EPN_ADDR	0x3780
#define M_TWB_ADDR	0x3980
#define MD_TWC_ADDR	0x3b80
#define MD_RPN_ADDR	0x3d80
#define M_TW_ADDR	0x3f80
#define MD_DBCAM_ADDR	0x3190
#define MD_DBRAM0_ADDR	0x3390
#define MD_DBRAM1_ADDR	0x3590
#define DEC_ADDR	0x2c00
#define TB_ADDR		0x3880
#define TBU_ADDR	0x3a80
#define DPDR_ADDR	0x2d30


Now that I think of it you will also need the following diff:

diff -u -r1.1 -r1.2
--- include/asm-ppc/pgtable.h	2000/01/11 17:53:57	1.1
+++ include/asm-ppc/pgtable.h	2000/01/11 18:44:12	1.2
@@ -8,6 +8,6 @@
 #include <asm/processor.h>		/* For TASK_SIZE */
 #include <asm/mmu.h>
 #include <asm/page.h>

 extern void local_flush_tlb_all(void);
 extern void local_flush_tlb_mm(struct mm_struct *mm);
@@ -230,7 +231,7 @@
  do { \
 	unsigned long __pgdir = (unsigned long)pgdir; \
 	((tsk)->tss.pg_tables = (unsigned long *)(__pgdir)); \
-	asm("mtspr %0,%1 \n\t" : : "i"(M_TWB), "r"(__pa(__pgdir))); \
+	set_m_twb(__pa(__pgdir)); \
  } while (0)
 #endif /* CONFIG_8xx */


Where set_m_twb is defined as:

#  define set_m_twb(val) \
do {	unsigned long dummy_var; \
	register unsigned long reg5 __asm__ ("r5") = M_TWB_ADDR; \
	register unsigned long reg4 __asm__ ("r4") = (unsigned long) &dummy_var; \
	asm volatile ( \
		"stw   %3,0(%2)\n\t" \
		"lwz   %3,0(%2)\n\t" \
		"mtspr %0,%1 \n\t" \
	    : : "i"(M_TWB), "r"((val)), "r"(reg4), "r"(reg5) \
		       : "r4", "r5", "memory"); }while(0)

> As I understood your patches, the define NO_MPC8xxBUG_CPU6 should NOT be
> applied, is this correct?

Yes, that's correct.

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
