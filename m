Return-Path: <asolokha@kb.kras.ru>
Received: from ispman.iskranet.ru (ispman.iskranet.ru [62.213.33.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7422D1A0FB0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 20:05:24 +1100 (AEDT)
From: Arseny Solokha <asolokha@kb.kras.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/4] kvm/ppc/mpic: drop unused IRQ_testbit
Date: Tue, 24 Feb 2015 16:05:04 +0700
Message-Id: <1424768706-23150-3-git-send-email-asolokha@kb.kras.ru>
In-Reply-To: <1424768706-23150-1-git-send-email-asolokha@kb.kras.ru>
References: <1424084188-17097-1-git-send-email-asolokha@kb.kras.ru>
 <1424768706-23150-1-git-send-email-asolokha@kb.kras.ru>
Cc: Gleb Natapov <gleb@kernel.org>, linux-kernel@vger.kernel.org,
 Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Scott Wood <scottwood@freescale.com>,
 Arseny Solokha <asolokha@kb.kras.ru>, linuxppc-dev@lists.ozlabs.org
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
from the OpenPIC implementation borrowed from the kernel.

[1] https://lists.gnu.org/archive/html/qemu-devel/2014-06/msg01812.html

Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>
Cc: Alexander Graf <agraf@suse.de>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
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
2.3.0
