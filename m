Return-Path: <srs0=6vp1=a3=au1.ibm.com=sam.bobroff@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y1Wj21wnpzDsPN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 16:47:17 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3y1Wj034w2z8t08
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 16:47:16 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3y1Whz4jYQz9tXD
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2017 16:47:14 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8Q6iAfn113621
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2017 02:47:12 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d7e53vdwr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2017 02:47:11 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Tue, 26 Sep 2017 16:47:08 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8Q6l5m843516144
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2017 16:47:05 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8Q6l8Rk002548
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2017 16:47:08 +1000
Date: Tue, 26 Sep 2017 16:47:04 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org, paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH 1/1] KVM: PPC: Book3S: Fix server always zero from
 kvmppc_xive_get_xive()
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <4585437e86d14900985c7e16bfd4afef672b26c7.1506408341.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In KVM's XICS-on-XIVE emulation, kvmppc_xive_get_xive() returns the
value of state->guest_server as "server". However, this value is not
set by it's counterpart kvmppc_xive_set_xive(). When the guest uses
this interface to migrate interrupts away from a CPU that is going
offline, it sees all interrupts as belonging to CPU 0, so they are
left assigned to (now) offline CPUs.

This patch removes the guest_server field from the state, and returns
act_server in it's place (that is, the CPU actually handling the
interrupt, which may differ from the one requested).

Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE
interrupt controller")
Cc: stable@vger.kernel.org
Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
The other obvious way to patch this would be to set state->guest_server in
kvmppc_xive_set_xive() and that does also work because act_server is usually
equal to guest_server.

However, in the cases where guest_server differed from act_server, the guest
would only move IRQs correctly if it got act_server (the CPU actually handling
the interrupt) here. So, that approach seemed better.

 arch/powerpc/kvm/book3s_xive.c | 5 ++---
 arch/powerpc/kvm/book3s_xive.h | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 13304622ab1c..bf457843e032 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -622,7 +622,7 @@ int kvmppc_xive_get_xive(struct kvm *kvm, u32 irq, u32 *server,
 		return -EINVAL;
 	state = &sb->irq_state[idx];
 	arch_spin_lock(&sb->lock);
-	*server = state->guest_server;
+	*server = state->act_server;
 	*priority = state->guest_priority;
 	arch_spin_unlock(&sb->lock);
 
@@ -1331,7 +1331,7 @@ static int xive_get_source(struct kvmppc_xive *xive, long irq, u64 addr)
 	xive->saved_src_count++;
 
 	/* Convert saved state into something compatible with xics */
-	val = state->guest_server;
+	val = state->act_server;
 	prio = state->saved_scan_prio;
 
 	if (prio == MASKED) {
@@ -1507,7 +1507,6 @@ static int xive_set_source(struct kvmppc_xive *xive, long irq, u64 addr)
 	/* First convert prio and mark interrupt as untargetted */
 	act_prio = xive_prio_from_guest(guest_prio);
 	state->act_priority = MASKED;
-	state->guest_server = server;
 
 	/*
 	 * We need to drop the lock due to the mutex below. Hopefully
diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
index 5938f7644dc1..6ba63f8e8a61 100644
--- a/arch/powerpc/kvm/book3s_xive.h
+++ b/arch/powerpc/kvm/book3s_xive.h
@@ -35,7 +35,6 @@ struct kvmppc_xive_irq_state {
 	struct xive_irq_data *pt_data;	/* XIVE Pass-through associated data */
 
 	/* Targetting as set by guest */
-	u32 guest_server;		/* Current guest selected target */
 	u8 guest_priority;		/* Guest set priority */
 	u8 saved_priority;		/* Saved priority when masking */
 
-- 
2.14.1.4.g334a7be4f
