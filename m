Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1050.oracle.com (aserp1050.oracle.com [141.146.126.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7T2S5W4DzDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 18:07:44 +1000 (AEST)
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by aserp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v6D7d99u004500
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 07:39:09 GMT
Date: Thu, 13 Jul 2017 10:38:49 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alexander Graf <agraf@suse.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] KVM: PPC: e500mc: Fix a NULL dereference
Message-ID: <20170713073849.tj6jqmhliyjmn3zi@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We should set "err = -ENOMEM;", otherwise it means we're returning
ERR_PTR(0) which is NULL.  It results in a NULL pointer dereference in
the caller.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index f48a0c22e8f9..d0b6b5788afc 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -331,8 +331,10 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_e500mc(struct kvm *kvm,
 		goto uninit_vcpu;
 
 	vcpu->arch.shared = (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-	if (!vcpu->arch.shared)
+	if (!vcpu->arch.shared) {
+		err = -ENOMEM;
 		goto uninit_tlb;
+	}
 
 	return vcpu;
 
