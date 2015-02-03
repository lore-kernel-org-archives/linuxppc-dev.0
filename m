Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 557B61A0AF2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 16:36:02 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 agraf@suse.de
Subject: [PATCH 4/5] powerpc: Cleanup KVM emulated load/store endian handling
Date: Tue,  3 Feb 2015 16:36:24 +1100
Message-Id: <1422941785-22557-5-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1422941785-22557-1-git-send-email-david@gibson.dropbear.id.au>
References: <1422941785-22557-1-git-send-email-david@gibson.dropbear.id.au>
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mdroth@us.ibm.com, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sometimes the KVM code on powerpc needs to emulate load or store
instructions from the guest, which can include both normal and byte
reversed forms.

We currently (AFAICT) handle this correctly, but some variable names are
very misleading.  In particular we use "is_bigendian" in several places to
actually mean "is the IO the same endian as the host", but we now support
little-endian powerpc hosts.  This also ties into the misleadingly named
ld_le*() and st_le*() functions, which in fact always byteswap, even on
an LE host.

This patch cleans this up by renaming to more accurate "host_swabbed", and
uses the generic swab*() functions instead of the powerpc specific and
misleadingly named ld_le*() and st_le*() functions.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/kvm_host.h |  2 +-
 arch/powerpc/kvm/powerpc.c          | 38 ++++++++++++++++++-------------------
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 7efd666a..9b18149 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -584,7 +584,7 @@ struct kvm_vcpu_arch {
 	pgd_t *pgdir;
 
 	u8 io_gpr; /* GPR used as IO source/target */
-	u8 mmio_is_bigendian;
+	u8 mmio_host_swabbed;
 	u8 mmio_sign_extend;
 	u8 osi_needed;
 	u8 osi_enabled;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index c45eaab..e115793 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -721,7 +721,7 @@ static void kvmppc_complete_mmio_load(struct kvm_vcpu *vcpu,
 		return;
 	}
 
-	if (vcpu->arch.mmio_is_bigendian) {
+	if (!vcpu->arch.mmio_host_swabbed) {
 		switch (run->mmio.len) {
 		case 8: gpr = *(u64 *)run->mmio.data; break;
 		case 4: gpr = *(u32 *)run->mmio.data; break;
@@ -729,10 +729,10 @@ static void kvmppc_complete_mmio_load(struct kvm_vcpu *vcpu,
 		case 1: gpr = *(u8 *)run->mmio.data; break;
 		}
 	} else {
-		/* Convert BE data from userland back to LE. */
 		switch (run->mmio.len) {
-		case 4: gpr = ld_le32((u32 *)run->mmio.data); break;
-		case 2: gpr = ld_le16((u16 *)run->mmio.data); break;
+		case 8: gpr = swab64(*(u64 *)run->mmio.data); break;
+		case 4: gpr = swab32(*(u32 *)run->mmio.data); break;
+		case 2: gpr = swab16(*(u16 *)run->mmio.data); break;
 		case 1: gpr = *(u8 *)run->mmio.data; break;
 		}
 	}
@@ -781,14 +781,13 @@ int kvmppc_handle_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		       int is_default_endian)
 {
 	int idx, ret;
-	int is_bigendian;
+	bool host_swabbed;
 
+	/* Pity C doesn't have a logical XOR operator */
 	if (kvmppc_need_byteswap(vcpu)) {
-		/* Default endianness is "little endian". */
-		is_bigendian = !is_default_endian;
+		host_swabbed = is_default_endian;
 	} else {
-		/* Default endianness is "big endian". */
-		is_bigendian = is_default_endian;
+		host_swabbed = !is_default_endian;
 	}
 
 	if (bytes > sizeof(run->mmio.data)) {
@@ -801,7 +800,7 @@ int kvmppc_handle_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	run->mmio.is_write = 0;
 
 	vcpu->arch.io_gpr = rt;
-	vcpu->arch.mmio_is_bigendian = is_bigendian;
+	vcpu->arch.mmio_host_swabbed = host_swabbed;
 	vcpu->mmio_needed = 1;
 	vcpu->mmio_is_write = 0;
 	vcpu->arch.mmio_sign_extend = 0;
@@ -841,14 +840,13 @@ int kvmppc_handle_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
 {
 	void *data = run->mmio.data;
 	int idx, ret;
-	int is_bigendian;
+	bool host_swabbed;
 
+	/* Pity C doesn't have a logical XOR operator */
 	if (kvmppc_need_byteswap(vcpu)) {
-		/* Default endianness is "little endian". */
-		is_bigendian = !is_default_endian;
+		host_swabbed = is_default_endian;
 	} else {
-		/* Default endianness is "big endian". */
-		is_bigendian = is_default_endian;
+		host_swabbed = !is_default_endian;
 	}
 
 	if (bytes > sizeof(run->mmio.data)) {
@@ -863,7 +861,7 @@ int kvmppc_handle_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	vcpu->mmio_is_write = 1;
 
 	/* Store the value at the lowest bytes in 'data'. */
-	if (is_bigendian) {
+	if (!host_swabbed) {
 		switch (bytes) {
 		case 8: *(u64 *)data = val; break;
 		case 4: *(u32 *)data = val; break;
@@ -871,11 +869,11 @@ int kvmppc_handle_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		case 1: *(u8  *)data = val; break;
 		}
 	} else {
-		/* Store LE value into 'data'. */
 		switch (bytes) {
-		case 4: st_le32(data, val); break;
-		case 2: st_le16(data, val); break;
-		case 1: *(u8 *)data = val; break;
+		case 8: *(u64 *)data = swab64(val); break;
+		case 4: *(u32 *)data = swab32(val); break;
+		case 2: *(u16 *)data = swab16(val); break;
+		case 1: *(u8  *)data = val; break;
 		}
 	}
 
-- 
2.1.0
