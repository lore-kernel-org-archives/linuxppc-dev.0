Return-Path: <olof@lixom.net>
Date: Wed, 12 Apr 2006 15:28:13 -0500
To: paulus@ozlabs.org
Subject: [9/10]: Quiet rtasd output at boot
Message-ID: <20060412202813.GP19464@pb15.lixom.net>
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

Most users won't really know the difference between a started RTAS
daemon and a missing event-scan. Move it to debug levels.


Signed-off-by: Olof Johansson <olof@lixom.net>


Index: 2.6/arch/powerpc/platforms/pseries/rtasd.c
===================================================================
--- 2.6.orig/arch/powerpc/platforms/pseries/rtasd.c
+++ 2.6/arch/powerpc/platforms/pseries/rtasd.c
@@ -348,7 +348,7 @@ static int enable_surveillance(int timeo
 		return 0;
 
 	if (error == -EINVAL) {
-		printk(KERN_INFO "rtasd: surveillance not supported\n");
+		printk(KERN_DEBUG "rtasd: surveillance not supported\n");
 		return 0;
 	}
 
@@ -440,7 +440,7 @@ static int rtasd(void *unused)
 		goto error;
 	}
 
-	printk(KERN_INFO "RTAS daemon started\n");
+	printk(KERN_DEBUG "RTAS daemon started\n");
 
 	DEBUG("will sleep for %d milliseconds\n", (30000/rtas_event_scan_rate));
 
@@ -487,7 +487,7 @@ static int __init rtas_init(void)
 
 	/* No RTAS */
 	if (rtas_token("event-scan") == RTAS_UNKNOWN_SERVICE) {
-		printk(KERN_INFO "rtasd: no event-scan on system\n");
+		printk(KERN_DEBUG "rtasd: no event-scan on system\n");
 		return 1;
 	}
 
