Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B51DB1A0009
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 07:42:48 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Tue, 5 Aug 2014 15:42:45 -0600
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 1ECAB6E801A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 17:42:32 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s75LggFZ46072058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Aug 2014 21:42:42 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s75Lggu0004343
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Aug 2014 17:42:42 -0400
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pseries/hvcserver: Fix endian issue in
 hvcs_get_partner_info
Date: Tue,  5 Aug 2014 16:42:39 -0500
Message-Id: <1407274959-20501-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A buffer returned by H_VTERM_PARTNER_INFO contains device information
in big endian format, causing problems for little endian architectures.
This patch ensures that they are in cpu endian.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hvcserver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hvcserver.c b/arch/powerpc/platforms/pseries/hvcserver.c
index 4557e91..eedb645 100644
--- a/arch/powerpc/platforms/pseries/hvcserver.c
+++ b/arch/powerpc/platforms/pseries/hvcserver.c
@@ -163,8 +163,8 @@ int hvcs_get_partner_info(uint32_t unit_address, struct list_head *head,
 			return retval;
 		}
 
-		last_p_partition_ID = pi_buff[0];
-		last_p_unit_address = pi_buff[1];
+		last_p_partition_ID = be64_to_cpu(pi_buff[0]);
+		last_p_unit_address = be64_to_cpu(pi_buff[1]);
 
 		/* This indicates that there are no further partners */
 		if (last_p_partition_ID == ~0UL
-- 
1.9.3
