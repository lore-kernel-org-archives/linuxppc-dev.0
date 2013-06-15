Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C266C2C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 19:03:41 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sat, 15 Jun 2013 05:03:39 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 829FDC9003E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 05:03:35 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5F93aDf58523808
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 05:03:36 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5F93Zp0015738
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 06:03:36 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 24/27] powernv/opal: Disable OPAL notifier upon poweroff
Date: Sat, 15 Jun 2013 17:03:15 +0800
Message-Id: <1371286998-2842-25-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371286998-2842-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371286998-2842-1-git-send-email-shangw@linux.vnet.ibm.com>
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
