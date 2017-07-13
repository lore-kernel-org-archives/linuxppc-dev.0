Return-Path: <dan.carpenter@oracle.com>
Received: from userp1050.oracle.com (userp1050.oracle.com [156.151.31.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7V6X1Q9nzDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 18:56:19 +1000 (AEST)
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v6D7crKB011350
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 07:38:54 GMT
Date: Thu, 13 Jul 2017 10:38:29 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alexander Graf <agraf@suse.com>, Scott Wood <scottwood@freescale.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] KVM: PPC: e500: fix some NULL dereferences on error
Message-ID: <20170713073829.dqjahnakxqvpne7x@mwanda>
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

There are some error paths in kvmppc_core_vcpu_create_e500() where we
forget to set the error code.  It means that we return ERR_PTR(0) which
is NULL and it results in a NULL pointer dereference in the caller.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index 32fdab57d604..f9f6468f4171 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -455,16 +455,20 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_e500(struct kvm *kvm,
 	if (err)
 		goto free_vcpu;
 
-	if (kvmppc_e500_id_table_alloc(vcpu_e500) == NULL)
+	if (kvmppc_e500_id_table_alloc(vcpu_e500) == NULL) {
+		err = -ENOMEM;
 		goto uninit_vcpu;
+	}
 
 	err = kvmppc_e500_tlb_init(vcpu_e500);
 	if (err)
 		goto uninit_id;
 
 	vcpu->arch.shared = (void*)__get_free_page(GFP_KERNEL|__GFP_ZERO);
-	if (!vcpu->arch.shared)
+	if (!vcpu->arch.shared) {
+		err = -ENOMEM;
 		goto uninit_tlb;
+	}
 
 	return vcpu;
 
