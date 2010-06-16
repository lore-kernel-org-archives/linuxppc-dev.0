Return-Path: <paulmck@paulmck-laptop.linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 25AA11007D2
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jun 2010 10:48:44 +1000 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o5G0lCUR009223
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 20:47:12 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5G0meYA149458
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 20:48:40 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5G0meiQ015115
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 20:48:40 -0400
Received: from paulmck-laptop.localdomain
	(paulmck-laptop-009047022149.beaverton.ibm.com [9.47.22.149])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	o5G0medW015112
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 20:48:40 -0400
Date: Tue, 15 Jun 2010 17:48:39 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH RFC] ppc: fix default_machine_crash_shutdown #ifdef botch
Message-ID: <20100616004839.GA18110@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

crash_kexec_wait_realmode() is defined only if CONFIG_PPC_STD_MMU_64
and CONFIG_SMP, but is called if CONFIG_PPC_STD_MMU_64 even if !CONFIG_SMP.
Fix the conditional compilation around the invocation.

Untested, probably does not compile.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index b46f2e0..29df48f 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -447,7 +447,7 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
 	crash_kexec_prepare_cpus(crashing_cpu);
 	cpu_set(crashing_cpu, cpus_in_crash);
 	crash_kexec_stop_spus();
-#ifdef CONFIG_PPC_STD_MMU_64
+#if defined(CONFIG_PPC_STD_MMU_64) && defined(CONFIG_SMP)
 	crash_kexec_wait_realmode(crashing_cpu);
 #endif
 	if (ppc_md.kexec_cpu_down)
