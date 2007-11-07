Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out0.tiscali.nl (smtp-out0.tiscali.nl [195.241.79.175])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B3554DDDF8
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 09:08:49 +1100 (EST)
Received: from [82.171.216.234] (helo=[192.168.1.2])
	by smtp-out0.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1Ipt4m-0006su-AQ
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Nov 2007 23:08:44 +0100
Message-ID: <4732376A.8050203@tiscali.nl>
Date: Wed, 07 Nov 2007 23:08:42 +0100
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] mpc8xx_pic_init(); arch/powerpc/sysdev/mpc8xx_pic.c
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Again: untested 
--
iounmap siu_reg on error

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8xx_pic.c
index 7aa4ff5..1a51251 100644
--- a/arch/powerpc/sysdev/mpc8xx_pic.c
+++ b/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -177,14 +177,15 @@ int mpc8xx_pic_init(void)
 	siu_reg = ioremap(res.start, res.end - res.start + 1);
 	if (siu_reg == NULL)
 		return -EINVAL;
 
 	mpc8xx_pic_host = irq_alloc_host(of_node_get(np), IRQ_HOST_MAP_LINEAR,
 					 64, &mpc8xx_pic_host_ops, 64);
 	if (mpc8xx_pic_host == NULL) {
+		iounmap(siu_reg);
 		printk(KERN_ERR "MPC8xx PIC: failed to allocate irq host!\n");
 		ret = -ENOMEM;
 	}
 
 out:
 	of_node_put(np);
 	return ret;
