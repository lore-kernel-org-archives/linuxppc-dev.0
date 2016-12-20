Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjRgC32j4zDwRW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 16:49:11 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	sjitindarsingh@gmail.com
Cc: benh@kernel.crashing.org, thuth@redhat.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCHv2 02/11] powerpc/kvm: HPT resizing documentation and reserved
 numbers
Date: Tue, 20 Dec 2016 16:48:58 +1100
Message-Id: <20161220054907.9204-3-david@gibson.dropbear.id.au>
In-Reply-To: <20161220054907.9204-1-david@gibson.dropbear.id.au>
References: <20161220054907.9204-1-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a new powerpc-specific KVM_CAP_SPAPR_RESIZE_HPT capability to
advertise whether KVM is capable of handling the PAPR extensions for
resizing the hashed page table during guest runtime.  It also adds
definitions for two new VM ioctl()s to implement this extension, and
documentation of the same.

Note that, HPT resizing is already possible with KVM PR without kernel
modification, since the HPT is managed within userspace (qemu).  The
capability defined here will only be set where an in-kernel implementation
of resizing is necessary, i.e. for KVM HV.  To determine if the userspace
resize implementation can be used, it's necessary to check
KVM_CAP_PPC_ALLOC_HTAB.  Unfortunately older kernels incorrectly set
KVM_CAP_PPC_ALLOC_HTAB even with KVM PR.  If userspace it want to support
resizing with KVM PR on such kernels, it will need a workaround.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 Documentation/virtual/kvm/api.txt | 95 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h          | 11 +++++
 2 files changed, 106 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 42be7b1..f452c72 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3201,6 +3201,101 @@ struct kvm_reinject_control {
 pit_reinject = 0 (!reinject mode) is recommended, unless running an old
 operating system that uses the PIT for timing (e.g. Linux 2.4.x).
 
+4.100 KVM_PPC_RESIZE_HPT_PREPARE
+
+Capability: KVM_CAP_SPAPR_RESIZE_HPT
+Architectures: powerpc
+Type: vm ioctl
+Parameters: struct kvm_ppc_resize_hpt (in)
+Returns: 0 on successful completion,
+	 >0 if a new HPT is being prepared, the value is an estimated
+             number of milliseconds until preparation is complete
+         -EFAULT if struct kvm_reinject_control cannot be read,
+	 -EINVAL if the supplied shift or flags are invalid
+	 -ENOMEM if unable to allocate the new HPT
+	 -ENOSPC if there was a hash collision when moving existing
+                  HPT entries to the new HPT
+	 -EIO on other error conditions
+
+Used to implement the PAPR extension for runtime resizing of a guest's
+Hashed Page Table (HPT).  Specifically this starts, stops or monitors
+the preparation of a new potential HPT for the guest, essentially
+implementing the H_RESIZE_HPT_PREPARE hypercall.
+
+If called with shift > 0 when there is no pending HPT for the guest,
+this begins preparation of a new pending HPT of size 2^(shift) bytes.
+It then returns a positive integer with the estimated number of
+milliseconds until preparation is complete.
+
+If called when there is a pending HPT whose size does not match that
+requested in the parameters, discards the existing pending HPT and
+creates a new one as above.
+
+If called when there is a pending HPT of the size requested, will:
+  * If preparation of the pending HPT is already complete, return 0
+  * If preparation of the pending HPT has failed, return an error
+    code, then discard the pending HPT.
+  * If preparation of the pending HPT is still in progress, return an
+    estimated number of milliseconds until preparation is complete.
+
+If called with shift == 0, discards any currently pending HPT and
+returns 0 (i.e. cancels any in-progress preparation).
+
+flags is reserved for future expansion, currently setting any bits in
+flags will result in an -EINVAL.
+
+Normally this will be called repeatedly with the same parameters until
+it returns <= 0.  The first call will initiate preparation, subsequent
+ones will monitor preparation until it completes or fails.
+
+struct kvm_ppc_resize_hpt {
+	__u64 flags;
+	__u32 shift;
+	__u32 pad;
+};
+
+4.100 KVM_PPC_RESIZE_HPT_COMMIT
+
+Capability: KVM_CAP_SPAPR_RESIZE_HPT
+Architectures: powerpc
+Type: vm ioctl
+Parameters: struct kvm_ppc_resize_hpt (in)
+Returns: 0 on successful completion,
+         -EFAULT if struct kvm_reinject_control cannot be read,
+	 -EINVAL if the supplied shift or flags are invalid
+	 -ENXIO is there is no pending HPT, or the pending HPT doesn't
+                 have the requested size
+	 -EBUSY if the pending HPT is not fully prepared
+	 -ENOSPC if there was a hash collision when moving existing
+                  HPT entries to the new HPT
+	 -EIO on other error conditions
+
+Used to implement the PAPR extension for runtime resizing of a guest's
+Hashed Page Table (HPT).  Specifically this requests that the guest be
+transferred to working with the new HPT, essentially implementing the
+H_RESIZE_HPT_COMMIT hypercall.
+
+This should only be called after KVM_PPC_RESIZE_HPT_PREPARE has
+returned 0 with the same parameters.  In other cases
+KVM_PPC_RESIZE_HPT_COMMIT will return an error (usually -ENXIO or
+-EBUSY, though others may be possible if the preparation was started,
+but failed).
+
+This will have undefined effects on the guest if it has not already
+placed itself in a quiescent state where no vcpu will make MMU enabled
+memory accesses.
+
+On succsful completion, the pending HPT will become the guest's active
+HPT and the previous HPT will be discarded.
+
+On failure, the guest will still be operating on its previous HPT.
+
+struct kvm_ppc_resize_hpt {
+	__u64 flags;
+	__u32 shift;
+	__u32 pad;
+};
+
 5. The kvm_run structure
 ------------------------
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index cac48ed..50ee1c7 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -685,6 +685,13 @@ struct kvm_ppc_smmu_info {
 	struct kvm_ppc_one_seg_page_size sps[KVM_PPC_PAGE_SIZES_MAX_SZ];
 };
 
+/* for KVM_PPC_RESIZE_HPT_{PREPARE,COMMIT} */
+struct kvm_ppc_resize_hpt {
+	__u64 flags;
+	__u32 shift;
+	__u32 pad;
+};
+
 #define KVMIO 0xAE
 
 /* machine type bits, to be used as argument to KVM_CREATE_VM */
@@ -871,6 +878,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_S390_USER_INSTR0 130
 #define KVM_CAP_MSI_DEVID 131
 #define KVM_CAP_PPC_HTM 132
+#define KVM_CAP_SPAPR_RESIZE_HPT 133
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1187,6 +1195,9 @@ struct kvm_s390_ucas_mapping {
 #define KVM_ARM_SET_DEVICE_ADDR	  _IOW(KVMIO,  0xab, struct kvm_arm_device_addr)
 /* Available with KVM_CAP_PPC_RTAS */
 #define KVM_PPC_RTAS_DEFINE_TOKEN _IOW(KVMIO,  0xac, struct kvm_rtas_token_args)
+/* Available with KVM_CAP_SPAPR_RESIZE_HPT */
+#define KVM_PPC_RESIZE_HPT_PREPARE _IOR(KVMIO, 0xad, struct kvm_ppc_resize_hpt)
+#define KVM_PPC_RESIZE_HPT_COMMIT _IOR(KVMIO, 0xae, struct kvm_ppc_resize_hpt)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
-- 
2.9.3
