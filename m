Return-Path: <a.p.zijlstra@chello.nl>
Received: from viefep20-int.chello.at (viefep20-int.chello.at [62.179.121.40])
	by bilbo.ozlabs.org (Postfix) with ESMTP id D0E6AB7D7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 16:54:32 +1000 (EST)
Subject: Re: [PATCH 2/4]: CPUIDLE: Introduce architecture independent
	cpuidle_pm_idle in drivers/cpuidle/cpuidle.c
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: arun@linux.vnet.ibm.com
In-Reply-To: <20090828061434.GA11863@linux.vnet.ibm.com>
References: <20090827114908.GA24986@linux.vnet.ibm.com>
	<20090827115354.GC24986@linux.vnet.ibm.com>
	<1251377607.18584.96.camel@twins>
	<20090828061434.GA11863@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Fri, 28 Aug 2009 08:48:05 +0200
Message-Id: <1251442085.18584.120.camel@twins>
Mime-Version: 1.0
Cc: Gautham R Shenoy <ego@in.ibm.com>, "Pallipadi,
	Venkatesh" <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-08-28 at 11:44 +0530, Arun R Bharadwaj wrote:
> * Peter Zijlstra <a.p.zijlstra@chello.nl> [2009-08-27 14:53:27]:
> 
> Hi Peter, Ben,
> 
> I've put the whole thing in a sort of a block diagram. Hope it
> explains things more clearly.
> 
> 
> 
> 
> 
> 
> 				----------------
> 				|    CPUIDLE   |  (Select idle states like
> 				|   GOVERNORS  |   C1, C1e, C6 etc in case
> 				| (Menu/Ladder)|   x86 & nap, snooze in
> 				|	       |   case of POWER - based on
> 				----------------   latency & power req)
> 					^
> 					|
> 					|
> 					|
> 					|
> 					|
>   ----------			-----------------	         -------------
>   |	   |			|		|	         |  PSERIES  |
>   |  ACPI  |------------------>	|    CPUIDLE	| <--------------|   IDLE    |
>   |	   |			|		|	         |           |
>   ----------			-----------------	         -------------
> 
> Main idle routine- pm_idle()			         Main idle routine-
> 							     ppc_md.power_save()
> 
> pm_idle = cpuidle_pm_idle;			         ppc_md.power_save =
> (start using cpuidle's idle				      cpuidle_pm_idle();
>  loop, which internally calls
>  governor to select the right
>  state to go into).
> 
> 
> Relavent code snippet from drivers/cpuidle/cpuidle.c
> -------------------------------------
> 
> static void cpuidle_idle_call(void)
> {
> 	............
> 	............
> 
> 	/* Call the menu_select() to select the idle state to enter. */
> 	next_state = cpuidle_curr_governor->select(dev);
> 
> 	............
> 	............
> 
> 	/*
> 	 * Enter the idle state previously selected. target_state->enter
> 	 * would call pseries_cpuidle_loop() which selects nap/snooze
> 	 * /
> 	dev->last_residency = target_state->enter(dev, target_state);
> }
> 
> void cpuidle_install_idle_handler(void)
> {
> 	.........
> 	.........
> 	cpuidle_pm_idle = cpuidle_idle_call;
> }

All I'm seeing here is a frigging mess.

How on earths can something called: cpuidle_install_idle_handler() have
a void argument, _WHAT_ handler is it going to install?

So somehow you added to the ACPI mess by now having 3 wild function
pointers, that's _NOT_ progress.
