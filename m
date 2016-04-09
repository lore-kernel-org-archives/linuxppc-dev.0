Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmJ154rhzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:14:25 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 02:14:23 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 0E7E06E803C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 02:01:10 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396EKZ335193052
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 06:14:20 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396EJee010460
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 02:14:20 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: [PATCH V2 01/68] powerpc/cxl: Use REGION_ID instead of opencoding
Date: Sat,  9 Apr 2016 11:42:57 +0530
Message-Id: <1460182444-2468-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Also note that the `~` operation is wrong.

Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 drivers/misc/cxl/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 9a8650bcb042..9a236543da23 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -152,7 +152,7 @@ static void cxl_handle_page_fault(struct cxl_context *ctx,
 	access = _PAGE_PRESENT;
 	if (dsisr & CXL_PSL_DSISR_An_S)
 		access |= _PAGE_RW;
-	if ((!ctx->kernel) || ~(dar & (1ULL << 63)))
+	if ((!ctx->kernel) || (REGION_ID(dar) == USER_REGION_ID))
 		access |= _PAGE_USER;
 
 	if (dsisr & DSISR_NOHPTE)
-- 
2.5.0
