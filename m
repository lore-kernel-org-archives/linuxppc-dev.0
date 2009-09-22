Return-Path: <a.p.zijlstra@chello.nl>
Received: from viefep19-int.chello.at (viefep19-int.chello.at [62.179.121.39])
	by ozlabs.org (Postfix) with ESMTP id C9FAAB7334
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Sep 2009 17:29:59 +1000 (EST)
Subject: Re: [v5 RFC PATCH 0/7]: cpuidle/x86/POWER (REDESIGN): Cleanup idle
	power management code in x86, cleanup drivers/cpuidle/cpuidle.c and
	introduce cpuidle to POWER.
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: arun@linux.vnet.ibm.com
In-Reply-To: <20090922053314.GA6417@linux.vnet.ibm.com>
References: <20090922053314.GA6417@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Tue, 22 Sep 2009 09:25:59 +0200
Message-Id: <1253604359.8439.278.camel@twins>
Mime-Version: 1.0
Cc: Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Much better :-)


But I'm puzzled by all the per-cpu-ish-ness of the stuff. Why would you
need to register things on a per-cpu basis?

Also:


+       list_for_each(pos, &per_cpu(cpuidle_devices_list, cpu)) {
+               temp_dev = container_of(pos, struct cpuidle_device,
+                                       percpu_list[cpu]);
+               if (dev == temp_dev) {
+                       list_del(&temp_dev->percpu_list[cpu]);
+                       cpuidle_remove_state_sysfs(temp_dev);
+               }
+       }

Looks buggy, either you want to break out of the loop on dev ==
temp_dev, or you want to use list_for_each_safe().
