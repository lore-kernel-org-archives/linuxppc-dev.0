Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrRN574CpzF1XR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 05:01:41 +1100 (AEDT)
Received: by mail-pl0-x243.google.com with SMTP id bb3so11839109plb.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 10:01:41 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 25/30] KVM: PPC: Book3S PR: enable HTM for PR KVM for
 KVM_CHECK_EXTENSION ioctl
Date: Wed, 28 Feb 2018 01:52:33 +0800
Message-Id: <1519753958-11756-15-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1519753958-11756-1-git-send-email-wei.guo.simon@gmail.com>
References: <1519753958-11756-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

With current patch set, PR KVM now supports HTM. So this patch turns it
on for PR KVM.

Tested with:
https://github.com/justdoitqd/publicFiles/blob/master/test_kvm_htm_cap.c

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kvm/powerpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 748562e..2d10314 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -648,8 +648,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		break;
 #endif
 	case KVM_CAP_PPC_HTM:
-		r = hv_enabled &&
-		    (cur_cpu_spec->cpu_user_features2 & PPC_FEATURE2_HTM_COMP);
+		r = (cur_cpu_spec->cpu_user_features2 & PPC_FEATURE2_HTM_COMP);
 		break;
 	default:
 		r = 0;
-- 
1.8.3.1
