Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpNmD3FzPzDqpQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 10:55:08 +1000 (AEST)
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rpNmC4Xwlz9sDk
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2016 10:55:06 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id dx3so63466pab.2
 for <linuxppc-dev@ozlabs.org>; Mon, 11 Jul 2016 17:55:06 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: arnd@arndb.de,
	Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 1/5] powerpc/kvm: Clarify __user annotations
Date: Tue, 12 Jul 2016 10:54:48 +1000
Message-Id: <1468284892-27765-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kvmppc_h_put_tce_indirect labels a u64 pointer as __user. It also
labelled the u64 where get_user puts the result as __user. This isn't
a pointer and so doesn't need to be labelled __user.

Split the u64 value definition onto a new line to make it clear that
it doesn't get the annotation.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/kvm/book3s_64_vio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 18cf6d1f8174..c379ff5a4438 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -242,7 +242,8 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	struct kvmppc_spapr_tce_table *stt;
 	long i, ret = H_SUCCESS, idx;
 	unsigned long entry, ua = 0;
-	u64 __user *tces, tce;
+	u64 __user *tces;
+	u64 tce;
 
 	stt = kvmppc_find_table(vcpu, liobn);
 	if (!stt)
-- 
2.1.4
