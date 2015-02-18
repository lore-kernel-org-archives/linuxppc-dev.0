Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB2FD1A09CC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 11:04:04 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 19:04:02 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 54040C9007D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 18:55:10 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1I03xr423593052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 00:03:59 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1I03wMl007442
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 19:03:59 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH 1/3] powerpc/powernv: only register log if OPAL supports doing
 so
Date: Wed, 18 Feb 2015 11:03:42 +1100
Message-Id: <1424217824-30596-2-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1424217824-30596-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1424217824-30596-1-git-send-email-stewart@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Correct use of REGISTER/UNREGISTER is to check if the token exists
before calling. If we don't we get a "OPAL: Called with bad token 101 !"
error, which is harmless but may be alarming to some.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index f10b9ec..84ff20c 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -665,6 +665,9 @@ static void __init opal_dump_region_init(void)
 	uint64_t size;
 	int rc;
 
+	if (!opal_check_token(OPAL_REGISTER_DUMP_REGION))
+		return;
+
 	/* Register kernel log buffer */
 	addr = log_buf_addr_get();
 	size = log_buf_len_get();
@@ -795,7 +798,8 @@ void opal_shutdown(void)
 	}
 
 	/* Unregister memory dump region */
-	opal_unregister_dump_region(OPAL_DUMP_REGION_LOG_BUF);
+	if (opal_check_token(OPAL_UNREGISTER_DUMP_REGION))
+		opal_unregister_dump_region(OPAL_DUMP_REGION_LOG_BUF);
 }
 
 /* Export this so that test modules can use it */
-- 
1.7.10.4
