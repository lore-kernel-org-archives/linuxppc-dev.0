Return-Path: <clg@fr.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B4B9C2C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 02:10:46 +1100 (EST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 20 Mar 2014 15:10:43 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id DBECC1B0806E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 15:10:30 +0000 (GMT)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
 [9.149.37.212])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2KFARg441353446
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 15:10:28 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2KFAdDS018662
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 09:10:39 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 14/18] powerpc/boot: modify how we enter kernel on 64bit
Date: Thu, 20 Mar 2014 16:10:09 +0100
Message-Id: <1395328213-19206-15-git-send-email-clg@fr.ibm.com>
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

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/boot/main.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index a28f02165e97..46a7464e13c2 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -205,7 +205,11 @@ void start(void)
 	if (console_ops.close)
 		console_ops.close();
 
+#ifdef __powerpc64__
+	kentry = (kernel_entry_t) &vmlinux.addr;
+#else
 	kentry = (kernel_entry_t) vmlinux.addr;
+#endif
 	if (ft_addr)
 		kentry(ft_addr, 0, NULL);
 	else
-- 
1.7.10.4
