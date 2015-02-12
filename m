Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BDE91A0FBD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Feb 2015 16:26:31 +1100 (AEDT)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 11 Feb 2015 22:26:29 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 8D6931FF0045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 22:17:39 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1C5QLUv25231368
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 22:26:29 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1C5PsNK027267
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 22:25:54 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH 2/3] powerpc/powernv: only call OPAL_ELOG_RESEND if firmware
 supports it
Date: Thu, 12 Feb 2015 16:25:28 +1100
Message-Id: <1423718729-17992-3-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1423718729-17992-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1423718729-17992-1-git-send-email-stewart@linux.vnet.ibm.com>
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
