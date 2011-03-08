Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AACF0B6EF7
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2011 17:37:40 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p286beUN009438
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:40 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p286bd4T2355210
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:39 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p286bddA026827
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:39 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 17/18] powerpc/smp: Increase vdso_data->processorCount,
	not just decrease it
Date: Tue,  8 Mar 2011 17:37:29 +1100
Message-Id: <1299566250-10516-18-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
References: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/smp.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index e337073..6023395 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -551,6 +551,10 @@ void __devinit start_secondary(void *unused)
 
 	secondary_cpu_time_init();
 
+#ifdef CONFIG_PPC64
+	if (system_state == SYSTEM_RUNNING)
+		vdso_data->processorCount++;
+#endif
 	ipi_call_lock();
 	notify_cpu_starting(cpu);
 	set_cpu_online(cpu, true);
-- 
1.7.1
