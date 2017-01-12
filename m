Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzfzd24C0zDqVc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 20:07:41 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 08/18] KVM: PPC: Book3S HV: Don't try to signal cpu -1
Date: Thu, 12 Jan 2017 20:07:16 +1100
Message-Id: <1484212046-29591-9-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1484212046-29591-1-git-send-email-paulus@ozlabs.org>
References: <1484212046-29591-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the target vcpu for kvmppc_fast_vcpu_kick_hv() is not running on
any CPU, then we will have vcpu->arch.thread_cpu == -1, and as it
happens, kvmppc_fast_vcpu_kick_hv will call kvmppc_ipi_thread with
-1 as the cpu argument.  Although this is not meaningful, in the past,
before commit 1704a81ccebc ("KVM: PPC: Book3S HV: Use msgsnd for IPIs
to other cores on POWER9", 2016-11-18), it was harmless because CPU
-1 is not in the same core as any real CPU thread.  On a POWER9,
however, we don't do the "same core" check, so we were trying to
do a msgsnd to thread -1, which is invalid.  To avoid this, we add
a check to see that vcpu->arch.thread_cpu is >= 0 before calling
kvmppc_ipi_thread() with it.  Since vcpu->arch.thread_vcpu can change
asynchronously, we use READ_ONCE to ensure that the value we check is
the same value that we use as the argument to kvmppc_ipi_thread().

Fixes: 1704a81ccebc ("KVM: PPC: Book3S HV: Use msgsnd for IPIs to other cores on POWER9")
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index ec34e39..8d9cc07 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -182,7 +182,8 @@ static void kvmppc_fast_vcpu_kick_hv(struct kvm_vcpu *vcpu)
 		++vcpu->stat.halt_wakeup;
 	}
 
-	if (kvmppc_ipi_thread(vcpu->arch.thread_cpu))
+	cpu = READ_ONCE(vcpu->arch.thread_cpu);
+	if (cpu >= 0 && kvmppc_ipi_thread(cpu))
 		return;
 
 	/* CPU points to the first thread of the core */
-- 
2.7.4
