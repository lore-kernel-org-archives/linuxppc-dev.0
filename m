Return-Path: <arun@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [59.145.155.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B702BB7B74
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Oct 2009 20:48:40 +1100 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp03.in.ibm.com (8.14.3/8.13.1) with ESMTP id n989mVxZ010686
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Oct 2009 15:18:31 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n989mV7h2511096
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Oct 2009 15:18:31 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n989mU1B006161
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Oct 2009 20:48:30 +1100
Date: Thu, 8 Oct 2009 15:18:28 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@elte.hu>,
	Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Arun Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [v8 PATCH 0/8]: cpuidle: Cleanup cpuidle/ Introduce cpuidle to POWER.
Message-ID: <20091008094828.GA20595@linux.vnet.ibm.com>
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

Hi

Please consider this for inclusion into the testing tree.

This patchset introduces cpuidle infrastructure to POWER, prototyping
for pSeries, and also does a major refactoring of current x86 idle
power management and a cleanup of cpuidle infrastructure.

Earlier discussions on the same can be found at:

v7 --> http://lkml.org/lkml/2009/10/6/278
v6 --> http://lkml.org/lkml/2009/9/22/180
v5 --> http://lkml.org/lkml/2009/9/22/26
v4 --> http://lkml.org/lkml/2009/9/1/133
v3 --> http://lkml.org/lkml/2009/8/27/124
v2 --> http://lkml.org/lkml/2009/8/26/233
v1 --> http://lkml.org/lkml/2009/8/19/150


Changes in this version:
--------------------------------------

* Remove redundant poll_idle definition in arch/x86/kernel/process.c

* Prevent acpi_driver from registering when boot_option_idle_override
  is set and let cpuidle_default driver to take over in this case.

* Enable default_idle when power_save=off in POWER.

thanks,
arun
