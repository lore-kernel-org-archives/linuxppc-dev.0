Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 2C37167A46
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Feb 2005 07:59:39 +1100 (EST)
Message-ID: <42092835.1040701@mvista.com>
Date: Tue, 08 Feb 2005 13:59:33 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------070800090907020909060702"
Cc: Nathaniel Case <ncase@xes-inc.com>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH][PPC32] Fix mv64x60 register relocation bug in bootwrapper
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.
--------------070800090907020909060702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The gt64260 looks at the highest 20 bits while the mv64[34]60 looks at 
only the highest 16 bits when determining the base address for the 
bridge's registers.  This patch adds support for both.

Please apply.

Signed-off-by: Nate Case <ncase@xes-inc.com>
Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

--------------070800090907020909060702
Content-Type: text/plain;
 name="misc-mv64x60.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc-mv64x60.patch"

diff -Nru a/arch/ppc/boot/simple/misc-mv64x60.S b/arch/ppc/boot/simple/misc-mv64x60.S
--- a/arch/ppc/boot/simple/misc-mv64x60.S	2005-02-08 13:55:06 -07:00
+++ b/arch/ppc/boot/simple/misc-mv64x60.S	2005-02-08 13:55:06 -07:00
@@ -32,7 +32,11 @@
 #if (CONFIG_MV64X60_NEW_BASE != CONFIG_MV64X60_BASE)
 move_base:
 	li	r20,0
+#ifdef CONFIG_GT64260
 	li	r23,20
+#else /* Must be mv64[34]60 which uses top 16 bits */
+	li	r23,16
+#endif
 
 	/* Relocate bridge's regs */
 	addis	r25,0,CONFIG_MV64X60_BASE@h

--------------070800090907020909060702--
