Return-Path: <arun@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 900EBB7BB2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Oct 2009 20:39:02 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id n9GKRpBS001330
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2009 07:27:51 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9G9cwUe1331232
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2009 20:38:58 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9G9cvcY032403
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2009 20:38:58 +1100
Date: Fri, 16 Oct 2009 15:08:50 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@elte.hu>,
	Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
	Andi Kleen <andi@firstfloor.org>, Arun Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [v9 PATCH 0/9]: cpuidle: Cleanup cpuidle/ Introduce cpuidle to POWER.
Message-ID: <20091016093850.GB27350@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

This patch series has been in discussion for quite a while now and
below are the links to the previous discussions.

Hopefully, this is ready to be included in the -tip tree.

v8 --> http://lkml.org/lkml/2009/10/8/82
v7 --> http://lkml.org/lkml/2009/10/6/278
v6 --> http://lkml.org/lkml/2009/9/22/180
v5 --> http://lkml.org/lkml/2009/9/22/26
v4 --> http://lkml.org/lkml/2009/9/1/133
v3 --> http://lkml.org/lkml/2009/8/27/124
v2 --> http://lkml.org/lkml/2009/8/26/233
v1 --> http://lkml.org/lkml/2009/8/19/150


Changes in this version:
----------------------------------------
        *Added documentation for the new design regarding registration
        of idle routines in Documentation/cpuidle/core.txt

        *Platforms which do not want the code bloat of cpuidle can
        disable CONFIG_CPU_IDLE. Alternate definition of
        cpuidle_idle_call is provided which would call the appropriate
        idle routine provided by the arch without the overhead of
        registration and governors.
        (Thanks to Andi for raising this isuue)

        *I had missed a cpuidle_kick_cpus() in
        cpuidle_pause_and_lock() which is called from the hotplug
        path. So added that and tested this patchset by subjecting it
        to cpuhotplug torture.
        (Thanks to Balbir for noticing this)


--arun
