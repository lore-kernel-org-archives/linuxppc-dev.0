Return-Path: <B02008@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7B6F82C009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 02:56:19 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] KVM: PPC: Book3E: Add LRAT error exception handler
Date: Wed, 3 Jul 2013 19:56:06 +0300
Message-ID: <1372870566-11299-2-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1372870566-11299-1-git-send-email-mihai.caraman@freescale.com>
References: <1372870566-11299-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With LRAT (Logical to Real Address Translation) error exception handler in kernel
KVM needs to add the counterpart otherwise will break the build.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/bookehv_interrupts.S |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index e8ed7d6..a0d6929 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -319,6 +319,8 @@ kvm_handler BOOKE_INTERRUPT_DEBUG, EX_PARAMS(DBG), \
 	SPRN_DSRR0, SPRN_DSRR1, 0
 kvm_handler BOOKE_INTERRUPT_DEBUG, EX_PARAMS(CRIT), \
 	SPRN_CSRR0, SPRN_CSRR1, 0
+kvm_handler BOOKE_INTERRUPT_LRAT_ERROR, EX_PARAMS(GEN), \
+	SPRN_SRR0, SPRN_SRR1, (NEED_EMU | NEED_DEAR | NEED_ESR)
 #else
 /*
  * For input register values, see arch/powerpc/include/asm/kvm_booke_hv_asm.h
-- 
1.7.3.4
