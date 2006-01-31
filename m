Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx009.isp.belgacom.be (outmx009.isp.belgacom.be
	[195.238.5.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 88034689C0
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Feb 2006 03:33:31 +1100 (EST)
Received: from outmx009.isp.belgacom.be (localhost [127.0.0.1])
	by outmx009.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k0VGXPXo029778
	for <linuxppc-embedded@ozlabs.org>; Tue, 31 Jan 2006 17:33:25 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx009.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k0VGXKPw029717
	for <linuxppc-embedded@ozlabs.org>; Tue, 31 Jan 2006 17:33:20 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] Merge Embedded Planet board information parsers into a single
	function
Date: Tue, 31 Jan 2006 17:33:20 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RF53DcvWE9I4O6w"
Message-Id: <200601311733.21132.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_RF53DcvWE9I4O6w
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everybody,

arch/ppc/boot/simple/embed_config.c has duplicate board information parsing 
code. This patch merges the parsers into a single function.

This is the first time I use git, so please point out the mistakes I probably 
did. I didn't include EP8248 support in this patch, as Tom Rini pointed out 
that it would have to wait for 2.6.17-rc1.

Laurent Pinchart

--Boundary-00=_RF53DcvWE9I4O6w
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ep-parser.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ep-parser.patch"

Merge Embedded Planet board information parsers into a single function.

The Embedded Planet boot loader passes board information as a text string
which must be parsed. This patch merges the multiple parser implementations
into a single one. 

Signed-off-by: Laurent Pinchart <laurent.pinchart@tbox.biz>


---

 arch/ppc/boot/simple/embed_config.c |  236 +++++++++++------------------------
 arch/ppc/platforms/rpx8260.h        |    2 
 2 files changed, 73 insertions(+), 165 deletions(-)

1ea98a415a76c902314014e17a3b76fec3dbedf8
diff --git a/arch/ppc/boot/simple/embed_config.c b/arch/ppc/boot/simple/embed_config.c
index 491a691..9ab2851 100644
--- a/arch/ppc/boot/simple/embed_config.c
+++ b/arch/ppc/boot/simple/embed_config.c
@@ -147,7 +147,6 @@ rpx_eth(bd_t *bd, u_char *cp)
 	}
 }
 
-#ifdef CONFIG_RPX8260
 static uint
 rpx_baseten(u_char *cp)
 {
@@ -162,26 +161,9 @@ rpx_baseten(u_char *cp)
 	}
 	return(retval);
 }
-#endif
 
 #if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC)
 static void
-rpx_brate(bd_t *bd, u_char *cp)
-{
-	uint	rate;
-
-	rate = 0;
-
-	while (*cp != '\n') {
-		rate *= 10;
-		rate += (*cp) - '0';
-		cp++;
-	}
-
-	bd->bi_baudrate = rate * 100;
-}
-
-static void
 rpx_cpuspeed(bd_t *bd, u_char *cp)
 {
 	uint	num, den;
@@ -217,69 +199,11 @@ rpx_cpuspeed(bd_t *bd, u_char *cp)
 }
 #endif
 
-#if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC) || defined(CONFIG_EP405)
-static void
-rpx_memsize(bd_t *bd, u_char *cp)
-{
-	uint	size;
-
-	size = 0;
-
-	while (*cp != '\n') {
-		size *= 10;
-		size += (*cp) - '0';
-		cp++;
-	}
-
-	bd->bi_memsize = size * 1024 * 1024;
-}
-#endif /* LITE || CLASSIC || EP405 */
-#if defined(CONFIG_EP405)
 static void
