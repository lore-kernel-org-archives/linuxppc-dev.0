Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 41FD42C00FC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2013 15:34:12 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 18 Apr 2013 01:34:03 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 4B7C338C801A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2013 01:34:00 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3I5Y0Nk291180
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2013 01:34:00 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3I5XxgQ016348
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2013 01:34:00 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mm: Use tlbiel for 4KB pages
Date: Thu, 18 Apr 2013 13:33:55 +0800
Message-Id: <1366263235-7787-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The firmware should have supplied correct information for the kernel
to figure out the page size array, which is traced by mmu_psize_defs[].
Otherwise, the kernel will fail back to use solely 4KB page size
and copy mmu_psize_defaults_old[] over to mmu_psize_defs[]. However,
the "tlbiel" isn't enabled in mmu_psize_defaults_old[].

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 2d4a20c..8675ae5 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -130,7 +130,7 @@ static struct mmu_psize_def mmu_psize_defaults_old[] = {
 		.sllp	= 0,
 		.penc	= 0,
 		.avpnm	= 0,
-		.tlbiel = 0,
+		.tlbiel = 1,
 	},
 };
 
-- 
1.7.5.4
