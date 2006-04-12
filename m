Return-Path: <olof@lixom.net>
Date: Wed, 12 Apr 2006 15:20:27 -0500
To: paulus@ozlabs.org
Subject: [2/10]: Quiet time init output
Message-ID: <20060412202027.GI19464@pb15.lixom.net>
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

Move time_init console output to KERN_DEBUG prink level. No need to
print it at every boot.

Signed-off-by: Olof Johansson <olof@lixom.net>

Index: 2.6/arch/powerpc/kernel/time.c
===================================================================
--- 2.6.orig/arch/powerpc/kernel/time.c
+++ 2.6/arch/powerpc/kernel/time.c
@@ -945,9 +945,9 @@ void __init time_init(void)
 	} else {
 		/* Normal PowerPC with timebase register */
 		ppc_md.calibrate_decr();
-		printk(KERN_INFO "time_init: decrementer frequency = %lu.%.6lu MHz\n",
+		printk(KERN_DEBUG "time_init: decrementer frequency = %lu.%.6lu MHz\n",
 		       ppc_tb_freq / 1000000, ppc_tb_freq % 1000000);
-		printk(KERN_INFO "time_init: processor frequency   = %lu.%.6lu MHz\n",
+		printk(KERN_DEBUG "time_init: processor frequency   = %lu.%.6lu MHz\n",
 		       ppc_proc_freq / 1000000, ppc_proc_freq % 1000000);
 		tb_last_stamp = tb_last_jiffy = get_tb();
 	}
