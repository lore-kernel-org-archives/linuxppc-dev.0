Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9C8B4140146
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2014 20:36:07 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 11 Apr 2014 04:36:04 -0600
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 9DCE3C90042
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2014 06:35:57 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3BAa14Q63635492
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2014 10:36:01 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3BAa1Gk002158
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2014 06:36:01 -0400
Subject: [PATCH 2/3] ppc/kvm: Set the runlatch bit of a CPU just before
 starting guest
To: linuxppc-dev@ozlabs.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Fri, 11 Apr 2014 16:01:58 +0530
Message-ID: <20140411103157.27683.79563.stgit@preeti.in.ibm.com>
In-Reply-To: <20140411103030.27683.2107.stgit@preeti.in.ibm.com>
References: <20140411103030.27683.2107.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: paulus@samba.org, linux-kernel@vger.kernel.org,
 srivatsa.bhat@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The secondary threads in the core are kept offline before launching guests
in kvm on powerpc: "371fefd6f2dc4666:KVM: PPC: Allow book3s_hv guests to use
SMT processor modes."

Hence their runlatch bits are cleared. When the secondary threads are called
in to start a guest, their runlatch bits need to be set to indicate that they
are busy. The primary thread has its runlatch bit set though, but there is no
harm in setting this bit once again. Hence set the runlatch bit for all
threads before they start guest.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Acked-by: Paul Mackerras <paulus@samba.org>
Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/powerpc/kvm/book3s_hv_rmhandlers.S |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index ffbb871..b254075 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -242,6 +242,12 @@ kvm_novcpu_exit:
  */
 	.globl	kvm_start_guest
 kvm_start_guest:
+
+	/* Set runlatch bit the minute you wake up from nap */
+	mfspr	r1, SPRN_CTRLF
+	ori 	r1, r1, 1
+	mtspr	SPRN_CTRLT, r1
+
 	ld	r2,PACATOC(r13)
 
 	li	r0,KVM_HWTHREAD_IN_KVM
