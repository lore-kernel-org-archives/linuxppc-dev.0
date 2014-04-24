Return-Path: <clg@fr.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 20365140112
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:23:55 +1000 (EST)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 24 Apr 2014 08:23:50 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 213C72190056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 08:23:40 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7NlfW61341904
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 07:23:47 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O7Nkhj019854
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 01:23:47 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v2 01/15] powerpc/boot: fix do_div for 64bit wrapper
Date: Thu, 24 Apr 2014 09:23:25 +0200
Message-Id: <1398324219-8919-2-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1398324219-8919-1-git-send-email-clg@fr.ibm.com>
References: <1398324219-8919-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1395651884.30488.10.camel@pasglop>
References: <1395651884.30488.10.camel@pasglop>
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
