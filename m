Return-Path: <gizero@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C2271B7018
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Apr 2011 18:55:56 +1000 (EST)
Received: by wyg36 with SMTP id 36so464298wyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Apr 2011 01:55:51 -0700 (PDT)
From: Andrea Galbusera <gizero@gmail.com>
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 1/1] powerpc: Fix multicast problem in fs_enet driver
Date: Wed, 20 Apr 2011 10:55:19 +0200
Message-Id: <1303289719-16913-1-git-send-email-gizero@gmail.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Andrea Galbusera <gizero@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mac-fec.c was setting individual UDP address registers instead of multicast
group address registers when joining a multicast group.
This prevented from correctly receiving UDP multicast packets.
According to datasheet, replaced hash_table_high and hash_table_low
with grp_hash_table_high and grp_hash_table_low respectively.

Tested on a MPC5121 based board.

Signed-off-by: Andrea Galbusera <gizero@gmail.com>
---
 drivers/net/fs_enet/mac-fec.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/fs_enet/mac-fec.c b/drivers/net/fs_enet/mac-fec.c
index 61035fc..b9fbc83 100644
--- a/drivers/net/fs_enet/mac-fec.c
+++ b/drivers/net/fs_enet/mac-fec.c
@@ -226,8 +226,8 @@ static void set_multicast_finish(struct net_device *dev)
 	}
 
 	FC(fecp, r_cntrl, FEC_RCNTRL_PROM);
-	FW(fecp, hash_table_high, fep->fec.hthi);
-	FW(fecp, hash_table_low, fep->fec.htlo);
+	FW(fecp, grp_hash_table_high, fep->fec.hthi);
+	FW(fecp, grp_hash_table_low, fep->fec.htlo);
 }
 
 static void set_multicast_list(struct net_device *dev)
@@ -273,8 +273,8 @@ static void restart(struct net_device *dev)
 	/*
 	 * Reset all multicast.
 	 */
-	FW(fecp, hash_table_high, fep->fec.hthi);
-	FW(fecp, hash_table_low, fep->fec.htlo);
+	FW(fecp, grp_hash_table_high, fep->fec.hthi);
+	FW(fecp, grp_hash_table_low, fep->fec.htlo);
 
 	/*
 	 * Set maximum receive buffer size.
-- 
1.7.0.4
