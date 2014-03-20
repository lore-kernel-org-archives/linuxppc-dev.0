Return-Path: <clg@fr.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3303C2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 02:10:44 +1100 (EST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 20 Mar 2014 15:10:40 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id BA2491B08070
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 15:10:29 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2KFARCd4587888
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 15:10:27 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2KFAcIw018632
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 09:10:38 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 08/18] powerpc/boot: fix compile warning in 64bit
Date: Thu, 20 Mar 2014 16:10:03 +0100
Message-Id: <1395328213-19206-9-git-send-email-clg@fr.ibm.com>
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
index 5ab9cb57cd31..e8697df2df27 100644
--- a/arch/powerpc/boot/oflib.c
+++ b/arch/powerpc/boot/oflib.c
@@ -203,7 +203,7 @@ void of_exit(void)
  */
 void *of_finddevice(const char *name)
 {
-	return (phandle) of_call_prom("finddevice", 1, 1, name);
+	return (void *) (unsigned long) of_call_prom("finddevice", 1, 1, name);
 }
 
 int of_getprop(const void *phandle, const char *name, void *buf,
-- 
1.7.10.4
