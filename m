Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0G85226fzDvXm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 04:31:49 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9KHSuE5111274
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 13:31:47 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 266y50ce0c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 13:31:47 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Fri, 21 Oct 2016 03:31:44 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CD9FE3578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 04:31:41 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9KHVfIm52822036
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 04:31:41 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9KHVeIT004972
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 04:31:41 +1100
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
 will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com,
 pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com,
 borntraeger@de.ibm.com, rkrcmar@redhat.com,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v5 7/9] x86, xen: support vcpu preempted check
Date: Thu, 20 Oct 2016 17:27:52 -0400
In-Reply-To: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Message-Id: <1476998874-2089-8-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Juergen Gross <jgross@suse.com>

Support the vcpu_is_preempted() functionality under Xen. This will
enhance lock performance on overcommitted hosts (more runnable vcpus
than physical cpus in the system) as doing busy waits for preempted
vcpus will hurt system performance far worse than early yielding.

A quick test (4 vcpus on 1 physical cpu doing a parallel build job
with "make -j 8") reduced system time by about 5% with this patch.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/x86/xen/spinlock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 3d6e006..74756bb 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -114,7 +114,6 @@ void xen_uninit_lock_cpu(int cpu)
 	per_cpu(irq_name, cpu) = NULL;
 }
 
-
 /*
  * Our init of PV spinlocks is split in two init functions due to us
  * using paravirt patching and jump labels patching and having to do
@@ -137,6 +136,8 @@ void __init xen_init_spinlocks(void)
 	pv_lock_ops.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
 	pv_lock_ops.wait = xen_qlock_wait;
 	pv_lock_ops.kick = xen_qlock_kick;
+
+	pv_lock_ops.vcpu_is_preempted = xen_vcpu_stolen;
 }
 
 /*
-- 
2.4.11
