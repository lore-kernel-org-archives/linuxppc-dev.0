Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D1A052C029A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 13:52:09 +1100 (EST)
Message-ID: <512C2345.6000405@asianux.com>
Date: Tue, 26 Feb 2013 10:51:49 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org, "paulus@samba.org" <paulus@samba.org>
Subject: [PATCH] PowerPC:PSeries: strncpy need limit destnation length
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


  the dest buf len is 80 (HVCS_CLC_LENGTH + 1).
  the src buf len is PAGE_SIZE.
  if src buf string len is more than 80, it will cause issue.

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/powerpc/platforms/pseries/hvcserver.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hvcserver.c b/arch/powerpc/platforms/pseries/hvcserver.c
index fcf4b4c..4557e91 100644
--- a/arch/powerpc/platforms/pseries/hvcserver.c
+++ b/arch/powerpc/platforms/pseries/hvcserver.c
@@ -23,6 +23,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 
 #include <asm/hvcall.h>
 #include <asm/hvcserver.h>
@@ -188,9 +189,9 @@ int hvcs_get_partner_info(uint32_t unit_address, struct list_head *head,
 			= (unsigned int)last_p_partition_ID;
 
 		/* copy the Null-term char too */
-		strncpy(&next_partner_info->location_code[0],
+		strlcpy(&next_partner_info->location_code[0],
 			(char *)&pi_buff[2],
-			strlen((char *)&pi_buff[2]) + 1);
+			sizeof(next_partner_info->location_code));
 
 		list_add_tail(&(next_partner_info->node), head);
 		next_partner_info = NULL;
-- 
1.7.7.6
