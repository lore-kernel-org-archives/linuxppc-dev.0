Return-Path: <albert_herranz@yahoo.es>
Received: from smtp111.mail.ukl.yahoo.com (smtp111.mail.ukl.yahoo.com
	[77.238.184.49]) by ozlabs.org (Postfix) with SMTP id DBAC61007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Dec 2009 07:04:56 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org, glikely@secretlab.ca
Subject: [PATCH v2.6.33] powerpc: hlwd-pic: convert irq_desc.lock to
	raw_spinlock
Date: Fri, 18 Dec 2009 21:04:42 +0100
Message-Id: <1261166682-29904-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix the following build failures:

arch/powerpc/platforms/embedded6xx/hlwd-pic.c: In function 'hlwd_pic_irq_cascade':
arch/powerpc/platforms/embedded6xx/hlwd-pic.c:135: error: passing argument 1 of 'spin_lock' from incompatible pointer type
arch/powerpc/platforms/embedded6xx/hlwd-pic.c:137: error: passing argument 1 of 'spin_unlock' from incompatible pointer type
arch/powerpc/platforms/embedded6xx/hlwd-pic.c:145: error: passing argument 1 of 'spin_lock' from incompatible pointer type
arch/powerpc/platforms/embedded6xx/hlwd-pic.c:149: error: passing argument 1 of 'spin_unlock' from incompatible pointer type

These failures are caused by the changes introduced in commit
"genirq: Convert irq_desc.lock to raw_spinlock". The reason this driver
was not updated is that it wasn't merged yet.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index fe0ff06..a771f91 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -132,9 +132,9 @@ static void hlwd_pic_irq_cascade(unsigned int cascade_virq,
 	struct irq_host *irq_host = get_irq_data(cascade_virq);
 	unsigned int virq;
 
-	spin_lock(&desc->lock);
+	raw_spin_lock(&desc->lock);
 	desc->chip->mask(cascade_virq); /* IRQ_LEVEL */
-	spin_unlock(&desc->lock);
+	raw_spin_unlock(&desc->lock);
 
 	virq = __hlwd_pic_get_irq(irq_host);
 	if (virq != NO_IRQ)
@@ -142,11 +142,11 @@ static void hlwd_pic_irq_cascade(unsigned int cascade_virq,
 	else
 		pr_err("spurious interrupt!\n");
 
-	spin_lock(&desc->lock);
+	raw_spin_lock(&desc->lock);
 	desc->chip->ack(cascade_virq); /* IRQ_LEVEL */
 	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
 		desc->chip->unmask(cascade_virq);
-	spin_unlock(&desc->lock);
+	raw_spin_unlock(&desc->lock);
 }
 
 /*
-- 
1.6.3.3
