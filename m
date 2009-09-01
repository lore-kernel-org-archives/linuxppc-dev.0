Return-Path: <arun@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A1847B7B85
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 21:37:23 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp04.au.ibm.com (8.14.3/8.13.1) with ESMTP id n81BYWs4032242
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Sep 2009 21:34:32 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n81BbIo71159298
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Sep 2009 21:37:18 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n81BbHWX003686
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Sep 2009 21:37:18 +1000
Date: Tue, 1 Sep 2009 17:07:04 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Joel Schopp <jschopp@austin.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>,
	Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
	Gautham R Shenoy <ego@in.ibm.com>,
	Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [v4 PATCH 0/5]: cpuidle/POWER (REDISIGN): Introducing cpuidle to
	POWER.
Message-ID: <20090901113704.GG7599@linux.vnet.ibm.com>
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

******** This is an RFC, not for inclusion **********

This patchset introduces cpuidle infrastructure to POWER, prototyping
for pseries and currently in the process of porting to x86 and hence
will *not* build on x86/other POWER platforms.

This is to get initial comments on the redesign of my earlier implementation
which can be found at http://lkml.org/lkml/2009/8/27/124

Major changes from last iteration:
----------------------------------

* Cleanup drivers/cpuidle/cpuidle.c
	Currently, the cpuidle implementation has weakness in the
	framework where an exported pm_idle function pointer is
	manipulated by various subsystem. The proposed framework has
	a registration architecture to cleanly add and remove new idle
	routines from different subsystems.

* Introduce [un]register_idle_function() routines
        Implement a LIFO based approach for registering architecture
        dependent idle routines.

* Sample implementation of register_idle_function for pSeries


TODO:
-----

* Extend this prototype to cover x86 and other archs that use cpuidle.
        Currently, in x86, the cpu_idle() idle loop doesn't have a
        default idle loop to fall back to if pm_idle is NULL, unlike
        the corresponding implementation in pseries, where
        ppc_md.power_save can be NULL and there is a fallback.
        So we need to create a similar fork in cpu_idle() idle loop of
        x86.



Patches included in this series:
--------------------------------

1/5 - Cleanup drivers/cpuidle/cpuidle.c
2/5 - Implement routines to register and unregister idle function.
3/5 - Incorporate registering of idle loop for pSeries.
4/5 - Add Kconfig entry to enable cpuidle for POWER.
5/5 - Implement pSeries processor idle module.


Any comments on the design is welcome.

--arun
