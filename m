Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id 78001DDFAE
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 04:12:02 +1100 (EST)
Received: from localhost (unknown [127.0.0.1])
	by mail.semihalf.com (Postfix) with ESMTP id 0003C14355
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 18:13:09 +0100 (CET)
Received: from mail.semihalf.com ([127.0.0.1])
	by localhost (mail.semihalf.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00621-01 for <linuxppc-dev@ozlabs.org>;
	Fri,  9 Nov 2007 18:13:08 +0100 (CET)
Received: from hekate.izotz.org (frozen.izotz.org [83.175.187.135])
	by mail.semihalf.com (Postfix) with ESMTP id 900EB1431C
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 18:13:08 +0100 (CET)
From: Marian Balakowicz <m8@semihalf.com>
Subject: [PATCH v4 02/13] [POWERPC] Add 'fsl,
	lpb' bus type for MPC5200 LocalPlus Bus
To: linuxppc-dev@ozlabs.org
Date: Fri, 09 Nov 2007 18:11:49 +0100
Message-ID: <20071109171149.16289.88635.stgit@hekate.izotz.org>
In-Reply-To: <20071109171137.16289.39575.stgit@hekate.izotz.org>
References: <20071109171137.16289.39575.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Define MPC52xx specific device id list, add new
'fsl,lpb' compatible id for LocalPlus Bus.

Signed-off-by: Marian Balakowicz <m8@semihalf.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---

 arch/powerpc/platforms/52xx/mpc52xx_common.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)


diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index 9850685..2df97c5 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -124,11 +124,18 @@ mpc5200_setup_xlb_arbiter(void)
 	iounmap(xlb);
 }
 
+static struct of_device_id mpc52xx_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{ .compatible = "fsl,lpb", },
+	{},
+};
+
 void __init
 mpc52xx_declare_of_platform_devices(void)
 {
 	/* Find every child of the SOC node and add it to of_platform */
-	if (of_platform_bus_probe(NULL, NULL, NULL))
+	if (of_platform_bus_probe(NULL, mpc52xx_ids, NULL))
 		printk(KERN_ERR __FILE__ ": "
 			"Error while probing of_platform bus\n");
 }
