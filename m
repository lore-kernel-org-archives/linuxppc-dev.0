Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 853DEDE0A8
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 00:15:43 +1000 (EST)
Date: Fri, 23 May 2008 18:15:41 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] [POWERPC] mpic: fix ambiguous else statement
Message-ID: <20080523141541.GA16217@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes following warning introduced by
commit 475ca391b490a683d66bf19999a8a7a24913f139 (mpic: Deal with bogus NIRQ
in Feature Reporting Register):

  CC      arch/powerpc/sysdev/mpic.o
arch/powerpc/sysdev/mpic.c: In function ‘mpic_alloc’:
arch/powerpc/sysdev/mpic.c:1146: warning: suggest explicit braces to avoid ambiguous ‘else’

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/mpic.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index f99f81a..a281341 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1143,13 +1143,14 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	greg_feature = mpic_read(mpic->gregs, MPIC_INFO(GREG_FEATURE_0));
 	mpic->num_cpus = ((greg_feature & MPIC_GREG_FEATURE_LAST_CPU_MASK)
 			  >> MPIC_GREG_FEATURE_LAST_CPU_SHIFT) + 1;
-	if (isu_size == 0)
+	if (isu_size == 0) {
 		if (flags & MPIC_BROKEN_FRR_NIRQS)
 			mpic->num_sources = mpic->irq_count;
 		else
 			mpic->num_sources =
 				((greg_feature & MPIC_GREG_FEATURE_LAST_SRC_MASK)
 				 >> MPIC_GREG_FEATURE_LAST_SRC_SHIFT) + 1;
+	}
 
 	/* Map the per-CPU registers */
 	for (i = 0; i < mpic->num_cpus; i++) {
-- 
1.5.5.1
