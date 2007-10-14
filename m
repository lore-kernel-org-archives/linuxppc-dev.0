Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5DBB6DDE19
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 04:35:06 +1000 (EST)
To: torvalds@linux-foundation.org
Subject: [PATCH] endian-clean in_le64/out_le64
Message-Id: <E1Ih8Im-00041u-6N@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Sun, 14 Oct 2007 19:35:00 +0100
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/asm-powerpc/io.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index affba70..0d0589e 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -138,12 +138,12 @@ DEF_MMIO_IN_BE(in_be64, 64, ld);
 /* There is no asm instructions for 64 bits reverse loads and stores */
 static inline u64 in_le64(const volatile u64 __iomem *addr)
 {
-	return le64_to_cpu(in_be64(addr));
+	return swab64(in_be64(addr));
 }
 
 static inline void out_le64(volatile u64 __iomem *addr, u64 val)
 {
-	out_be64(addr, cpu_to_le64(val));
+	out_be64(addr, swab64(val));
 }
 #endif /* __powerpc64__ */
 
-- 
1.5.3.GIT
