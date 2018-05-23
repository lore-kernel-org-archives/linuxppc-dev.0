Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rPkY1QjWzDrnr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 17:47:49 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id e9-v6so10080376pfi.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:47:49 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v4 12/29] KVM: PPC: Book3S PR: prevent TS bits change in
 kvmppc_interrupt_pr()
Date: Wed, 23 May 2018 15:01:55 +0800
Message-Id: <1527058932-7434-13-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
References: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

PR KVM host usually equipped with enabled TM in its host MSR value, and
with non-transactional TS value.

When a guest with TM active traps into PR KVM host, the rfid at the
tail of kvmppc_interrupt_pr() will try to switch TS bits from
S0 (Suspended & TM disabled) to N1 (Non-transactional & TM enabled).

That will leads to TM Bad Thing interrupt.

This patch manually sets target TS bits unchanged to avoid this
exception.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_segment.S | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
index 93a180c..98ccc7e 100644
--- a/arch/powerpc/kvm/book3s_segment.S
+++ b/arch/powerpc/kvm/book3s_segment.S
@@ -383,6 +383,19 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 	 */
 
 	PPC_LL	r6, HSTATE_HOST_MSR(r13)
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	/*
+	 * We don't want to change MSR[TS] bits via rfi here.
+	 * The actual TM handling logic will be in host with
+	 * recovered DR/IR bits after HSTATE_VMHANDLER.
+	 * And MSR_TM can be enabled in HOST_MSR so rfid may
+	 * not suppress this change and can lead to exception.
+	 * Manually set MSR to prevent TS state change here.
+	 */
+	mfmsr   r7
+	rldicl  r7, r7, 64 - MSR_TS_S_LG, 62
+	rldimi  r6, r7, MSR_TS_S_LG, 63 - MSR_TS_T_LG
+#endif
 	PPC_LL	r8, HSTATE_VMHANDLER(r13)
 
 #ifdef CONFIG_PPC64
-- 
1.8.3.1
