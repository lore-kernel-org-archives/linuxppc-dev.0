Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id B503E679E6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 May 2005 19:08:45 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j4D9DP8M004958
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 May 2005 12:13:28 +0300 (EEST)
Message-ID: <42846AA9.5040209@intracom.gr>
Date: Fri, 13 May 2005 11:51:53 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Pantelis Antoniou <panto@intracom.gr>
References: <427F4D3F.1010802@intracom.gr> <20050509133808.A16776@cox.net>
	<4280985D.80108@intracom.gr>
	<f1e15a8d9ed033e850b56ca965754a43@embeddededge.com>
	<20050510062744.A21835@cox.net> <4280B3CB.8030007@intracom.gr>
	<20050510064702.B21835@cox.net> <428323C9.8070608@intracom.gr>
In-Reply-To: <428323C9.8070608@intracom.gr>
Content-Type: multipart/mixed; boundary="------------020007020602000907030900"
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH  03/04] Freescale Ethernet combined driver
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
--------------020007020602000907030900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi

Fix compile on 8xx FEC.

Brown bag time.

Regards

Pantelis



--------------020007020602000907030900
Content-Type: text/x-patch;
 name="fec-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fec-fix.patch"

Index: linux-2.6.11.7-fs_enet/drivers/net/fs_enet/fs_enet.h
===================================================================
--- linux-2.6.11.7-fs_enet.orig/drivers/net/fs_enet/fs_enet.h
+++ linux-2.6.11.7-fs_enet/drivers/net/fs_enet/fs_enet.h
@@ -108,7 +108,7 @@ struct fs_enet_mii_bus {
 	union {
 		struct {
 			unsigned int mii_speed;
-			void *fsp;
+			void *fecp;
 		} fec;
 
 		struct {
@@ -172,7 +172,7 @@ struct fs_enet_private {
 	union {
 		struct {
 			int idx;		/* FEC1 = 0, FEC2 = 1  */
-			void *fsp;		/* hw registers        */
+			void *fecp;		/* hw registers        */
 			__u32 hthi, htlo;	/* state for multicast */
 		} fec;
 
Index: linux-2.6.11.7-fs_enet/drivers/net/fs_enet/mac-fec.c
===================================================================
--- linux-2.6.11.7-fs_enet.orig/drivers/net/fs_enet/mac-fec.c
+++ linux-2.6.11.7-fs_enet/drivers/net/fs_enet/mac-fec.c
@@ -60,10 +60,10 @@
 #endif
 
 /* write */
-#define FW(_fecp, _reg, _v) __fs_out32(&(_fecp)->fs_ ## _reg, (_v))
+#define FW(_fecp, _reg, _v) __fs_out32(&(_fecp)->fec_ ## _reg, (_v))
 
 /* read */
-#define FR(_fecp, _reg)	__fs_in32(&(_fecp)->fs_ ## _reg)
+#define FR(_fecp, _reg)	__fs_in32(&(_fecp)->fec_ ## _reg)
 
 /* set bits */
 #define FS(_fecp, _reg, _v) FW(_fecp, _reg, FR(_fecp, _reg) | (_v))

--------------020007020602000907030900--
