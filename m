Return-Path: <arun@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 19DD3B7B65
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Sep 2009 18:56:53 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id n8M8up9J010116
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2009 18:56:51 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8M8upZC921728
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2009 18:56:51 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n8M8uoee017265
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2009 18:56:51 +1000
Date: Tue, 22 Sep 2009 14:26:44 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [v5 RFC PATCH 0/7]: cpuidle/x86/POWER (REDESIGN): Cleanup idle
	power management code in x86, cleanup drivers/cpuidle/cpuidle.c and
	introduce cpuidle to POWER.
Message-ID: <20090922085644.GA5511@linux.vnet.ibm.com>
References: <20090922053314.GA6417@linux.vnet.ibm.com>
	<1253604359.8439.278.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1253604359.8439.278.camel@twins>
Cc: Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Arun Bharadwaj <arun@linux.vnet.ibm.com>,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
Reply-To: arun@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Peter Zijlstra <a.p.zijlstra@chello.nl> [2009-09-22 09:25:59]:

> 
> 
> Much better :-)
> 
> 
> But I'm puzzled by all the per-cpu-ish-ness of the stuff. Why would you
> need to register things on a per-cpu basis?
> 
> Also:
> 
> 
> +       list_for_each(pos, &per_cpu(cpuidle_devices_list, cpu)) {
> +               temp_dev = container_of(pos, struct cpuidle_device,
> +                                       percpu_list[cpu]);
> +               if (dev == temp_dev) {
> +                       list_del(&temp_dev->percpu_list[cpu]);
> +                       cpuidle_remove_state_sysfs(temp_dev);
> +               }
> +       }
> 
> Looks buggy, either you want to break out of the loop on dev ==
> temp_dev, or you want to use list_for_each_safe().
> 
> 
> 

Hi Peter,

There were a couple of buggy issues, which i have cleaned up for the
next iteration.

        * As you pointed out above, the loop is buggy.
        * Also, the percpu_list[NR_CPUS] which i am defining inside
          struct cpuidle_device is wrong. It does not need to be an
          array.

Thanks for the quick turnaround
arun
