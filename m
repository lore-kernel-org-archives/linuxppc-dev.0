Return-Path: <xufengzhang.main@gmail.com>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A18352C035A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2012 19:06:29 +1000 (EST)
Received: by vbip1 with SMTP id p1so901307vbi.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2012 02:06:26 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 18 Jul 2012 17:00:29 +0800
Message-ID: <CA+=dFzhEf12XKxL5=M5vhtoYin9Ct=RucNCh=v-FVQUSPrkOww@mail.gmail.com>
Subject: mpc85xx_edac.c: Should the mpc85xx_l2_isr be shared irqs?
From: Xufeng Zhang <xufengzhang.main@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

I detected below error when booting p1021mds after enabled EDAC feature:
EDAC MC: Ver: 2.1.0 Jul 17 2012
Freescale(R) MPC85xx EDAC driver, (C) 2006 Montavista Software
EDAC MC0: Giving out device to 'MPC85xx_edac' 'mpc85xx_mc_err': DEV mpc85xx_mc_e
rr
IRQ 45/[EDAC] MC err: IRQF_DISABLED is not guaranteed on shared IRQs
MPC85xx_edac acquired irq 45 for MC
MPC85xx_edac MC err registered
EDAC DEVICE0: Giving out device to module 'MPC85xx_edac' controller 'mpc85xx_l2_
err': DEV 'mpc85xx_l2_err' (INTERRUPT)
mpc85xx_l2_err_probe: Unable to requiest irq 45 for MPC85xx L2 err

Then kernel hang.

When request irq for l2-cache, since it share the same irq with memory
controller,
I think the code should be:
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -577,7 +577,7 @@ static int __devinit mpc85xx_l2_err_probe(struct
of_device *op,
 	if (edac_op_state == EDAC_OPSTATE_INT) {
 		pdata->irq = irq_of_parse_and_map(op->node, 0);
 		res = devm_request_irq(&op->dev, pdata->irq,
-				       mpc85xx_l2_isr, IRQF_DISABLED,
+				       mpc85xx_l2_isr, IRQF_DISABLED | IRQF_SHARED,
 				       "[EDAC] L2 err", edac_dev);
 		if (res < 0) {
 			printk(KERN_ERR





Thanks,
Xufeng Zhang
