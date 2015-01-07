Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 812491A0BA8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 15:43:15 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4D864140082
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2015 15:43:13 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 7 Jan 2015 14:43:12 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7A0742BB003F
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2015 15:43:10 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t074h9KI43909370
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2015 15:43:10 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t074h8wX004161
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2015 15:43:09 +1100
Subject: [PATCH] powerpc/book3s: Fix the MCE code to use
 CONFIG_KVM_BOOK3S_HV_POSSIBLE
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 07 Jan 2015 10:13:07 +0530
Message-ID: <20150107044237.5803.85825.stgit@mars.in.ibm.com>
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

commit id 9975f5e added new config variable CONFIG_KVM_BOOK3S_HV_POSSIBLE
that helps to select the relevant code in the kernel when HV and PR
bits are built as separate modules. As part of that commit, all the
instances of #ifdef CONFIG_KVM_BOOK3S_64_HV was replaced with
CONFIG_KVM_BOOK3S_HV_POSSIBLE. But the MCE code still depends on
CONFIG_KVM_BOOK3S_64_HV which is wrong. When HV bits are built as a
separate module the relevent MCE code gets excluded. This patch fixes
the MCE code to use CONFIG_KVM_BOOK3S_HV_POSSIBLE.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/exceptions-64s.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index c2df815..7335857 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1408,7 +1408,7 @@ machine_check_handle_early:
 	bne	9f			/* continue in V mode if we are. */
 
 5:
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	/*
 	 * We are coming from kernel context. Check if we are coming from
 	 * guest. if yes, then we can continue. We will fall through
