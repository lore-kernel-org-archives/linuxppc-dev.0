Return-Path: <matvejchikov@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id F41F6DDEFC
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Jul 2007 15:51:11 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so4534591pyi
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 03 Jul 2007 22:51:09 -0700 (PDT)
Message-ID: <8496f91a0707032251m6fea386cu2405899d2945fd07@mail.gmail.com>
Date: Wed, 4 Jul 2007 09:51:09 +0400
From: "Matvejchikov Ilya" <matvejchikov@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Too many spurious interrupts on mpc82xx with linux-2.4.35.5
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: matvejchikov@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all!

If you still have this problem, try this patch. It helps :)

Signed-off-by : Matvejchikov Ilya <matvejchikov@gmail.com>
---
diff -purN linux-2.4.34.5-vanilla/arch/ppc/kernel/cpm2_pic.c
linux-2.4.34.5/arch/ppc/kernel/cpm2_pic.c
--- linux-2.4.34.5-vanilla/arch/ppc/kernel/cpm2_pic.c	2007-06-06
23:20:53.000000000 +0400
+++ linux-2.4.34.5/arch/ppc/kernel/cpm2_pic.c	2007-06-28
12:17:42.000000000 +0400
@@ -79,6 +79,12 @@ static void cpm2_mask_and_ack(unsigned i
 	ppc_cached_irq_mask[word] &= ~(1 << (31 - bit));
 	simr[word] = ppc_cached_irq_mask[word];
 	sipnr[word] = 1 << (31 - bit);
+
+	/*
+	 * Work around large numbers of spurious IRQs on PowerPC 82xx
+	 * systems.
+	 */
+	mb();
 }

 static void cpm2_end_irq(unsigned int irq_nr)
