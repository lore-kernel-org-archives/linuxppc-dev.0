Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cl2z1rXRzF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 09:06:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org,
	diana.craciun@nxp.com
Cc: oss@buserror.net,
	leoyang.li@nxp.com,
	bharat.bhushan@nxp.com
Subject: [PATCH v5 2/8] powerpc/64: Make stf barrier PPC_BOOK3S_64 specific.
Date: Sat, 28 Jul 2018 09:06:33 +1000
Message-Id: <20180727230639.25413-3-mpe@ellerman.id.au>
In-Reply-To: <20180727230639.25413-1-mpe@ellerman.id.au>
References: <20180727230639.25413-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Diana Craciun <diana.craciun@nxp.com>

NXP Book3E platforms are not vulnerable to speculative store
bypass, so make the mitigations PPC_BOOK3S_64 specific.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/security.c | 3 +++
 1 file changed, 3 insertions(+)

v5: No change.

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 79f9397998ed..77f253a6f8c9 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -176,6 +176,7 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, c
 	return s.len;
 }
 
+#ifdef CONFIG_PPC_BOOK3S_64
 /*
  * Store-forwarding barrier support.
  */
@@ -323,3 +324,5 @@ static __init int stf_barrier_debugfs_init(void)
 }
 device_initcall(stf_barrier_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */
+#endif /* CONFIG_PPC_BOOK3S_64 */
+
-- 
2.14.1
