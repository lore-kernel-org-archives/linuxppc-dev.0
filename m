Subject: [PATCH] fix redwood boot (linuxppc-2.4, from linuxppc_2_4_devel)
From: Andreas Oberritter <obi@saftware.de>
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Content-Type: multipart/mixed; boundary="=-J0g6NrpZypqtMa2Tze16"
Message-Id: <1066088250.1580.16.camel@shiva.eth.saftware.de>
Mime-Version: 1.0
Date: Tue, 14 Oct 2003 01:37:30 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-J0g6NrpZypqtMa2Tze16
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

without this patch booting stops at "Calibrating delay loop" (jiffies
don't increase). Please apply to linuxppc-2.4.

Regards,
Andreas

--=-J0g6NrpZypqtMa2Tze16
Content-Disposition: attachment; filename=embed_config.diff
Content-Type: text/plain; name=embed_config.diff; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

===== arch/ppc/boot/simple/embed_config.c 1.16 vs edited =====
--- 1.16/arch/ppc/boot/simple/embed_config.c	Thu Sep 25 00:55:59 2003
+++ edited/arch/ppc/boot/simple/embed_config.c	Tue Oct 14 01:12:29 2003
@@ -684,26 +684,23 @@
 			bd->bi_pci_enetaddr[i] = *cp++;
 #endif
 		}
+		bd->bi_tbfreq = 200000000;
 		bd->bi_intfreq = 200000000;
 		bd->bi_busfreq = 100000000;
 #ifdef CONFIG_PCI
 		bd->bi_pci_busfreq = 66666666;
 #endif
-		/* Yeah, this look weird, but on Redwood 4 they are
-		 * different object in the structure.  When RW5 uses
-		 * OpenBIOS, it requires a special value.
-		 */
-#ifdef CONFIG_REDWOOD_5
-	bd->bi_intfreq = 200 * 1000 * 1000;
-	bd->bi_busfreq = 0;
-
-		bd->bi_tbfreq = 27 * 1000 * 1000;
-#elif CONFIG_REDWOOD_4
-		bd->bi_tbfreq = bd->bi_intfreq;
-#endif
 	}
-}
+	/* Yeah, this look weird, but on Redwood 4 they are
+	 * different object in the structure.  When RW5 uses
+	 * OpenBIOS, it requires a special value.
+	 */
+#if defined(CONFIG_REDWOOD_5) || defined (CONFIG_REDWOOD_6)
+	bd->bi_tbfreq = 27000000;
 #endif
+	timebase_period_ns = 1000000000 / bd->bi_tbfreq;
+}
+#endif /* CONFIG_IBM_OPENBIOS */

 #ifdef CONFIG_ARCTIC2
 /* Several bootloaders have been used on the Arctic.  We assume either

--=-J0g6NrpZypqtMa2Tze16--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
