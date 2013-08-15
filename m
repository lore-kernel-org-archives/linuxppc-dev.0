Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BAB7C2C04DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 15:24:03 +1000 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 14 Aug 2013 23:24:01 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id A124D3E40040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:23:35 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
 id r7F5Nx7H179530
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:23:59 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7F5Nw4c015140
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:23:59 -0600
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/8] powerpc/pseries: pack update_props_workarea to map
 correctly to rtas buffer header
Date: Wed, 14 Aug 2013 22:23:47 -0700
Message-Id: <1376544232-24936-4-git-send-email-tyreld@linux.vnet.ibm.com>
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

The work area buffer returned by the ibm,update-properties rtas call contains
20 bytes of header information prior to the property value descriptor data.
Currently update_dt_node tries to advance over this header using sizeof(upwa).
The update_props_workarea struct contains 20 bytes worth of fields, that map
to the relevant header data, but the sizeof the structure is 24 bytes due to
4 bytes of padding at the end of the structure. Packing the structure ensures
that we don't advance too far over the rtas buffer.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index aaae85d..023e354 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -28,7 +28,7 @@ struct update_props_workarea {
 	u32 state;
 	u64 reserved;
 	u32 nprops;
-};
+} __packed;
 
 #define NODE_ACTION_MASK	0xff000000
 #define NODE_COUNT_MASK		0x00ffffff
-- 
1.7.12.4
