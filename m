Return-Path: <apw@shadowen.org>
Received: from hellhawk.shadowen.org (hellhawk.shadowen.org [80.68.90.175])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C9156DDE3E
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 23:20:03 +1000 (EST)
From: Andy Whitcroft <apw@shadowen.org>
Sender: Andy Whitcroft <apw@shadowen.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] powerpc: hash_preload fails to preload under
	CONFIG_PPC_MM_SLICES
References: <exportbomb.1187270320@pinky>
Message-ID: <8b4c69b92d61b5a840468f07e0ec1320@pinky>
Date: Thu, 16 Aug 2007 14:18:51 +0100
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Randy Dunlap <rdunlap@xenotime.net>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Seems that a trailing ';' has slipped onto the end of the
get_slice_psize checks under CONFIG_PPC_MM_SLICES causing us to
return unconditionally and never preload.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
---
 arch/powerpc/mm/hash_utils_64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index f178957..a47151e 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -795,7 +795,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 
 #ifdef CONFIG_PPC_MM_SLICES
 	/* We only prefault standard pages for now */
-	if (unlikely(get_slice_psize(mm, ea) != mm->context.user_psize));
+	if (unlikely(get_slice_psize(mm, ea) != mm->context.user_psize))
 		return;
 #endif
 
