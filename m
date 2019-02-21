Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E34C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 03:46:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8672C2086A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 03:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8672C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444gPW1hNZzDqMb
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 14:46:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 444gMj3y59zDq78
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 14:44:49 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id B0FB0AE80011;
 Wed, 20 Feb 2019 22:44:15 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel] KVM: PPC: Improve KVM reference counting
Date: Thu, 21 Feb 2019 14:44:14 +1100
Message-Id: <20190221034414.41777-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The anon fd's ops releases the KVM reference in the release hook.
However we reference the KVM object after we create the fd so there is
small window when the release function can be called and
dereferenced the KVM object which potentially may free it.

It is not a problem at the moment as the file is created and KVM is
referenced under the KVM lock and the release function obtains the same
lock before dereferencing the KVM (although the lock is not held when
calling kvm_put_kvm()) but it is a fragile against future changes.

This references the KVM object before creating a file.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

The original bug is described here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cfa393811
But in this case kvm_put_kvm() is called straight away with no locks before/after/around.

---
 arch/powerpc/kvm/book3s_64_vio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 532ab797..d68c969 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -338,14 +338,15 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 		}
 	}
 
+	kvm_get_kvm(kvm);
 	if (!ret)
 		ret = anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
 				       stt, O_RDWR | O_CLOEXEC);
 
-	if (ret >= 0) {
+	if (ret >= 0)
 		list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
-		kvm_get_kvm(kvm);
-	}
+	else
+		kvm_put_kvm(kvm);
 
 	mutex_unlock(&kvm->lock);
 
-- 
2.17.1

