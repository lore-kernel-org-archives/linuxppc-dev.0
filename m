Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 582B71A0D1F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 00:40:40 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Apr 2015 20:10:37 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 78B9B1258044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 20:12:30 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3LEeWpP393700
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 20:10:32 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3LEeWmP000355
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 20:10:32 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH] powerpc/mm: Fix build error with CONFIG_PPC_TRANSACTIONAL_MEM
 disabled
Date: Tue, 21 Apr 2015 20:10:26 +0530
Message-Id: <1429627226-11596-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fix the below build error

arch/powerpc/mm/hash_utils_64.c: In function ‘flush_hash_hugepage’:
arch/powerpc/mm/hash_utils_64.c:1381:1: error: label at end of compound statement
 tm_abort:
 ^
make[1]: *** [arch/powerpc/mm/hash_utils_64.o] Error 1

Reported-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 2c2022d16059..ac5c4373cd8b 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1394,6 +1394,7 @@ tm_abort:
 		tm_abort(TM_CAUSE_TLBI);
 	}
 #endif
+	return;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-- 
2.1.0
