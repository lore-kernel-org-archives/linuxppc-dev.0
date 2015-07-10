Return-Path: <k.kozlowski@samsung.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 87FF21A0DCE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 16:49:01 +1000 (AEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NR90046BEGRA140@mailout4.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 10 Jul 2015 07:38:51 +0100 (BST)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jeremy Kerr <jk@ozlabs.org>, Stewart Smith <stewart@linux.vnet.ibm.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
 (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powerpc/powernv: Drop owner assignment from platform_driver
Date: Fri, 10 Jul 2015 15:38:41 +0900
Message-id: <1436510324-5838-1-git-send-email-k.kozlowski@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

platform_driver does not need to set an owner because
platform_driver_register() will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 arch/powerpc/platforms/powernv/opal-prd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-prd.c b/arch/powerpc/platforms/powernv/opal-prd.c
index 4ece8e40dd54..e315e704cca7 100644
--- a/arch/powerpc/platforms/powernv/opal-prd.c
+++ b/arch/powerpc/platforms/powernv/opal-prd.c
@@ -434,7 +434,6 @@ static const struct of_device_id opal_prd_match[] = {
 static struct platform_driver opal_prd_driver = {
 	.driver = {
 		.name		= "opal-prd",
-		.owner		= THIS_MODULE,
 		.of_match_table	= opal_prd_match,
 	},
 	.probe	= opal_prd_probe,
-- 
1.9.1
