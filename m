Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmLYm3WPCzDqFd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 12:08:44 +1000 (AEST)
Date: Fri, 15 Apr 2016 12:08:19 +1000
From: Anton Blanchard <anton@samba.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Michael Neuling
 <mikey@neuling.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander
 Graf <agraf@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: [PATCH 3/3] powerpc: Update TM user feature bits in scan_features()
Message-ID: <20160415120819.7144900c@kryten>
In-Reply-To: <20160404211112.66b0756f@kryten>
References: <20160404164457.539a55f0@kryten> <57021123.6050506@ozlabs.ru>
 <20160404204346.1cf44df8@kryten> <20160404211112.66b0756f@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to update the user TM feature bits (PPC_FEATURE2_HTM and
PPC_FEATURE2_HTM) to mirror what we do with the kernel TM feature
bit.

At the moment, if firmware reports TM is not available we turn off
the kernel TM feature bit but leave the userspace ones on. Userspace
thinks it can execute TM instructions and it dies trying.

This (together with a QEMU patch) fixes PR KVM, which doesn't currently
support TM.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: stable@vger.kernel.org
---
 arch/powerpc/kernel/prom.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 99709bb..5beffd7 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -161,11 +161,12 @@ static struct ibm_pa_feature {
 	{0, MMU_FTR_CI_LARGE_PAGE, 0, 0,		1, 2, 0},
 	{CPU_FTR_REAL_LE, PPC_FEATURE_TRUE_LE, 0, 0, 5, 0, 0},
 	/*
-	 * If the kernel doesn't support TM (ie. CONFIG_PPC_TRANSACTIONAL_MEM=n),
-	 * we don't want to turn on CPU_FTR_TM here, so we use CPU_FTR_TM_COMP
-	 * which is 0 if the kernel doesn't support TM.
+	 * If the kernel doesn't support TM (ie CONFIG_PPC_TRANSACTIONAL_MEM=n),
+	 * we don't want to turn on TM here, so we use the *_COMP versions
+	 * which are 0 if the kernel doesn't support TM.
 	 */
-	{CPU_FTR_TM_COMP, 0, 0, 0,		22, 0, 0},
+	{CPU_FTR_TM_COMP, 0, 0,
+	 PPC_FEATURE2_HTM_COMP|PPC_FEATURE2_HTM_NOSC_COMP, 22, 0, 0},
 };
 
 static void __init scan_features(unsigned long node, const unsigned char *ftrs,
-- 
2.7.4
