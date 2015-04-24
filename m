Return-Path: <B43198@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0137.outbound.protection.outlook.com [157.56.110.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B97E1A0C47
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 01:53:32 +1000 (AEST)
From: Bogdan Purcareata <bogdan.purcareata@freescale.com>
To: <tglx@linutronix.de>, <bigeasy@linutronix.de>, <pbonzini@redhat.com>,
 <agraf@suse.de>, <scottwood@freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <mihai.caraman@freescale.com>, <b10716@freescale.com>
Subject: [PATCH v2 2/2] powerpc/kvm: Disable in-kernel MPIC emulation for
 PREEMPT_RT_FULL
Date: Fri, 24 Apr 2015 15:53:13 +0000
Message-ID: <1429890793-19487-3-git-send-email-bogdan.purcareata@freescale.com>
In-Reply-To: <1429890793-19487-1-git-send-email-bogdan.purcareata@freescale.com>
References: <1429890793-19487-1-git-send-email-bogdan.purcareata@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While converting the openpic emulation code to use a raw_spinlock_t enables
guests to run on RT, there's still a performance issue. For interrupts sent in
directed delivery mode with a multiple CPU mask, the emulated openpic will loop
through all of the VCPUs, and for each VCPUs, it call IRQ_check, which will loop
through all the pending interrupts for that VCPU. This is done while holding the
raw_lock, meaning that in all this time the interrupts and preemption are
disabled on the host Linux. A malicious user app can max both these number and
cause a DoS.

This temporary fix is sent for two reasons. First is so that users who want to
use the in-kernel MPIC emulation are aware of the potential latencies, thus
making sure that the hardware MPIC and their usage scenario does not involve
interrupts sent in directed delivery mode, and the number of possible pending
interrupts is kept small. Secondly, this should incentivize the development of a
proper openpic emulation that would be better suited for RT.

Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
---
 arch/powerpc/kvm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 11850f3..415499a 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -158,6 +158,7 @@ config KVM_E500MC
 config KVM_MPIC
 	bool "KVM in-kernel MPIC emulation"
 	depends on KVM && E500
+	depends on !PREEMPT_RT_FULL
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQFD
 	select HAVE_KVM_IRQ_ROUTING
-- 
2.1.4
