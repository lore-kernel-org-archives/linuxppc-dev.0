Return-Path: <spopovyc@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yn5nh0NCLzDql1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 03:38:31 +1100 (AEDT)
From: Serhii Popovych <spopovyc@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: michael@ellerman.id.au, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, david@gibson.dropbear.id.au
Subject: [PATCH 3/4] KVM: PPC: Book3S HV: Fix use after free in case of
 multiple resize requests
Date: Wed, 29 Nov 2017 11:38:25 -0500
Message-Id: <1511973506-65683-4-git-send-email-spopovyc@redhat.com>
In-Reply-To: <1511973506-65683-1-git-send-email-spopovyc@redhat.com>
References: <1511973506-65683-1-git-send-email-spopovyc@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When serving multiple resize requests following could happen:

    CPU0                                    CPU1
    ----                                    ----
    kvm_vm_ioctl_resize_hpt_prepare(1);
      -> schedule_work()
                                            /* system_rq might be busy: delay */
    kvm_vm_ioctl_resize_hpt_prepare(2);
      mutex_lock();
      if (resize) {
         ...
         release_hpt_resize();
      }
      ...                                   resize_hpt_prepare_work()
      -> schedule_work()                    {
      mutex_unlock()                           /* resize->kvm could be wrong */
                                               struct kvm *kvm = resize->kvm;

                                               mutex_lock(&kvm->lock);   <<<< UAF
                                               ...
                                            }

Since scheduled work could be delayed (e.g. when system is busy) we
another resize request with different order could be promoted by
kvm_vm_ioctl_resize_hpt_prepare() and previous request could be
freed right before resize_hpt_prepare_work() begins execution or
right under mutex_lock() when it is executed in parallel with ioctl.

In both cases we get use after free in point marked with UAF on the
diagram above.

To prevent this from happening we must not release previous request
immediately in ioctl instead postponing this to resize_hpt_prepare_work().

Make resize_hpt_release() generic: we use it in more cases.

This fixes following or similar host kernel crash message:

