Return-Path: <arun@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8F700B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 21:07:32 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id n7QB4wiW014464
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2009 21:04:58 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7QB7T1M1122370
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2009 21:07:30 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7QB7Sjd001509
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2009 21:07:29 +1000
Date: Wed, 26 Aug 2009 16:37:21 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Joel Schopp <jschopp@austin.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>,
	Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Balbir Singh <balbir@linux.vnet.ibm.com>,
	Gautham R Shenoy <ego@in.ibm.com>,
	Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [v2 PATCH 0/2]: cpuidle: Introducing cpuidle infrastructure to POWER
Message-ID: <20090826110721.GA29759@linux.vnet.ibm.com>
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



"Cpuidle" is a CPU Power Management infrastrusture which helps manage
idle CPUs in a clean and efficient manner. The architecture can register
its driver (in this case, pseries_idle driver) so that it subscribes for
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
pseries processor idle driver called pseries_idle_driver in
arch/powerpc/platform/pseries/processor_idle.c, which implements the
idle loop which would replace the pseries_dedicated_idle_sleep()
when cpuidle is enabled.

Experiment conducted:
----------------------

The following experiment was conducted on a completely idle JS22 blade,
to prove that using cpuidle infrastructure, the amount of nap time increases.

Nap and snooze times were sampled for all the cpus.
For a window of 1000 samples, When cpuidle was enabled,
the total nap time was of the order of a few seconds (5-10s), whereas
the total snooze time was of the order of a few milliseconds(10-30 ms).

When cpuidle infrastructure was disabled and the regular
pseries_dedicated_idle_sleep() idle loop was used, the snooze time itself
was of the order of hundreds of milliseconds. (100 - 500 ms).
This is clearly due to unnecessary snoozing before napping even on a
completely idle system.


The previous post in this area can be found at
http://lkml.org/lkml/2009/8/19/150

Changes from the previous version:
----------------------------------

Earlier I used the the name TPMD (Thermal and Power Management Devices)
to refer to this module which hooks on to the cpuidle infrastructure.
I have renamed this to Pseries Processor Idle, in order to avoid confusion.


Patches included in this set:
------------------------------
PATCH 1/2 - Enable cpuidle for pSeries.
PATCH 2/2 - Implement Pseries Processor Idle idle module


Any feedback on the overall design and idea is immensely valuable.

--arun
