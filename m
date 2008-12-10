Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 71637DDF31
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 04:00:48 +1100 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][v2] fork_init: fix division by zero
Date: Wed, 10 Dec 2008 19:50:51 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200812101950.51958.yur@emcraft.com>
Cc: Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>,
	Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The following patch fixes divide-by-zero error for the
cases of really big PAGE_SIZEs (e.g. 256KB on ppc44x).
Support for big page sizes on 44x is not present in the
current kernel yet, but coming soon.

Also this patch fixes the comment for the max_threads
settings, as this didn't match the things actually done
in the code.

Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 kernel/fork.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 8d6a7dd..638eb7f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -181,10 +181,14 @@ void __init fork_init(unsigned long mempages)
 
 	/*
 	 * The default maximum number of threads is set to a safe
-	 * value: the thread structures can take up at most half
-	 * of memory.
+	 * value: the thread structures can take up at most
+	 * (1/8) part of memory.
 	 */
+#if (8 * THREAD_SIZE) > PAGE_SIZE
 	max_threads = mempages / (8 * THREAD_SIZE / PAGE_SIZE);
+#else
+	max_threads = mempages * (PAGE_SIZE / (8 * THREAD_SIZE));
+#endif
 
 	/*
 	 * we need to allow at least 20 threads to boot a system
-- 
1.5.6.1
