Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 829431A2AF2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 03:58:42 +1100 (AEDT)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D8D8014016B
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2015 03:58:41 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 23 Mar 2015 22:28:39 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 73C3AE004C
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2015 22:30:46 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2NGwYJe27263046
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2015 22:28:34 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2NGwXnH023004
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2015 22:28:34 +0530
Subject: [RESEND PATCH v2] powerpc/book3s: Fix the MCE code to use
 CONFIG_KVM_BOOK3S_64_HANDLER
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 23 Mar 2015 22:28:33 +0530
Message-ID: <20150323165820.18559.56145.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>,
 KVM-PPC <kvm-ppc@vger.kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 stable@vger.kernel.org#v3.14+, David Gibson <dgibson@redhat.com>,
 stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

commit id 2ba9f0d changed CONFIG_KVM_BOOK3S_64_HV to tristate to allow
HV/PR bits to be built as modules. But the MCE code still depends on
CONFIG_KVM_BOOK3S_64_HV which is wrong. When user selects
CONFIG_KVM_BOOK3S_64_HV=m to build HV/PR bits as a separate module the
relevant MCE code gets excluded.

This patch fixes the MCE code to use CONFIG_KVM_BOOK3S_64_HANDLER. This
makes sure that the relevant MCE code is included when HV/PR bits
are built as a separate modules.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Acked-by: Paul Mackerras <paulus@samba.org>
Cc: stable@vger.kernel.org  # v3.14+
---
 arch/powerpc/kernel/exceptions-64s.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index c2df815..9519e6b 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1408,7 +1408,7 @@ machine_check_handle_early:
 	bne	9f			/* continue in V mode if we are. */
 
 5:
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 	/*
 	 * We are coming from kernel context. Check if we are coming from
 	 * guest. if yes, then we can continue. We will fall through
