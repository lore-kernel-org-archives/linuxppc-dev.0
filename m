Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C66D91A014C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:27:31 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 9 Feb 2015 21:27:29 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 2F13C38C8041
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 21:27:26 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1A2RQFY28049566
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 02:27:26 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A2ROdV015942
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 21:27:24 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 18/18] powerpc/powernv: s/OpalM64EnableAction/OpalM64Action/
 and __be64 annotation
Date: Tue, 10 Feb 2015 13:27:00 +1100
Message-Id: <1423535220-6322-19-git-send-email-stewart@linux.vnet.ibm.com>
In-Reply-To: <1423535220-6322-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1423535220-6322-1-git-send-email-stewart@linux.vnet.ibm.com>
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

This finally syncs the content of opal.h between linux and firmware

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 68ce7ef..6ea59ca 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -334,7 +334,7 @@ enum OpalMveEnableAction {
 	OPAL_ENABLE_MVE = 1
 };
 
-enum OpalM64EnableAction {
+enum OpalM64Action {
 	OPAL_DISABLE_M64 = 0,
 	OPAL_ENABLE_M64_SPLIT = 1,
 	OPAL_ENABLE_M64_NON_SPLIT = 2
@@ -774,8 +774,8 @@ enum {
 };
 
 typedef struct oppanel_line {
-	const char * 	line;
-	uint64_t 	line_len;
+	__be64 line;
+	__be64 line_len;
 } oppanel_line_t;
 
 /*
-- 
1.7.10.4
