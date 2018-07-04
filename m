Return-Path: <hofrat@osadl.org>
Received: from www.osadl.org (www.osadl.org [62.245.132.105])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LD8k0Dx9zF1S9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 18:06:29 +1000 (AEST)
From: Nicholas Mc Guire <hofrat@osadl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] powerpc: icp-hv: fix missing of_node_put in success path
Date: Wed,  4 Jul 2018 10:03:27 +0200
Message-Id: <1530691407-3991-1-git-send-email-hofrat@osadl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 Both of_find_compatible_node() and of_find_node_by_type() will
return a refcounted node on success - thus for the success path
the node must be explicitly released with a of_node_put().

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit 0b05ac6e2480 ("powerpc/xics: Rewrite XICS driver")
---
Problem found by experimental coccinelle script

Patch was compiletested with: ppc64_defconfig (implies
CONFIG_PPC_ICP_HV=y)
with sparse warnings though not related to the proposed change

Patch is against 4.18-rc3 (localversion-next is next-20180704)

 arch/powerpc/sysdev/xics/icp-hv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/xics/icp-hv.c b/arch/powerpc/sysdev/xics/icp-hv.c
index bbc839a..003deaa 100644
--- a/arch/powerpc/sysdev/xics/icp-hv.c
+++ b/arch/powerpc/sysdev/xics/icp-hv.c
@@ -179,6 +179,7 @@ int icp_hv_init(void)
 
 	icp_ops = &icp_hv_ops;
 
+	of_node_put(np);
 	return 0;
 }
 
-- 
2.1.4
