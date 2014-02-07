Return-Path: <clg@fr.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D6B9E2C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Feb 2014 02:59:56 +1100 (EST)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Fri, 7 Feb 2014 15:59:53 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id CC0F617D805C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 16:00:14 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s17FxcS966125902
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 15:59:38 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s17Fxn0G014735
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 08:59:49 -0700
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [RFC PATCH 14/18] powerpc/boot: modify how we enter kernel on 64bit
Date: Fri,  7 Feb 2014 16:59:27 +0100
Message-Id: <1391788771-16405-15-git-send-email-clg@fr.ibm.com>
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
