Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2FFE12C0529
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 15:24:03 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 14 Aug 2013 23:24:00 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 2BB303E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:23:35 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
 id r7F5NwRw131384
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:23:58 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7F5NwmD015131
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:23:58 -0600
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/8] powerpc/pseries: fix over writing of rtas return code in
 update_dt_node
Date: Wed, 14 Aug 2013 22:23:46 -0700
Message-Id: <1376544232-24936-3-git-send-email-tyreld@linux.vnet.ibm.com>
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

The rc variable is initially used to store the return code from the
ibm,update-properties rtas call which returns 0 or 1 on success. A return
code of 1 indicates that ibm,update-properties must be called again for the
node. However, the rc variable is overwritten by a call to update_dt_prop
which returns 0 on success. This results in ibm,update-properties not being
called again for the given node when the rtas call rc was previously 1.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index f28abee..aaae85d 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -130,7 +130,7 @@ static int update_dt_node(u32 phandle, s32 scope)
 	struct update_props_workarea *upwa;
 	struct device_node *dn;
 	struct property *prop = NULL;
-	int i, rc;
+	int i, rc, rtas_rc;
 	char *prop_data;
 	char *rtas_buf;
 	int update_properties_token;
@@ -154,9 +154,9 @@ static int update_dt_node(u32 phandle, s32 scope)
 	upwa->phandle = phandle;
 
 	do {
-		rc = mobility_rtas_call(update_properties_token, rtas_buf,
+		rtas_rc = mobility_rtas_call(update_properties_token, rtas_buf,
 					scope);
-		if (rc < 0)
+		if (rtas_rc < 0)
 			break;
 
 		prop_data = rtas_buf + sizeof(*upwa);
@@ -202,7 +202,7 @@ static int update_dt_node(u32 phandle, s32 scope)
 				prop_data += vd;
 			}
 		}
-	} while (rc == 1);
+	} while (rtas_rc == 1);
 
 	of_node_put(dn);
 	kfree(rtas_buf);
-- 
1.7.12.4