-rpx_nvramsize(bd_t *bd, u_char *cp)
-{
-	uint	size;
-
-	size = 0;
-
-	while (*cp != '\n') {
-		size *= 10;
-		size += (*cp) - '0';
-		cp++;
-	}
-
-	bd->bi_nvramsize = size * 1024;
-}
-#endif /* CONFIG_EP405 */
-
-#endif	/* Embedded Planet boards */
-
-#if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC)
-
-/* Read the EEPROM on the RPX-Lite board.
-*/
-void
-embed_config(bd_t **bdp)
+ep_parse_keyvals(bd_t *bd, u_char *keyvals)
 {
-	u_char	eebuf[256], *cp;
-	bd_t	*bd;
+	u_char *cp = keyvals;
 
-	/* Read the first 256 bytes of the EEPROM.  I think this
-	 * is really all there is, and I hope if it gets bigger the
-	 * info we want is still up front.
-	 */
-	bd = &bdinfo;
-	*bdp = bd;
-
-#if 1
-	iic_read(0xa8, eebuf, 0, 128);
-	iic_read(0xa8, &eebuf[128], 128, 128);
-
-	/* We look for two things, the Ethernet address and the
-	 * serial baud rate.  The records are separated by
-	 * newlines.
-	 */
-	cp = eebuf;
 	for (;;) {
 		if (*cp == 'E') {
 			cp++;
@@ -288,20 +212,28 @@ embed_config(bd_t **bdp)
 				rpx_eth(bd, cp);
 			}
 		}
+#if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC) || \
+    defined(CONFIG_RPX8260)
 		if (*cp == 'S') {
 			cp++;
 			if (*cp == 'B') {
 				cp += 2;
-				rpx_brate(bd, cp);
+#if defined(CONFIG_RPX8260)
+				bd->bi_baudrate = rpx_baseten(cp);
+#else
+				bd->bi_baudrate = rpx_baseten(cp) * 100;
+#endif
 			}
 		}
+#endif
 		if (*cp == 'D') {
 			cp++;
 			if (*cp == '1') {
 				cp += 2;
-				rpx_memsize(bd, cp);
+				bd->bi_memsize = rpx_baseten(cp) * 1024 * 1024;
 			}
 		}
+#if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC)
 		if (*cp == 'H') {
 			cp++;
 			if (*cp == 'Z') {
@@ -309,6 +241,29 @@ embed_config(bd_t **bdp)
 				rpx_cpuspeed(bd, cp);
 			}
 		}
+#endif
+#if defined(CONFIG_EP405) || defined(CONFIG_RPX8260)
+		if (*cp == 'N') {
+			cp++;
+			if (*cp == 'V') {
+				cp += 2;
+#if defined(CONFIG_EP405)
+				bd->bi_nvramsize = rpx_baseten(cp) * 1024;
+#else
+				bd->bi_nvramsize = rpx_baseten(cp) * 1024 * 1024;
+#endif
+			}
+		}
+#endif
+#if defined(CONFIG_RPX8260)
+		if (*cp == 'X') {
+			cp++;
+			if (*cp == 'T') {
+				cp += 2;
+				bd->bi_busfreq = rpx_baseten(cp);
+			}
+		}
+#endif
 
 		/* Scan to the end of the record.
 		*/
@@ -317,10 +272,42 @@ embed_config(bd_t **bdp)
 
 		/* If the next character is a 0 or ff, we are done.
 		*/
+
 		cp++;
 		if ((*cp == 0) || (*cp == 0xff))
 			break;
 	}
