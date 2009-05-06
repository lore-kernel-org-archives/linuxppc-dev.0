Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id B102DDE9D0
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 06:21:08 +1000 (EST)
From: Wolfgang Denk <wd@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/04] *** NOT FOR RELEASE *** HACK *** Work around MII clock
	issue ***
Date: Wed,  6 May 2009 22:21:02 +0200
Message-Id: <1241641262-5202-6-git-send-email-wd@denx.de>
In-Reply-To: <1241641262-5202-1-git-send-email-wd@denx.de>
References: <1241641262-5202-1-git-send-email-wd@denx.de>
Cc: Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Wolfgang Denk <wd@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: John Rigby <jcrigby@gmail.com>
---
This patch is NOT intended for inclusion into mainline, but rather a
request for help. For some reason which I don't understand yet, the
Ethernet interface on the ARIA board does not work in the default
configuration, because MII probing fails.

What I'm seeing is this; the problem is with this part of code in
"drivers/net/fs_enet/mii-fec.c":

156         fec->mii_speed = ((ppc_proc_freq + 4999999) / 5000000) << 1;
...
163         out_be32(&fec->fecp->fec_mii_speed, fec->mii_speed);

I added some debug messages, and this is what I see:

On the ADS5121, we have the CPU clocked at 400 MHz.  I get:
...
## ppc_proc_freq = 399999996, fec->mii_speed = 160
FEC MII Bus: probed
...
It works fine.

According to the Ref. Man.:
        A value of 0 in this field turns off the MDC and leaves it in
        a low-voltage state. Any non-zero value results in the MDC
        frequency of 1/(mii_speed*2) of the system clock frequency.
that means we have a MDC frequency of
	400 MHz / (2 * 160) = 1.25 MHz
which is obviously within the 2.5 MHz limit.

Now ARIA is currently running at 316.8 MHz, and this is what I get:
...
## ppc_proc_freq = 316800000, fec->mii_speed = 128
fsl-fec-mdio: probe of 80002800.mdio failed with error -5
...
It fails. MDC frequency is
	316.8 MHz / (2 * 128) = 1.24 MHz
which should be fine.

However, If I change the code to

fec->mii_speed = (((ppc_proc_freq / 1000000) / 30) + 1) << 1;

then I get:
...
## ppc_proc_freq = 316800000, fec->mii_speed = 22
FEC MII Bus: probed
... and it's working!!! However, I compute MDC frequency as
	316.8 MHz / (2 * 22) = 7.2 MHz
which is far above the maximum allowed clock of 2.5 MHz ???

Has anybody any idea what might be going on here?


 drivers/net/fs_enet/mii-fec.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/net/fs_enet/mii-fec.c b/drivers/net/fs_enet/mii-fec.c
index 9d8bd97..a51dd83 100644
--- a/drivers/net/fs_enet/mii-fec.c
+++ b/drivers/net/fs_enet/mii-fec.c
@@ -153,8 +153,12 @@ static int __devinit fs_enet_mdio_probe(struct of_device *ofdev,
 	if (!fec->fecp)
 		goto out_fec;
 
+#if 0
 	fec->mii_speed = ((ppc_proc_freq + 4999999) / 5000000) << 1;
-
+#else
+	fec->mii_speed = (((ppc_proc_freq / 1000000) / 30) + 1) << 1;
+	printk("## ppc_proc_freq = %d, fec->mii_speed = %d\n", ppc_proc_freq, fec->mii_speed);
+#endif
 	setbits32(&fec->fecp->fec_r_cntrl, FEC_RCNTRL_MII_MODE);
 	setbits32(&fec->fecp->fec_ecntrl, FEC_ECNTRL_PINMUX |
 	                                  FEC_ECNTRL_ETHER_EN);
-- 
1.6.0.6
