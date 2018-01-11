Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHMCT6L3tzF0T7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 21:13:25 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id z20so1859388pgv.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 02:13:25 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 26/26] KVM: PPC: Book3S PR: enable HTM for PR KVM for
 KVM_CHECK_EXTENSION ioctl
Date: Thu, 11 Jan 2018 18:11:39 +0800
Message-Id: <1515665499-31710-27-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
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
index 1915e86..0b431aa 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -643,8 +643,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
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
