Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3th60l4gZZzDwBg
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Dec 2016 12:29:43 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v2 01/11] KVM: PPC: Reserve KVM_CAP_SPAPR_TCE_VFIO
 capability number
Date: Sun, 18 Dec 2016 12:28:50 +1100
Message-Id: <20161218012900.18142-2-aik@ozlabs.ru>
In-Reply-To: <20161218012900.18142-1-aik@ozlabs.ru>
References: <20161218012900.18142-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a capability number for in-kernel support for VFIO on
SPAPR platform.

The capability will tell the user space whether in-kernel handlers of
H_PUT_TCE can handle VFIO-targeted requests or not. If not, the user space
must not attempt allocating a TCE table in the host kernel via
the KVM_CREATE_SPAPR_TCE KVM ioctl because in that case TCE requests
will not be passed to the user space which is desired action in
the situation like that.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/uapi/linux/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 300ef255d1e0..810f74317987 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -870,6 +870,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_S390_USER_INSTR0 130
 #define KVM_CAP_MSI_DEVID 131
 #define KVM_CAP_PPC_HTM 132
+#define KVM_CAP_SPAPR_TCE_VFIO 133
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.11.0
