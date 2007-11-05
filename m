Return-Path: <lizf@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
	by ozlabs.org (Postfix) with ESMTP id 3B796DDDF6
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Nov 2007 14:40:59 +1100 (EST)
Message-ID: <472E7E44.6000807@cn.fujitsu.com>
Date: Mon, 05 Nov 2007 10:21:56 +0800
From: Li Zefan <lizf@cn.fujitsu.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/6]] POWERPC: fix memset size error
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The size passing to memset is wrong.

Signed-off-by Li Zefan <lizf@cn.fujitsu.com>

---
 arch/powerpc/kernel/prom_init.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 1db10f7..1add6ef 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1244,7 +1244,7 @@ static void __init prom_initialize_tce_table(void)
 			local_alloc_bottom = base;
 
 		/* It seems OF doesn't null-terminate the path :-( */
-		memset(path, 0, sizeof(path));
+		memset(path, 0, PROM_SCRATCH_SIZE);
 		/* Call OF to setup the TCE hardware */
 		if (call_prom("package-to-path", 3, 1, node,
 			      path, PROM_SCRATCH_SIZE-1) == PROM_ERROR) {
-- 
1.5.3.rc7
