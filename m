Return-Path: <anton@ozlabs.org>
Date: Tue, 20 Mar 2007 21:04:43 -0500
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 10/10] Make sure we only enable xmon once
Message-ID: <20070321020443.GA24496@kryten>
References: <20070321013810.404636000@samba.org>
	<20070321013825.735752000@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070321013825.735752000@samba.org>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[Resent with __initdata fix from Olof]

Now we use notifier hooks we have to be careful not to enable xmon multiple
times.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/xmon/xmon.c
===================================================================
--- linux-2.6.orig/arch/powerpc/xmon/xmon.c	2007-03-11 14:52:45.000000000 -0500
+++ linux-2.6/arch/powerpc/xmon/xmon.c	2007-03-11 14:56:37.000000000 -0500
@@ -2658,11 +2658,20 @@
 	unregister_page_fault_notifier(&xmon_page_fault_nb);
 }
 
+#ifdef CONFIG_XMON_DEFAULT
+int xmon_on = 1;
+#else
+int xmon_on = 0;
+#endif
+
 #ifdef CONFIG_MAGIC_SYSRQ
 static void sysrq_handle_xmon(int key, struct tty_struct *tty) 
 {
 	/* ensure xmon is enabled */
-	xmon_enable();
+	if (!xmon_on) {
+		xmon_on = 1;
+		xmon_enable();
+	}
 	xmon(get_irq_regs());
 }
 
@@ -2683,18 +2692,18 @@
 __initcall(setup_xmon_sysrq);
 #endif /* CONFIG_MAGIC_SYSRQ */
 
-int __initdata xmon_early, xmon_off;
+int __initdata xmon_early;
 
 static int __init early_parse_xmon(char *p)
 {
 	if (!p || strncmp(p, "early", 5) == 0) {
 		/* just "xmon" is equivalent to "xmon=early" */
-		xmon_enable();
+		xmon_on = 1;
 		xmon_early = 1;
 	} else if (strncmp(p, "on", 2) == 0)
-		xmon_enable();
+		xmon_on = 1;
 	else if (strncmp(p, "off", 3) == 0)
-		xmon_off = 1;
+		xmon_on = 0;
 	else if (strncmp(p, "nobt", 4) == 0)
 		xmon_no_auto_backtrace = 1;
 	else
@@ -2706,10 +2715,9 @@
 
 void __init xmon_setup(void)
 {
-#ifdef CONFIG_XMON_DEFAULT
-	if (!xmon_off)
+	if (xmon_on)
 		xmon_enable();
-#endif
+
 	if (xmon_early)
 		xmon(NULL);
 }

--

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
