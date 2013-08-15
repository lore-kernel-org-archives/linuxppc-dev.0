Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7F3EA2C0511
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 15:24:05 +1000 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 14 Aug 2013 23:24:03 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id D10321FF001B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:18:33 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
 id r7F5Nx4Z196854
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:23:59 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7F5Nxox015152
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:23:59 -0600
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/8] powerpc/pseries: fix parsing of initial node path in
 update_dt_node
Date: Wed, 14 Aug 2013 22:23:48 -0700
Message-Id: <1376544232-24936-5-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1376544232-24936-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1376544232-24936-1-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On the first call to ibm,update-properties for a node the first property
returned is the full node path. Currently this is not parsed correctly by the
update_dt_node function. Commit 2e9b7b0 attempted to fix this, but was
incorrect as it made a wrong assumption about the layout of the first
property in the work area. Further, if ibm,update-properties must be called
multiple times for the same node this special property should only be skipped
after the initial call. The first property descriptor returned consists of
the property name, property value length, and property value. The property
name is an empty string, property length is encoded in 4 byte integer, and
the property value is the node path.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 023e354..ed5426f 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -161,18 +161,19 @@ static int update_dt_node(u32 phandle, s32 scope)
 
 		prop_data = rtas_buf + sizeof(*upwa);
 
-		/* The first element of the buffer is the path of the node
-		 * being updated in the form of a 8 byte string length
-		 * followed by the string. Skip past this to get to the
-		 * properties being updated.
+		/* On the first call to ibm,update-properties for a node the
+		 * the first property value descriptor contains an empty
+		 * property name, the property value length encoded as u32,
+		 * and the property value is the node path being updated.
 		 */
-		vd = *prop_data++;
-		prop_data += vd;
+		if (*prop_data == 0) {
+			prop_data++;
+			vd = *(u32 *)prop_data;
+			prop_data += vd + sizeof(vd);
+			upwa->nprops--;
+		}
 
-		/* The path we skipped over is counted as one of the elements
-		 * returned so start counting at one.
-		 */
-		for (i = 1; i < upwa->nprops; i++) {
+		for (i = 0; i < upwa->nprops; i++) {
 			char *prop_name;
 
 			prop_name = prop_data;
-- 
1.7.12.4
