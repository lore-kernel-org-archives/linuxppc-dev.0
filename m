Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 24D3ADDEF1
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 07:29:15 +1000 (EST)
Date: Thu, 10 Jul 2008 16:29:05 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Jeremy Kerr <jk@ozlabs.org>, <cbe-oss-dev@ozlabs.org>
In-Reply-To: <for-27-patch1-0@bga.com>
Message-Id: <for-27-patch8-4@bga.com>
Subject: [PATCH] spufs: correct kcalloc usage
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

kcalloc is supposed to be called with the count as its first argument and
the element size as the second.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
Both arguments are size_t so does not affect correctness.  This callsite is
during module_init and therefore not performance critical.  Another patch
will optimize the case when the count is variable but the size is fixed.


diff --git a/arch/powerpc/platforms/cell/spufs/sputrace.c b/arch/powerpc/platforms/cell/spufs/sputrace.c
index 8c0e957..92d20e9 100644
--- a/arch/powerpc/platforms/cell/spufs/sputrace.c
+++ b/arch/powerpc/platforms/cell/spufs/sputrace.c
@@ -196,8 +196,7 @@ static int __init sputrace_init(void)
 	struct proc_dir_entry *entry;
 	int i, error = -ENOMEM;
 
-	sputrace_log = kcalloc(sizeof(struct sputrace),
-				bufsize, GFP_KERNEL);
+	sputrace_log = kcalloc(bufsize, sizeof(struct sputrace), GFP_KERNEL);
 	if (!sputrace_log)
 		goto out;
 
