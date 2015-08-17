Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 66F5D1A1DAF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:38:04 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 17 Aug 2015 16:38:03 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6587E2CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:38:01 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7H6br1C49217686
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:38:01 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7H6bSmg028841
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 16:37:28 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ryabinin.a.a@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 4/8] kasan: Don't use kasan shadow pointer in generic
 functions
Date: Mon, 17 Aug 2015 12:06:36 +0530
Message-Id: <1439793400-18147-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
