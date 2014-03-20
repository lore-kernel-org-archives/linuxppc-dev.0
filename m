Return-Path: <clg@fr.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5F9372C0201
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 02:11:15 +1100 (EST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 20 Mar 2014 15:10:42 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 194661B08066
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 15:10:30 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2KFARAS45940744
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 15:10:27 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2KFAcMa004029
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 09:10:38 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 01/18] powerpc/boot: fix do_div for 64bit wrapper
Date: Thu, 20 Mar 2014 16:09:56 +0100
Message-Id: <1395328213-19206-2-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1395328213-19206-1-git-send-email-clg@fr.ibm.com>
References: <1395328213-19206-1-git-send-email-clg@fr.ibm.com>
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
