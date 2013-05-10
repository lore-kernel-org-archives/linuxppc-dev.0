Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D03B92C012A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2013 13:09:57 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Alexander Graf <agraf@suse.de>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: [PATCH v2 2/4] kvm/ppc/booke64: Fix lazy ee handling in
 kvmppc_handle_exit()
Date: Thu, 9 May 2013 22:09:42 -0500
Message-ID: <1368155384-11035-3-git-send-email-scottwood@freescale.com>
In-Reply-To: <1368155384-11035-1-git-send-email-scottwood@freescale.com>
References: <1368155384-11035-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

EE is hard-disabled on entry to kvmppc_handle_exit(), so call
hard_irq_disable() so that PACA_IRQ_HARD_DIS is set, and soft_enabled
is unset.

Without this, we get warnings such as arch/powerpc/kernel/time.c:300,
and sometimes host kernel hangs.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kvm/booke.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 1020119..705fc5c 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -833,6 +833,11 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	int r = RESUME_HOST;
 	int s;
 
+#ifdef CONFIG_PPC64
+	WARN_ON(local_paca->irq_happened != 0);
+#endif
+	hard_irq_disable();
+
 	/* update before a new last_exit_type is rewritten */
 	kvmppc_update_timing_stats(vcpu);
 
-- 
1.7.10.4
