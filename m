Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 77CB1DDFAE
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 01:00:32 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9JF0SOk012274
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 11:00:28 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9JF0R3s080918
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 09:00:28 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9JF0RC8014382
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 09:00:27 -0600
Received: from [9.10.86.71] (weaponx.rchland.ibm.com [9.10.86.71])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l9JF0Q0a013852
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 09:00:26 -0600
Message-Id: <20071019145512.494878000@linux.vnet.ibm.com>>
References: <20071019145307.978880000@linux.vnet.ibm.com>>
Date: Fri, 19 Oct 2007 09:53:10 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch 2/4] 4xx: Fix timebase clock selection on Walnut
In-Reply-To: <20071019145307.978880000@linux.vnet.ibm.com>>
Content-Type: text/plain
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current bootwrapper fails to set the timebase clock to the CPU clock
which causes the time to increment incorrectly.  This fixes it by using the
correct #define for the CPC0_CR1 register.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/boot/treeboot-walnut.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.orig/arch/powerpc/boot/treeboot-walnut.c
+++ linux-2.6/arch/powerpc/boot/treeboot-walnut.c
@@ -57,8 +57,8 @@ void ibm405gp_fixup_clocks(unsigned int 
 	}
 
 	/* setup the timebase clock to tick at the cpu frequency */
-	cpc0_cr1 = cpc0_cr1 & ~ 0x00800000;
-	mtdcr(DCRN_CPC0_CR1, cpc0_cr1);
+	cpc0_cr1 = cpc0_cr1 & ~0x00800000;
+	mtdcr(DCRN_405_CPC0_CR1, cpc0_cr1);
 	tb = cpu;
 
 	dt_fixup_cpu_clocks(cpu, tb, 0);

-- 
