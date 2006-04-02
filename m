Return-Path: <anton@ozlabs.org>
Date: Sun, 2 Apr 2006 20:18:32 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Avoid __initcall warnings
Message-ID: <20060402101831.GK23416@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Fix __initcall return in proc_rtas_init and rtas_init.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/kernel/rtas-proc.c
===================================================================
--- build.orig/arch/powerpc/kernel/rtas-proc.c	2006-03-30 10:08:47.000000000 +1100
+++ build/arch/powerpc/kernel/rtas-proc.c	2006-04-02 19:57:41.000000000 +1000
@@ -258,11 +258,11 @@ static int __init proc_rtas_init(void)
 	struct proc_dir_entry *entry;
 
 	if (!machine_is(pseries))
-		return 1;
+		return -ENODEV;
 
 	rtas_node = of_find_node_by_name(NULL, "rtas");
 	if (rtas_node == NULL)
-		return 1;
+		return -ENODEV;
 
 	entry = create_proc_entry("ppc64/rtas/progress", S_IRUGO|S_IWUSR, NULL);
 	if (entry)
Index: build/arch/powerpc/platforms/pseries/rtasd.c
===================================================================
--- build.orig/arch/powerpc/platforms/pseries/rtasd.c	2006-03-30 10:08:47.000000000 +1100
+++ build/arch/powerpc/platforms/pseries/rtasd.c	2006-04-02 20:14:50.000000000 +1000
@@ -488,7 +488,7 @@ static int __init rtas_init(void)
 	/* No RTAS */
 	if (rtas_token("event-scan") == RTAS_UNKNOWN_SERVICE) {
 		printk(KERN_INFO "rtasd: no event-scan on system\n");
-		return 1;
+		return -ENODEV;
 	}
 
 	entry = create_proc_entry("ppc64/rtas/error_log", S_IRUSR, NULL);
