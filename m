Return-Path: <hofrat@osadl.org>
Received: from www.osadl.org (www.osadl.org [62.245.132.105])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41K1hV23yKzF1BP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2018 19:11:21 +1000 (AEST)
From: Nicholas Mc Guire <hofrat@osadl.org>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] powerpc: hwrng; fix missing of_node_put()
Date: Mon,  2 Jul 2018 11:08:16 +0200
Message-Id: <1530522496-14816-1-git-send-email-hofrat@osadl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 The call to of_find_compatible_node() returns a node pointer with refcount
incremented thus it must be explicitly decremented here before returning.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit a489043f4626 ("powerpc/pseries: Implement arch_get_random_long() based on H_RANDOM")
---
Problem found with experimental coccinelle script

Patch was compiletested with: ppc64_defconfig (implies CONFIG_PPC_PSERIES=y)
with some unrelated sparse warnings (which I did not understand)
./arch/powerpc/include/asm/head-64.h:13:36: warning: Unknown escape '('
./arch/powerpc/include/asm/head-64.h:16:36: warning: Unknown escape '('
./arch/powerpc/include/asm/head-64.h:19:36: warning: Unknown escape '('

Patch is aginst 4.18-rc2 (localversion-next is next-20180702)

 arch/powerpc/platforms/pseries/rng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/rng.c b/arch/powerpc/platforms/pseries/rng.c
index 31ca557..262b8c5 100644
--- a/arch/powerpc/platforms/pseries/rng.c
+++ b/arch/powerpc/platforms/pseries/rng.c
@@ -40,6 +40,7 @@ static __init int rng_init(void)
 
 	ppc_md.get_random_seed = pseries_get_random_long;
 
+	of_node_put(dn);
 	return 0;
 }
 machine_subsys_initcall(pseries, rng_init);
-- 
2.1.4
