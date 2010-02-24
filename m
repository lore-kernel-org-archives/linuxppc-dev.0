Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 17383B7C48
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 08:38:04 +1100 (EST)
Date: Thu, 25 Feb 2010 00:38:02 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2] powerpc: Add hibernation support for FSL BookE processors
Message-ID: <20100224213802.GA12843@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is started as swsusp_32.S modifications, but the amount of #ifdefs
made the whole file horribly unreadable, so let's put the support into
its own separate file.

The code should be relatively easy to modify to support 44x BookEs as
well, but since I don't have any 44x to test, let's confine the code to
FSL BookE. (The only FSL-specific parts are 'flush_dcache_L1' and TLB
invalidation code).

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

Sorry for the delayed response...

On Tue, Jan 12, 2010 at 01:34:08PM +1100, Benjamin Herrenschmidt wrote:
[...]
> Here's a quick review. Looks good but two things:
> 
>  - Please make it swsusp_booke.c, 44x support is trivial and I don't
> want to rename the file :-)

Done.

>  - Is there really an SDR1 register on FSL BookE ? It's supposed to be
> the pointer to the hash table on server ...

Thanks, fixed.

>  - You probably should save/restore the TCR and ack pending crap DEC or
> FIT interrupts in the TSR right before you kick the decrementer

Done.

>  - Nowadays, we still assume that the "loader" kernel is exactly the
> same as the "loaded" kernel on resume ?

I'm pretty sure today we do rely on this, yes. This is not some
generic code limitation though, it's just hard to test the case
when loader != loaded. In most cases it will work fine since the
loader kernel wouldn't differ a lot from the loaded kernel, so
it'll setup the low level stuff the same way.

We may try to link the loader kernel to a different address
(relocate it as in kdump case), and hope that it'll trigger
all sort of problems so that we could fix them.

Though, the better test case would be to resume the hibernated
kernel directly from the bootloader.

Thanks,

 arch/powerpc/kernel/Makefile       |    8 +-
 arch/powerpc/kernel/swsusp_booke.S |  200 ++++++++++++++++++++++++++++++++++++
 2 files changed, 206 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/kernel/swsusp_booke.S

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index c002b04..33d9dda 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -57,8 +57,12 @@ obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_E500)		+= idle_e500.o
 obj-$(CONFIG_6xx)		+= idle_6xx.o l2cr_6xx.o cpu_setup_6xx.o
 obj-$(CONFIG_TAU)		+= tau_6xx.o
-obj-$(CONFIG_HIBERNATION)	+= swsusp.o suspend.o \
-				   swsusp_$(CONFIG_WORD_SIZE).o
+obj-$(CONFIG_HIBERNATION)	+= swsusp.o suspend.o
+ifeq ($(CONFIG_FSL_BOOKE),y)
+obj-$(CONFIG_HIBERNATION)	+= swsusp_booke.o
+else
+obj-$(CONFIG_HIBERNATION)	+= swsusp_$(CONFIG_WORD_SIZE).o
+endif
 obj64-$(CONFIG_HIBERNATION)	+= swsusp_asm64.o
 obj-$(CONFIG_MODULES)		+= module.o module_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_44x)		+= cpu_setup_44x.o
