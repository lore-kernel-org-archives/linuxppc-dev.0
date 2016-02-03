Return-Path: <ego@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E301B1A007F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 23:03:12 +1100 (AEDT)
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 18948140BA0
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Feb 2016 23:03:10 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 3 Feb 2016 05:03:09 -0700
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id DF78419D8045
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Feb 2016 04:51:05 -0700 (MST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u13C369Q32964682
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Feb 2016 12:03:06 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u13C35tb015991
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Feb 2016 07:03:05 -0500
Date: Wed, 3 Feb 2016 17:32:58 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
 linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org,
 ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com,
 bsingharora@gmail.com, mpe@ellerman.id.au, linux-api@vger.kernel.org
Subject: Re: [PATCH v8 6/6] cpufreq: powernv: Add sysfs attributes to show
 throttle stats
Message-ID: <20160203120258.GA32294@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1454442102-1229-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1454442102-1229-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20160203082700.GZ31828@vireshk>
 <56B1BD71.2050403@linux.vnet.ibm.com>
 <20160203090357.GA31828@vireshk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160203090357.GA31828@vireshk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Viresh,

> 
> What I can suggest is:
> - Move this directory inside cpuX/cpufreq/ directory, in a similar way
>   as to how we create 'stats' directory today.
> - You can then get policy->cpu, to get chip->id out of it.
> - The only disadvantage here is that the same chip directory will be
>   replicated in multiple policies, but that makes it more readable.

Thinking about it, having a sysfs group attached to a policy kobject
looks ok if replication of the same chip information across multiple
policies is not objectionable.

Regarding the table-format, it breaks the sysfs's one-value-per-file
rule. So I would still prefer each throttle reason being a separate
file which gives the number of times the chip frequency was throttled
due to that reason. We can live without the per-frequency
throttle stats listed in the throttle_status.

So, would the following be sysfs group structure be acceptable?

$ls -1 /sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/
unthrottle
powercap
overtemp
supply_fault
overcurrent
occ_reset
turbo_stat
sub_turbo_stat

--
Thanks and Regards
gautham.
