Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 594171A017C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:24:51 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:24:49 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id F0CE32CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:24:45 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F923aq3670286
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:02:03 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9OjVu020958
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:24:45 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 02/16] KVM: PPC: Use RCU when adding to
 arch.spapr_tce_tables
Date: Tue, 15 Jul 2014 19:24:26 +1000
Message-Id: <1405416280-12318-3-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405416280-12318-1-git-send-email-aik@ozlabs.ru>
References: <1405416280-12318-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_64_vio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 54cf9bc..516f2ee 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -131,7 +131,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	kvm_get_kvm(kvm);
 
 	mutex_lock(&kvm->lock);
-	list_add(&stt->list, &kvm->arch.spapr_tce_tables);
+	list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
 
 	mutex_unlock(&kvm->lock);
 
-- 
2.0.0