+}
+
+#endif	/* Embedded Planet boards */
+
+#if defined(CONFIG_RPXLITE) || defined(CONFIG_RPXCLASSIC)
+
+/* Read the EEPROM on the RPX-Lite board.
+*/
+void
+embed_config(bd_t **bdp)
+{
+	u_char	eebuf[256];
+	bd_t	*bd;
+
+	/* Read the first 256 bytes of the EEPROM.  I think this
+	 * is really all there is, and I hope if it gets bigger the
+	 * info we want is still up front.
+	 */
+	bd = &bdinfo;
+	*bdp = bd;
+
+#if 1
+	iic_read(0xa8, eebuf, 0, 128);
+	iic_read(0xa8, &eebuf[128], 128, 128);
+
+	/* We look for two things, the Ethernet address and the
+	 * serial baud rate.  The records are separated by
+	 * newlines.
+	 */
+	ep_parse_keyvals(bd, eebuf);
+
 	bd->bi_memstart = 0;
 #else
 	/* For boards without initialized EEPROM.
@@ -588,12 +575,11 @@ embed_config(bd_t **bdp)
 }
 #endif /* SBS8260 */
 
-#ifdef CONFIG_RPX8260
+#if defined(CONFIG_RPX8260)
 void
 embed_config(bd_t **bdp)
 {
-	u_char	*cp, *keyvals;
-	int	i;
+	u_char	*keyvals;
 	bd_t	*bd;
 
 	keyvals = (u_char *)*bdp;
@@ -606,55 +592,8 @@ embed_config(bd_t **bdp)
 	 * function in a string, but the format of all of the fields
 	 * is slightly different.
 	 */
-	cp = keyvals;
-	for (;;) {
-		if (*cp == 'E') {
-			cp++;
-			if (*cp == 'A') {
-				cp += 2;
-				rpx_eth(bd, cp);
-			}
-		}
-		if (*cp == 'S') {
-			cp++;
-			if (*cp == 'B') {
-				cp += 2;
-				bd->bi_baudrate = rpx_baseten(cp);
-			}
-		}
-		if (*cp == 'D') {
-			cp++;
-			if (*cp == '1') {
-				cp += 2;
-				bd->bi_memsize = rpx_baseten(cp) * 1024 * 1024;
-			}
-		}
-		if (*cp == 'X') {
-			cp++;
-			if (*cp == 'T') {
-				cp += 2;
-				bd->bi_busfreq = rpx_baseten(cp);
-			}
-		}
-		if (*cp == 'N') {
-			cp++;
-			if (*cp == 'V') {
-				cp += 2;
-				bd->bi_nvsize = rpx_baseten(cp) * 1024 * 1024;
-			}
-		}
+	ep_parse_keyvals(bd, keyvals);
 
-		/* Scan to the end of the record.
-		*/
-		while ((*cp != '\n') && (*cp != 0xff))
-			cp++;
-
-		/* If the next character is a 0 or ff, we are done.
-		*/
-		cp++;
-		if ((*cp == 0) || (*cp == 0xff))
-			break;
-	}
 	bd->bi_memstart = 0;
 
 	/* The memory size includes both the 60x and local bus DRAM.
@@ -673,7 +612,7 @@ embed_config(bd_t **bdp)
 	*/
 	bd->bi_intfreq = 200000000;
 }
-#endif /* RPX6 for testing */
+#endif /* CONFIG_RXP8260 */
 
 #ifdef CONFIG_ADS8260
 void
@@ -853,7 +792,6 @@ void
 embed_config(bd_t **bdp)
 {
 	u32 chcr0;
-	u_char *cp;
 	bd_t	*bd;
 
 	/* Different versions of the PlanetCore firmware vary in how
@@ -882,38 +820,8 @@ embed_config(bd_t **bdp)
 	bd = &bdinfo;
 	*bdp = bd;
 #if 1
-	        cp = (u_char *)0xF0000EE0;
-	        for (;;) {
-	                if (*cp == 'E') {
-	                        cp++;
-	                        if (*cp == 'A') {
-                                  cp += 2;
-                                  rpx_eth(bd, cp);
-	                        }
-		         }
-
-	         	if (*cp == 'D') {
-	                        	cp++;
-	                        	if (*cp == '1') {
-		                                cp += 2;
-		                                rpx_memsize(bd, cp);
-	        	                }
-                	}
-
-			if (*cp == 'N') {
-				cp++;
-				if (*cp == 'V') {
-					cp += 2;
-					rpx_nvramsize(bd, cp);
-				}
-			}
-			while ((*cp != '\n') && (*cp != 0xff))
-			      cp++;
+	ep_parse_keyvals(bd, (u_char*)0xF0000EE0);
 
-	                cp++;
-	                if ((*cp == 0) || (*cp == 0xff))
-	                   break;
-	       }
 	bd->bi_intfreq   = 200000000;
 	bd->bi_busfreq   = 100000000;
 	bd->bi_pci_busfreq= 33000000 ;
diff --git a/arch/ppc/platforms/rpx8260.h b/arch/ppc/platforms/rpx8260.h
index 843494a..e8d8fe3 100644
--- a/arch/ppc/platforms/rpx8260.h
+++ b/arch/ppc/platforms/rpx8260.h
@@ -15,7 +15,7 @@
 typedef struct bd_info {
 	unsigned int	bi_memstart;	/* Memory start address */
 	unsigned int	bi_memsize;	/* Memory (end) size in bytes */
-	unsigned int	bi_nvsize;	/* NVRAM size in bytes (can be 0) */
+	unsigned int	bi_nvramsize;	/* NVRAM size in bytes (can be 0) */
 	unsigned int	bi_intfreq;	/* Internal Freq, in Hz */
 	unsigned int	bi_busfreq;	/* Bus Freq, in MHz */
 	unsigned int	bi_cpmfreq;	/* CPM Freq, in MHz */

--Boundary-00=_RF53DcvWE9I4O6w--
