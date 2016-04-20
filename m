Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqZ6z4BJmzDqc2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 18:00:11 +1000 (AEST)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 20 Apr 2016 13:30:08 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3K802sV19333300
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 13:30:04 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3K801Qo001625
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 13:30:02 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: [PATCH V2] powerpc/cxl: Use REGION_ID instead of opencoding
Date: Wed, 20 Apr 2016 03:59:47 -0400
Message-Id: <1461139187-10553-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Also the wrong `~` operation resulted in wrong access check as explained
below.

The current code will set _PAGE_USER to the access flags for any
fault address because ~ operation will be true for all address we take
a fault on. But setting _PAGE_USER also means that the fault will be
handled only if the page table have _PAGE_USER set. Hence there is
no security hole with the current code.

Now if it is an user space access, then the change in this patch really
don't have an impact because we have (!ctx->kernel) set true
and we take the if condition true.

Now kernel context created fault on an address in the kernel range
will result in a fault loop because we will not insert the
hash pte due to access and pte permission mismatch. This patch fix
the above issue.

fixes: f204e0b8cedd ("cxl: Driver code for powernv PCIe based cards for
userspace acces")

Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Changes from v1:
* v1 never reached mailing list

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
