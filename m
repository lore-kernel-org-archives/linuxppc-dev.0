Subject: 405LP compile fix
From: Hollis Blanchard <hollis@austin.ibm.com>
To: embedded list <linuxppc-embedded@lists.linuxppc.org>
Date: 18 Dec 2002 09:49:24 -0600
Message-Id: <1040226565.29647.15.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm glad I'm not the only one who sometimes doesn't compile-test his
patches... ;)

This patch fixes the Beech build, which is calling the now-nonexistant
function beech_time_init. In actuality beech_calibrate_decr was never called
anyways... :)

Please apply to _2_4_devel.

-Hollis
--
PowerPC Linux
IBM Linux Technology Center


===== arch/ppc/platforms/beech.c 1.9 vs edited =====
--- 1.9/arch/ppc/platforms/beech.c	Thu Dec 12 17:06:37 2002
+++ edited/arch/ppc/platforms/beech.c	Tue Dec 17 13:47:47 2002
@@ -253,64 +253,6 @@
 	/* Set RTS/CTS mode for UART 1 */

 	*beech_fpga_reg_2 |= FPGA_REG_2_DEFAULT_UART1_N;
-}
-
-void __init
-beech_calibrate_decr(void)
-{
-	ulong	freq;
-	ulong	tbl, tbu;
-        long	i, loop_count;
-        u_char	sec;
-
-	beech_time_init();
-
-	/*
-	 * Actually this is bad for precision, we should have a loop in
-	 * which we only read the seconds counter. todc_read_val writes
-	 * the address bytes on every call and this takes a lot of time.
-	 * Perhaps an nvram_wait_change method returning a time
-	 * stamp with a loop count as parameter would be the solution.
-	 */
-	/*
-	 * Need to make sure the tbl doesn't roll over so if tbu increments
-	 * during this test, we need to do it again.
-	 */
-	loop_count = 0;
-
-	sec = mfdcr(DCRN_RTC0_SEC) & 0x7f;
-
-	do {
-		tbu = get_tbu();
-
-		for (i = 0 ; i < 10000000 ; i++) {/* may take up to 1 second */
-		   tbl = get_tbl();
-
-		   if ((mfdcr(DCRN_RTC0_SEC) & 0x7f) != sec) {
-		      break;
-		   }
-		}
-
-		sec = mfdcr(DCRN_RTC0_SEC) & 0x7f;
-
-		for (i = 0 ; i < 10000000 ; i++) { /* Should take 1 second */
-		   freq = get_tbl();
-
-		   if ((mfdcr(DCRN_RTC0_SEC) & 0x7f) != sec) {
-		      break;
-		   }
-		}
-
-		freq -= tbl;
-	} while ((get_tbu() != tbu) && (++loop_count < 2));
-
-	printk("time_init: decrementer frequency = %lu.%.6lu MHz\n",
-	       freq/1000000, freq%1000000);
-
-	tb_ticks_per_jiffy = freq / HZ;
-	tb_to_us = mulhwu_scale_factor(freq, 1000000);
-
-	return;
 }

 /*

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
