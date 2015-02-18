Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 20CC41A09D0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 11:04:03 +1100 (AEDT)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 19:04:00 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id D9EAA6E805E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 18:55:50 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1I03x5T27525218
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 00:03:59 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1I03wnr007466
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 19:03:59 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH 2/3] powerpc/powernv: only call OPAL_ELOG_RESEND if firmware
 supports it
Date: Wed, 18 Feb 2015 11:03:43 +1100
Message-Id: <1424217824-30596-3-git-send-email-stewart@linux.vnet.ibm.com>
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

Otherwise firmware complains: "OPAL: Called with bad token 74 !"
as not all OPAL systems have the ability to resend error logs.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-elog.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
index 518fe95..38ce757 100644
--- a/arch/powerpc/platforms/powernv/opal-elog.c
+++ b/arch/powerpc/platforms/powernv/opal-elog.c
@@ -313,7 +313,8 @@ int __init opal_elog_init(void)
 	}
 
 	/* We are now ready to pull error logs from opal. */
-	opal_resend_pending_logs();
+	if (opal_check_token(OPAL_ELOG_RESEND))
+		opal_resend_pending_logs();
 
 	return 0;
 }
-- 
1.7.10.4
