Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 3BAA1DE05C
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 05:38:08 +1100 (EST)
Message-ID: <478666C6.2030104@denx.de>
Date: Thu, 10 Jan 2008 19:41:10 +0100
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH for 2.6.24][NET] fs_enet: check for phydev existence in
	the ethtool handlers
References: <1199875566.3408.11.camel@p60365-ste> <4784C509.5030507@denx.de>
	<20080109182038.GA4337@loki.buserror.net>
	<4785D3D8.7080300@denx.de> <4785E014.4040709@denx.de>
	<4786556C.8040108@freescale.com>
In-Reply-To: <4786556C.8040108@freescale.com>
Content-Type: text/plain; charset=UTF-8
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

Hello Scott,

Scott Wood wrote:
> Heiko Schocher wrote:
>> diff --git a/drivers/net/fs_enet/fs_enet-main.c
>> b/drivers/net/fs_enet/fs_enet-main.c
>> index f2a4d39..f432a18 100644
>> --- a/drivers/net/fs_enet/fs_enet-main.c
>> +++ b/drivers/net/fs_enet/fs_enet-main.c
>> @@ -810,6 +810,10 @@ static int fs_enet_open(struct net_device *dev)
>>      if (fep->fpi->use_napi)
>>          napi_enable(&fep->napi);
>>
>> +    /* to initialize the fep->cur_rx,... */
>> +    /* not doing this, will cause a crash in fs_enet_rx_napi */
>> +    fs_init_bds(fep->ndev);
> 
> We should do this just before napi_enable() rather than just after, to
> eliminate any chance of a race window.

Yes, you are right.
Here is the new patch:

>From 3b8db4261199f0115d8e0188b6bffbc9f5e7673d Mon Sep 17 00:00:00 2001
From: Heiko Schocher <hs@denx.de>
Date: Thu, 10 Jan 2008 19:28:18 +0100
Subject: [PATCH] [POWERPC] Fix Ethernet over SCC on a CPM2,
          also Fix crash in fs_enet_rx_napi()

Signed-off-by: Heiko Schocher <hs@denx.de>
---
 drivers/net/fs_enet/fs_enet-main.c |   10 +++++++++-
 drivers/net/fs_enet/mac-scc.c      |    8 +++++++-
 include/asm-powerpc/cpm2.h         |    5 +++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index f2a4d39..70a0319 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -807,6 +807,10 @@ static int fs_enet_open(struct net_device *dev)
 	int r;
 	int err;

+	/* to initialize the fep->cur_rx,... */
+	/* not doing this, will cause a crash in fs_enet_rx_napi */
+	fs_init_bds(fep->ndev);
+
 	if (fep->fpi->use_napi)
 		napi_enable(&fep->napi);

@@ -982,6 +986,7 @@ static struct net_device *fs_init_instance(struct device *dev,
 	fep = netdev_priv(ndev);

 	fep->dev = dev;
+	fep->ndev = ndev;
 	dev_set_drvdata(dev, ndev);
 	fep->fpi = fpi;
 	if (fpi->init_ioports)
@@ -1085,7 +1090,6 @@ static struct net_device *fs_init_instance(struct device *dev,
 	}
 	registered = 1;

-
 	return ndev;

 err:
@@ -1347,6 +1351,10 @@ static struct of_device_id fs_enet_match[] = {
 		.compatible = "fsl,cpm1-scc-enet",
 		.data = (void *)&fs_scc_ops,
 	},
+	{
+		.compatible = "fsl,cpm2-scc-enet",
+		.data = (void *)&fs_scc_ops,
+	},
 #endif
 #ifdef CONFIG_FS_ENET_HAS_FCC
 	{
diff --git a/drivers/net/fs_enet/mac-scc.c b/drivers/net/fs_enet/mac-scc.c
index fe3d8a6..3889271 100644
--- a/drivers/net/fs_enet/mac-scc.c
+++ b/drivers/net/fs_enet/mac-scc.c
@@ -50,7 +50,6 @@
 #include "fs_enet.h"

 /*************************************************/
-
 #if defined(CONFIG_CPM1)
 /* for a 8xx __raw_xxx's are sufficient */
 #define __fs_out32(addr, x)	__raw_writel(x, addr)
@@ -65,6 +64,8 @@
 #define __fs_out16(addr, x)	out_be16(addr, x)
 #define __fs_in32(addr)	in_be32(addr)
 #define __fs_in16(addr)	in_be16(addr)
+#define __fs_out8(addr, x)	out_8(addr, x)
+#define __fs_in8(addr)	in_8(addr)
 #endif

 /* write, read, set bits, clear bits */
@@ -297,8 +298,13 @@ static void restart(struct net_device *dev)

 	/* Initialize function code registers for big-endian.
 	 */
+#ifndef CONFIG_NOT_COHERENT_CACHE
+	W8(ep, sen_genscc.scc_rfcr, SCC_EB | SCC_GBL);
+	W8(ep, sen_genscc.scc_tfcr, SCC_EB | SCC_GBL);
+#else
 	W8(ep, sen_genscc.scc_rfcr, SCC_EB);
 	W8(ep, sen_genscc.scc_tfcr, SCC_EB);
+#endif

 	/* Set maximum bytes per receive buffer.
 	 * This appears to be an Ethernet frame size, not the buffer
diff --git a/include/asm-powerpc/cpm2.h b/include/asm-powerpc/cpm2.h
index f1112c1..14c6496 100644
--- a/include/asm-powerpc/cpm2.h
+++ b/include/asm-powerpc/cpm2.h
@@ -375,6 +375,11 @@ typedef struct scc_param {
 	uint	scc_tcrc;	/* Internal */
 } sccp_t;

+/* Function code bits.
+*/
+#define SCC_EB	((u_char) 0x10)	/* Set big endian byte order */
+#define SCC_GBL	((u_char) 0x20) /* Snooping enabled */
+
 /* CPM Ethernet through SCC1.
  */
 typedef struct scc_enet {
-- 
1.5.2.2


bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
