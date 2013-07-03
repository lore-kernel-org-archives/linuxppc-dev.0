Return-Path: <B02008@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B3A472C03FF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 23:31:08 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 1/2] KVM: PPC: Fix kvm_exit_names array
Date: Wed, 3 Jul 2013 16:30:54 +0300
Message-ID: <1372858255-19708-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some exit ids where left out from kvm_exit_names array.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/timing.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/timing.c b/arch/powerpc/kvm/timing.c
index 07b6110..c392d26 100644
--- a/arch/powerpc/kvm/timing.c
+++ b/arch/powerpc/kvm/timing.c
@@ -135,7 +135,9 @@ static const char *kvm_exit_names[__NUMBER_OF_KVM_EXIT_TYPES] = {
 	[USR_PR_INST] =             "USR_PR_INST",
 	[FP_UNAVAIL] =              "FP_UNAVAIL",
 	[DEBUG_EXITS] =             "DEBUG",
-	[TIMEINGUEST] =             "TIMEINGUEST"
+	[TIMEINGUEST] =             "TIMEINGUEST",
+	[DBELL_EXITS] =             "DBELL",
+	[GDBELL_EXITS] =            "GDBELL"
 };
 
 static int kvmppc_exit_timing_show(struct seq_file *m, void *private)
-- 
1.7.3.4
