Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (rav-az.mvista.com [65.200.49.157])
	by ozlabs.org (Postfix) with ESMTP id 505F6679F4
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 May 2005 11:27:02 +1000 (EST)
Received: from [10.50.1.144] (rvinson@linuxbox.az.mvista.com [10.50.1.144])
	by zipcode.az.mvista.com (8.9.3/8.9.3) with ESMTP id SAA08292
	for <linuxppc-embedded@ozlabs.org>; Fri, 20 May 2005 18:08:20 -0700
Message-ID: <428E8369.50500@mvista.com>
Date: Fri, 20 May 2005 17:40:09 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [PATCH][PPC32] Fix an Off-By-One Error in arch/ppc/syslib/ipic.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fix an off-by-one error in ipic_init.

There is an off-by-one error in the IPIC code that configures the
external interrupts (Edge or Level Sensitive).

Signed-off-by Randy Vinson <rvinson@mvista.com>

---
commit 0c92b569e09b94a1580cc5bae6efbdd749fec28a
tree 9c1e83adcec1bee0a700888546385444ef5f4000
parent 66e60f92518268f4d2a702a1c4ffbe1caacd6290
author Randy Vinson <rvinson@linuxbox.(none)> Fri, 20 May 2005 15:58:02 -0700
committer Randy Vinson <rvinson@linuxbox.(none)> Fri, 20 May 2005 15:58:02 -0700

arch/ppc/syslib/ipic.c |    2 +-
1 files changed, 1 insertion(+), 1 deletion(-)

Index: arch/ppc/syslib/ipic.c
===================================================================
--- 889a1e2919ac50253be8136a1b0855fde27fcb36/arch/ppc/syslib/ipic.c  (mode:100644)
+++ 9c1e83adcec1bee0a700888546385444ef5f4000/arch/ppc/syslib/ipic.c  (mode:100644)
@@ -479,7 +479,7 @@
    temp = 0;
    for (i = 0 ; i < senses_count ; i++) {
        if ((senses[i] & IRQ_SENSE_MASK) == IRQ_SENSE_EDGE) {
-            temp |= 1 << (16 - i);
+            temp |= 1 << (15 - i);
            if (i != 0)
                irq_desc[i + irq_offset + MPC83xx_IRQ_EXT1 - 1].status = 0;
            else
