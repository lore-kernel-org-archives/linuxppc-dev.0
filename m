Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 638371A02AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 17:25:51 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 5 Jun 2014 17:25:50 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A4CCA2CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 17:25:47 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5573rmm64094380
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 17:03:53 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s557Pk3A007828
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 17:25:46 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] PPC: KVM: Reserve KVM_CAP_SPAPR_TCE_VFIO capability number
Date: Thu,  5 Jun 2014 17:25:42 +1000
Message-Id: <1401953144-19186-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1401953144-19186-1-git-send-email-aik@ozlabs.ru>
References: <1401953144-19186-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>
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
index a8f4ee5..944cd21 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -743,6 +743,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_IOAPIC_POLARITY_IGNORED 97
 #define KVM_CAP_ENABLE_CAP_VM 98
 #define KVM_CAP_S390_IRQCHIP 99
+#define KVM_CAP_SPAPR_TCE_VFIO 100
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.0.0
