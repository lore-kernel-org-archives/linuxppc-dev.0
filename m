Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 069652C01B6
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Sep 2013 22:42:25 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 16 Sep 2013 22:34:46 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BBC353578052
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Sep 2013 22:42:20 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8GCPgNj53805098
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Sep 2013 22:25:42 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8GCgJKv003517
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Sep 2013 22:42:20 +1000
Subject: [RFC PATCH v4 11/12] powerpc/powernv: Remove machine check handling
 in OPAL.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 16 Sep 2013 18:12:18 +0530
Message-ID: <20130916124217.16111.70085.stgit@mars.in.ibm.com>
In-Reply-To: <20130916123908.16111.4657.stgit@mars.in.ibm.com>
References: <20130916123908.16111.4657.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Now that we are ready to handle machine check directly in linux, do not
register with firmware to handle machine check exception.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index f789514..0170d19 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -83,14 +83,10 @@ static int __init opal_register_exception_handlers(void)
 	if (!(powerpc_firmware_features & FW_FEATURE_OPAL))
 		return -ENODEV;
 
-	/* Hookup some exception handlers. We use the fwnmi area at 0x7000
-	 * to provide the glue space to OPAL
+	/* Hookup some exception handlers except machine check. We use the
+	 * fwnmi area at 0x7000 to provide the glue space to OPAL
 	 */
 	glue = 0x7000;
-	opal_register_exception_handler(OPAL_MACHINE_CHECK_HANDLER,
-					__pa(opal_mc_secondary_handler[0]),
-					glue);
-	glue += 128;
 	opal_register_exception_handler(OPAL_HYPERVISOR_MAINTENANCE_HANDLER,
 					0, glue);
 	glue += 128;
