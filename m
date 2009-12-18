Return-Path: <albert_herranz@yahoo.es>
Received: from smtp149.mail.ukl.yahoo.com (smtp149.mail.ukl.yahoo.com
	[77.238.184.80]) by ozlabs.org (Postfix) with SMTP id D92491007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Dec 2009 07:04:33 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org, glikely@secretlab.ca
Subject: [PATCH v2.6.33] powerpc: flipper-pic/hlwd-pic: remove get_irq_desc()
Date: Fri, 18 Dec 2009 21:04:05 +0100
Message-Id: <1261166645-29867-1-git-send-email-albert_herranz@yahoo.es>
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

arch/powerpc/platforms/embedded6xx/flipper-pic.c: In function 'flipper_pic_map':
arch/powerpc/platforms/embedded6xx/flipper-pic.c:105: error: implicit declaration of function 'get_irq_desc'

arch/powerpc/platforms/embedded6xx/hlwd-pic.c: In function 'hlwd_pic_map':
arch/powerpc/platforms/embedded6xx/hlwd-pic.c:98: error: implicit declaration of function 'get_irq_desc'

These failures are caused by the changes introduced in commit
"powerpc: Remove get_irq_desc()". The reason these drivers were not
updated is that they weren't merged yet.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/platforms/embedded6xx/flipper-pic.c |    2 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index d596328..c278bd3 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -102,7 +102,7 @@ static int flipper_pic_map(struct irq_host *h, unsigned int virq,
 			   irq_hw_number_t hwirq)
 {
 	set_irq_chip_data(virq, h->host_data);
-	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	irq_to_desc(virq)->status |= IRQ_LEVEL;
 	set_irq_chip_and_handler(virq, &flipper_pic, handle_level_irq);
 	return 0;
 }
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index dd20bff..fe0ff06 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -95,7 +95,7 @@ static int hlwd_pic_map(struct irq_host *h, unsigned int virq,
 			   irq_hw_number_t hwirq)
 {
 	set_irq_chip_data(virq, h->host_data);
-	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	irq_to_desc(virq)->status |= IRQ_LEVEL;
 	set_irq_chip_and_handler(virq, &hlwd_pic, handle_level_irq);
 	return 0;
 }
-- 
1.6.3.3
