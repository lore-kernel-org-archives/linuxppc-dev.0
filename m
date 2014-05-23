Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F2F061A05DD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 18:15:44 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alexander Graf <agraf@suse.de>
Subject: [PATCH v2 4/6] powerpc: Check cpu_thread_in_subcore() in __cpu_up()
Date: Fri, 23 May 2014 18:15:28 +1000
Message-Id: <1400832930-17050-5-git-send-email-mikey@neuling.org>
In-Reply-To: <1400832930-17050-1-git-send-email-mikey@neuling.org>
References: <1400832930-17050-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <mpe@ellerman.id.au>

To support split core we need to change the check in __cpu_up() that
determines if a cpu is allowed to come online.

Currently we refuse to online cpus which are not the primary thread
within their core.

On POWER8 with split core support this check needs to instead refuse to
online cpus which are not the primary thread within their *sub* core.

On POWER7 and other systems that do not support split core,
threads_per_subcore == threads_per_core and so the check is equivalent.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 6edae3d..b5222c4 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -489,7 +489,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	 * Don't allow secondary threads to come online if inhibited
 	 */
 	if (threads_per_core > 1 && secondaries_inhibited() &&
-	    cpu % threads_per_core != 0)
+	    cpu_thread_in_subcore(cpu))
 		return -EBUSY;
 
 	if (smp_ops == NULL ||
-- 
1.9.1
