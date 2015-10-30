Return-Path: <linuxram@us.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 570E01A0BF9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2015 09:31:32 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Fri, 30 Oct 2015 18:31:30 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D0C7738C803B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 18:31:26 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9UMVPrK55181518
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 22:31:25 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9UMVOPw019993
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 18:31:24 -0400
Date: Fri, 30 Oct 2015 15:31:20 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, hbabu@us.ibm.com, nacc@us.ibm.com
Subject: [PATCH] nx-842: Ignore bit 3 of condition register returned by icswx
Message-ID: <20151030223120.GA22550@ram.oc3035372033.ibm.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

icswx occasionally under heavy load sets bit 3 of condition register 0.
It has no software implication.

Currently that bit is interpreted by the driver as a failure, when
it should have calmly ignored it.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/icswx.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/icswx.h b/arch/powerpc/include/asm/icswx.h
index 9f8402b..bce20c7 100644
--- a/arch/powerpc/include/asm/icswx.h
+++ b/arch/powerpc/include/asm/icswx.h
@@ -177,7 +177,7 @@ static inline int icswx(__be32 ccw, struct coprocessor_request_block *crb)
 	: "r" (ccw_reg), "r" (crb)
 	: "cr0", "memory");
 
-	return (int)((cr >> 28) & 0xf);
+	return (int)((cr >> 28) & 0xe);
 }
