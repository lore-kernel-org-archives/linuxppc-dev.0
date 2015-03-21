Return-Path: <asolokha@kb.kras.ru>
Received: from ispman.iskranet.ru (ispman.iskranet.ru [62.213.33.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 678731A02EE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 17:56:54 +1100 (AEDT)
From: Arseny Solokha <asolokha@kb.kras.ru>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH v4 2/4] kvm/ppc/mpic: drop unused IRQ_testbit
Date: Sat, 21 Mar 2015 13:56:44 +0700
Message-Id: <1426921004-27685-1-git-send-email-asolokha@kb.kras.ru>
In-Reply-To: <550C0760.50903@suse.de>
References: <550C0760.50903@suse.de>
Cc: Arseny Solokha <asolokha@kb.kras.ru>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Drop unused static procedure which doesn't have callers within its
translation unit. It had been already removed independently in QEMU[1]
from the OpenPIC implementation borrowed by the kernel.

[1] https://lists.gnu.org/archive/html/qemu-devel/2014-06/msg01812.html

v4: Fixed the comment regarding the origination of OpenPIC codebase
    and CC'ed KVM mailing lists, as suggested by Alexander Graf.

v3: In patch 4/4, do not remove fsl_mpic_primary_get_version() from
    arch/powerpc/sysdev/mpic.c because the patch by Jia Hongtao
    ("powerpc/85xx: workaround for chips with MSI hardware errata") makes
    use of it.

v2: Added a brief explanation to each patch description of why removed
    functions are unused, as suggested by Michael Ellerman.

Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>
---
 arch/powerpc/kvm/mpic.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/kvm/mpic.c b/arch/powerpc/kvm/mpic.c
index 39b3a8f..a480d99 100644
--- a/arch/powerpc/kvm/mpic.c
+++ b/arch/powerpc/kvm/mpic.c
@@ -289,11 +289,6 @@ static inline void IRQ_resetbit(struct irq_queue *q, int n_IRQ)
 	clear_bit(n_IRQ, q->queue);
 }
 
-static inline int IRQ_testbit(struct irq_queue *q, int n_IRQ)
-{
-	return test_bit(n_IRQ, q->queue);
-}
-
 static void IRQ_check(struct openpic *opp, struct irq_queue *q)
 {
 	int irq = -1;
-- 
2.3.3
