Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2CE2F1A0244
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 06:01:10 +1100 (AEDT)
From: Colin King <colin.king@canonical.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/pseries/hvcserver: don't memset pi_buff if it is null
Date: Thu,  8 Oct 2015 20:00:58 +0100
Message-Id: <1444330858-5508-1-git-send-email-colin.king@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Colin Ian King <colin.king@canonical.com>

pi_buff is being memset before it is sanity checked. Move the
memset after the null pi_buff sanity check to avoid an oops.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/powerpc/platforms/pseries/hvcserver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/hvcserver.c b/arch/powerpc/platforms/pseries/hvcserver.c
index eedb645..94a6e56 100644
--- a/arch/powerpc/platforms/pseries/hvcserver.c
+++ b/arch/powerpc/platforms/pseries/hvcserver.c
@@ -142,11 +142,11 @@ int hvcs_get_partner_info(uint32_t unit_address, struct list_head *head,
 	int more = 1;
 	int retval;
 
-	memset(pi_buff, 0x00, PAGE_SIZE);
 	/* invalid parameters */
 	if (!head || !pi_buff)
 		return -EINVAL;
 
+	memset(pi_buff, 0x00, PAGE_SIZE);
 	last_p_partition_ID = last_p_unit_address = ~0UL;
 	INIT_LIST_HEAD(head);
 
-- 
2.5.0
