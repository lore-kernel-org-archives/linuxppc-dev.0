Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vdJDV68dJzDqXw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 14:00:26 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v7 05/10] KVM: PPC: Reserve KVM_CAP_SPAPR_TCE_VFIO
 capability number
Date: Wed,  8 Mar 2017 14:00:06 +1100
Message-Id: <20170308030011.26780-6-aik@ozlabs.ru>
In-Reply-To: <20170308030011.26780-1-aik@ozlabs.ru>
References: <20170308030011.26780-1-aik@ozlabs.ru>
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
index f51d5082a377..f5a52ffb6b58 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -883,6 +883,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_MMU_RADIX 134
 #define KVM_CAP_PPC_MMU_HASH_V3 135
 #define KVM_CAP_IMMEDIATE_EXIT 136
+#define KVM_CAP_SPAPR_TCE_VFIO 137
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.11.0
