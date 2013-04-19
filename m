Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 08E6E2C023F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 21:45:34 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Fri, 19 Apr 2013 21:40:36 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 51564357804E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 21:45:31 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3JBiqQf59900036
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 21:44:52 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3JBiv1F008647
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 21:44:57 +1000
Subject: [PATCH] powerpc/rtas_flash: New return code to indicate FW
 entitlement expiry
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org, paulus@samba.org
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Fri, 19 Apr 2013 17:14:45 +0530
Message-ID: <20130419114410.19115.35846.stgit@hegdevasant>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add new return code to rtas_flash to indicate firmware entitlement
expiry. This will be used by the update_flash script to return
appropriate message to the user.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/rtas_flash.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index a7020d2..0a12c16 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -64,6 +64,7 @@
 #define VALIDATE_TMP_COMMIT_DL 4     /* Validate Return Status */
 #define VALIDATE_TMP_COMMIT    5     /* Validate Return Status */
 #define VALIDATE_TMP_UPDATE_DL 6     /* Validate Return Status */
+#define VALIDATE_OUT_OF_WRNTY  7     /* Validate Return Status */
 
 /* ibm,manage-flash-image operation tokens */
 #define RTAS_REJECT_TMP_IMG   0
