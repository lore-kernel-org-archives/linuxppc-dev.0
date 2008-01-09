Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1B6FADDF81
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 00:15:33 +1100 (EST)
Message-ID: <4784C509.5030507@denx.de>
Date: Wed, 09 Jan 2008 13:58:49 +0100
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: Sergej Stepanov <Sergej.Stepanov@ids.de>
Subject: Re: [PATCH for 2.6.24][NET] fs_enet: check for phydev existence in
	the ethtool handlers
References: <1199875566.3408.11.camel@p60365-ste>
In-Reply-To: <1199875566.3408.11.camel@p60365-ste>
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jeff@garzik.org>
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Sergej,

Wed Jan 9 21:46:06 EST 2008 Sergej Stepanov Sergej.Stepanov@ids.de wrote:
> I got also oops problem with the driver.
> What could be false?
> After the following patch it functions.
> Thanks for any advance.
>
> diff --git a/drivers/net/fs_enet/fs_enet-main.c
> b/drivers/net/fs_enet/fs_enet-main.c
> index f2a4d39..d5081b1 100644
> --- a/drivers/net/fs_enet/fs_enet-main.c
> +++ b/drivers/net/fs_enet/fs_enet-main.c
> @@ -99,6 +99,8 @@ static int fs_enet_rx_napi(struct napi_struct *napi,
> int budget)

seems your mailer wraps long lines

>        if (!netif_running(dev))
>                return 0;
>
> +       if (fep->cur_rx == NULL)
> +               return 0;
>         /*
>          * First, grab all of the stats for the incoming packet.
>          * These get messed up if we get called due to a busy condition.

Hmm... I had also a oops in fs_enet_rx_napi () because of an
uninitialized fep->cur_rx. The following Patch solves this, also
adds support for using Ethernet over SCC on a CPM2.

>From 62cd02d481eb772f4417e9ba17fb010d1954c330 Mon Sep 17 00:00:00 2001
From: Heiko Schocher <hs@denx.de>
Date: Mon, 7 Jan 2008 09:42:09 +0100
Subject: [PATCH] [POWERPC] Fix Ethernet over SCC on a CPM2

Signed-off-by: Heiko Schocher <hs@denx.de>
---
 drivers/net/fs_enet/fs_enet-main.c |   11 +++++++++--
 drivers/net/fs_enet/mac-scc.c      |   18 ++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index f2a4d39..b4a1480 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -982,6 +982,7 @@ static struct net_device *fs_init_instance(struct device *dev,
 	fep = netdev_priv(ndev);

 	fep->dev = dev;
+	fep->ndev = ndev;
 	dev_set_drvdata(dev, ndev);
 	fep->fpi = fpi;
 	if (fpi->init_ioports)
@@ -1085,7 +1086,6 @@ static struct net_device *fs_init_instance(struct device *dev,
 	}
 	registered = 1;

-
 	return ndev;

 err:
@@ -1312,6 +1312,9 @@ static int __devinit fs_enet_probe(struct of_device *ofdev,
 	       ndev->dev_addr[0], ndev->dev_addr[1], ndev->dev_addr[2],
 	       ndev->dev_addr[3], ndev->dev_addr[4], ndev->dev_addr[5]);

+	/* to initialize the fep->cur_rx,... */
+	/* not doing this, will cause a crash in fs_enet_rx_napi */
+	fs_init_bds(ndev);
 	return 0;

 out_free_bd:
@@ -1342,9 +1345,13 @@ static int fs_enet_remove(struct of_device *ofdev)
 }

 static struct of_device_id fs_enet_match[] = {
-#ifdef CONFIG_FS_ENET_HAS_SCC
+#if defined(CONFIG_FS_ENET_HAS_SCC)
 	{
+#if defined(CONFIG_CPM1)
 		.compatible = "fsl,cpm1-scc-enet",
+#else
+		.compatible = "fsl,cpm2-scc-enet",
+#endif
 		.data = (void *)&fs_scc_ops,
 	},
 #endif
diff --git a/drivers/net/fs_enet/mac-scc.c b/drivers/net/fs_enet/mac-scc.c
index 48f2f30..3b5ca76 100644
--- a/drivers/net/fs_enet/mac-scc.c
+++ b/drivers/net/fs_enet/mac-scc.c
@@ -50,6 +50,7 @@
 #include "fs_enet.h"

 /*************************************************/
+#define SCC_EB ((u_char)0x10)  /* Set big endian byte order */

 #if defined(CONFIG_CPM1)
 /* for a 8xx __raw_xxx's are sufficient */
@@ -65,6 +66,8 @@
 #define __fs_out16(addr, x)	out_be16(addr, x)
 #define __fs_in32(addr)	in_be32(addr)
 #define __fs_in16(addr)	in_be16(addr)
+#define __fs_out8(addr, x)	out_8(addr, x)
+#define __fs_in8(addr)	in_8(addr)
 #endif

 /* write, read, set bits, clear bits */
@@ -96,10 +99,18 @@ static inline int scc_cr_cmd(struct fs_enet_private *fep, u32 op)
 	const struct fs_platform_info *fpi = fep->fpi;
 	int i;

+#if defined(CONFIG_CPM1)
 	W16(cpmp, cp_cpcr, fpi->cp_command | CPM_CR_FLG | (op << 8));
 	for (i = 0; i < MAX_CR_CMD_LOOPS; i++)
 		if ((R16(cpmp, cp_cpcr) & CPM_CR_FLG) == 0)
 			return 0;
+#else
+	W32(cpmp, cp_cpcr, fpi->cp_command | CPM_CR_FLG | op);
+	for (i = 0; i < MAX_CR_CMD_LOOPS; i++)
+		if ((R32(cpmp, cp_cpcr) & CPM_CR_FLG) == 0)
+			return 0;
+
+#endif

 	printk(KERN_ERR "%s(): Not able to issue CPM command\n",
 		__FUNCTION__);
@@ -306,8 +317,15 @@ static void restart(struct net_device *dev)

 	/* Initialize function code registers for big-endian.
 	 */
+#ifdef CONFIG_CPM2
+	/* from oldstyle driver in arch/ppc */
+	/* seems necessary */
+	W8(ep, sen_genscc.scc_rfcr, SCC_EB | 0x20);
+	W8(ep, sen_genscc.scc_tfcr, SCC_EB | 0x20);
+#else
 	W8(ep, sen_genscc.scc_rfcr, SCC_EB);
 	W8(ep, sen_genscc.scc_tfcr, SCC_EB);
+#endif

 	/* Set maximum bytes per receive buffer.
 	 * This appears to be an Ethernet frame size, not the buffer
-- 
1.5.2.2


bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
