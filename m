Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CFCA12C037C
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 13:07:13 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 15 Oct 2013 20:07:11 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 749471FF0020
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Oct 2013 20:06:59 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9G279NF348448
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Oct 2013 20:07:09 -0600
Received: from d03av04.boulder.ibm.com (localhost [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9G279ok022673
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Oct 2013 20:07:09 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: [PATCH 04/10][v6] tools/perf: Remove local byteorder.h.
Date: Tue, 15 Oct 2013 19:06:36 -0700
Message-Id: <1381889202-16826-5-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1381889202-16826-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1381889202-16826-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the local tools/perf/util/include/asm/byteorder.h and add
a few missing typedefs to tools/perf/util/include/linux/types.h.

The local byteorder.h complicates defining big/little endian versions
of data structures in include/uapi/linux/perf_event.h.

Fix proposed by Michael Ellerman.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/Makefile                     |    1 -
 tools/perf/util/include/asm/byteorder.h |    2 --
 tools/perf/util/include/linux/types.h   |   20 ++++++++++++++++++++
 3 files changed, 20 insertions(+), 3 deletions(-)
 delete mode 100644 tools/perf/util/include/asm/byteorder.h

diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index b62e12d..3c4a7d9 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -225,7 +225,6 @@ LIB_H += util/include/linux/types.h
 LIB_H += util/include/linux/linkage.h
 LIB_H += util/include/asm/asm-offsets.h
 LIB_H += util/include/asm/bug.h
-LIB_H += util/include/asm/byteorder.h
 LIB_H += util/include/asm/hweight.h
 LIB_H += util/include/asm/swab.h
 LIB_H += util/include/asm/system.h
diff --git a/tools/perf/util/include/asm/byteorder.h b/tools/perf/util/include/asm/byteorder.h
deleted file mode 100644
index 2a9bdc0..0000000
--- a/tools/perf/util/include/asm/byteorder.h
+++ /dev/null
@@ -1,2 +0,0 @@
-#include <asm/types.h>
-#include "../../../../include/uapi/linux/swab.h"
diff --git a/tools/perf/util/include/linux/types.h b/tools/perf/util/include/linux/types.h
index eb46478..775f68e 100644
--- a/tools/perf/util/include/linux/types.h
+++ b/tools/perf/util/include/linux/types.h
@@ -7,10 +7,30 @@
 #define __bitwise
 #endif
 
+#ifndef __le16
+typedef __u16 __bitwise __le16;
+#endif
+
 #ifndef __le32
 typedef __u32 __bitwise __le32;
 #endif
 
+#ifndef __be16
+typedef __u16 __bitwise __be16;
+#endif
+
+#ifndef __le64
+typedef __u64 __bitwise __le64;
+#endif
+
+#ifndef __be32
+typedef __u32 __bitwise __be32;
+#endif
+
+#ifndef __be64
+typedef __u64 __bitwise __be64;
+#endif
+
 #define DECLARE_BITMAP(name,bits) \
 	unsigned long name[BITS_TO_LONGS(bits)]
 
-- 
1.7.9.5
