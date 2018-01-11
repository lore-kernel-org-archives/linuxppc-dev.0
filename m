Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHM9w09d7zF0X4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 21:12:04 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id e11so1305069pff.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 02:12:03 -0800 (PST)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 03/26] KVM: PPC: Book3S PR: turn on FP/VSX/VMX MSR bits in
 kvmppc_save_tm()
Date: Thu, 11 Jan 2018 18:11:16 +0800
Message-Id: <1515665499-31710-4-git-send-email-wei.guo.simon@gmail.com>
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

kvmppc_save_tm() invokes  store_fp_state/store_vr_state(). So it is
mandatory to turn on FP/VSX/VMX MSR bits for its execution, just
like what kvmppc_restore_tm() did.

Previsouly HV KVM has turned the bits on outside of function
kvmppc_save_tm().  Now we include this bit change in kvmppc_save_tm()
so that the logic is more clean. And PR KVM can reuse it later.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/tm.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/tm.S b/arch/powerpc/kvm/tm.S
index e779b15..2d6fe5b 100644
--- a/arch/powerpc/kvm/tm.S
+++ b/arch/powerpc/kvm/tm.S
@@ -43,6 +43,8 @@ _GLOBAL(kvmppc_save_tm)
 	mfmsr	r8
 	li	r0, 1
 	rldimi	r8, r0, MSR_TM_LG, 63-MSR_TM_LG
+	ori     r8, r8, MSR_FP
+	oris    r8, r8, (MSR_VEC | MSR_VSX)@h
 	mtmsrd	r8
 
 	rldicl. r4, r4, 64 - MSR_TS_S_LG, 62
-- 
1.8.3.1
