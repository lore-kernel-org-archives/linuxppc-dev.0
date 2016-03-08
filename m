Return-Path: <linux@rasmusvillemoes.dk>
Received: from mail-wm0-x22d.google.com (mail-wm0-x22d.google.com
 [IPv6:2a00:1450:400c:c09::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C6B861A005D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 08:26:29 +1100 (AEDT)
Received: by mail-wm0-x22d.google.com with SMTP id l68so45403514wml.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Mar 2016 13:26:29 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/pseries: fix error return value in
 cmm_mem_going_offline
Date: Tue,  8 Mar 2016 22:26:17 +0100
Message-Id: <1457472378-22274-1-git-send-email-linux@rasmusvillemoes.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cmm_mem_going_offline is (only) called from cmm_memory_cb(), which
sends the return value through notifier_from_errno(). The latter
expects 0 or -errno (notifier_to_errno(notifier_from_errno(x)) is 0
for any x >= 0, so passing a positive value cannot make sense). Hence
negate ENOMEM.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/platforms/pseries/cmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index fc44ad0475f8..66e7227469b8 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -574,7 +574,7 @@ static int cmm_mem_going_offline(void *arg)
 				cmm_dbg("Failed to allocate memory for list "
 						"management. Memory hotplug "
 						"failed.\n");
-				return ENOMEM;
+				return -ENOMEM;
 			}
 			memcpy(npa, pa_curr, PAGE_SIZE);
 			if (pa_curr == cmm_page_list)
-- 
2.1.4
