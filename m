Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 50B312C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 21:31:10 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>, <galak@kernel.crashing.org>
Subject: [RFC][v0][PATCH 1/1] ppc64: ignore interrupts while offline
Date: Tue, 15 Jan 2013 18:31:00 +0800
Message-ID: <1358245860-6546-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With lazy interrupt, some implementations of hotplug will
get some interrupts even while offline, just ignore these.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kernel/irq.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 4f97fe3..dbca574 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -144,6 +144,12 @@ notrace unsigned int __check_irq_replay(void)
 	 */
 	unsigned char happened = local_paca->irq_happened;
 
+	/* Some implementations of hotplug will get some interrupts while
+	 * offline, just ignore these.
+	 */
+	if (cpu_is_offline(smp_processor_id()))
+		return 0;
+
 	/* Clear bit 0 which we wouldn't clear otherwise */
 	local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
 
-- 
1.7.9.5
