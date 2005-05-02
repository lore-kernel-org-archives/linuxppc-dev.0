Return-Path: <nacc@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.132])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3AEE567B1B
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 May 2005 16:26:19 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j426Q3eE321106
	for <linuxppc-embedded@ozlabs.org>; Mon, 2 May 2005 02:26:04 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j426Q3lt205584
	for <linuxppc-embedded@ozlabs.org>; Mon, 2 May 2005 00:26:03 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	j426Q3kj032391
	for <linuxppc-embedded@ozlabs.org>; Mon, 2 May 2005 00:26:03 -0600
Date: Sun, 1 May 2005 23:26:00 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: dmalek@jlc.net
Message-ID: <20050502062600.GD10173@us.ibm.com>
References: <20050502061446.GB10173@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050502061446.GB10173@us.ibm.com>
Cc: Kernel-Janitors <kernel-janitors@lists.osdl.org>,
	linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc/fcc_enet: replace schedule_timeout() with ssleep()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I couldn't find an appropriate entry in MAINTAINERS for this patch.

Use ssleep() instead of schedule_timeout() to guarantee the task delays
as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.12-rc3/arch/ppc/8260_io/fcc_enet.c	2005-04-29 11:03:03.000000000 -0700
+++ 2.6.12-rc3-dev/arch/ppc/8260_io/fcc_enet.c	2005-05-01 19:10:58.000000000 -0700
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
