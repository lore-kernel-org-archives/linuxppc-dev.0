Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjdSL1MhyzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 17:09:54 +1000 (AEST)
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rjdSK16sXz9s5J
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Jul 2016 17:09:52 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id us13so15157829pab.1
 for <linuxppc-dev@ozlabs.org>; Mon, 04 Jul 2016 00:09:52 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>
Subject: [PATCH 1/6] powerpc/kvm: Clarify __user annotations
Date: Mon,  4 Jul 2016 17:09:37 +1000
Message-Id: <1467616182-30886-1-git-send-email-dja@axtens.net>
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
