Subject: New 745x errata
From: Adrian Cox <adrian@humboldt.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Cc: paulus@samba.org
Content-Type: text/plain
Date: 13 Nov 2003 11:05:17 +0000
Message-Id: <1068721518.23764.84.camel@newt>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Since October there are new errata on Motorola's website for the 745x
family processors. The following patch against linuxppc-2.4-devel
contains workarounds to two problems:

1) The BTIC doesn't work reliably: it can cause execution of corrupted
instructions. (This is listed in the errata for the 7450 and 7457, but
not for the 7455. I'll only believe that the 7455 escaped this bug if I
hear confirmation out of Motorola.)
2) dcbt to protected addresses can cause spurious bus cycles. This could
potentially be exploited from userspace to lock up hardware.

- Adrian Cox
http://www.humboldt.co.uk/

===== arch/ppc/kernel/cpu_setup_6xx.S 1.3 vs edited =====
--- 1.3/arch/ppc/kernel/cpu_setup_6xx.S	Fri Jul 18 20:53:16 2003
+++ edited/arch/ppc/kernel/cpu_setup_6xx.S	Thu Nov 13 10:51:52 2003
@@ -191,9 +191,10 @@

 /* MPC 745x
  * Enable Store Gathering (SGE), Branch Folding (FOLD)
- * Branch History Table (BHTE), Branch Target ICache (BTIC)
+ * Branch History Table (BHTE)
  * Dynamic Power Management (DPM), Speculative (SPD)
- * Ensure our data cache instructions really operate.
+ * Disable Branch Target ICache (BTIC) and data cache touch instructions to
+ * work around published chip errata.
  * Timebase has to be running or we wouldn't have made it here,
  * just ensure we don't disable it.
  * Clear Instruction cache throttling (ICTC)
@@ -218,14 +219,14 @@

 	/* All of the bits we have to set.....
 	 */
-	ori	r11,r11,HID0_SGE | HID0_FOLD | HID0_BHTE | HID0_BTIC | HID0_LRSTK
+	ori	r11,r11,HID0_SGE | HID0_FOLD | HID0_BHTE | HID0_LRSTK | HID0_NOPTI
 BEGIN_FTR_SECTION
 	oris	r11,r11,HID0_DPM@h	/* enable dynamic power mgmt */
 END_FTR_SECTION_IFCLR(CPU_FTR_NO_DPM)

 	/* All of the bits we have to clear....
 	 */
-	li	r3,HID0_SPD | HID0_NOPDST | HID0_NOPTI
+	li	r3,HID0_SPD | HID0_NOPDST | HID0_BTIC
 	andc	r11,r11,r3		/* clear SPD: enable speculative */
  	li	r3,0


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
