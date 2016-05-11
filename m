Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4JDD3Xf5zDqM1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 11:18:52 +1000 (AEST)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 11 May 2016 11:18:51 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 18B092CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 11:18:38 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4B1I5aQ11600024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 11:18:27 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4B1GuEW019479
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 11:16:56 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, warrier@linux.vnet.ibm.com, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/kvm: Fix build error on book3s_hv.c
Date: Wed, 11 May 2016 11:15:55 +1000
Message-Id: <1462929355-30681-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When CONFIG_KVM_XICS is enabled, CPU_UP_PREPARE and other macros for
CPU states in linux/cpu.h are needed by arch/powerpc/kvm/book3s_hv.c.
Otherwise, build error as below is seen:

   gwshan@gwshan:~/sandbox/l$ make arch/powerpc/kvm/book3s_hv.o
    :
   CC      arch/powerpc/kvm/book3s_hv.o
   arch/powerpc/kvm/book3s_hv.c: In function ‘kvmppc_cpu_notify’:
   arch/powerpc/kvm/book3s_hv.c:3072:7: error: ‘CPU_UP_PREPARE’ \
   undeclared (first use in this function)

This fixes the issue introduced by commit <6f3bb80944> ("KVM: PPC:
Book3S HV: kvmppc_host_rm_ops - handle offlining CPUs").

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 4cd37b4..e20beae 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -27,6 +27,7 @@
 #include <linux/export.h>
 #include <linux/fs.h>
 #include <linux/anon_inodes.h>
+#include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/spinlock.h>
 #include <linux/page-flags.h>
-- 
2.1.0
