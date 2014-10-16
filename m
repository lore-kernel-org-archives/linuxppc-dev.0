Return-Path: <kernelfans@gmail.com>
Received: from mail-pd0-x234.google.com (mail-pd0-x234.google.com
 [IPv6:2607:f8b0:400e:c02::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75DA71A0560
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 18:26:23 +1100 (AEDT)
Received: by mail-pd0-f180.google.com with SMTP id fp1so2765225pdb.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Oct 2014 00:26:21 -0700 (PDT)
From: kernelfans@gmail.com
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [RFC 10/11] powerpc: kvm: on_primary_thread() force the secondary
 threads into NAP mode
Date: Thu, 16 Oct 2014 15:29:59 -0400
Message-Id: <1413487800-7162-11-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The primary hwthread ceases the scheduler of secondary hwthread by
bringing them into NAP. Then, the secondary is ready for guest.

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 4348abd..7896c31 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1593,15 +1593,22 @@ static int on_primary_thread(void)
 {
 	int cpu = smp_processor_id();
 	int thr;
+	struct cpumask msk;
 
 	/* Are we on a primary subcore? */
 	if (cpu_thread_in_subcore(cpu))
 		return 0;
 
 	thr = 0;
+#ifdef KVMPPC_ENABLE_SECONDARY
+	while (++thr < threads_per_subcore)
+		cpumask_set_cpu(thr, &msk);
+	stop_cpus_async(&msk, kvmppc_secondary_stopper, NULL);
+#else
 	while (++thr < threads_per_subcore)
 		if (cpu_online(cpu + thr))
 			return 0;
+#endif
 
 	/* Grab all hw threads so they can't go into the kernel */
 	for (thr = 1; thr < threads_per_subcore; ++thr) {
-- 
1.8.3.1
