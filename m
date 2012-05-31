Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B60EBB7031
 for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2012 13:07:45 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 30 May 2012 21:07:42 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id C48CEC40005
 for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2012 03:07:40 +0000 (WET)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q4V37djX203464
 for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2012 21:07:39 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q4V37bKK015967
 for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2012 21:07:39 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/mm: dereference OF node "/chosen"
Date: Thu, 31 May 2012 11:07:29 +0800
Message-Id: <1338433650-19599-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: michael@ellerman.id.au, Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The form affinity for NUMA is set to 1 if the firmware supports
OPAL. Otherwise, we have to retrieve that from OF node "/chosen".
For the latter case, OF node "/chosen" was referred without
dereferencing.

The patch dereference OF node "/chosen" if necessary.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index b6edbb3..5ca3a15 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -340,6 +340,8 @@ static int __init find_min_common_depth(void)
 				dbg("Using form 1 affinity\n");
 				form1_affinity = 1;
 			}
+
+			of_node_put(chosen);
 		}
 	}
 
-- 
1.7.9.5
