Return-Path: <clg@fr.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 326FE2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Feb 2014 02:59:48 +1100 (EST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Fri, 7 Feb 2014 15:59:45 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 423AB1B08066
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 15:59:15 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s17FxUH353608536
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 15:59:30 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s17FxfbU013451
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 08:59:42 -0700
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [RFC PATCH 01/18] powerpc/boot: fix do_div for 64bit wrapper
Date: Fri,  7 Feb 2014 16:59:14 +0100
Message-Id: <1391788771-16405-2-git-send-email-clg@fr.ibm.com>
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

When the boot wrapper is compiled in 64bit, there is no need to
use __div64_32.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/boot/stdio.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/boot/stdio.c b/arch/powerpc/boot/stdio.c
index 5b57800bbc67..a701261b1781 100644
--- a/arch/powerpc/boot/stdio.c
+++ b/arch/powerpc/boot/stdio.c
@@ -21,6 +21,18 @@ size_t strnlen(const char * s, size_t count)
 	return sc - s;
 }
 
+#ifdef __powerpc64__
+
+# define do_div(n, base) ({						\
+	unsigned int __base = (base);					\
+	unsigned int __rem;						\
+	__rem = ((unsigned long long)(n)) % __base;			\
+	(n) = ((unsigned long long)(n)) / __base;			\
+	__rem;								\
+})
+
+#else
+
 extern unsigned int __div64_32(unsigned long long *dividend,
 			       unsigned int divisor);
 
@@ -39,6 +51,8 @@ extern unsigned int __div64_32(unsigned long long *dividend,
 	__rem;								\
  })
 
+#endif /* __powerpc64__ */
+
 static int skip_atoi(const char **s)
 {
 	int i, c;
-- 
1.7.10.4
