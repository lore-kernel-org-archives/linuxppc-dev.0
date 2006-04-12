Return-Path: <olof@lixom.net>
Date: Wed, 12 Apr 2006 15:23:22 -0500
To: paulus@ozlabs.org
Subject: [5/10]: Don't print chosen idle loop at every boot
Message-ID: <20060412202322.GL19464@pb15.lixom.net>
References: <20060412201823.GG19464@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060412201823.GG19464@pb15.lixom.net>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

No need to write out what idle loop is used on every boot.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: 2.6/arch/powerpc/platforms/maple/setup.c
===================================================================
--- 2.6.orig/arch/powerpc/platforms/maple/setup.c
+++ 2.6/arch/powerpc/platforms/maple/setup.c
@@ -189,7 +189,7 @@ void __init maple_setup_arch(void)
 	conswitchp = &dummy_con;
 #endif
 
-	printk(KERN_INFO "Using native/NAP idle loop\n");
+	printk(KERN_DEBUG "Using native/NAP idle loop\n");
 }
 
 /* 
Index: 2.6/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- 2.6.orig/arch/powerpc/platforms/iseries/setup.c
+++ 2.6/arch/powerpc/platforms/iseries/setup.c
@@ -535,10 +535,10 @@ static void __init iSeries_setup_arch(vo
 {
 	if (get_lppaca()->shared_proc) {
 		ppc_md.idle_loop = iseries_shared_idle;
-		printk(KERN_INFO "Using shared processor idle loop\n");
+		printk(KERN_DEBUG "Using shared processor idle loop\n");
 	} else {
 		ppc_md.idle_loop = iseries_dedicated_idle;
-		printk(KERN_INFO "Using dedicated idle loop\n");
+		printk(KERN_DEBUG "Using dedicated idle loop\n");
 	}
 
 	/* Setup the Lp Event Queue */
Index: 2.6/arch/powerpc/platforms/powermac/feature.c
===================================================================
--- 2.6.orig/arch/powerpc/platforms/powermac/feature.c
+++ 2.6/arch/powerpc/platforms/powermac/feature.c
@@ -2510,7 +2510,7 @@ found:
 		if (get_property(np, "flush-on-lock", NULL))
 			break;
 		powersave_nap = 1;
-		printk(KERN_INFO "Processor NAP mode on idle enabled.\n");
+		printk(KERN_DEBUG "Processor NAP mode on idle enabled.\n");
 		break;
 	}
 
Index: 2.6/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- 2.6.orig/arch/powerpc/platforms/pseries/setup.c
+++ 2.6/arch/powerpc/platforms/pseries/setup.c
@@ -235,14 +235,14 @@ static void __init pSeries_setup_arch(vo
 	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
 		vpa_init(boot_cpuid);
 		if (get_lppaca()->shared_proc) {
-			printk(KERN_INFO "Using shared processor idle loop\n");
+			printk(KERN_DEBUG "Using shared processor idle loop\n");
 			ppc_md.power_save = pseries_shared_idle_sleep;
 		} else {
-			printk(KERN_INFO "Using dedicated idle loop\n");
+			printk(KERN_DEBUG "Using dedicated idle loop\n");
 			ppc_md.power_save = pseries_dedicated_idle_sleep;
 		}
 	} else {
-		printk(KERN_INFO "Using default idle loop\n");
+		printk(KERN_DEBUG "Using default idle loop\n");
 	}
 
 	if (firmware_has_feature(FW_FEATURE_LPAR))
