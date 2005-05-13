Return-Path: <domen@nd47.coderock.org>
Received: from trashy.coderock.org (coderock.org [193.77.147.115])
	by ozlabs.org (Postfix) with ESMTP id DAEC167A6B
	for <linuxppc-dev@ozlabs.org>; Sat, 14 May 2005 08:23:00 +1000 (EST)
Message-Id: <20050513221214.176864000@nd47.coderock.org>
Date: Sat, 14 May 2005 00:12:14 +0200
From: domen@coderock.org
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, domen@coderock.org,
	Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [patch 1/1] ppc/fcc_enet: replace schedule_timeout() with ssleep()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Nishanth Aravamudan <nacc@us.ibm.com>


Use ssleep() instead of schedule_timeout() to guarantee the task delays
as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 fcc_enet.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

Index: quilt/arch/ppc/8260_io/fcc_enet.c
===================================================================
--- quilt.orig/arch/ppc/8260_io/fcc_enet.c
+++ quilt/arch/ppc/8260_io/fcc_enet.c
@@ -1305,12 +1305,11 @@ static void mii_parse_dm9161_scsr(uint m
 
 static void mii_dm9161_wait(uint mii_reg, struct net_device *dev)
 {
-	int timeout = HZ;
+	int timeout_secs = 1;
 
 	/* Davicom takes a bit to come up after a reset,
 	 * so wait here for a bit */
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(timeout);
+	ssleep(timeout_secs);
 }
 
 static phy_info_t phy_info_dm9161 = {

--
