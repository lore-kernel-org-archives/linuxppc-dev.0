Subject: [PATCH] add weak embed_config()
From: Andreas Oberritter <obi@saftware.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Content-Type: multipart/mixed; boundary="=-4Y5SKZdS42fJ3mqS8COc"
Message-Id: <1090251755.4369.15.camel@shiva.saftware.de>
Mime-Version: 1.0
Date: Mon, 19 Jul 2004 17:42:36 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-4Y5SKZdS42fJ3mqS8COc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Tom,

in 2.4 there is a weak embed_config function for boards which don't need
to fill the bd_t struct because they are using u-boot. This patch adds
the function to linuxppc-2.5. Please apply.

Signed-off-by: Andreas Oberritter <obi@saftware.de>

--=-4Y5SKZdS42fJ3mqS8COc
Content-Disposition: attachment; filename=embed_config.diff
Content-Type: text/x-patch; name=embed_config.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

===== arch/ppc/boot/simple/misc-embedded.c 1.14 vs edited =====
--- 1.14/arch/ppc/boot/simple/misc-embedded.c	2004-04-01 17:35:14 +02:00
+++ edited/arch/ppc/boot/simple/misc-embedded.c	2004-07-18 20:09:05 +02:00
@@ -72,6 +72,14 @@
 extern void gunzip(void *, int, unsigned char *, int *);
 extern void embed_config(bd_t **bp);

+/* Weak function for boards which don't need to build the
+ * board info struct because they are using PPCBoot/U-Boot.
+ */
+void __attribute__ ((weak))
+embed_config(bd_t **bdp)
+{
+}
+
 unsigned long
 load_kernel(unsigned long load_addr, int num_words, unsigned long cksum, bd_t *bp)
 {

--=-4Y5SKZdS42fJ3mqS8COc--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
