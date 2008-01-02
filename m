Return-Path: <paul.gortmaker@windriver.com>
Received: from yow-pgortmak-d1.corp.ad.wrs.com (unknown [209.5.119.169])
	by ozlabs.org (Postfix) with ESMTP id E0B64DDEE7
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 04:50:03 +1100 (EST)
Date: Wed, 2 Jan 2008 12:50:01 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] mpc85xx_ads: add in missing of_node_put()
Message-ID: <20080102175001.GA18205@windriver.com>
References: <20071221154009.GB20661@windriver.com>
	<20071223095038.ce1ad7a5.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071223095038.ce1ad7a5.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message: Re: [PATCH] mpc85xx_ads: add in missing of_node_put()
on 23/12/2007 Stephen Rothwell wrote:

> On Fri, 21 Dec 2007 10:40:09 -0500 Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> >
> > cpm2_pic_init() does its own of_node_get() so we should do an of_node_put()
> > before calling it.
> 
> The of_node_put() should really go after the call to cpm2_pic_init(), that
> way you retain a raised ref count at all times.  Sorry fo not being
> entirely clear before.

No problem.  Updated version below.

Thanks,
Paul.


>From eea2826182b4b732ded224240ef9dc89a881ce4b Mon Sep 17 00:00:00 2001
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 21 Dec 2007 10:12:38 -0500
Subject: [PATCH] mpc85xx_ads: add in missing of_node_put()

Add in missing of_node_put() after cpm2_pic_init(). This and other coding
style cleanups as suggested by Stephen Rothwell.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_ads.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index bccdc25..91781a9 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -52,9 +52,9 @@ static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
 {
 	int cascade_irq;
 
-	while ((cascade_irq = cpm2_get_irq()) >= 0) {
+	while ((cascade_irq = cpm2_get_irq()) >= 0)
 		generic_handle_irq(cascade_irq);
-	}
+
 	desc->chip->eoi(irq);
 }
 
@@ -70,13 +70,12 @@ static void __init mpc85xx_ads_pic_init(void)
 #endif
 
 	np = of_find_node_by_type(np, "open-pic");
-
-	if (np == NULL) {
+	if (!np) {
 		printk(KERN_ERR "Could not find open-pic node\n");
 		return;
 	}
 
-	if(of_address_to_resource(np, 0, &r)) {
+	if (of_address_to_resource(np, 0, &r)) {
 		printk(KERN_ERR "Could not map mpic register space\n");
 		of_node_put(np);
 		return;
@@ -100,6 +99,7 @@ static void __init mpc85xx_ads_pic_init(void)
 	irq = irq_of_parse_and_map(np, 0);
 
 	cpm2_pic_init(np);
+	of_node_put(np);
 	set_irq_chained_handler(irq, cpm2_cascade);
 #endif
 }
@@ -112,7 +112,7 @@ struct cpm_pin {
 	int port, pin, flags;
 };
 
-static struct cpm_pin mpc8560_ads_pins[] = {
+static const struct cpm_pin mpc8560_ads_pins[] = {
 	/* SCC1 */
 	{3, 29, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
 	{3, 30, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
-- 
1.5.0.rc1.gf4b6c
