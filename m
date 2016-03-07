Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 633B61A036D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:42:48 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 7 Mar 2016 13:42:48 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5117D2CE8060
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:42:45 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u273gbgH67043336
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 14:42:45 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u273gCt7028875
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 14:42:13 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 1/9] KVM: PPC: Reserve KVM_CAP_SPAPR_TCE_VFIO
 capability number
Date: Mon,  7 Mar 2016 14:41:09 +1100
Message-Id: <1457322077-26640-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
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
---
 include/uapi/linux/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index c251f06..080ffbf 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -863,6 +863,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_HYPERV_SYNIC 123
 #define KVM_CAP_S390_RI 124
 #define KVM_CAP_SPAPR_TCE_64 125
+#define KVM_CAP_SPAPR_TCE_VFIO 126
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.5.0.rc3