[  635.277361] Unable to handle kernel paging request for data at address 0x00000000
[  635.277438] Faulting instruction address: 0xc00000000052f568
[  635.277446] Oops: Kernel access of bad area, sig: 11 [#1]
[  635.277451] SMP NR_CPUS=2048 NUMA PowerNV
[  635.277470] Modules linked in: xt_CHECKSUM iptable_mangle ipt_MASQUERADE
nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4
nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 tun bridge stp llc
ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter nfsv3 nfs_acl nfs
lockd grace fscache kvm_hv kvm rpcrdma sunrpc ib_isert iscsi_target_mod ib_iser libiscsi
scsi_transport_iscsi ib_srpt target_core_mod ext4 ib_srp scsi_transport_srp
ib_ipoib mbcache jbd2 rdma_ucm ib_ucm ib_uverbs ib_umad rdma_cm ib_cm iw_cm ocrdma(T)
ib_core ses enclosure scsi_transport_sas sg shpchp leds_powernv ibmpowernv i2c_opal
i2c_core powernv_rng ipmi_powernv ipmi_devintf ipmi_msghandler ip_tables xfs
libcrc32c sr_mod sd_mod cdrom lpfc nvme_fc(T) nvme_fabrics nvme_core ipr nvmet_fc(T)
tg3 nvmet libata be2net crc_t10dif crct10dif_generic scsi_transport_fc ptp scsi_tgt
pps_core crct10dif_common dm_mirror dm_region_hash dm_log dm_mod
[  635.278687] CPU: 40 PID: 749 Comm: kworker/40:1 Tainted: G
------------ T 3.10.0.bz1510771+ #1
[  635.278782] Workqueue: events resize_hpt_prepare_work [kvm_hv]
[  635.278851] task: c0000007e6840000 ti: c0000007e9180000 task.ti: c0000007e9180000
[  635.278919] NIP: c00000000052f568 LR: c0000000009ea310 CTR: c0000000009ea4f0
[  635.278988] REGS: c0000007e91837f0 TRAP: 0300   Tainted: G
------------ T  (3.10.0.bz1510771+)
[  635.279077] MSR: 9000000100009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 24002022  XER:
00000000
[  635.279248] CFAR: c000000000009368 DAR: 0000000000000000 DSISR: 40000000 SOFTE: 1
GPR00: c0000000009ea310 c0000007e9183a70 c000000001250b00 c0000007e9183b10
GPR04: 0000000000000000 0000000000000000 c0000007e9183650 0000000000000000
GPR08: c0000007ffff7b80 00000000ffffffff 0000000080000028 d00000000d2529a0
GPR12: 0000000000002200 c000000007b56800 c000000000120028 c0000007f135bb40
GPR16: 0000000000000000 c000000005c1e018 c000000005c1e018 0000000000000000
GPR20: 0000000000000001 c0000000011bf778 0000000000000001 fffffffffffffef7
GPR24: 0000000000000000 c000000f1e262e50 0000000000000002 c0000007e9180000
GPR28: c000000f1e262e4c c000000f1e262e50 0000000000000000 c0000007e9183b10
[  635.280149] NIP [c00000000052f568] __list_add+0x38/0x110
[  635.280197] LR [c0000000009ea310] __mutex_lock_slowpath+0xe0/0x2c0
[  635.280253] Call Trace:
[  635.280277] [c0000007e9183af0] [c0000000009ea310] __mutex_lock_slowpath+0xe0/0x2c0
[  635.280356] [c0000007e9183b70] [c0000000009ea554] mutex_lock+0x64/0x70
[  635.280426] [c0000007e9183ba0] [d00000000d24da04]
resize_hpt_prepare_work+0xe4/0x1c0 [kvm_hv]
[  635.280507] [c0000007e9183c40] [c000000000113c0c] process_one_work+0x1dc/0x680
[  635.280587] [c0000007e9183ce0] [c000000000114250] worker_thread+0x1a0/0x520
[  635.280655] [c0000007e9183d80] [c00000000012010c] kthread+0xec/0x100
[  635.280724] [c0000007e9183e30] [c00000000000a4b8] ret_from_kernel_thread+0x5c/0xa4
[  635.280814] Instruction dump:
[  635.280880] 7c0802a6 fba1ffe8 fbc1fff0 7cbd2b78 fbe1fff8 7c9e2378 7c7f1b78
f8010010
[  635.281099] f821ff81 e8a50008 7fa52040 40de00b8 <e8be0000> 7fbd2840 40de008c
7fbff040
[  635.281324] ---[ end trace b628b73449719b9d ]---

Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 45 ++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 3e9abd9..690f061 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1417,15 +1417,18 @@ static void resize_hpt_pivot(struct kvm_resize_hpt *resize)
 
 static void resize_hpt_release(struct kvm *kvm, struct kvm_resize_hpt *resize)
 {
-	BUG_ON(kvm->arch.resize_hpt != resize);
+	BUG_ON(!mutex_is_locked(&kvm->lock));
 
 	if (!resize)
 		return;
 
-	kvmppc_free_hpt(&resize->hpt);
+	if (resize->error != -EBUSY) {
+		kvmppc_free_hpt(&resize->hpt);
+		kfree(resize);
+	}
 
-	kvm->arch.resize_hpt = NULL;
-	kfree(resize);
+	if (kvm->arch.resize_hpt == resize)
+		kvm->arch.resize_hpt = NULL;
 }
 
 static void resize_hpt_prepare_work(struct work_struct *work)
@@ -1434,24 +1437,40 @@ static void resize_hpt_prepare_work(struct work_struct *work)
 						     struct kvm_resize_hpt,
 						     work);
 	struct kvm *kvm = resize->kvm;
-	int err;
+	int err = 0;
 
 	BUG_ON(resize->error != -EBUSY);
 
-	resize_hpt_debug(resize, "resize_hpt_prepare_work(): order = %d\n",
-			 resize->order);
+	mutex_lock(&kvm->lock);
+
+	/* Request is still current? */
+	if (kvm->arch.resize_hpt == resize) {
+		/* We may request large allocations here:
+		 * do not sleep with kvm->lock held for a while.
+		 */
+		mutex_unlock(&kvm->lock);
 
-	err = resize_hpt_allocate(resize);
+		resize_hpt_debug(resize, "resize_hpt_prepare_work(): order = %d\n",
+				 resize->order);
 
-	/* We have strict assumption about -EBUSY
-	 * when preparing for HPT resize.
-	 */
-	BUG_ON(err == -EBUSY);
+		err = resize_hpt_allocate(resize);
 
-	mutex_lock(&kvm->lock);
+		/* We have strict assumption about -EBUSY
+		 * when preparing for HPT resize.
+		 */
+		BUG_ON(err == -EBUSY);
+
+		mutex_lock(&kvm->lock);
+		/* It is possible that kvm->arch.resize_hpt != resize
+		 * after we grab kvm->lock again.
+		 */
+	}
 
 	resize->error = err;
 
+	if (kvm->arch.resize_hpt != resize)
+		resize_hpt_release(kvm, resize);
+
 	mutex_unlock(&kvm->lock);
 }
 
-- 
1.8.3.1
