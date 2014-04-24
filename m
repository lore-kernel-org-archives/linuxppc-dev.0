Return-Path: <clg@fr.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AA2EE14015C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:23:58 +1000 (EST)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 24 Apr 2014 08:23:55 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id CE51D2190041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 08:23:44 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7NqWI5570866
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 07:23:52 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O7Np7S031783
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 01:23:51 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v2 08/15] powerpc/boot: fix compile warning in 64bit
Date: Thu, 24 Apr 2014 09:23:32 +0200
Message-Id: <1398324219-8919-9-git-send-email-clg@fr.ibm.com>
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

 arch/powerpc/boot/oflib.c:211:9: warning: cast to pointer from integer of \
		  different size [-Wint-to-pointer-cast]
  return (phandle) of_call_prom("finddevice", 1, 1, name);

This is a work around. The definite solution would be to define the
phandle typedef as a u32, as in the kernel, but this would break the
device tree ops API.

Let it be for the moment.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/boot/oflib.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/oflib.c b/arch/powerpc/boot/oflib.c
index 956443fb9f65..cdfe762d2b2b 100644
--- a/arch/powerpc/boot/oflib.c
+++ b/arch/powerpc/boot/oflib.c
@@ -201,7 +201,7 @@ void of_exit(void)
  */
 void *of_finddevice(const char *name)
 {
-	return (phandle) of_call_prom("finddevice", 1, 1, name);
+	return (void *) (unsigned long) of_call_prom("finddevice", 1, 1, name);
 }
 
 int of_getprop(const void *phandle, const char *name, void *buf,
-- 
1.7.10.4
