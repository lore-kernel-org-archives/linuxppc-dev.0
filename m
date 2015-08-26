Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 133851A0CBA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 18:26:53 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 26 Aug 2015 13:56:50 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 55CF8E0059
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 13:56:13 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7Q8QfEI37552236
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 13:56:43 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7Q8Qd6g025185
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 13:56:41 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ryabinin.a.a@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 04/10] kasan: Don't use kasan shadow pointer in generic
 functions
Date: Wed, 26 Aug 2015 13:56:12 +0530
Message-Id: <1440577578-15813-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can't use generic functions like print_hex_dump to access kasan
shadow region. This require us to setup another kasan shadow region
for the address passed (kasan shadow address). Most architecture won't
be able to do that. Hence remove dumping kasan shadow region dump. If
we really want to do this we will have to have a kasan internal implemen
tation of print_hex_dump for which we will disable address sanitizer
operation.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 mm/kasan/report.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index d19d01823a68..79fbc5d14bd2 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -170,12 +170,6 @@ static void print_shadow_for_address(const void *addr)
 		snprintf(buffer, sizeof(buffer),
 			(i == 0) ? ">%p: " : " %p: ", kaddr);
 
-		kasan_disable_current();
-		print_hex_dump(KERN_ERR, buffer,
-			DUMP_PREFIX_NONE, SHADOW_BYTES_PER_ROW, 1,
-			shadow_row, SHADOW_BYTES_PER_ROW, 0);
-		kasan_enable_current();
-
 		if (row_is_guilty(shadow_row, shadow))
 			pr_err("%*c\n",
 				shadow_pointer_offset(shadow_row, shadow),
-- 
2.5.0
