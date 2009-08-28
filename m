Return-Path: <arun@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [59.145.155.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp09.in.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3B250B7EE3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 16:14:48 +1000 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp09.in.ibm.com (8.14.3/8.13.1) with ESMTP id n7S6E0b2009211
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2009 11:44:00 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7S6EaKj2142212
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2009 11:44:36 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n7S6EZXj008968
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2009 16:14:36 +1000
Date: Fri, 28 Aug 2009 11:44:34 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/4]: CPUIDLE: Introduce architecture independent
	cpuidle_pm_idle in drivers/cpuidle/cpuidle.c
Message-ID: <20090828061434.GA11863@linux.vnet.ibm.com>
References: <20090827114908.GA24986@linux.vnet.ibm.com>
	<20090827115354.GC24986@linux.vnet.ibm.com>
	<1251377607.18584.96.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1251377607.18584.96.camel@twins>
Cc: Gautham R Shenoy <ego@in.ibm.com>, "Pallipadi,
	Venkatesh" <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Arun Bharadwaj <arun@linux.vnet.ibm.com>,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <balbir@linux.vnet.ibm.com>
Reply-To: arun@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Peter Zijlstra <a.p.zijlstra@chello.nl> [2009-08-27 14:53:27]:

Hi Peter, Ben,

I've put the whole thing in a sort of a block diagram. Hope it
explains things more clearly.






				----------------
				|    CPUIDLE   |  (Select idle states like
				|   GOVERNORS  |   C1, C1e, C6 etc in case
				| (Menu/Ladder)|   x86 & nap, snooze in
				|	       |   case of POWER - based on
				----------------   latency & power req)
					^
					|
					|
					|
					|
					|
  ----------			-----------------	         -------------
  |	   |			|		|	         |  PSERIES  |
  |  ACPI  |------------------>	|    CPUIDLE	| <--------------|   IDLE    |
  |	   |			|		|	         |           |
  ----------			-----------------	         -------------

Main idle routine- pm_idle()			         Main idle routine-
							     ppc_md.power_save()

pm_idle = cpuidle_pm_idle;			         ppc_md.power_save =
(start using cpuidle's idle				      cpuidle_pm_idle();
 loop, which internally calls
 governor to select the right
 state to go into).


Relavent code snippet from drivers/cpuidle/cpuidle.c
-------------------------------------

static void cpuidle_idle_call(void)
{
	............
	............

	/* Call the menu_select() to select the idle state to enter. */
	next_state = cpuidle_curr_governor->select(dev);

	............
	............

	/*
	 * Enter the idle state previously selected. target_state->enter
	 * would call pseries_cpuidle_loop() which selects nap/snooze
	 * /
	dev->last_residency = target_state->enter(dev, target_state);
}

void cpuidle_install_idle_handler(void)
{
	.........
	.........
	cpuidle_pm_idle = cpuidle_idle_call;
}

--arun
