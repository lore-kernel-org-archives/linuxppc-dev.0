Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tScqj2nS2zDvp3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 19:57:05 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id i88so7947431pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 00:57:05 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/8xx: xmon compile fix
Date: Tue, 29 Nov 2016 19:56:54 +1100
Message-Id: <20161129085654.1967-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/xmon/xmon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 7605455..435f5f5 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1213,10 +1213,13 @@ bpt_cmds(void)
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
2.10.2
