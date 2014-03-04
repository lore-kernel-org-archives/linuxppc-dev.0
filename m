Return-Path: <tipbot@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2F2432C0228
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 10:17:00 +1100 (EST)
Date: Tue, 4 Mar 2014 15:15:51 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-57310c3c99eb6fab2ecbd63aa3f7c323341ca77e@git.kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] powerpc: eeh:
 Fixup the brown paperbag fallout of the "cleanup"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: shangw@linux.vnet.ibm.com, peterz@infradead.org, hpa@zytor.com,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
 peterz@infradead.org, linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 tglx@linutronix.de, shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit-ID:  57310c3c99eb6fab2ecbd63aa3f7c323341ca77e
Gitweb:     http://git.kernel.org/tip/57310c3c99eb6fab2ecbd63aa3f7c323341ca77e
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 5 Mar 2014 00:06:11 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 5 Mar 2014 00:13:33 +0100

powerpc: eeh: Fixup the brown paperbag fallout of the "cleanup"

Commit b8a9a11b9 (powerpc: eeh: Kill another abuse of irq_desc) is
missing some brackets .....

It's not a good idea to write patches in grumpy mode and then forget
to at least compile test them or rely on the few eyeballs discussing
that patch to spot it.....

Reported-by: fengguang.wu@intel.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ppc <linuxppc-dev@lists.ozlabs.org>
---
 arch/powerpc/kernel/eeh_driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 3e1d7de..bb61ca5 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -166,8 +166,9 @@ static void eeh_enable_irq(struct pci_dev *dev)
 		 *
 		 *	tglx
 		 */
-		if (irqd_irq_disabled(irq_get_irq_data(dev->irq))
+		if (irqd_irq_disabled(irq_get_irq_data(dev->irq)))
 			enable_irq(dev->irq);
+	}
 }
 
 /**
