Return-Path: <ivan@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRLVM1BwVzDqZc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 23:08:10 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4FD46Xt129393
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 09:08:06 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2afb6nwn21-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 09:08:05 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ivan@de.ibm.com>;
 Mon, 15 May 2017 14:08:02 +0100
From: Ivan Mikhaylov <ivan@de.ibm.com>
To: Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@ozlabs.au.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4/4] arch/powerpc/44x/fsp2: wdt tcr update instead of whole
 rewrite
Date: Mon, 15 May 2017 16:07:54 +0300
Message-Id: <20170515130754.59363-5-ivan@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Prevent a kernel panic caused by unintentionally clearing TCR
watchdog bits.  At this point in the kernel boot, the watchdog has
already been enabled by u-boot.  The original code's attempt to
write to the TCR register results in an inadvertent clearing of the
watchdog configuration bits, causing the 476 to reset.
Panic happens in case of error as silently reboot without any outputs
on serial.

Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
---
 arch/powerpc/kernel/time.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 2b33cfa..f75e512 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -738,12 +738,28 @@ static int __init get_freq(char *name, int cells, unsigned long *val)
 
 static void start_cpu_decrementer(void)
 {
+	unsigned int tcr;
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
 	/* Clear any pending timer interrupts */
 	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
 
+#ifdef CONFIG_FSP2
+	/*
+	 * Prevent a kernel panic caused by unintentionally clearing TCR
+	 * watchdog bits.  At this point in the kernel boot, the watchdog has
+	 * already been enabled by u-boot.  The original code's attempt to
+	 * write to the TCR register results in an inadvertent clearing of the
+	 * watchdog configuration bits, causing the 440 to reset.
+	 */
+	tcr = mfspr(SPRN_TCR);
+	tcr &= TCR_WP_MASK; /* clear all bits except for TCR[WP] */
+	tcr |= TCR_DIE; /* enable decrementer */
+	mtspr(SPRN_TCR, tcr);
+#else
 	/* Enable decrementer interrupt */
 	mtspr(SPRN_TCR, TCR_DIE);
+#endif
+
 #endif /* defined(CONFIG_BOOKE) || defined(CONFIG_40x) */
 }
 
-- 
1.7.1
