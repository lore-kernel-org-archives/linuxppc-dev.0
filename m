Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 664D62C0734
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 15:24:03 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 14 Aug 2013 23:24:01 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id D4BE319D8041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:23:45 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
 id r7F5NwSo179524
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:23:58 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7F5NwOk015120
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:23:58 -0600
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/8] powerpc/pseries: fix creation of loop in device node
 property list
Date: Wed, 14 Aug 2013 22:23:45 -0700
Message-Id: <1376544232-24936-2-git-send-email-tyreld@linux.vnet.ibm.com>
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

The update_dt_prop helper function fails to set the IN/OUT parameter prop to
NULL after a complete property has been parsed from the work area returned by
the ibm,update-properties rtas function. This results in the property list of
the device node being updated is corrupted and becomes a loop since the same
property structure is used repeatedly.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 3d01eee..f28abee 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -119,7 +119,7 @@ static int update_dt_property(struct device_node *dn, struct property **prop,
 
 	if (!more) {
 		of_update_property(dn, new_prop);
-		new_prop = NULL;
+		*prop = NULL;
 	}
 
 	return 0;
-- 
1.7.12.4
