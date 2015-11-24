Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C219B1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 10:37:54 +1100 (AEDT)
Received: by padhx2 with SMTP id hx2so36857387pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 15:37:53 -0800 (PST)
Received: from circle.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id 81sm16554254pfk.56.2015.11.24.15.37.50
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 24 Nov 2015 15:37:51 -0800 (PST)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Append linux_banner to exception information in xmon.
Date: Wed, 25 Nov 2015 10:37:41 +1100
Message-Id: <1448408261-30772-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently if you are in xmon without an oops etc. to view the kernel version you have to type "d $linux_banner" - not necessarily obvious. As this is useful information, append to the output of "e" command.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 arch/powerpc/xmon/xmon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index df05bd2fca07..6d3d9d031aea 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1528,6 +1528,8 @@ static void excprint(struct pt_regs *fp)
 
 	if (trap == 0x700)
 		print_bug_trap(fp);
+
+	printf(linux_banner);
 }
 
 static void prregs(struct pt_regs *fp)
-- 
2.5.0
