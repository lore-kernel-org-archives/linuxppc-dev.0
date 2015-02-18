Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47D201A09D3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 11:04:04 +1100 (AEDT)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 19:04:01 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 6AB2C6E8041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 18:55:50 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1I03w1o16580668
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 00:03:58 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1I03wxC030533
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 19:03:58 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH 3/3] powerpc/powernv: only call OPAL_RESEND_DUMP if firmware
 supports it
Date: Wed, 18 Feb 2015 11:03:44 +1100
Message-Id: <1424217824-30596-4-git-send-email-stewart@linux.vnet.ibm.com>
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

Not all OPAL platforms support resending system dumps, so check
that current firmware supports it first. Otherwise we get firmware
complaining:
"OPAL: Called with bad token 91 !"

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-dump.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
index 23260f7..5aa9c1c 100644
--- a/arch/powerpc/platforms/powernv/opal-dump.c
+++ b/arch/powerpc/platforms/powernv/opal-dump.c
@@ -452,5 +452,6 @@ void __init opal_platform_dump_init(void)
 		return;
 	}
 
-	opal_dump_resend_notification();
+	if (opal_check_token(OPAL_DUMP_RESEND))
+		opal_dump_resend_notification();
 }
-- 
1.7.10.4
