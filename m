Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 3F991DDDFC
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 16:04:20 +1100 (EST)
Message-Id: <20070202045508.905053000@lixom.net>>
References: <20070202045448.145851000@lixom.net>>
Date: Thu, 01 Feb 2007 22:54:54 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [6/9] pasemi: SMP timebase sync
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timebase update is simple on PA6T, since global updates can be done from
one core by writing to a couble of SPRs.


Signed-off-by: Olof Johansson <olof@lixom.net>


Index: merge/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- merge.orig/arch/powerpc/platforms/pasemi/setup.c
+++ merge/arch/powerpc/platforms/pasemi/setup.c
@@ -52,13 +52,36 @@ static void pas_restart(char *cmd)
 }
 
 #ifdef CONFIG_SMP
+static DEFINE_SPINLOCK(timebase_lock);
+
+static void __devinit pas_give_timebase(void)
+{
+	unsigned long tb;
+
+	spin_lock(&timebase_lock);
+	mtspr(SPRN_TBCTL, TBCTL_FREEZE);
+	tb = mftb();
+	mtspr(SPRN_TBCTL, TBCTL_UPDATE_LOWER | (tb & 0xffffffff));
+	mtspr(SPRN_TBCTL, TBCTL_UPDATE_UPPER | (tb >> 32));
+	mtspr(SPRN_TBCTL, TBCTL_RESTART);
+	spin_unlock(&timebase_lock);
+	pr_debug("pas_give_timebase: cpu %d gave tb %lx\n",
+		 smp_processor_id(), tb);
+}
+
+static void __devinit pas_take_timebase(void)
+{
+	pr_debug("pas_take_timebase: cpu %d has tb %lx\n",
+		 smp_processor_id(), mftb());
+}
+
 struct smp_ops_t pas_smp_ops = {
 	.probe		= smp_mpic_probe,
 	.message_pass	= smp_mpic_message_pass,
 	.kick_cpu	= smp_generic_kick_cpu,
 	.setup_cpu	= smp_mpic_setup_cpu,
-	.give_timebase	= smp_generic_give_timebase,
-	.take_timebase	= smp_generic_take_timebase,
+	.give_timebase	= pas_give_timebase,
+	.take_timebase	= pas_take_timebase,
 };
 #endif /* CONFIG_SMP */
 
Index: merge/include/asm-powerpc/reg.h
===================================================================
--- merge.orig/include/asm-powerpc/reg.h
+++ merge/include/asm-powerpc/reg.h
@@ -392,6 +392,12 @@
 #define SPRN_HSRR0	0x13A	/* Save/Restore Register 0 */
 #define SPRN_HSRR1	0x13B	/* Save/Restore Register 1 */
 
+#define SPRN_TBCTL	0x35f	/* PA6T Timebase control register */
+#define   TBCTL_FREEZE		0x0000000000000000ull /* Freeze all tbs */
+#define   TBCTL_RESTART		0x0000000100000000ull /* Restart all tbs */
+#define   TBCTL_UPDATE_UPPER	0x0000000200000000ull /* Set upper 32 bits */
+#define   TBCTL_UPDATE_LOWER	0x0000000300000000ull /* Set lower 32 bits */
+
 #ifndef SPRN_SVR
 #define SPRN_SVR	0x11E	/* System Version Register */
 #endif

--
