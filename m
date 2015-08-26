Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EED591A077B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 18:55:48 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 26 Aug 2015 18:55:37 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 982452BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 18:55:34 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7Q8tQUY44957740
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 18:55:34 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7Q8t2NX027209
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 18:55:02 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 ryabinin.a.a@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 04/10] kasan: Don't use kasan shadow pointer in generic
 functions
In-Reply-To: <1440577578-15813-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1440577578-15813-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 26 Aug 2015 14:24:42 +0530
Message-ID: <87mvxectv1.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Missed to cherry-pick the updated version of this patch, before sending
the series out.

commit aeb324e09d95c189eda4ce03790da94b535d1dfc
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Fri Aug 14 12:28:58 2015 +0530

    kasan: Don't use kasan shadow pointer in generic functions
    
    We can't use generic functions like print_hex_dump to access kasan
    shadow region. This require us to setup another kasan shadow region
    for the address passed (kasan shadow address). Most architecture won't
    be able to do that. Hence make a copy of the shadow region row and
    pass that to generic functions.
    
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index d19d01823a68..60fdb0413f3b 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -166,14 +166,20 @@ static void print_shadow_for_address(const void *addr)
 	for (i = -SHADOW_ROWS_AROUND_ADDR; i <= SHADOW_ROWS_AROUND_ADDR; i++) {
 		const void *kaddr = kasan_shadow_to_mem(shadow_row);
 		char buffer[4 + (BITS_PER_LONG/8)*2];
+		char shadow_buf[SHADOW_BYTES_PER_ROW];
 
 		snprintf(buffer, sizeof(buffer),
 			(i == 0) ? ">%p: " : " %p: ", kaddr);
-
+		/*
+		 * We should not pass a shadow pointer to generic
+		 * function, because generic functions may try to
+		 * kasan mapping for the passed address.
+		 */
+		memcpy(shadow_buf, shadow_row, SHADOW_BYTES_PER_ROW);
 		kasan_disable_current();
 		print_hex_dump(KERN_ERR, buffer,
 			DUMP_PREFIX_NONE, SHADOW_BYTES_PER_ROW, 1,
-			shadow_row, SHADOW_BYTES_PER_ROW, 0);
+			shadow_buf, SHADOW_BYTES_PER_ROW, 0);
 		kasan_enable_current();
 
 		if (row_is_guilty(shadow_row, shadow))
