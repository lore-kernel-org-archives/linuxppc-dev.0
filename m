Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A5516B7C33
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Mar 2010 23:58:08 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp03.in.ibm.com (8.14.3/8.13.1) with ESMTP id o21Cw6fQ030577
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Mar 2010 18:28:06 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o21Cw5Sb2924796
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Mar 2010 18:28:06 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o21Cw5rg020211
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Mar 2010 18:28:05 +0530
Subject: [PATCH v2 0/3] powerpc: bug fixes in pseries_mach_cpu_die()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Anton Blanchard <anton@samba.org>
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date: Mon, 01 Mar 2010 18:28:03 +0530
Message-ID: <20100301123519.26066.8639.stgit@drishya.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, Gautham R Shenoy <ego@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

The following set of patches fixes kernel stack reset issue and also
potential race conditions.

This fix should be applied in 2.6.33 stable tree onwards.

Problem description:

(1) Repeated offline/online operation on pseries with extended cede
processor feature will run over the kernel stack and crash since the
stack was not reset on resume from cede processor.

(2) The 'if' conditions and code has been slightly rearranged to avoid
any possible race conditions where preferred_offline_state can change
while the cpu is still executing the condition checks in
pseries_mach_cpu_die().  The new code has the CPU_STATE_OFFLINE as
default and also improved readability.  Thanks to Anton Blanchard for
pointing this out.

(3) There were too many noisy KERN_INFO printks on offline/online
operation.  Removed the printk's for now.  Other debug methods or
traceevents can be introduced at a later point.

The patch has been tested on large POWER machine with both
cede_offline=off case and the default cede_offline=on case.

Please apply in powerpc.git tree and push upstream.

Previous version of the patch can be found at:

[PATCH] powerpc: reset kernel stack on cpu online from cede state
http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-February/080515.html

Thanks,
Vaidy

---

Vaidyanathan Srinivasan (3):
      powerpc: reset kernel stack on cpu online from cede state
      powerpc: move checks in pseries_mach_cpu_die()
      powerpc: reduce printk from pseries_mach_cpu_die()


 arch/powerpc/kernel/head_64.S                   |   11 ++++++
 arch/powerpc/platforms/pseries/hotplug-cpu.c    |   42 ++++++++---------------
 arch/powerpc/platforms/pseries/offline_states.h |    2 +
 3 files changed, 27 insertions(+), 28 deletions(-)
