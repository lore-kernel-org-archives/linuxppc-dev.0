Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D8C51A1834
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 14:16:26 +1100 (AEDT)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EADD014031E
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2016 14:16:25 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 14 Jan 2016 13:16:24 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C28082CE8054
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2016 14:16:19 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0E3G1d722478926
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2016 14:16:10 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0E3FkR8018606
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2016 14:15:47 +1100
Subject: [PATCH 3/3] KVM: PPC: Book3S HV: Fix soft lockups in KVM on HMI for
 time base errors
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: KVM-PPC <kvm-ppc@vger.kernel.org>, KVM <kvm@vger.kernel.org>
Date: Thu, 14 Jan 2016 08:45:28 +0530
Message-ID: <20160114031528.1287.7326.stgit@mars>
In-Reply-To: <20160114031457.1287.32132.stgit@mars>
References: <20160114031457.1287.32132.stgit@mars>
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

When secondaries are napping in kvm_unsplit_nap() with hwthread_req = 1,
the HMI goes ignored even though subcores are already exited the guest.
Hence HMI keeps waking up secondaries from nap in a loop and secondaries
always go back to nap since no vcore is assigned to them. This makes
impossible for primary thread to get hold of secondary threads resulting
into a soft lockup in KVM path.

This patch fixes this by adding a HMI check just before the thread goes
to unsplit nap.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index e8a456e..c5d43b9 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -440,6 +440,12 @@ kvm_no_guest:
  * whole-core mode, so we need to nap.
  */
 kvm_unsplit_nap:
+	/* Before we head down to nap, check if HMI is pending and handle it */
+	cmpwi	r12, BOOK3S_INTERRUPT_HMI
+	bne	55f
+	li	r3, 0			/* NULL argument */
+	bl	hmi_exception_realmode
+55:
 	/*
 	 * Ensure that secondary doesn't nap when it has
 	 * its vcore pointer set.