diff --git a/arch/powerpc/kernel/swsusp_booke.S b/arch/powerpc/kernel/swsusp_booke.S
new file mode 100644
index 0000000..dbffad2
--- /dev/null
+++ b/arch/powerpc/kernel/swsusp_booke.S
@@ -0,0 +1,200 @@
+/*
+ * Based on swsusp_32.S, modified for FSL BookE by
+ * Anton Vorontsov <avorontsov@ru.mvista.com>
+ * Copyright (c) 2009-2010 MontaVista Software, LLC.
+ */
+
+#include <linux/threads.h>
+#include <asm/processor.h>
+#include <asm/page.h>
+#include <asm/cputable.h>
+#include <asm/thread_info.h>
+#include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/mmu.h>
+
+/*
+ * Structure for storing CPU registers on the save area.
+ */
+#define SL_SP		0
+#define SL_PC		4
+#define SL_MSR		8
+#define SL_TCR		0xc
+#define SL_SPRG0	0x10
+#define SL_SPRG1	0x14
+#define SL_SPRG2	0x18
+#define SL_SPRG3	0x1c
+#define SL_SPRG4	0x20
+#define SL_SPRG5	0x24
+#define SL_SPRG6	0x28
+#define SL_SPRG7	0x2c
+#define SL_TBU		0x30
+#define SL_TBL		0x34
+#define SL_R2		0x38
+#define SL_CR		0x3c
+#define SL_LR		0x40
+#define SL_R12		0x44	/* r12 to r31 */
+#define SL_SIZE		(SL_R12 + 80)
+
+	.section .data
+	.align	5
+
+_GLOBAL(swsusp_save_area)
+	.space	SL_SIZE
+
+
+	.section .text
+	.align	5
+
+_GLOBAL(swsusp_arch_suspend)
+	lis	r11,swsusp_save_area@h
+	ori	r11,r11,swsusp_save_area@l
+
+	mflr	r0
+	stw	r0,SL_LR(r11)
+	mfcr	r0
+	stw	r0,SL_CR(r11)
+	stw	r1,SL_SP(r11)
+	stw	r2,SL_R2(r11)
+	stmw	r12,SL_R12(r11)
+
+	/* Save MSR & TCR */
+	mfmsr	r4
+	stw	r4,SL_MSR(r11)
+	mfspr	r4,SPRN_TCR
+	stw	r4,SL_TCR(r11)
+
+	/* Get a stable timebase and save it */
+1:	mftbu	r4
+	stw	r4,SL_TBU(r11)
+	mftb	r5
+	stw	r5,SL_TBL(r11)
+	mftbu	r3
+	cmpw	r3,r4
+	bne	1b
+
+	/* Save SPRGs */
+	mfsprg	r4,0
+	stw	r4,SL_SPRG0(r11)
+	mfsprg	r4,1
+	stw	r4,SL_SPRG1(r11)
+	mfsprg	r4,2
+	stw	r4,SL_SPRG2(r11)
+	mfsprg	r4,3
+	stw	r4,SL_SPRG3(r11)
+	mfsprg	r4,4
+	stw	r4,SL_SPRG4(r11)
+	mfsprg	r4,5
+	stw	r4,SL_SPRG5(r11)
+	mfsprg	r4,6
+	stw	r4,SL_SPRG6(r11)
+	mfsprg	r4,7
+	stw	r4,SL_SPRG7(r11)
+
+	/* Call the low level suspend stuff (we should probably have made
+	 * a stackframe...
+	 */
+	bl	swsusp_save
+
+	/* Restore LR from the save area */
+	lis	r11,swsusp_save_area@h
+	ori	r11,r11,swsusp_save_area@l
+	lwz	r0,SL_LR(r11)
+	mtlr	r0
+
+	blr
+
+_GLOBAL(swsusp_arch_resume)
+ 	sync
+
+	/* Load ptr the list of pages to copy in r3 */
+	lis	r11,(restore_pblist)@h
+	ori	r11,r11,restore_pblist@l
+	lwz	r3,0(r11)
+
+	/* Copy the pages. This is a very basic implementation, to
+	 * be replaced by something more cache efficient */
+1:
+	li	r0,256
+	mtctr	r0
+	lwz	r5,pbe_address(r3)	/* source */
+	lwz	r6,pbe_orig_address(r3)	/* destination */
+2:
+	lwz	r8,0(r5)
+	lwz	r9,4(r5)
+	lwz	r10,8(r5)
+	lwz	r11,12(r5)
+	addi	r5,r5,16
+	stw	r8,0(r6)
+	stw	r9,4(r6)
+	stw	r10,8(r6)
+	stw	r11,12(r6)
+	addi	r6,r6,16
+	bdnz	2b
+	lwz	r3,pbe_next(r3)
+	cmpwi	0,r3,0
+	bne	1b
+
+	bl flush_dcache_L1
+	bl flush_instruction_cache
+
+	lis	r11,swsusp_save_area@h
+	ori	r11,r11,swsusp_save_area@l
+
+	lwz	r4,SL_SPRG0(r11)
+	mtsprg	0,r4
+	lwz	r4,SL_SPRG1(r11)
+	mtsprg	1,r4
+	lwz	r4,SL_SPRG2(r11)
+	mtsprg	2,r4
+	lwz	r4,SL_SPRG3(r11)
+	mtsprg	3,r4
+	lwz	r4,SL_SPRG4(r11)
+	mtsprg	4,r4
+	lwz	r4,SL_SPRG5(r11)
+	mtsprg	5,r4
+	lwz	r4,SL_SPRG6(r11)
+	mtsprg	6,r4
+	lwz	r4,SL_SPRG7(r11)
+	mtsprg	7,r4
+
+	/* Invalidate TLB0 & TLB1 */
+	li	r6,0x04
+	tlbivax 0,r6
+	TLBSYNC
+	li	r6,0x0c
+	tlbivax 0,r6
+	TLBSYNC
+
+	/* restore the MSR */
+	lwz	r3,SL_MSR(r11)
+
+	/* Restore TB */
+	li	r3,0
+	mttbl	r3
+	lwz	r3,SL_TBU(r11)
+	lwz	r4,SL_TBL(r11)
+	mttbu	r3
+	mttbl	r4
+
+	/* Restore TCR and clear any pending bits in TSR. */
+	lwz	r4,SL_TCR(r11)
+	mtspr	SPRN_TCR,r4
+	lis	r4, (TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS)@h
+	mtspr	SPRN_TSR,r4
+
+	/* Kick decrementer */
+	li	r0,1
+	mtdec	r0
+
+	/* Restore the callee-saved registers and return */
+	lwz	r0,SL_CR(r11)
+	mtcr	r0
+	lwz	r2,SL_R2(r11)
+	lmw	r12,SL_R12(r11)
+	lwz	r1,SL_SP(r11)
+	lwz	r0,SL_LR(r11)
+	mtlr	r0
+
+	li	r3,0
+	blr
-- 
1.7.0
