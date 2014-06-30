Return-Path: <mihai.caraman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0C7C1A00C1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 01:35:18 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 6/6 v2] KVM: PPC: Book3E: Enable e6500 core
Date: Mon, 30 Jun 2014 18:34:57 +0300
Message-ID: <1404142497-6430-7-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
References: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
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
v2:
 - no changes

 arch/powerpc/kvm/e500mc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index c60b653..0bc9684 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -177,6 +177,16 @@ int kvmppc_core_check_processor_compat(void)
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
1.7.11.7
