Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A73682C0740
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 15:24:04 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 14 Aug 2013 23:24:02 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id F282F1FF001B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:18:34 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
 id r7F5O0u6171256
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:24:00 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7F5O0Ho015187
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:24:00 -0600
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 7/8] powerpc/pseries: add mising of_node_put in delete_dt_node
Date: Wed, 14 Aug 2013 22:23:51 -0700
Message-Id: <1376544232-24936-8-git-send-email-tyreld@linux.vnet.ibm.com>
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

The node to be detached is retrieved via its phandle by a call to
of_find_node_by_phandle which increments the ref count. We need a matching
call to of_node_put to decrement the ref count and ensure the node is
actually freed.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index ff102e2..cde4e0a 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -62,6 +62,7 @@ static int delete_dt_node(u32 phandle)
 		return -ENOENT;
 
 	dlpar_detach_node(dn);
+	of_node_put(dn);
 	return 0;
 }
 
-- 
1.7.12.4
