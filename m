Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 55D69DDF68
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 10:52:23 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Message-Id: <46cdc66d103b6a35a4958961a0970e1554d6d590.1211935894.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH] [PPC] Export emty_zero_page and copy_page on ppc
Date: Wed, 28 May 2008 10:52:19 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently ext4 and fuse fail to link if modular:
ERROR: "copy_page" [fs/fuse/fuse.ko] undefined!
ERROR: "empty_zero_page" [fs/ext4/ext4dev.ko] undefined!
make[3]: *** [__modpost] Error 1
make[2]: *** [modules] Error 2
make[1]: *** [sub-make] Error 2

While arch ppc exists it may as well compile.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
Should be safe for 2.6.26.

 arch/ppc/kernel/ppc_ksyms.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
index 602c268..5d529bc 100644
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -60,8 +60,10 @@ long long __ashrdi3(long long, int);
 long long __ashldi3(long long, int);
 long long __lshrdi3(long long, int);
 
+EXPORT_SYMBOL(empty_zero_page);
 EXPORT_SYMBOL(clear_pages);
 EXPORT_SYMBOL(clear_user_page);
+EXPORT_SYMBOL(copy_page);
 EXPORT_SYMBOL(transfer_to_handler);
 EXPORT_SYMBOL(do_IRQ);
 EXPORT_SYMBOL(machine_check_exception);
-- 
1.5.5.1
