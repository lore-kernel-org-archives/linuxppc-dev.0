Return-Path: <chenyu105@gmail.com>
Received: from mail-pd0-x234.google.com (mail-pd0-x234.google.com
 [IPv6:2607:f8b0:400e:c02::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6F1AE2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Sep 2013 00:32:50 +1000 (EST)
Received: by mail-pd0-f180.google.com with SMTP id y10so4801267pdj.39
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Sep 2013 07:32:46 -0700 (PDT)
From: Yu Chen <chenyu105@gmail.com>
To: galak@kernel.crashing.org, wangshilong1991@gmail.com,
 chenhui.zhao@freescale.com, lu.zhongjun@zte.com.cn, liu.xiang6@zte.com.cn
Subject: [PATCH] [RFC PATCH v1 1/1] powerpc/85xx: Wakeup kexec smp slave cpus
 in second kernel
Date: Tue,  3 Sep 2013 06:19:17 +0800
Message-Id: <1378160357-3653-1-git-send-email-chenyu105@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Chen Yu <chen.yu10@zte.com.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Chen Yu <chen.yu10@zte.com.cn>

In current 85xx smp kexec implementation,master cpu reset slave cpus by mpic_reset_core,
before jump to second kernel.In order to wake slave cpus up in second kernel,we debug
this patch on p2041rdb.

The main principle of this patch,is to get slave cpus polling for flag to change,
thus waiting for master cpu to set it with non-zero cpu number(see misc_32.S).
This flag is placed in kexec control page,so it would not be overlapped when copying kimage.
The master cpu put flag's physical address in r28 as a parameter passed to second kernel,
so the latter knows how to wake slave cpus up in smp_85xx_kick_cpu.
The pseudo-code may be like:
void slave_cpu_spin(void)
{
	int cpu = smp_processor_id();
	while (*kexec_poll != cpu)
		;
	/*slave wakeup and jump*/
	jump(*(kexec_poll+1));
}

void master_cpu_wakeup(unsigned long *kexec_poll, int cpu)
{
	*(kexec_poll+1) = __early_start;
	mb();
	*kexec_poll = cpu;
}

However,after applied this patch,we got some kernel exception during booting second kernel,
I'm not sure if it's caused by improper treament of cache,or tlb,or other.So I put this
patch here hoping someone can check and review it.

Signed-off-by: Chen Yu <chen.yu10@zte.com.cn>
---
 arch/powerpc/include/asm/kexec.h     |    7 ++
 arch/powerpc/kernel/head_fsl_booke.S |    6 ++
 arch/powerpc/kernel/misc_32.S        |   63 +++++++++++++
 arch/powerpc/platforms/85xx/smp.c    |  162 +++++++++++++++++++++++++++++++---
 4 files changed, 224 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 16d7e33..a70f480 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -87,6 +87,13 @@ extern int overlaps_crashkernel(unsigned long start, unsigned long size);
 extern void reserve_crashkernel(void);
 extern void machine_kexec_mask_interrupts(void);
 
+#ifdef CONFIG_FSL_BOOKE
+#define KEXEC_MAGIC 0xdeadbeef
+#define KEXEC_RESERVE_LIMIT 0x10
+extern const unsigned int relocate_smp_cpu_size;
+extern const unsigned char  relocate_smp_cpu_wait[];
+extern const unsigned int relocate_smp_cpu_offset;
+#endif
 #else /* !CONFIG_KEXEC */
 static inline void crash_kexec_secondary(struct pt_regs *regs) { }
 
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index d10a7ca..497f1dc 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -178,6 +178,12 @@ _ENTRY(__early_start)
 	 * This is where the main kernel code starts.
 	 */
 
+#if defined(CONFIG_KEXEC) && defined(CONFIG_SMP)
+	/* r28 contain position where slave cpus spin*/
+	lis	r1,kexec_poll_phy@h
+	ori	r1,r1,kexec_poll_phy@l
+	stw	r28,0(r1)
+#endif
 	/* ptr to current */
 	lis	r2,init_task@h
 	ori	r2,r2,init_task@l
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index e469f30..5562306 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -707,6 +707,16 @@ relocate_new_kernel:
 	mr	r30, r4
 	mr	r31, r5
 
+#ifdef CONFIG_SMP
+	bl	1f
+1:	mflr	r8
+	addi	r8,r8,kexec_flag-1b
+	lis     r7,PAGE_OFFSET@h
+	ori     r7,r7,PAGE_OFFSET@l
+	/*r28 contain slave cpu spin physical address */
+	subf	r28, r7, r8
+#endif
+
 #define ENTRY_MAPPING_KEXEC_SETUP
 #include "fsl_booke_entry_mapping.S"
 #undef ENTRY_MAPPING_KEXEC_SETUP
@@ -1172,4 +1182,57 @@ relocate_new_kernel_end:
 	.globl relocate_new_kernel_size
 relocate_new_kernel_size:
 	.long relocate_new_kernel_end - relocate_new_kernel
+#ifdef CONFIG_FSL_BOOKE
+	/**
+	* Slave cpus wait for kexec_flag to change
+	*/
+	.globl relocate_smp_cpu_offset
+relocate_smp_cpu_offset:
+	.long relocate_smp_cpu_wait-relocate_new_kernel
+
+	.globl relocate_smp_cpu_wait
+relocate_smp_cpu_wait:
+
+	bl	1f
+1:	mflr	r5
+	addi	r5,r5,kexec_flag-1b
+	/*see if anyone calls me?*/
+	mfspr   r24,SPRN_PIR
+99:	lwz	r4,4(r5)
+	cmpw	r4,r24
+	msync
+	bne		99b
+
+	msync
+	/*r4 contains jump address*/
+	lwz	r4,8(r5)
+	msync
+	lis	r5,MSR_KERNEL@h
+	ori	r5,r5,MSR_KERNEL@l
+	msync
+	isync
+	mtspr	SPRN_SRR1, r5
+	mtspr	SPRN_SRR0, r4
+	msync
+	isync
+	rfi
+	isync
+1:	b	1b
+
+	/**
+	* kexec_flag indicates a kexec magic
+	* kexec_flag+4 bytes supposed to be set with cpu number
+	* kexec_flag+8 countain addr for slave cpu to jump into
+	*/
+	.globl kexec_flag
+kexec_flag:
+	.long   KEXEC_MAGIC
+	.long	0
+	.long	0
+relocate_smp_cpu_wait_end:
+	.globl relocate_smp_cpu_size
+relocate_smp_cpu_size:
+	.long relocate_smp_cpu_wait_end-relocate_smp_cpu_wait
+#endif
+
 #endif
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 6a17599..4dc8366 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -141,6 +141,73 @@ static inline u32 read_spin_table_addr_l(void *spin_table)
 	return in_be32(&((struct epapr_spin_table *)spin_table)->addr_l);
 }
 
+#ifdef CONFIG_KEXEC
+
+unsigned long kexec_poll_phy __init_task_data;
+
+void reserve_kexec_bootmem(unsigned long poll_phy, int size)
+{
+	;/*fixme*/
+}
+
+/*
+ * Reserved bootmem for slave cpus kexec spin area.
+ */
+void mpc85xx_smp_reserve_kexec(void)
+{
+	unsigned long kexec_poll_virt;
+	unsigned long *kexec_magic_virt;
+
+	if (!kexec_poll_phy ||
+			kexec_poll_phy >= __max_low_memory)
+		return;
+
+	kexec_poll_virt = (unsigned long)phys_to_virt(kexec_poll_phy);
+	kexec_magic_virt = (unsigned long *)kexec_poll_virt;
+
+	if (*kexec_magic_virt == KEXEC_MAGIC)
+		reserve_kexec_bootmem(kexec_poll_phy, KEXEC_RESERVE_LIMIT);
+}
+
+/*
+ * Kick slave cpus from kexec spin area.
+ */
+int mpc85xx_smp_kick_kexec_cpus(int nr)
+{
+	unsigned long  kexec_poll_virt;
+	unsigned long *kexec_flag_virt;
+	unsigned long *kexec_magic_virt;
+	unsigned long *kexec_jump_virt;
+
+	/*verify accessible*/
+	if (!kexec_poll_phy ||
+			kexec_poll_phy >= __max_low_memory)
+		return -EBUSY;
+
+	kexec_poll_virt = (unsigned long)phys_to_virt(kexec_poll_phy);
+
+	kexec_magic_virt = (unsigned long *)kexec_poll_virt;
+	kexec_flag_virt = (unsigned long *)kexec_poll_virt + 1;
+	kexec_jump_virt = (unsigned long *)kexec_poll_virt + 2;
+
+	/*verify a valid kexec kick*/
+	if (*kexec_magic_virt == KEXEC_MAGIC) {
+		flush_dcache_range((ulong)kexec_poll_virt,
+		(ulong)kexec_poll_virt + L1_CACHE_BYTES-1);
+		*kexec_jump_virt = (unsigned long)__early_start;
+		mb();
+		/*kick cpu[nr] up*/
+		*kexec_flag_virt = nr;
+		mb();
+		flush_dcache_range((ulong)kexec_poll_virt,
+		(ulong)kexec_poll_virt + L1_CACHE_BYTES-1);
+
+		return 0;
+	}
+	return -EBUSY;
+}
+#endif
+
 static int __cpuinit smp_85xx_kick_cpu(int nr)
 {
 	unsigned long flags;
@@ -181,6 +248,10 @@ static int __cpuinit smp_85xx_kick_cpu(int nr)
 
 	local_irq_save(flags);
 #ifdef CONFIG_PPC32
+#ifdef CONFIG_KEXEC
+	if (!mpc85xx_smp_kick_kexec_cpus(nr))
+		goto kexec_kick_done;
+#endif
 #ifdef CONFIG_HOTPLUG_CPU
 	/* Corresponding to generic_set_cpu_dead() */
 	generic_set_cpu_up(nr);
@@ -226,6 +297,9 @@ static int __cpuinit smp_85xx_kick_cpu(int nr)
 	out_be32(&spin_table->addr_l, __pa(__early_start));
 	flush_spin_table(spin_table);
 
+#ifdef CONFIG_KEXEC
+kexec_kick_done:
+#endif
 	/* Wait a bit for the CPU to ack. */
 	if (!spin_event_timeout(__secondary_hold_acknowledge == hw_cpu,
 					10000, 100)) {
@@ -267,6 +341,10 @@ struct smp_ops_t smp_85xx_ops = {
 
 #ifdef CONFIG_KEXEC
 atomic_t kexec_down_cpus = ATOMIC_INIT(0);
+atomic_t kexec_ready_to_reboot = ATOMIC_INIT(0);
+atomic_t kexec_slave_finish = ATOMIC_INIT(0);
+unsigned long wait_code_buffer;
+static struct kimage *save_image;
 
 void mpc85xx_smp_kexec_cpu_down(int crash_shutdown, int secondary)
 {
@@ -274,8 +352,29 @@ void mpc85xx_smp_kexec_cpu_down(int crash_shutdown, int secondary)
 
 	if (secondary) {
 		atomic_inc(&kexec_down_cpus);
-		/* loop forever */
-		while (1);
+		mb();
+
+		if (crash_shutdown) {
+			/* loop forever */
+			while (1)
+				;
+		} else {
+			while (!atomic_read(&kexec_ready_to_reboot))
+				cpu_relax();
+			/*flush destination*/
+			if (save_image)
+				mpc85xx_smp_flush_dcache_kexec(save_image, 1);
+
+			flush_icache_range(wait_code_buffer,
+				wait_code_buffer + relocate_smp_cpu_size);
+			flush_dcache_range(wait_code_buffer,
+				wait_code_buffer + relocate_smp_cpu_size);
+
+			atomic_inc(&kexec_slave_finish);
+
+			((void (*)(void)) wait_code_buffer)();
+			/* NOTREACHED */
+		}
 	}
 }
 
@@ -285,13 +384,23 @@ static void mpc85xx_smp_kexec_down(void *arg)
 		ppc_md.kexec_cpu_down(0,1);
 }
 
-static void map_and_flush(unsigned long paddr)
+static void map_and_flush(unsigned long paddr, int atomic)
 {
 	struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
-	unsigned long kaddr  = (unsigned long)kmap(page);
+	unsigned long kaddr;
+
+	if (atomic)
+		kaddr  = (unsigned long)kmap_atomic(page);
+	else
+		kaddr  = (unsigned long)kmap(page);
 
 	flush_dcache_range(kaddr, kaddr + PAGE_SIZE);
-	kunmap(page);
+	flush_icache_range(kaddr, kaddr + PAGE_SIZE);
+
+	if (atomic)
+		kunmap_atomic((void *)kaddr);
+	else
+		kunmap(page);
 }
 
 /**
@@ -312,18 +421,18 @@ static void mpc85xx_smp_flush_dcache_kexec(struct kimage *image)
 		     ptr = (entry & IND_INDIRECTION) ?
 				phys_to_virt(entry & PAGE_MASK) : ptr + 1) {
 			if (!(entry & IND_DESTINATION)) {
-				map_and_flush(entry);
+				map_and_flush(entry, atomic);
 			}
 		}
 		/* flush out last IND_DONE page */
-		map_and_flush(entry);
+		map_and_flush(entry, atomic);
 	} else {
 		/* crash type kexec images are copied to the crash region */
 		for (i = 0; i < image->nr_segments; i++) {
 			struct kexec_segment *seg = &image->segment[i];
 			for (paddr = seg->mem; paddr < seg->mem + seg->memsz;
 			     paddr += PAGE_SIZE) {
-				map_and_flush(paddr);
+				map_and_flush(paddr, atomic);
 			}
 		}
 	}
@@ -340,8 +449,11 @@ static void mpc85xx_smp_machine_kexec(struct kimage *image)
 
 	mpc85xx_smp_flush_dcache_kexec(image);
 
-	if (image->type == KEXEC_TYPE_DEFAULT)
+	if (image->type == KEXEC_TYPE_DEFAULT) {
+		save_image = image;
+		mb();
 		smp_call_function(mpc85xx_smp_kexec_down, NULL, 0);
+	}
 
 	while ( (atomic_read(&kexec_down_cpus) != (num_cpus - 1)) &&
 		( timeout > 0 ) )
@@ -352,12 +464,34 @@ static void mpc85xx_smp_machine_kexec(struct kimage *image)
 	if ( !timeout )
 		printk(KERN_ERR "Unable to bring down secondary cpu(s)");
 
-	for_each_online_cpu(i)
-	{
-		if ( i == smp_processor_id() ) continue;
-		mpic_reset_core(i);
-	}
+	if (image->type == KEXEC_TYPE_DEFAULT) {
 
+		wait_code_buffer =
+		(unsigned long)page_address(image->control_code_page)+
+				relocate_smp_cpu_offset;
+
+		/* copy slave cpu spin code to the control code page */
+		memcpy((void *)wait_code_buffer, relocate_smp_cpu_wait,
+						relocate_smp_cpu_size);
+		atomic_set(&kexec_ready_to_reboot, 1);
+		mb();
+		timeout = INT_MAX;
+
+		while ((atomic_read(&kexec_slave_finish) != (num_cpus-1)) &&
+			(timeout > 0))
+			timeout--;
+
+		if (!timeout)
+			pr_err("Unable to wait for secondary cpu(s) to flush caches\n");
+
+		} else {
+		for_each_online_cpu(i)
+		{
+			if (i == smp_processor_id())
+				continue;
+			mpic_reset_core(i);
+		}
+	}
 	default_machine_kexec(image);
 }
 #endif /* CONFIG_KEXEC */
-- 
1.7.1
