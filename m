Return-Path: <clg@fr.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 944F42C00D5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Feb 2014 02:59:53 +1100 (EST)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Fri, 7 Feb 2014 15:59:49 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6C60C1B0806E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 15:59:19 +0000 (GMT)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s17FxYAj2556308
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 15:59:34 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s17FxkhZ005951
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 08:59:46 -0700
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [RFC PATCH 09/18] powerpc/boot: define byteswapping routines for
 little endian
Date: Fri,  7 Feb 2014 16:59:22 +0100
Message-Id: <1391788771-16405-10-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1391788771-16405-1-git-send-email-clg@fr.ibm.com>
References: <1391788771-16405-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are not the most efficient versions of swab but the wrapper does
not do much byte swapping. On a big endian cpu, these routines are
a no-op.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/boot/of.h   |    7 +++++++
 arch/powerpc/boot/swab.h |   29 +++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 arch/powerpc/boot/swab.h

diff --git a/arch/powerpc/boot/of.h b/arch/powerpc/boot/of.h
index bf228fea3517..fc71848f6962 100644
--- a/arch/powerpc/boot/of.h
+++ b/arch/powerpc/boot/of.h
@@ -1,6 +1,8 @@
 #ifndef _PPC_BOOT_OF_H_
 #define _PPC_BOOT_OF_H_
 
+#include "swab.h"
+
 typedef void *phandle;
 typedef u32 ihandle;
 
@@ -21,7 +23,12 @@ void of_console_init(void);
 
 typedef u32			__be32;
 
+#ifdef __LITTLE_ENDIAN__
+#define cpu_to_be32(x) swab32(x)
+#define be32_to_cpu(x) swab32(x)
+#else
 #define cpu_to_be32(x) (x)
 #define be32_to_cpu(x) (x)
+#endif
 
 #endif /* _PPC_BOOT_OF_H_ */
diff --git a/arch/powerpc/boot/swab.h b/arch/powerpc/boot/swab.h
new file mode 100644
index 000000000000..d0e1431084ca
--- /dev/null
+++ b/arch/powerpc/boot/swab.h
@@ -0,0 +1,29 @@
+#ifndef _PPC_BOOT_SWAB_H_
+#define _PPC_BOOT_SWAB_H_
+
+static inline u16 swab16(u16 x)
+{
+	return  ((x & (u16)0x00ffU) << 8) |
+		((x & (u16)0xff00U) >> 8);
+}
+
+static inline u32 swab32(u32 x)
+{
+	return  ((x & (u32)0x000000ffUL) << 24) |
+		((x & (u32)0x0000ff00UL) <<  8) |
+		((x & (u32)0x00ff0000UL) >>  8) |
+		((x & (u32)0xff000000UL) >> 24);
+}
+
+static inline u64 swab64(u64 x)
+{
+	return  (u64)((x & (u64)0x00000000000000ffULL) << 56) |
+		(u64)((x & (u64)0x000000000000ff00ULL) << 40) |
+		(u64)((x & (u64)0x0000000000ff0000ULL) << 24) |
+		(u64)((x & (u64)0x00000000ff000000ULL) <<  8) |
+		(u64)((x & (u64)0x000000ff00000000ULL) >>  8) |
+		(u64)((x & (u64)0x0000ff0000000000ULL) >> 24) |
+		(u64)((x & (u64)0x00ff000000000000ULL) >> 40) |
+		(u64)((x & (u64)0xff00000000000000ULL) >> 56);
+}
+#endif /* _PPC_BOOT_SWAB_H_ */
-- 
1.7.10.4
