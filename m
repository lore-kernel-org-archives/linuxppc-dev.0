Return-Path: <k.kozlowski@samsung.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 686C91A0352
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 15:10:51 +1100 (AEDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NY100KPZN56KW10@mailout1.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Thu, 19 Nov 2015 04:00:43 +0000 (GMT)
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RESEND PATCH] powerpc/powernv: Drop owner assignment from
 platform_driver
Date: Thu, 19 Nov 2015 13:00:39 +0900
Message-id: <1447905639-31018-1-git-send-email-k.kozlowski@samsung.com>
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
