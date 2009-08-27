Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 69A90B7B85
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 07:30:45 +1000 (EST)
Subject: Re: [PATCH 2/4]: CPUIDLE: Introduce architecture independent
	cpuidle_pm_idle in drivers/cpuidle/cpuidle.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1251377607.18584.96.camel@twins>
References: <20090827114908.GA24986@linux.vnet.ibm.com>
	<20090827115354.GC24986@linux.vnet.ibm.com>
	<1251377607.18584.96.camel@twins>
Content-Type: text/plain
Date: Fri, 28 Aug 2009 07:28:12 +1000
Message-Id: <1251408492.20467.56.camel@pasglop>
Mime-Version: 1.0
Cc: Gautham R Shenoy <ego@in.ibm.com>, "Pallipadi,
	Venkatesh" <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	arun@linux.vnet.ibm.com, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org, Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-08-27 at 14:53 +0200, Peter Zijlstra wrote:

> I'm not quite seeing how this makes anything any better. Not we have 3
> function pointers, where 1 should suffice.

There's also the question of us having different "idle" vs.
"power_save", the former being the entire idle loop, the later being the
part that does put the processor into power.

At what level are we trying to change the loop here ?

There are some requirements of things to do in our idle loop that really
don't have their place in generic drivers/* code.

Ben.

> /me wonders what's wrong with something like:
> 
> struct idle_func_desc {
> 	int		 power;
> 	int		 latency;
> 	void		 (*idle)(void);
> 	struct list_head list;
> };
> 
> static void spin_idle(void)
> {
> 	for (;;)
> 		cpu_relax();
> }
> 
> static idle_func_desc default_idle_func = {
> 	power = 0, 	   /* doesn't safe any power */
> 	latency = INT_MAX, /* has max latency */
> 	idle = spin_idle,
> 	list = INIT_LIST_HEAD(default_idle_func.list),
> };
> 
> void (*idle_func)(void);
> static struct list_head idle_func_list;
> 
> static void pick_idle_func(void)
> {
> 	struct idle_func_desc *desc, *idle = &default_idle_desc;
> 
> 	list_for_each_entry(desc, &idle_func_list, list) {
> 		if (desc->power < idle->power)
> 			continue;
> 		if (desc->latency > target_latency);
> 			continue;
> 		idle = desc;
> 	}
> 
> 	pm_idle = idle->idle;
> }
> 
> void register_idle_func(struct idle_func_desc *desc)
> {
> 	WARN_ON_ONCE(!list_empty(&desc->list));
> 
> 	list_add_tail(&idle_func_list, &desc->list);
> 	pick_idle_func();
> }
> 
> void unregister_idle_func(struct idle_func_desc *desc)
> {
> 	WARN_ON_ONCE(list_empty(&desc->list));
> 
> 	list_del_init(&desc->list);
> 	if (idle_func == desc->idle) 
> 		pick_idle_func();
> }
