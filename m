Return-Path: <David.Daney@caviumnetworks.com>
Received: from mail3.caviumnetworks.com (mail3.caviumnetworks.com
	[12.108.191.235]) by ozlabs.org (Postfix) with ESMTP id AF692B6F07
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Dec 2009 04:40:42 +1100 (EST)
From: David Daney <ddaney@caviumnetworks.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 3/5] powerpc: Convert BUG() to use unreachable()
Date: Thu, 10 Dec 2009 09:28:19 -0800
Message-Id: <1260466101-17545-3-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <4B212EEC.3060808@caviumnetworks.com>
References: <4B212EEC.3060808@caviumnetworks.com>
Cc: David Daney <ddaney@caviumnetworks.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, akpm@linux-foundation.org,
	torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the new unreachable() macro instead of for(;;);

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: linuxppc-dev@ozlabs.org
---
 arch/powerpc/include/asm/bug.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index 64e1fdc..2c15212 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -68,7 +68,7 @@
 		_EMIT_BUG_ENTRY					\
 		: : "i" (__FILE__), "i" (__LINE__),		\
 		    "i" (0), "i"  (sizeof(struct bug_entry)));	\
-	for(;;) ;						\
+	unreachable();						\
 } while (0)
 
 #define BUG_ON(x) do {						\
-- 
1.6.2.5
