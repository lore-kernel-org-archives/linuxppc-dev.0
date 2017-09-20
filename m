Return-Path: <daniel.black@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxj060W5TzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 11:32:05 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8K1UHbp092223
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 21:32:03 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d3e86spry-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 21:32:03 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <daniel.black@au1.ibm.com>;
 Wed, 20 Sep 2017 11:32:01 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8K1VxRX37421290
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 11:31:59 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8K1Vwpb013046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 11:31:58 +1000
From: Daniel Black <daniel.black@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, pbonzini@redhat.com
Cc: Daniel Black <daniel.black@au1.ibm.com>, trivial@kernel.org,
 abdhalee@linux.vnet.ibm.com, sachinp@linux.vnet.ibm.com, jschoenh@amazon.de
Subject: [PATCH] KVM: KVM_MAX_IRQ_ROUTES only defined with
 CONFIG_HAVE_KVM_IRQ_ROUTING
Date: Wed, 20 Sep 2017 11:31:39 +1000
In-Reply-To: <1505579069.9665.22.camel@abdul.in.ibm.com>
References: <1505579069.9665.22.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20170920013139.13329-1-daniel.black@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 36ae3c0a36b7 introduced code using KVM_MAX_IRQ_ROUTES. This
define isn't available on all platforms. As it is dependent on
CONFIG_HAVE_KVM_IRQ_ROUTING this define is used to enable the code
in 36ae3c0a36b7.

Fixes: 36ae3c0a36b7 ("KVM: Don't accept obviously wrong gsi values via KVM_IRQFD")
Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Suggested-by: Jan H. Schönherr <jschoenh@amazon.de>
Signed-off-by: Daniel Black <daniel.black@au.ibm.com>
---
 virt/kvm/eventfd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index c608ab4..75910dd 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -565,8 +565,10 @@ kvm_irqfd(struct kvm *kvm, struct kvm_irqfd *args)
 {
 	if (args->flags & ~(KVM_IRQFD_FLAG_DEASSIGN | KVM_IRQFD_FLAG_RESAMPLE))
 		return -EINVAL;
+#ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
 	if (args->gsi >= KVM_MAX_IRQ_ROUTES)
 		return -EINVAL;
+#endif
 
 	if (args->flags & KVM_IRQFD_FLAG_DEASSIGN)
 		return kvm_irqfd_deassign(kvm, args);
-- 
2.9.5
