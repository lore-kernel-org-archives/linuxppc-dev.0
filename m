Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r6qx26Bs7zDq8V
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 May 2016 14:14:30 +1000 (AEST)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r6qx15t0nz9t5c
 for <linuxppc-dev@ozlabs.org>; Sun, 15 May 2016 14:14:29 +1000 (AEST)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Sun, 15 May 2016 09:44:27 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6E932E0040
 for <linuxppc-dev@ozlabs.org>; Sun, 15 May 2016 09:47:32 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4F4ELtf19005776
 for <linuxppc-dev@ozlabs.org>; Sun, 15 May 2016 09:44:21 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4F4ELv9005577
 for <linuxppc-dev@ozlabs.org>; Sun, 15 May 2016 09:44:22 +0530
Subject: [PATCH v2 1/2] Powernv: Remove the usage of PACAR1 from opal wrappers
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: KVM <kvm@vger.kernel.org>, KVM-PPC <kvm-ppc@vger.kernel.org>
Date: Sun, 15 May 2016 09:44:13 +0530
Message-ID: <20160515041413.2280.747.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

OPAL_CALL wrapper code sticks the r1 (stack pointer) into PACAR1 purely
for debugging purpose only. The power7_wakeup* functions relies on stack
pointer saved in PACAR1. Any opal call made using opal wrapper (directly
or in-directly) before we fall through power7_wakeup*, then it ends up
replacing r1 in PACAR1(r13) leading to kernel panic. So far we don't see
any issues because we have never made any opal calls using OPAL wrapper
before power7_wakeup*. But the subsequent HMI patch would need to invoke
C calls during cpu wakeup/idle path that in-directly makes opal call using
opal wrapper. This patch facilitates the subsequent HMI patch by removing
usage of PACAR1 from opal call wrapper.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/opal-wrappers.S |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index e45b88a..df6ad94 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -64,7 +64,6 @@ END_FTR_SECTION(0, 1);						\
 	OPAL_BRANCH(opal_tracepoint_entry) \
 	mfcr	r12;			\
 	stw	r12,8(r1);		\
-	std	r1,PACAR1(r13);		\
 	li	r11,0;			\
 	mfmsr	r12;			\
 	ori	r11,r11,MSR_EE;		\
@@ -127,7 +126,6 @@ opal_tracepoint_entry:
 	mfcr	r12
 	std	r11,16(r1)
 	stw	r12,8(r1)
-	std	r1,PACAR1(r13)
 	li	r11,0
 	mfmsr	r12
 	ori	r11,r11,MSR_EE
