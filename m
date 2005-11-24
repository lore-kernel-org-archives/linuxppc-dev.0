Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 17:34:03 +1100
Message-Id: <1132814044.26560.441.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Fix g5 build with xmon
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

My previous patches inadvertently broke building a G5 kernel with
CONFIG_XMON enabled. This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-serialfix/arch/powerpc/platforms/powermac/pic.c
===================================================================
--- linux-serialfix.orig/arch/powerpc/platforms/powermac/pic.c	2005-11-24 17:21:41.000000000 +1100
+++ linux-serialfix/arch/powerpc/platforms/powermac/pic.c	2005-11-24 17:36:07.000000000 +1100
@@ -459,7 +459,7 @@ void __init pmac_pic_init(void)
 			mpic_setup_cascade(irqctrler2->intrs[0].line,
 					   pmac_u3_cascade, mpic2);
 		}
-#ifdef CONFIG_XMON
+#if defined(CONFIG_XMON) && defined(CONFIG_PPC32)
 		{
 			struct device_node* pswitch;
 			int nmi_irq;
@@ -471,7 +471,7 @@ void __init pmac_pic_init(void)
 				setup_irq(nmi_irq, &xmon_action);
 			}
 		}
-#endif	/* CONFIG_XMON */
+#endif	/* defined(CONFIG_XMON) && defined(CONFIG_PPC32) */
 		return;
 	}
 	irqctrler = NULL;
