Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4076DB6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2012 10:35:17 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: grant.likely@secretlab.ca
Subject: [PATCH] ppc-6xx: fix build failure in flipper-pic.c and hlwd-pic.c
Date: Wed, 22 Feb 2012 18:35:03 -0500
Message-Id: <1329953703-25806-1-git-send-email-paul.gortmaker@windriver.com>
Cc: olof@lixom.net, Paul Gortmaker <paul.gortmaker@windriver.com>,
 linux-next@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The commit bae1d8f19983fbfa25559aa3cb6a81a84aa82a18 (linux-next)

  "irq_domain/powerpc: Use common irq_domain structure instead of irq_host"

made this change:

   -static struct irq_host *flipper_irq_host;
   +static struct irq_domain *flipper_irq_host;

and this change:

   -static struct irq_host *hlwd_irq_host;
   +static struct irq_domain *hlwd_irq_host;

The intent was to change the type, and not the name, but then in a
couple of instances, it looks like the sed to change the irq_domain_ops
name inadvertently also changed the irq_host name where it was not
supposed to, causing build failures.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

---

[seen in build tests on the linux-next tree from yesterday.]

diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index 675335a..53d6eee 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -172,7 +172,7 @@ out:
 
 unsigned int flipper_pic_get_irq(void)
 {
-	void __iomem *io_base = flipper_irq_domain->host_data;
+	void __iomem *io_base = flipper_irq_host->host_data;
 	int irq;
 	u32 irq_status;
 
@@ -182,7 +182,7 @@ unsigned int flipper_pic_get_irq(void)
 		return NO_IRQ;	/* no more IRQs pending */
 
 	irq = __ffs(irq_status);
-	return irq_linear_revmap(flipper_irq_domain, irq);
+	return irq_linear_revmap(flipper_irq_host, irq);
 }
 
 /*
@@ -197,7 +197,7 @@ void __init flipper_pic_probe(void)
 	np = of_find_compatible_node(NULL, NULL, "nintendo,flipper-pic");
 	BUG_ON(!np);
 
-	flipper_irq_domain = flipper_pic_init(np);
+	flipper_irq_host = flipper_pic_init(np);
 	BUG_ON(!flipper_irq_host);
 
 	irq_set_default_host(flipper_irq_host);
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index da6ca02..3006b51 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -189,7 +189,7 @@ struct irq_domain *hlwd_pic_init(struct device_node *np)
 
 unsigned int hlwd_pic_get_irq(void)
 {
-	return __hlwd_pic_get_irq(hlwd_irq_domain);
+	return __hlwd_pic_get_irq(hlwd_irq_host);
 }
 
 /*
@@ -213,7 +213,7 @@ void hlwd_pic_probe(void)
 			irq_set_handler_data(cascade_virq, host);
 			irq_set_chained_handler(cascade_virq,
 						hlwd_pic_irq_cascade);
-			hlwd_irq_domain = host;
+			hlwd_irq_host = host;
 			break;
 		}
 	}
@@ -227,7 +227,7 @@ void hlwd_pic_probe(void)
  */
 void hlwd_quiesce(void)
 {
-	void __iomem *io_base = hlwd_irq_domain->host_data;
+	void __iomem *io_base = hlwd_irq_host->host_data;
 
 	__hlwd_quiesce(io_base);
 }
-- 
1.7.9.1
