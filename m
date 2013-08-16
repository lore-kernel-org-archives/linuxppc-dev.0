Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 998E92C04EC
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 18:05:34 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 16 Aug 2013 17:55:18 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 75C953578052
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 18:05:32 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7G7nVcZ721272
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 17:49:32 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7G85VKd032633
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 18:05:32 +1000
Subject: [RFC PATCH v2 09/10] powerpc/powernv: Remove machine check handling
 in OPAL.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 16 Aug 2013 13:35:22 +0530
Message-ID: <20130816080522.680.2072.stgit@mars.in.ibm.com>
In-Reply-To: <20130816080213.680.50794.stgit@mars.in.ibm.com>
References: <20130816080213.680.50794.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>
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
index bcbbcdc..8545b33 100644
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
