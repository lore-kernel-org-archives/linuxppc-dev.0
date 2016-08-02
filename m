Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3QNb1fcDzDqTG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 15:53:18 +1000 (AEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id u725r1GN010813
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 00:53:04 -0500
Message-ID: <1470117181.12584.14.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/32: Fix early access to cpu_spec relocation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 02 Aug 2016 15:53:01 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 9402c684613163888714df0955fa1f17142b08bf introduced a subtle bug
on 32-bit. When reading the cpu spec from the global, we not only need
to do a pointer relocation on the global address but also on the pointer
we read from it.

This fixes crashes reported on MPC5200 based machines.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Fixes: 9402c684613163888714df0955fa1f17142b08bf
--
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index defb299..fd36e13 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -154,7 +154,7 @@ static void do_final_fixups(void)
 
 void apply_feature_fixups(void)
 {
-	struct cpu_spec *spec = *PTRRELOC(&cur_cpu_spec);
+	struct cpu_spec *spec = PTRRELOC(*PTRRELOC(&cur_cpu_spec));
 
 	/*
 	 * Apply the CPU-specific and firmware specific fixups to kernel text
