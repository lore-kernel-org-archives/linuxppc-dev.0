Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C9B8DB7C34
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 02:47:35 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm@vger.kernel.org
Subject: [PATCH 04/27] Add Book3s fields to vcpu structs
Date: Fri, 30 Oct 2009 16:47:04 +0100
Message-Id: <1256917647-6200-5-git-send-email-agraf@suse.de>
In-Reply-To: <1256917647-6200-1-git-send-email-agraf@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, bphilips@suse.de,
	Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to store more information than we currently have for vcpus
when running on Book3s.

So let's extend the internal struct definitions.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v3 -> v4:

  - use context_id instead of mm_context

v4 -> v5:

  - always include pvr in vcpu struct
---
 arch/powerpc/include/asm/kvm_host.h |   73 ++++++++++++++++++++++++++++++++++-
 1 files changed, 72 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index c9c930e..2cff5fe 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -37,6 +37,8 @@
 #define KVM_NR_PAGE_SIZES	1
 #define KVM_PAGES_PER_HPAGE(x)	(1UL<<31)
 
+#define HPTEG_CACHE_NUM 1024
+
 struct kvm;
 struct kvm_run;
 struct kvm_vcpu;
@@ -63,6 +65,17 @@ struct kvm_vcpu_stat {
 	u32 dec_exits;
 	u32 ext_intr_exits;
 	u32 halt_wakeup;
+#ifdef CONFIG_PPC64
+	u32 pf_storage;
+	u32 pf_instruc;
+	u32 sp_storage;
+	u32 sp_instruc;
+	u32 queue_intr;
+	u32 ld;
+	u32 ld_slow;
+	u32 st;
+	u32 st_slow;
+#endif
 };
 
 enum kvm_exit_types {
@@ -109,9 +122,53 @@ struct kvmppc_exit_timing {
 struct kvm_arch {
 };
 
+struct kvmppc_pte {
+	u64 eaddr;
+	u64 vpage;
+	u64 raddr;
+	bool may_read;
+	bool may_write;
+	bool may_execute;
+};
+
+struct kvmppc_mmu {
+	/* book3s_64 only */
+	void (*slbmte)(struct kvm_vcpu *vcpu, u64 rb, u64 rs);
+	u64  (*slbmfee)(struct kvm_vcpu *vcpu, u64 slb_nr);
+	u64  (*slbmfev)(struct kvm_vcpu *vcpu, u64 slb_nr);
+	void (*slbie)(struct kvm_vcpu *vcpu, u64 slb_nr);
+	void (*slbia)(struct kvm_vcpu *vcpu);
+	/* book3s */
+	void (*mtsrin)(struct kvm_vcpu *vcpu, u32 srnum, ulong value);
+	u32  (*mfsrin)(struct kvm_vcpu *vcpu, u32 srnum);
+	int  (*xlate)(struct kvm_vcpu *vcpu, gva_t eaddr, struct kvmppc_pte *pte, bool data);
+	void (*reset_msr)(struct kvm_vcpu *vcpu);
+	void (*tlbie)(struct kvm_vcpu *vcpu, ulong addr, bool large);
+	int  (*esid_to_vsid)(struct kvm_vcpu *vcpu, u64 esid, u64 *vsid);
+	u64  (*ea_to_vp)(struct kvm_vcpu *vcpu, gva_t eaddr, bool data);
+	bool (*is_dcbz32)(struct kvm_vcpu *vcpu);
+};
+
+struct hpte_cache {
+	u64 host_va;
+	u64 pfn;
+	ulong slot;
+	struct kvmppc_pte pte;
+};
+
 struct kvm_vcpu_arch {
-	u32 host_stack;
+	ulong host_stack;
 	u32 host_pid;
+#ifdef CONFIG_PPC64
+	ulong host_msr;
+	ulong host_r2;
+	void *host_retip;
+	ulong trampoline_lowmem;
+	ulong trampoline_enter;
+	ulong highmem_handler;
+	ulong host_paca_phys;
+	struct kvmppc_mmu mmu;
+#endif
 
 	u64 fpr[32];
 	ulong gpr[32];
@@ -123,6 +180,10 @@ struct kvm_vcpu_arch {
 	ulong xer;
 
 	ulong msr;
+#ifdef CONFIG_PPC64
+	ulong shadow_msr;
+	ulong hflags;
+#endif
 	u32 mmucr;
 	ulong sprg0;
 	ulong sprg1;
@@ -149,6 +210,7 @@ struct kvm_vcpu_arch {
 	u32 ivor[64];
 	ulong ivpr;
 	u32 pir;
+	u32 pvr;
 
 	u32 shadow_pid;
 	u32 pid;
@@ -174,6 +236,9 @@ struct kvm_vcpu_arch {
 #endif
 
 	u32 last_inst;
+#ifdef CONFIG_PPC64
+	ulong fault_dsisr;
+#endif
 	ulong fault_dear;
 	ulong fault_esr;
 	gpa_t paddr_accessed;
@@ -186,7 +251,13 @@ struct kvm_vcpu_arch {
 	u32 cpr0_cfgaddr; /* holds the last set cpr0_cfgaddr */
 
 	struct timer_list dec_timer;
+	u64 dec_jiffies;
 	unsigned long pending_exceptions;
+
+#ifdef CONFIG_PPC64
+	struct hpte_cache hpte_cache[HPTEG_CACHE_NUM];
+	int hpte_cache_offset;
+#endif
 };
 
 #endif /* __POWERPC_KVM_HOST_H__ */
-- 
1.6.0.2
