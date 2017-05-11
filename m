Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNxWX41xZzDqZb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 01:15:52 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id u187so3918992pgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 08:15:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Scott Wood <oss@buserror.net>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 3/3] powerpc/8xx: xmon compile fix
Date: Fri, 12 May 2017 01:15:22 +1000
Message-Id: <20170511151522.4772-3-npiggin@gmail.com>
In-Reply-To: <20170511151522.4772-1-npiggin@gmail.com>
References: <20170511151522.4772-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cc: Scott Wood <oss@buserror.net>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/xmon/xmon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index f11f65634aab..ec420b0e6e88 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1242,10 +1242,13 @@ bpt_cmds(void)
 {
 	int cmd;
 	unsigned long a;
-	int mode, i;
+	int i;
 	struct bpt *bp;
+#ifndef CONFIG_8xx
+	int mode;
 	const char badaddr[] = "Only kernel addresses are permitted "
 		"for breakpoints\n";
+#endif
 
 	cmd = inchar();
 	switch (cmd) {
-- 
2.11.0
