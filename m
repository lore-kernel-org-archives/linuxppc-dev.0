Return-Path: <a.hajda@samsung.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 51FD91A0021
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 18:10:35 +1000 (AEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NSP004DICWRZ440@mailout2.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 07 Aug 2015 09:00:27 +0100 (BST)
From: Andrzej Hajda <a.hajda@samsung.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrzej Hajda <a.hajda@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/31] arch/powerpc/pseries: use kmemdup rather than
 duplicating its implementation
Date: Fri, 07 Aug 2015 09:59:12 +0200
Message-id: <1438934377-4922-7-git-send-email-a.hajda@samsung.com>
In-reply-to: <1438934377-4922-1-git-send-email-a.hajda@samsung.com>
References: <1438934377-4922-1-git-send-email-a.hajda@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch was generated using fixed coccinelle semantic patch
scripts/coccinelle/api/memdup.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2014320

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 0ced387..e9ff44c 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -92,13 +92,12 @@ static struct property *dlpar_clone_drconf_property(struct device_node *dn)
 		return NULL;
 
 	new_prop->name = kstrdup(prop->name, GFP_KERNEL);
-	new_prop->value = kmalloc(prop->length, GFP_KERNEL);
+	new_prop->value = kmemdup(prop->value, prop->length, GFP_KERNEL);
 	if (!new_prop->name || !new_prop->value) {
 		dlpar_free_drconf_property(new_prop);
 		return NULL;
 	}
 
-	memcpy(new_prop->value, prop->value, prop->length);
 	new_prop->length = prop->length;
 
 	/* Convert the property to cpu endian-ness */
-- 
1.9.1
