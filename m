Return-Path: <arun@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DE5B5B70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 22:57:29 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id n7JCrf0m023076
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2009 22:53:41 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7JCvPuM287046
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2009 22:57:25 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7JCvOHU003729
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2009 22:57:25 +1000
Date: Wed, 19 Aug 2009 18:27:16 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Joel Schopp <jschopp@austin.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Shaohua Li <shaohua.li@intel.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Adam Belay <abelay@novell.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>,
	Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
	Gautham R Shenoy <ego@in.ibm.com>,
	Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [PATCH 0/2]: cpuidle: Introducing cpuidle infrastructure to powerpc.
Message-ID: <20090819125716.GA20627@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: arun@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,


**** RFC not for inclusion ****

"Cpuidle" is a CPU Power Management infrastrusture which helps manage
idle CPUs in a clean and efficient manner. The architecture can register
its driver (in this case, tpmd_idle driver) so that it subscribes for
cpuidle feature. Cpuidle has a set of governors (ladder and menu),
which will decide the best idle state to be chosen for the current situation,
based on heuristics, and calculates the expected residency time
for the current idle state. So based on this, the cpu is put into
the right idle state.

Currently, cpuidle infrasture is exploited by ACPI to choose between
the available ACPI C-states. This patch-set is aimed at enabling
cpuidle for powerpc and provides a sample implementation for pseries.

Currently, in the pseries_dedicated_idle_sleep(), the processor would
poll for a time period, which is called the snooze, and only then it
is ceded, which would put the processor in nap state. Cpuidle aims at
separating this into 2 different idle states. Based on the expected
residency time predicted by the cpuidle governor, the idle state is
chosen directly. So, choosing to enter the nap state directly based on
the decision made by cpuidle would avoid unnecessary snoozing before
entering nap.

This patch-set tries to achieve the above objective by introducing a
Thermal and Power Management Device module called tpmd_idle in
arch/powerpc/platform/pseries/tpmd_idle.c, which implements cpuidle
idle loop which would replace the pseries_dedicated_idle_sleep()
when cpuidle is enabled.

Patches included in this set:
PATCH 1/2 - Enable cpuidle for pSeries.
PATCH 2/2 - Implement Thermal & Power Management Devices(TPMD) idle module


Any feedback on the overall design and idea is immensely valuable.

--arun
