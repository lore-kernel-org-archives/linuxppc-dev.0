Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC9081A0191
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 01:06:05 +1100 (AEDT)
Received: from mail-pf0-x22a.google.com (mail-pf0-x22a.google.com
 [IPv6:2607:f8b0:400e:c00::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42B82140BCC
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Feb 2016 01:06:05 +1100 (AEDT)
Received: by mail-pf0-x22a.google.com with SMTP id o185so14480420pfb.1
 for <linuxppc-dev@ozlabs.org>; Wed, 03 Feb 2016 06:06:05 -0800 (PST)
Date: Wed, 3 Feb 2016 19:36:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: rjw@rjwysocki.net, Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org,
 shreyas@linux.vnet.ibm.com, bsingharora@gmail.com,
 mpe@ellerman.id.au, linux-api@vger.kernel.org
Subject: Re: [PATCH v8 6/6] cpufreq: powernv: Add sysfs attributes to show
 throttle stats
Message-ID: <20160203140600.GG3469@vireshk>
References: <1454442102-1229-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1454442102-1229-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20160203082700.GZ31828@vireshk>
 <56B1BD71.2050403@linux.vnet.ibm.com>
 <20160203090357.GA31828@vireshk>
 <20160203120258.GA32294@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160203120258.GA32294@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03-02-16, 17:32, Gautham R Shenoy wrote:
> Regarding the table-format, it breaks the sysfs's one-value-per-file
> rule. So I would still prefer each throttle reason being a separate
> file which gives the number of times the chip frequency was throttled
> due to that reason. We can live without the per-frequency
> throttle stats listed in the throttle_status.
> 
> So, would the following be sysfs group structure be acceptable?
> 
> $ls -1 /sys/devices/system/cpu/cpuX/cpufreq/throttle_stats/
> unthrottle
> powercap
> overtemp
> supply_fault
> overcurrent
> occ_reset
> turbo_stat
> sub_turbo_stat

That was suggested for your convenience only, feel free to keep it the
way you want it.

I forgot about the one-value-per-file thing really, but we are using
that for cpufreq-stats as well.

And now that you have mentioned that to me, why shouldn't this stats
directory be moved to debugfs ? :)

We are never going to perform a store here, isn't it ? And is just for
information, nothing more.

@Rafael: ??

-- 
viresh
