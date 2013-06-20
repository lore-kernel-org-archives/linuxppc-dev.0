Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C84702C0367
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 15:21:51 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 20 Jun 2013 01:21:49 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id CB9CA38C804A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 01:21:45 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5K5LkX054657058
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 01:21:46 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5K5Lksi004053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 02:21:46 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 28/31] powernv/opal: Disable OPAL notifier upon poweroff
Date: Thu, 20 Jun 2013 13:21:18 +0800
Message-Id: <1371705681-24632-29-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371705681-24632-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371705681-24632-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While we're restarting or powering off the system, we needn't
the OPAL notifier any more. So just to disable that.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/setup.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index d4459bf..84438af 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -93,6 +93,8 @@ static void  __noreturn pnv_restart(char *cmd)
 {
 	long rc = OPAL_BUSY;
 
+	opal_notifier_disable();
+
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_cec_reboot();
 		if (rc == OPAL_BUSY_EVENT)
@@ -108,6 +110,8 @@ static void __noreturn pnv_power_off(void)
 {
 	long rc = OPAL_BUSY;
 
+	opal_notifier_disable();
+
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_cec_power_down(0);
 		if (rc == OPAL_BUSY_EVENT)
-- 
1.7.5.4
