Return-Path: <claudiu.manoil@nxp.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0089.outbound.protection.outlook.com [104.47.42.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJn4G5w43zDvZh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 01:40:46 +1100 (AEDT)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <oss@buserror.net>, <roy.pledge@nxp.com>
Subject: [PATCH 05/17] soc/qman: Fix struct qm_fqd set accessor for context_a
Date: Wed, 16 Nov 2016 16:40:18 +0200
Message-ID: <1479307230-16650-6-git-send-email-claudiu.manoil@nxp.com>
In-Reply-To: <1479307230-16650-1-git-send-email-claudiu.manoil@nxp.com>
References: <1479307230-16650-1-git-send-email-claudiu.manoil@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

context_a.hi is 32bit

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 include/soc/fsl/qman.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
index 37f3eb0..1405810 100644
--- a/include/soc/fsl/qman.h
+++ b/include/soc/fsl/qman.h
@@ -411,7 +411,7 @@ static inline void qm_fqd_stashing_set64(struct qm_fqd *fqd, u64 addr)
 
 static inline void qm_fqd_context_a_set64(struct qm_fqd *fqd, u64 addr)
 {
-	fqd->context_a.hi = cpu_to_be16(upper_32_bits(addr));
+	fqd->context_a.hi = cpu_to_be32(upper_32_bits(addr));
 	fqd->context_a.lo = cpu_to_be32(lower_32_bits(addr));
 }
 
-- 
1.7.11.7
