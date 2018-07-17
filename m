Return-Path: <diana.craciun@nxp.com>
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VHcY3tSQzF3Hx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 21:10:05 +1000 (AEST)
From: Diana Craciun <diana.craciun@nxp.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, oss@buserror.net, leoyang.li@nxp.com,
 bharat.bhushan@nxp.com, Diana Craciun <diana.craciun@nxp.com>
Subject: [PATCH v4 3/6] powerpc/fsl: Make stf barrier PPC_BOOK3S_64 specific.
Date: Tue, 17 Jul 2018 14:09:54 +0300
Message-Id: <1531825797-14236-4-git-send-email-diana.craciun@nxp.com>
In-Reply-To: <1531825797-14236-1-git-send-email-diana.craciun@nxp.com>
References: <1531825797-14236-1-git-send-email-diana.craciun@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

NXP Book3E platforms are not vulnerable to speculative store
bypass, so make the mitigations PPC_BOOK3S_64 specific.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
---
History:

v2-->v3
- new

 arch/powerpc/kernel/security.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 2ebfc5b..3a4e5c3 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -169,6 +169,7 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, c
 	return s.len;
 }
 
+#ifdef CONFIG_PPC_BOOK3S_64
 /*
  * Store-forwarding barrier support.
  */
@@ -316,3 +317,5 @@ static __init int stf_barrier_debugfs_init(void)
 }
 device_initcall(stf_barrier_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */
+#endif /* CONFIG_PPC_BOOK3S_64 */
+
-- 
2.5.5
