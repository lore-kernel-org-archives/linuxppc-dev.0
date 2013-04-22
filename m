Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0227A2C00EC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 04:33:08 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 22 Apr 2013 14:33:02 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 3F1E76E8242
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 14:32:08 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3MIVquE284130
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 14:31:52 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3MIVpcf021408
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 15:31:51 -0300
Received: from [9.41.105.123] ([9.41.105.123])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r3MIVpdh021367
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 15:31:51 -0300
Message-ID: <51758217.7070807@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 13:31:51 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 2/12] Correct buffer parsing in update-properties
References: <51757951.2080007@linux.vnet.ibm.com>
In-Reply-To: <51757951.2080007@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Correct parsing of the buffer returned from ibm,update-properties. The first
element is a length and the path to the property which is slightly different
from the list of properties in the buffer so we need to specifically
handle this.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/mobility.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

Index: powerpc/arch/powerpc/platforms/pseries/mobility.c
===================================================================
--- powerpc.orig/arch/powerpc/platforms/pseries/mobility.c	2013-04-17 13:27:23.000000000 -0500
+++ powerpc/arch/powerpc/platforms/pseries/mobility.c	2013-04-17 13:28:58.000000000 -0500
@@ -135,6 +135,7 @@
 	char *prop_data;
 	char *rtas_buf;
 	int update_properties_token;
+	u32 vd;
 
 	update_properties_token = rtas_token("ibm,update-properties");
 	if (update_properties_token == RTAS_UNKNOWN_SERVICE)
@@ -161,13 +162,24 @@
 
 		prop_data = rtas_buf + sizeof(*upwa);
 
-		for (i = 0; i < upwa->nprops; i++) {
+		/* The first element of the buffer is the path of the node
+		 * being updated in the form of a 8 byte string length
+		 * followed by the string. Skip past this to get to the
+		 * properties being updated.
+		 */
+		vd = *prop_data++;
+		prop_data += vd;
+
+		/* The path we skipped over is counted as one of the elements
+		 * returned so start counting at one.
+		 */
+		for (i = 1; i < upwa->nprops; i++) {
 			char *prop_name;
-			u32 vd;
 
-			prop_name = prop_data + 1;
+			prop_name = prop_data;
 			prop_data += strlen(prop_name) + 1;
-			vd = *prop_data++;
+			vd = *(u32 *)prop_data;
+			prop_data += sizeof(vd);
 
 			switch (vd) {
 			case 0x00000000:
