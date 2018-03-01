Return-Path: <robherring2@gmail.com>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
 [74.125.82.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsbrf4QxWzF1p2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 02:26:58 +1100 (AEDT)
Received: by mail-ot0-f193.google.com with SMTP id f11so5873041otj.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Mar 2018 07:26:57 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: boot: add strrchr function
Date: Thu,  1 Mar 2018 09:26:54 -0600
Message-Id: <20180301152654.29275-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

libfdt gained a new dependency on strrchr, so copy the implementation
from lib/string.c. Most of the string functions are in assembly, but
stdio.c already has strnlen, so add strrchr there.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack. This is a dependency for dtc/libfdt sync with upstream.

 arch/powerpc/boot/stdio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/boot/stdio.c b/arch/powerpc/boot/stdio.c
index a701261b1781..98042eff7b26 100644
--- a/arch/powerpc/boot/stdio.c
+++ b/arch/powerpc/boot/stdio.c
@@ -21,6 +21,16 @@ size_t strnlen(const char * s, size_t count)
 	return sc - s;
 }
 
+char *strrchr(const char *s, int c)
+{
+	const char *last = NULL;
+	do {
+		if (*s == (char)c)
+			last = s;
+	} while (*s++);
+	return (char *)last;
+}
+
 #ifdef __powerpc64__
 
 # define do_div(n, base) ({						\
-- 
2.14.1
