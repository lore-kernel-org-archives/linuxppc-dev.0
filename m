Return-Path: <tabbott@MIT.EDU>
Received: from biscayne-one-station.mit.edu (BISCAYNE-ONE-STATION.MIT.EDU
	[18.7.7.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9C86B7BAE
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 02:53:55 +1100 (EST)
From: Tim Abbott <tabbott@ksplice.com>
To: linux-kernel@vger.kernel.org
Subject: From: Tim Abbott <tabbott@ksplice.com>
Date: Tue, 13 Oct 2009 11:53:26 -0400
Message-Id: <1255449206-16650-1-git-send-email-tabbott@ksplice.com>
Cc: linuxppc-dev@ozlabs.org, Tim Abbott <tabbott@ksplice.com>,
	Paul Mackerras <paulus@samba.org>, Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is already an architecture-independent __page_aligned_data macro
for this purpose, so removing the powerpc-specific macro should be
harmless.

Signed-off-by: Tim Abbott <tabbott@ksplice.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 arch/powerpc/include/asm/page_64.h |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index 3f17b83..3c7118f 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -162,14 +162,6 @@ do {						\
 
 #endif /* !CONFIG_HUGETLB_PAGE */
 
-#ifdef MODULE
-#define __page_aligned __attribute__((__aligned__(PAGE_SIZE)))
-#else
-#define __page_aligned \
-	__attribute__((__aligned__(PAGE_SIZE), \
-		__section__(".data.page_aligned")))
-#endif
-
 #define VM_DATA_DEFAULT_FLAGS \
 	(test_thread_flag(TIF_32BIT) ? \
 	 VM_DATA_DEFAULT_FLAGS32 : VM_DATA_DEFAULT_FLAGS64)
-- 
1.6.4.3
