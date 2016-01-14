Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D41A1A0C9A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 14:15:04 +1100 (AEDT)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C6841140180
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2016 14:15:03 +1100 (AEDT)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 14 Jan 2016 08:45:01 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0E3ExWx12059126
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2016 08:44:59 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0E3Ewid032397
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2016 08:44:59 +0530
Subject: [PATCH 1/3] Powernv: Remove the usage of PACAR1 from opal wrappers
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: KVM-PPC <kvm-ppc@vger.kernel.org>, KVM <kvm@vger.kernel.org>
Date: Thu, 14 Jan 2016 08:44:58 +0530
Message-ID: <20160114031457.1287.32132.stgit@mars>
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
---
 arch/powerpc/platforms/powernv/opal-wrappers.S |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index b7a464f..62fe496 100644
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
