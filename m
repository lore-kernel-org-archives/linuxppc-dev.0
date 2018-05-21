Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40q5pF6JYjzF0dY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 14:46:29 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id a3-v6so878399pgt.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 21:46:29 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v3 25/29] KVM: PPC: Book3S PR: enable HTM for PR KVM for
 KVM_CHECK_EXTENSION ioctl
Date: Mon, 21 May 2018 12:09:42 +0800
Message-Id: <1526875786-10372-26-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1526875786-10372-1-git-send-email-wei.guo.simon@gmail.com>
References: <1526875786-10372-1-git-send-email-wei.guo.simon@gmail.com>
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
 arch/powerpc/kvm/powerpc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index bef27b1..1fa5bbe 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -648,9 +648,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 #endif
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	case KVM_CAP_PPC_HTM:
-		r = hv_enabled &&
-		    (!!(cur_cpu_spec->cpu_user_features2 & PPC_FEATURE2_HTM) ||
-		     cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST));
+		r = !!(cur_cpu_spec->cpu_user_features2 & PPC_FEATURE2_HTM) ||
+		     (hv_enabled && cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST));
 		break;
 #endif
 	default:
-- 
1.8.3.1
