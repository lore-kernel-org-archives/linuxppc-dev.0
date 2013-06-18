Return-Path: <glikely@secretlab.ca>
Received: from mail-wi0-x235.google.com (mail-wi0-x235.google.com
 [IPv6:2a00:1450:400c:c05::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C411C2C009A
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Jun 2013 19:46:24 +1000 (EST)
Received: by mail-wi0-f181.google.com with SMTP id hq4so3023867wib.2
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Jun 2013 02:46:22 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v2 08/11] irqdomain: Refactor irq_domain_associate_many()
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <CACxGe6s+K0xF0pnLjKoKXtz_YNoeM2+erhr_g2dX4ONpddRNGA@mail.gmail.com>
References: <1371244086-9189-1-git-send-email-grant.likely@linaro.org>
 <1371244086-9189-9-git-send-email-grant.likely@linaro.org>
 <4521.1371518445@ale.ozlabs.ibm.com> <5220.1371518734@ale.ozlabs.ibm.com>
 <CACxGe6s+K0xF0pnLjKoKXtz_YNoeM2+erhr_g2dX4ONpddRNGA@mail.gmail.com>
Date: Tue, 18 Jun 2013 10:46:17 +0100
Message-Id: <20130618094617.9BFA93E0D88@localhost>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>,
 linux-next <linux-next@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 18 Jun 2013 10:05:31 +0100, Grant Likely <grant.likely@linaro.org> wrote:
> On Tue, Jun 18, 2013 at 2:25 AM, Michael Neuling <mikey@neuling.org> wrote:
> > Michael Neuling <mikey@neuling.org> wrote:
> >
> >> Grant,
> >>
> >> In next-20130617 we are getting the below crash on POWER7.  Bisecting,
> >> points to this patch (d39046ec72 in next)
> >
> > Also, reverting just d39046ec72 fixes the crash in next-20130617.
> 
> Odd. Of all the changes in that series, I would not have expected that
> one to cause any problems. I'm digging into it now...

Ugh. I flubbed the commit. Try this patch. It should solve the problem:

>From b7ba09c29ed36eda8e16453646b55faea7f9c25f Mon Sep 17 00:00:00 2001
From: Grant Likely <grant.likely@linaro.org>
Date: Tue, 18 Jun 2013 10:15:19 +0100
Subject: [PATCH] irqdomain: Fix flubbed irq_domain_associate_many refactoring

commit d39046ec72, "irqdomain: Refactor irq_domain_associate_many()" was
missing the following hunk which causes a boot failure on anything using
irq_domain_add_tree() to allocate an irq domain.

Signed-off-by: Grant Likely <grant.likely@linaro.org>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
Cc: Thomas Gleixner <tglx@linutronix.de>,
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/irqdomain.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 02f7658..c983ed1 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -162,7 +162,7 @@ static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return irq_domain_add_linear(of_node, 0, ops, host_data);
+	return __irq_domain_add(of_node, 0, ~0, 0, ops, host_data);
 }
 
 extern void irq_domain_remove(struct irq_domain *host);
-- 
1.8.1.2
