Return-Path: <albrecht.dress@arcor.de>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 557C3B6EDF
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 19:49:34 +1100 (EST)
Message-ID: <18304285.1257929369240.JavaMail.ngmail@webmail19.ha2.local>
Date: Wed, 11 Nov 2009 09:49:29 +0100 (CET)
From: "Albrecht Dreﬂ" <albrecht.dress@arcor.de>
To: grant.likely@secretlab.ca
Subject: [PATCH] mpc5200/gpt: tiny fix for gpt period limitation
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes a limitation of the 5200's period.

Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
---

 arch/powerpc/include/asm/mpc52xx.h        |    2 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/asm/=
mpc52xx.h
index 707ab75..933fb8f 100644
--- a/arch/powerpc/include/asm/mpc52xx.h
+++ b/arch/powerpc/include/asm/mpc52xx.h
@@ -279,7 +279,7 @@ extern void mpc52xx_restart(char *cmd);
 /* mpc52xx_gpt.c */
 struct mpc52xx_gpt_priv;
 extern struct mpc52xx_gpt_priv *mpc52xx_gpt_from_irq(int irq);
-extern int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, int perio=
d,
+extern int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, u64 perio=
d,
                             int continuous);
 extern void mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt);
=20
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platf=
orms/52xx/mpc52xx_gpt.c
index 2c3fa13..77572ab 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -378,12 +378,12 @@ EXPORT_SYMBOL(mpc52xx_gpt_from_irq);
 /**
  * mpc52xx_gpt_start_timer - Set and enable the GPT timer
  * @gpt: Pointer to gpt private data structure
- * @period: period of timer
+ * @period: period of timer in ns; max. ~130s @ 33MHz IPB clock
  * @continuous: set to 1 to make timer continuous free running
  *
  * An interrupt will be generated every time the timer fires
  */
-int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, int period,
+int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, u64 period,
                             int continuous)
 {
        u32 clear, set;
@@ -400,7 +400,7 @@ int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gp=
t, int period,
         * arithmatic is done here to preserve the precision until the valu=
e
         * is scaled back down into the u32 range.  Period is in 'ns', bus
         * frequency is in Hz. */
-       clocks =3D (u64)period * (u64)gpt->ipb_freq;
+       clocks =3D period * (u64)gpt->ipb_freq;
        do_div(clocks, 1000000000); /* Scale it down to ns range */
=20
        /* This device cannot handle a clock count greater than 32 bits */


Jetzt NEU: Do it youself E-Cards bei Arcor.de!
Stellen Sie Ihr eigenes Unikat zusammen und machen Sie dem Empf=E4nger eine=
 ganz pers=F6nliche Freude!
E-Card Marke Eigenbau: HIER KLICKEN: http://www.arcor.de/rd/footer.ecard
