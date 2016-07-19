Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtt9211xRzDqNp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 18:13:42 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id g202so935950pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 01:13:42 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: sjitindarsingh@gmail.com, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org,
 pbonzini@redhat.com, agraf@suse.com, rkrcmar@redhat.com,
 dmatlack@google.com, borntraeger@de.ibm.com
Subject: [PATCH V4 4/5] kvm/stats: Add provisioning for ulong vm stats and u64
 vcpu stats
Date: Tue, 19 Jul 2016 18:12:56 +1000
Message-Id: <1468915977-26929-4-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1468915977-26929-1-git-send-email-sjitindarsingh@gmail.com>
References: <1468915977-26929-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

vms and vcpus have statistics associated with them which can be viewed
within the debugfs. Currently it is assumed within the vcpu_stat_get() and
vm_stat_get() functions that all of these statistics are represented as
u32s, however the next patch adds some u64 vcpu statistics.

Change all vcpu statistics to u64 and modify vcpu_stat_get() accordingly.
Since vcpu statistics are per vcpu, they will only be updated by a single
vcpu at a time so this shouldn't present a problem on 32-bit machines
which can't atomically increment 64-bit numbers. However vm statistics
could potentially be updated by multiple vcpus from that vm at a time.
To avoid the overhead of atomics make all vm statistics ulong such that
they are 64-bit on 64-bit systems where they can be atomically incremented
and are 32-bit on 32-bit systems which may not be able to atomically
increment 64-bit numbers. Modify vm_stat_get() to expect ulongs.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

---
Change Log:

V2 -> V3:
	- Instead of implementing separate u32 and u64 functions keep the
	  generic functions and modify them to expect u64s. Thus update all
	  vm and vcpu statistics to u64s accordingly.
V3 -> V4:
	- Change vm_stats from u64 to ulong
