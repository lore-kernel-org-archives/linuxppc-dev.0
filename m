Return-Path: <B02008@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A7692C040B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 22:45:03 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 6/6] KVM: PPC: Book3E: Enable e6500 core
Date: Wed, 3 Jul 2013 15:42:39 +0300
Message-ID: <1372855359-13452-7-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that AltiVec support is in place enable e6500 core.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/e500mc.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index 09da1ac..bec897c 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -175,6 +175,16 @@ int kvmppc_core_check_processor_compat(void)
 		r = 0;
 	else if (strcmp(cur_cpu_spec->cpu_name, "e5500") == 0)
 		r = 0;
+#ifdef CONFIG_ALTIVEC
+	/*
+	 * Since guests have the priviledge to enable AltiVec, we need AltiVec
+	 * support in the host to save/restore their context.
+	 * Don't use CPU_FTR_ALTIVEC to identify cores with AltiVec unit
+	 * because it's cleared in the absence of CONFIG_ALTIVEC!
+	 */
+	else if (strcmp(cur_cpu_spec->cpu_name, "e6500") == 0)
+		r = 0;
+#endif
 	else
 		r = -ENOTSUPP;
 
-- 
1.7.3.4
