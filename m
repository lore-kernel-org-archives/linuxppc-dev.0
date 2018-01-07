Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zDtB30J4wzF0RX
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Jan 2018 20:18:34 +1100 (AEDT)
To: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] KVM: PPC: Use seq_puts() in kvmppc_exit_timing_show()
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <6f07cc84-cd86-8e48-5da2-edb86f466243@users.sourceforge.net>
Date: Sun, 7 Jan 2018 10:18:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 7 Jan 2018 10:07:36 +0100

A headline should be quickly put into a sequence. Thus use the
function "seq_puts" instead of "seq_printf" for this purpose.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/kvm/timing.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/timing.c b/arch/powerpc/kvm/timing.c
index e44d2b2ea97e..1c03c978eb18 100644
--- a/arch/powerpc/kvm/timing.c
+++ b/arch/powerpc/kvm/timing.c
@@ -143,8 +143,7 @@ static int kvmppc_exit_timing_show(struct seq_file *m, void *private)
 	int i;
 	u64 min, max, sum, sum_quad;
 
-	seq_printf(m, "%s", "type	count	min	max	sum	sum_squared\n");
-
+	seq_puts(m, "type	count	min	max	sum	sum_squared\n");
 
 	for (i = 0; i < __NUMBER_OF_KVM_EXIT_TYPES; i++) {
 
-- 
2.15.1
