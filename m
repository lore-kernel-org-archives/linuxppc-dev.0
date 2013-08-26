Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D85F62C0258
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:32:50 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 27 Aug 2013 05:24:18 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5ADAF357804E
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:32:48 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7QJGixp62390406
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:16:44 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7QJWlZr030058
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:32:47 +1000
Subject: [RFC PATCH v3 11/12] powerpc/powernv: Remove machine check handling
 in OPAL.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 27 Aug 2013 01:02:45 +0530
Message-ID: <20130826193244.2855.25079.stgit@mars>
In-Reply-To: <20130826192616.2855.18749.stgit@mars>
References: <20130826192616.2855.18749.stgit@mars>
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
