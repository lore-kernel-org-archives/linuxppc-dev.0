Return-Path: <arun@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7A792B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Sep 2009 21:25:41 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id n8MBPd5p006774
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2009 21:25:39 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8MBPdss409818
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2009 21:25:39 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8MBPbET019980
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2009 21:25:39 +1000
Date: Tue, 22 Sep 2009 16:55:27 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Joel Schopp <jschopp@austin.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
	Gautham R Shenoy <ego@in.ibm.com>, Shaohua Li <shaohua.li@intel.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Arun Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [v6 PATCH 0/7]: cpuidle/x86/POWER: Cleanup idle power management
	code in x86, cleanup drivers/cpuidle/cpuidle.c and introduce
	cpuidle to POWER.
Message-ID: <20090922112526.GA7788@linux.vnet.ibm.com>
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

This patchset introduces cpuidle infrastructure to POWER, prototyping
for pSeries, and also does a major refactoring of current x86 idle
power management and a cleanup of cpuidle infrastructure.

My earlier iterations can be found at:

v5 --> http://lkml.org/lkml/2009/9/22/26
v4 --> http://lkml.org/lkml/2009/9/1/133
v3 --> http://lkml.org/lkml/2009/8/27/124
v2 --> http://lkml.org/lkml/2009/8/26/233
v1 --> http://lkml.org/lkml/2009/8/19/150


Changes in this version:
------------------------------------------
Remove the bug from previous iteration in the routine
cpuidle_remove_from_list(), which was causing the kernel to panic on
platform supporting multiple sleep states.

Add the routine cpuidle_kick_cpus() in POWER, which is needed to kick
the cpus out of their idle when changing the idle routines.


TODO:
-------------------------------------------
Peterz suggested it would be nice to have a sysfs interface through
which an idle routine can be forced at runtime.

Also, current implementation registers every cpu as a cpuidle_device,
but this is an overkill and the registering mechanism should be a
systemwide process and not per-cpu. (probably one of the original
cpuidle authors can reply to this - Venki, Shaohua Li? ).

ppc_md.power_save has been replaced by cpuidle_idle_call only for
pseries. So this needs to be done for all POWER platforms so that
ppc_md.power_save is completely removed.


Any comments on the design is welcome.

--arun
