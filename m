Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wMgbX5wrczDqKS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 May 2017 23:44:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH 2/3] powerpc: Don't print cpu_spec->cpu_name if it's NULL
Date: Tue,  9 May 2017 23:44:31 +1000
Message-Id: <1494337472-23419-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1494337472-23419-1-git-send-email-mpe@ellerman.id.au>
References: <1494337472-23419-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

Currently we assume that if the cpu_spec has a pvr_mask then it must also have a
cpu_name. But that will change in a subsequent commit when we do CPU feature
discovery via the device tree, so check explicitly if cpu_name is NULL.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/setup-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 5c10b5925ac2..b57df7fc9e5f 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -256,7 +256,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, "processor\t: %lu\n", cpu_id);
 	seq_printf(m, "cpu\t\t: ");
 
-	if (cur_cpu_spec->pvr_mask)
+	if (cur_cpu_spec->pvr_mask && cur_cpu_spec->cpu_name)
 		seq_printf(m, "%s", cur_cpu_spec->cpu_name);
 	else
 		seq_printf(m, "unknown (%08x)", pvr);
-- 
2.7.4
