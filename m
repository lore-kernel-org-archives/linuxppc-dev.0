Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D4A822C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 23:27:28 +1000 (EST)
Received: from mail171-tx2 (localhost [127.0.0.1])	by
 mail171-tx2-R.bigfish.com (Postfix) with ESMTP id 473C13202DF	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 13:27:24 +0000 (UTC)
Received: from TX2EHSMHS029.bigfish.com (unknown [10.9.14.241])	by
 mail171-tx2.bigfish.com (Postfix) with ESMTP id 04413420073	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 13:27:21 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q76DRIPj014464	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Aug 2012 06:27:19 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/6] powerpc/booke64: fix machine check handler to use the
 right prolog
Date: Mon, 6 Aug 2012 16:27:03 +0300
Message-ID: <1344259628-31161-2-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1344259628-31161-1-git-send-email-mihai.caraman@freescale.com>
References: <1344259628-31161-1-git-send-email-mihai.caraman@freescale.com>
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

Machine check exception handler was using a wrong prolog. Hypervisors like
KVM which are called early from the exception handler rely on the interrupt
source.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kernel/exceptions-64e.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 98be7f0..0243b1b 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -297,7 +297,7 @@ interrupt_end_book3e:
 
 /* Machine Check Interrupt */
 	START_EXCEPTION(machine_check);
-	CRIT_EXCEPTION_PROLOG(0x200, PROLOG_ADDITION_NONE)
+	MC_EXCEPTION_PROLOG(0x200, PROLOG_ADDITION_NONE)
 //	EXCEPTION_COMMON(0x200, PACA_EXMC, INTS_DISABLE)
 //	bl	special_reg_save_mc
 //	addi	r3,r1,STACK_FRAME_OVERHEAD
-- 
1.7.4.1
