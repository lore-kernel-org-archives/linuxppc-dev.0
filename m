Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp10.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3AE4F2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Dec 2013 20:10:37 +1100 (EST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Mon, 2 Dec 2013 09:10:30 -0000
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: Linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: fix xmon disassembler for little-endian
Date: Mon,  2 Dec 2013 10:10:12 +0100
Message-Id: <1385975412-25869-1-git-send-email-felix@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes the disassembler of the powerpc kernel debugger xmon,
for little-endian.

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index af9d346..6c27804 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -171,7 +171,11 @@ extern void xmon_leave(void);
 #define REG		"%.8lx"
 #endif
 
+#ifdef __LITTLE_ENDIAN__
+#define GETWORD(v)	(((v)[3] << 24) + ((v)[2] << 16) + ((v)[1] << 8) + (v)[0])
+#else
 #define GETWORD(v)	(((v)[0] << 24) + ((v)[1] << 16) + ((v)[2] << 8) + (v)[3])
+#endif
 
 #define isxdigit(c)	(('0' <= (c) && (c) <= '9') \
 			 || ('a' <= (c) && (c) <= 'f') \
-- 
1.7.10.4
