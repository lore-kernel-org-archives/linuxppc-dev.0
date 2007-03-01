Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id 92BB4DDFD5
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 18:57:22 +1100 (EST)
Date: Thu, 1 Mar 2007 08:57:16 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 6/7] lite5200b suspend: PIC
Message-ID: <20070301075716.GF17184@moe.telargo.com>
References: <20070301075323.GP4397@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070301075323.GP4397@moe.telargo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Save and restore MPC52xx PIC registers.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

Index: grant.git/arch/powerpc/platforms/52xx/mpc52xx_pic.c
===================================================================
--- grant.git.orig/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ grant.git/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -471,3 +471,45 @@ unsigned int mpc52xx_get_irq(void)
 
 	return irq_linear_revmap(mpc52xx_irqhost, irq);
 }
+
+#ifdef CONFIG_PM
+/* save and restore registers for suspend to ram */
+static struct mpc52xx_intr saved_intr;
+void mpc52xx_pic_suspend(void)
+{
+	saved_intr.per_mask = in_be32(&intr->per_mask);
+	saved_intr.per_pri1 = in_be32(&intr->per_pri1);
+	saved_intr.per_pri2 = in_be32(&intr->per_pri2);
+	saved_intr.per_pri3 = in_be32(&intr->per_pri3);
+	saved_intr.ctrl =     in_be32(&intr->ctrl);
+	saved_intr.main_mask = in_be32(&intr->main_mask);
+	saved_intr.main_pri1 = in_be32(&intr->main_pri1);
+	saved_intr.main_pri2 = in_be32(&intr->main_pri2);
+	saved_intr.reserved1 = in_be32(&intr->reserved1);
+	saved_intr.enc_status = in_be32(&intr->enc_status);
+	saved_intr.crit_status = in_be32(&intr->crit_status);
+	saved_intr.main_status = in_be32(&intr->main_status);
+	saved_intr.per_status = in_be32(&intr->per_status);
+	saved_intr.reserved2 = in_be32(&intr->reserved2);
+	saved_intr.per_error = in_be32(&intr->per_error);
+}
+
+void mpc52xx_pic_resume(void)
+{
+	out_be32(&intr->per_mask, saved_intr.per_mask);
+	out_be32(&intr->per_pri1, saved_intr.per_pri1);
+	out_be32(&intr->per_pri2, saved_intr.per_pri2);
+	out_be32(&intr->per_pri3, saved_intr.per_pri3);
+	out_be32(&intr->ctrl,     saved_intr.ctrl);
+	out_be32(&intr->main_mask, saved_intr.main_mask);
+	out_be32(&intr->main_pri1, saved_intr.main_pri1);
+	out_be32(&intr->main_pri2, saved_intr.main_pri2);
+	out_be32(&intr->reserved1, saved_intr.reserved1);
+	out_be32(&intr->enc_status, saved_intr.enc_status);
+	out_be32(&intr->crit_status, saved_intr.crit_status);
+	out_be32(&intr->main_status, saved_intr.main_status);
+	out_be32(&intr->per_status, saved_intr.per_status);
+	out_be32(&intr->reserved2, saved_intr.reserved2);
+	out_be32(&intr->per_error, saved_intr.per_error);
+}
+#endif
