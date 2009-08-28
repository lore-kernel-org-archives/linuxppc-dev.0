Return-Path: <a.p.zijlstra@chello.nl>
Received: from viefep16-int.chello.at (viefep16-int.chello.at [62.179.121.36])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 6EED0B7C26
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 16:46:35 +1000 (EST)
Subject: Re: [PATCH 2/4]: CPUIDLE: Introduce architecture independent
	cpuidle_pm_idle in drivers/cpuidle/cpuidle.c
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: arun@linux.vnet.ibm.com
In-Reply-To: <20090828044901.GA10283@linux.vnet.ibm.com>
References: <20090827114908.GA24986@linux.vnet.ibm.com>
	<20090827115354.GC24986@linux.vnet.ibm.com>
	<1251377607.18584.96.camel@twins>
	<20090828044901.GA10283@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Fri, 28 Aug 2009 08:40:11 +0200
Message-Id: <1251441611.18584.112.camel@twins>
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

On Fri, 2009-08-28 at 10:19 +0530, Arun R Bharadwaj wrote:
> 
> 
> This only does the job of picking the right idle loop for current
> latency and power requirement. This is already done in ladder/menu
> governors under the routines menu_select()/ladder_select().
> I'm not sure whats the purpose of it here.

I can't seem to find ladder_select() but menu_select() doesn't manage
pm_idle and its not clear what it does manage.

> Here we are only concerned about the main idle loop, which is
> pm_idle/ppc_md.power_save. After setting the main idle loop to
> cpuidle_pm_idle, that would call cpuidle_idle_call() which would do
> the job of picking the right low level idle loop based on latency and
> other requirements.

It also gets pm_idle unexported and avoids anybody directly tinkering
with the function pointer, _that_ is the whole goal.

pm_idle is it exists today, and the whole cpuidle_{un,}install*() is
utter crap. It relies on unmanaged access to this function pointer.

/me stop looking at drivers/cpuidle/, convoluted mess that is, shame on
you for wanting to have anything to do with it.
