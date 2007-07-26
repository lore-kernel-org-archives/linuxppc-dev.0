Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA9A9DDEDB
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 02:35:54 +1000 (EST)
To: torvalds@linux-foundation.org
Subject: [PATCH] make powerpc BUG_ON() OK with pointers and bitwise
Message-Id: <E1IE6JZ-0005QA-R8@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 26 Jul 2007 17:35:49 +0100
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Since powerpc insists on printing the _value_ of condition
and on casting it to long...  At least let's make it a force-cast.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/asm-powerpc/bug.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-powerpc/bug.h b/include/asm-powerpc/bug.h
index f6fa394..a248b8b 100644
--- a/include/asm-powerpc/bug.h
+++ b/include/asm-powerpc/bug.h
@@ -79,7 +79,7 @@
 		_EMIT_BUG_ENTRY					\
 		: : "i" (__FILE__), "i" (__LINE__), "i" (0),	\
 		  "i" (sizeof(struct bug_entry)),		\
-		  "r" ((long)(x)));				\
+		  "r" ((__force long)(x)));			\
 	}							\
 } while (0)
 
-- 
1.5.3.GIT
