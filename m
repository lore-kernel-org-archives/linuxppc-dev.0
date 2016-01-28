Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D6D521A030F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 19:40:46 +1100 (AEDT)
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 53121140B96
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 19:40:45 +1100 (AEDT)
Received: by mail-pa0-x234.google.com with SMTP id ho8so19757424pac.2
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 00:40:45 -0800 (PST)
Date: Thu, 28 Jan 2016 14:10:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 rjw@rjwysocki.net, linux-pm@vger.kernel.org, pc@us.ibm.com,
 anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com,
 bsingharora@gmail.com, mpe@ellerman.id.au, linux-api@vger.kernel.org
Subject: Re: [PATCH v7 6/6] cpufreq: powernv: Add sysfs attributes to show
 throttle stats
Message-ID: <20160128084041.GK3935@vireshk>
References: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1453965941-7363-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453965941-7363-7-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28-01-16, 12:55, Shilpasri G Bhat wrote:
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index b683e8e..dea4620 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -271,3 +271,48 @@ Description:	Parameters for the CPU cache attributes
>  			- WriteBack: data is written only to the cache line and
>  				     the modified cache line is written to main
>  				     memory only when it is replaced
> +
> +What:		/sys/devices/system/cpu/cpufreq/chip*/throttle_stats

What about the chip directory ? Shouldn't that be documented? And
shouldn't that mention that this is just for powerpc ?

And before that, I don't think that you are doing this properly. I am
sorry that I never came to a point where I could review it, and you
continued with it, version after version.

But, I really have strong objections to the way this is done. And you
are making things more complex then they are.

So, these stats are per-policy, right ?

Then why aren't they added on the policy->kobj instead, just like
cpufreq-stats? And maybe inside cpufreq-stats folder only?

That will solve many complexities you have in place here and will look
sane as well.

Right now, you have stats as two places, cpu/cpufreq/chip/ and
cpu/cpuX/cpufreq/stats/, which doesn't look wise and adds to
confusion.

What do you say?

-- 
viresh