---
 arch/arm/include/asm/kvm_host.h     |  12 ++--
 arch/arm64/include/asm/kvm_host.h   |  12 ++--
 arch/mips/include/asm/kvm_host.h    |  46 ++++++-------
 arch/powerpc/include/asm/kvm_host.h |  60 ++++++++---------
 arch/s390/include/asm/kvm_host.h    | 128 ++++++++++++++++++------------------
 arch/x86/include/asm/kvm_host.h     |  72 ++++++++++----------
 virt/kvm/kvm_main.c                 |   4 +-
 7 files changed, 167 insertions(+), 167 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 96387d4..c8e55b3b 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -183,15 +183,15 @@ struct kvm_vcpu_arch {
 };
 
 struct kvm_vm_stat {
-	u32 remote_tlb_flush;
+	ulong remote_tlb_flush;
 };
 
 struct kvm_vcpu_stat {
-	u32 halt_successful_poll;
-	u32 halt_attempted_poll;
-	u32 halt_poll_invalid;
-	u32 halt_wakeup;
-	u32 hvc_exit_stat;
+	u64 halt_successful_poll;
+	u64 halt_attempted_poll;
+	u64 halt_poll_invalid;
+	u64 halt_wakeup;
+	u64 hvc_exit_stat;
 	u64 wfe_exit_stat;
 	u64 wfi_exit_stat;
 	u64 mmio_exit_user;
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 49095fc..b14c8bc 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -291,15 +291,15 @@ struct kvm_vcpu_arch {
 #endif
 
 struct kvm_vm_stat {
-	u32 remote_tlb_flush;
+	ulong remote_tlb_flush;
 };
 
 struct kvm_vcpu_stat {
-	u32 halt_successful_poll;
-	u32 halt_attempted_poll;
-	u32 halt_poll_invalid;
-	u32 halt_wakeup;
-	u32 hvc_exit_stat;
+	u64 halt_successful_poll;
+	u64 halt_attempted_poll;
+	u64 halt_poll_invalid;
+	u64 halt_wakeup;
+	u64 hvc_exit_stat;
 	u64 wfe_exit_stat;
 	u64 wfi_exit_stat;
 	u64 mmio_exit_user;
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 36a391d..9704888 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -98,32 +98,32 @@ extern void (*kvm_mips_release_pfn_clean)(kvm_pfn_t pfn);
 extern bool (*kvm_mips_is_error_pfn)(kvm_pfn_t pfn);
 
 struct kvm_vm_stat {
-	u32 remote_tlb_flush;
+	ulong remote_tlb_flush;
 };
 
 struct kvm_vcpu_stat {
-	u32 wait_exits;
-	u32 cache_exits;
-	u32 signal_exits;
-	u32 int_exits;
-	u32 cop_unusable_exits;
-	u32 tlbmod_exits;
-	u32 tlbmiss_ld_exits;
-	u32 tlbmiss_st_exits;
-	u32 addrerr_st_exits;
-	u32 addrerr_ld_exits;
-	u32 syscall_exits;
-	u32 resvd_inst_exits;
-	u32 break_inst_exits;
-	u32 trap_inst_exits;
-	u32 msa_fpe_exits;
-	u32 fpe_exits;
-	u32 msa_disabled_exits;
-	u32 flush_dcache_exits;
-	u32 halt_successful_poll;
-	u32 halt_attempted_poll;
-	u32 halt_poll_invalid;
-	u32 halt_wakeup;
+	u64 wait_exits;
+	u64 cache_exits;
+	u64 signal_exits;
+	u64 int_exits;
+	u64 cop_unusable_exits;
+	u64 tlbmod_exits;
+	u64 tlbmiss_ld_exits;
+	u64 tlbmiss_st_exits;
+	u64 addrerr_st_exits;
+	u64 addrerr_ld_exits;
+	u64 syscall_exits;
+	u64 resvd_inst_exits;
+	u64 break_inst_exits;
+	u64 trap_inst_exits;
+	u64 msa_fpe_exits;
+	u64 fpe_exits;
+	u64 msa_disabled_exits;
+	u64 flush_dcache_exits;
+	u64 halt_successful_poll;
+	u64 halt_attempted_poll;
+	u64 halt_poll_invalid;
+	u64 halt_wakeup;
 };
 
 enum kvm_mips_exit_types {
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 610f393..f6304c5 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -95,41 +95,41 @@ struct kvmppc_vcpu_book3s;
 struct kvmppc_book3s_shadow_vcpu;
 
 struct kvm_vm_stat {
-	u32 remote_tlb_flush;
+	ulong remote_tlb_flush;
 };
 
 struct kvm_vcpu_stat {
-	u32 sum_exits;
-	u32 mmio_exits;
-	u32 signal_exits;
-	u32 light_exits;
+	u64 sum_exits;
+	u64 mmio_exits;
+	u64 signal_exits;
+	u64 light_exits;
 	/* Account for special types of light exits: */
-	u32 itlb_real_miss_exits;
-	u32 itlb_virt_miss_exits;
-	u32 dtlb_real_miss_exits;
-	u32 dtlb_virt_miss_exits;
-	u32 syscall_exits;
-	u32 isi_exits;
-	u32 dsi_exits;
-	u32 emulated_inst_exits;
-	u32 dec_exits;
-	u32 ext_intr_exits;
-	u32 halt_successful_poll;
-	u32 halt_attempted_poll;
-	u32 halt_poll_invalid;
-	u32 halt_wakeup;
-	u32 dbell_exits;
-	u32 gdbell_exits;
-	u32 ld;
-	u32 st;
+	u64 itlb_real_miss_exits;
+	u64 itlb_virt_miss_exits;
+	u64 dtlb_real_miss_exits;
+	u64 dtlb_virt_miss_exits;
+	u64 syscall_exits;
+	u64 isi_exits;
+	u64 dsi_exits;
+	u64 emulated_inst_exits;
+	u64 dec_exits;
+	u64 ext_intr_exits;
+	u64 halt_successful_poll;
+	u64 halt_attempted_poll;
+	u64 halt_poll_invalid;
+	u64 halt_wakeup;
+	u64 dbell_exits;
+	u64 gdbell_exits;
+	u64 ld;
+	u64 st;
 #ifdef CONFIG_PPC_BOOK3S
-	u32 pf_storage;
-	u32 pf_instruc;
-	u32 sp_storage;
-	u32 sp_instruc;
-	u32 queue_intr;
-	u32 ld_slow;
-	u32 st_slow;
+	u64 pf_storage;
+	u64 pf_instruc;
+	u64 sp_storage;
+	u64 sp_instruc;
+	u64 queue_intr;
+	u64 ld_slow;
+	u64 st_slow;
 #endif
 };
 
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index ac82e8e..bdacd9c 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -238,69 +238,69 @@ struct sie_page {
 } __packed;
 
 struct kvm_vcpu_stat {
-	u32 exit_userspace;
-	u32 exit_null;
-	u32 exit_external_request;
-	u32 exit_external_interrupt;
-	u32 exit_stop_request;
-	u32 exit_validity;
-	u32 exit_instruction;
-	u32 exit_pei;
-	u32 halt_successful_poll;
-	u32 halt_attempted_poll;
-	u32 halt_poll_invalid;
-	u32 halt_wakeup;
-	u32 instruction_lctl;
-	u32 instruction_lctlg;
-	u32 instruction_stctl;
-	u32 instruction_stctg;
-	u32 exit_program_interruption;
-	u32 exit_instr_and_program;
-	u32 deliver_external_call;
-	u32 deliver_emergency_signal;
-	u32 deliver_service_signal;
-	u32 deliver_virtio_interrupt;
-	u32 deliver_stop_signal;
-	u32 deliver_prefix_signal;
-	u32 deliver_restart_signal;
-	u32 deliver_program_int;
-	u32 deliver_io_int;
-	u32 exit_wait_state;
-	u32 instruction_pfmf;
-	u32 instruction_stidp;
-	u32 instruction_spx;
-	u32 instruction_stpx;
-	u32 instruction_stap;
-	u32 instruction_storage_key;
-	u32 instruction_ipte_interlock;
-	u32 instruction_stsch;
-	u32 instruction_chsc;
-	u32 instruction_stsi;
-	u32 instruction_stfl;
-	u32 instruction_tprot;
-	u32 instruction_essa;
-	u32 instruction_sigp_sense;
-	u32 instruction_sigp_sense_running;
-	u32 instruction_sigp_external_call;
-	u32 instruction_sigp_emergency;
-	u32 instruction_sigp_cond_emergency;
-	u32 instruction_sigp_start;
-	u32 instruction_sigp_stop;
-	u32 instruction_sigp_stop_store_status;
-	u32 instruction_sigp_store_status;
-	u32 instruction_sigp_store_adtl_status;
-	u32 instruction_sigp_arch;
-	u32 instruction_sigp_prefix;
-	u32 instruction_sigp_restart;
-	u32 instruction_sigp_init_cpu_reset;
-	u32 instruction_sigp_cpu_reset;
-	u32 instruction_sigp_unknown;
-	u32 diagnose_10;
-	u32 diagnose_44;
-	u32 diagnose_9c;
-	u32 diagnose_258;
-	u32 diagnose_308;
-	u32 diagnose_500;
+	u64 exit_userspace;
+	u64 exit_null;
+	u64 exit_external_request;
+	u64 exit_external_interrupt;
+	u64 exit_stop_request;
+	u64 exit_validity;
+	u64 exit_instruction;
+	u64 exit_pei;
+	u64 halt_successful_poll;
+	u64 halt_attempted_poll;
+	u64 halt_poll_invalid;
+	u64 halt_wakeup;
+	u64 instruction_lctl;
+	u64 instruction_lctlg;
+	u64 instruction_stctl;
+	u64 instruction_stctg;
+	u64 exit_program_interruption;
+	u64 exit_instr_and_program;
+	u64 deliver_external_call;
+	u64 deliver_emergency_signal;
+	u64 deliver_service_signal;
+	u64 deliver_virtio_interrupt;
+	u64 deliver_stop_signal;
+	u64 deliver_prefix_signal;
+	u64 deliver_restart_signal;
+	u64 deliver_program_int;
+	u64 deliver_io_int;
+	u64 exit_wait_state;
+	u64 instruction_pfmf;
+	u64 instruction_stidp;
+	u64 instruction_spx;
+	u64 instruction_stpx;
+	u64 instruction_stap;
+	u64 instruction_storage_key;
+	u64 instruction_ipte_interlock;
+	u64 instruction_stsch;
+	u64 instruction_chsc;
+	u64 instruction_stsi;
+	u64 instruction_stfl;
+	u64 instruction_tprot;
+	u64 instruction_essa;
+	u64 instruction_sigp_sense;
+	u64 instruction_sigp_sense_running;
+	u64 instruction_sigp_external_call;
+	u64 instruction_sigp_emergency;
+	u64 instruction_sigp_cond_emergency;
+	u64 instruction_sigp_start;
+	u64 instruction_sigp_stop;
+	u64 instruction_sigp_stop_store_status;
+	u64 instruction_sigp_store_status;
+	u64 instruction_sigp_store_adtl_status;
+	u64 instruction_sigp_arch;
+	u64 instruction_sigp_prefix;
+	u64 instruction_sigp_restart;
+	u64 instruction_sigp_init_cpu_reset;
+	u64 instruction_sigp_cpu_reset;
+	u64 instruction_sigp_unknown;
+	u64 diagnose_10;
+	u64 diagnose_44;
+	u64 diagnose_9c;
+	u64 diagnose_258;
+	u64 diagnose_308;
+	u64 diagnose_500;
 };
 
 #define PGM_OPERATION			0x01
@@ -563,7 +563,7 @@ struct kvm_vcpu_arch {
 };
 
 struct kvm_vm_stat {
-	u32 remote_tlb_flush;
+	ulong remote_tlb_flush;
 };
 
 struct kvm_arch_memory_slot {
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 69e62862..c30462f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -782,45 +782,45 @@ struct kvm_arch {
 };
 
 struct kvm_vm_stat {
-	u32 mmu_shadow_zapped;
-	u32 mmu_pte_write;
-	u32 mmu_pte_updated;
-	u32 mmu_pde_zapped;
-	u32 mmu_flooded;
-	u32 mmu_recycled;
-	u32 mmu_cache_miss;
-	u32 mmu_unsync;
-	u32 remote_tlb_flush;
-	u32 lpages;
+	ulong mmu_shadow_zapped;
+	ulong mmu_pte_write;
+	ulong mmu_pte_updated;
+	ulong mmu_pde_zapped;
+	ulong mmu_flooded;
+	ulong mmu_recycled;
+	ulong mmu_cache_miss;
+	ulong mmu_unsync;
+	ulong remote_tlb_flush;
+	ulong lpages;
 };
 
 struct kvm_vcpu_stat {
-	u32 pf_fixed;
-	u32 pf_guest;
-	u32 tlb_flush;
-	u32 invlpg;
-
-	u32 exits;
-	u32 io_exits;
-	u32 mmio_exits;
-	u32 signal_exits;
-	u32 irq_window_exits;
-	u32 nmi_window_exits;
-	u32 halt_exits;
-	u32 halt_successful_poll;
-	u32 halt_attempted_poll;
-	u32 halt_poll_invalid;
-	u32 halt_wakeup;
-	u32 request_irq_exits;
-	u32 irq_exits;
-	u32 host_state_reload;
-	u32 efer_reload;
-	u32 fpu_reload;
-	u32 insn_emulation;
-	u32 insn_emulation_fail;
-	u32 hypercalls;
-	u32 irq_injections;
-	u32 nmi_injections;
+	u64 pf_fixed;
+	u64 pf_guest;
+	u64 tlb_flush;
+	u64 invlpg;
+
+	u64 exits;
+	u64 io_exits;
+	u64 mmio_exits;
+	u64 signal_exits;
+	u64 irq_window_exits;
+	u64 nmi_window_exits;
+	u64 halt_exits;
+	u64 halt_successful_poll;
+	u64 halt_attempted_poll;
+	u64 halt_poll_invalid;
+	u64 halt_wakeup;
+	u64 request_irq_exits;
+	u64 irq_exits;
+	u64 host_state_reload;
+	u64 efer_reload;
+	u64 fpu_reload;
+	u64 insn_emulation;
+	u64 insn_emulation_fail;
+	u64 hypercalls;
+	u64 irq_injections;
+	u64 nmi_injections;
 };
 
 struct x86_instruction_info;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 48bd520..37a6530 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3531,7 +3531,7 @@ static int vm_stat_get_per_vm(void *data, u64 *val)
 {
 	struct kvm_stat_data *stat_data = (struct kvm_stat_data *)data;
 
-	*val = *(u32 *)((void *)stat_data->kvm + stat_data->offset);
+	*val = *(ulong *)((void *)stat_data->kvm + stat_data->offset);
 
 	return 0;
 }
@@ -3561,7 +3561,7 @@ static int vcpu_stat_get_per_vm(void *data, u64 *val)
 	*val = 0;
 
 	kvm_for_each_vcpu(i, vcpu, stat_data->kvm)
-		*val += *(u32 *)((void *)vcpu + stat_data->offset);
+		*val += *(u64 *)((void *)vcpu + stat_data->offset);
 
 	return 0;
 }
-- 
2.5.5
