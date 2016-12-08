Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZ3RV6yl6zDvM6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2016 16:13:26 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: michael@ellerman.id.au,
	paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/6] kvm: Move KVM_PPC_PVINFO_FLAGS_EV_IDLE definition next to
 its structure
Date: Thu,  8 Dec 2016 16:13:16 +1100
Message-Id: <20161208051321.31446-2-david@gibson.dropbear.id.au>
In-Reply-To: <20161208051321.31446-1-david@gibson.dropbear.id.au>
References: <20161208051321.31446-1-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The KVM_PPC_PVINFO_FLAGS_EV_IDLE macro defines a bit for use in the flags
field of struct kvm_ppc_pvinfo.  However, changes since that was introduced
have moved it away from that structure definition, which is confusing.

Move it back next to the structure it belongs with.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/uapi/linux/kvm.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 4ee67cb..cac48ed 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -651,6 +651,9 @@ struct kvm_enable_cap {
 };
 
 /* for KVM_PPC_GET_PVINFO */
+
+#define KVM_PPC_PVINFO_FLAGS_EV_IDLE   (1<<0)
+
 struct kvm_ppc_pvinfo {
 	/* out */
 	__u32 flags;
@@ -682,8 +685,6 @@ struct kvm_ppc_smmu_info {
 	struct kvm_ppc_one_seg_page_size sps[KVM_PPC_PAGE_SIZES_MAX_SZ];
 };
 
-#define KVM_PPC_PVINFO_FLAGS_EV_IDLE   (1<<0)
-
 #define KVMIO 0xAE
 
 /* machine type bits, to be used as argument to KVM_CREATE_VM */
-- 
2.9.3
