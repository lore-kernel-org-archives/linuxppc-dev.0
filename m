Date: Tue, 20 May 2003 03:16:19 -0500 (CDT)
From: "Milton D. Miller II" <miltonm@realtime.net>
Message-Id: <200305200816.h4K8GJNq040669@sullivan.realtime.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Pointless ppc_md hook
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I can not think of a reason a hook that is called immediately after
platform_init (which sets the other hooks) would be needed.

Therefore, please exclude cset
trini@kernel.crashing.org|arch/ppc/kernel/setup.c|20030422001245|47202

to both linuxppc and devel.  Here's a patch to fixup pcore, the only
user in _devel:


===== arch/ppc/platforms/pcore_setup.c 1.23 vs edited =====
--- 1.23/arch/ppc/platforms/pcore_setup.c	Fri Apr 25 13:24:05 2003
+++ edited/arch/ppc/platforms/pcore_setup.c	Tue May 20 02:53:31 2003
@@ -303,10 +303,10 @@
 	ppc_md.nvram_write_val	= todc_m48txx_write_val;

 #ifdef CONFIG_SERIAL
+	ppc_md.early_serial_map = pcore_early_serial_map;
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
-	ppc_md.progress_init = gen550_progress_init;
+	gen550_progress_init();
 	ppc_md.progress = gen550_progress;
 #endif
-	ppc_md.early_serial_map = pcore_early_serial_map;
 #endif
 }



milton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
