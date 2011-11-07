Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 3491A1007D4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 05:50:32 +1100 (EST)
Received: from mail159-tx2 (localhost.localdomain [127.0.0.1])	by
 mail159-tx2-R.bigfish.com (Postfix) with ESMTP id F0A611940260	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2011 18:50:18 +0000 (UTC)
Received: from TX2EHSMHS031.bigfish.com (unknown [10.9.14.247])	by
 mail159-tx2.bigfish.com (Postfix) with ESMTP id A6016E90051	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2011 18:50:17 +0000 (UTC)
Message-ID: <4EB82870.1090907@freescale.com>
Date: Mon, 7 Nov 2011 12:50:24 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH 4/7] powerpc/85xx: add support to JOG feature using cpufreq
 interface
References: <1320410166-14500-1-git-send-email-chenhui.zhao@freescale.com>
 <4EB4403E.3040700@freescale.com>
 <20111107102724.GA16470@localhost.localdomain>
In-Reply-To: <20111107102724.GA16470@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/07/2011 04:27 AM, Zhao Chenhui wrote:
> On Fri, Nov 04, 2011 at 02:42:54PM -0500, Scott Wood wrote:
>> On 11/04/2011 07:36 AM, Zhao Chenhui wrote:
>>> +	cpufreq_frequency_table_target(policy,
>>> +				       mpc85xx_freqs,
>>> +				       target_freq,
>>> +				       relation,
>>> +				       &new);
>>> +
>>> +	freqs.old = policy->cur;
>>> +	freqs.new = mpc85xx_freqs[new].frequency;
>>> +	freqs.cpu = policy->cpu;
>>> +
>>> +	mutex_lock(&mpc85xx_switch_mutex);
>>> +	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
>>> +
>>> +	pr_info("Setting frequency for core %d to %d kHz, " \
>>> +		 "PLL ratio is %d/2\n",
>>> +		 policy->cpu,
>>> +		 mpc85xx_freqs[new].frequency,
>>> +		 mpc85xx_freqs[new].index);
>>> +
>>> +	set_pll(mpc85xx_freqs[new].index, policy->cpu);
>>> +
>>> +	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
>>> +	mutex_unlock(&mpc85xx_switch_mutex);
>>> +
>>> +	ppc_proc_freq = freqs.new * 1000ul;
>>
>> ppc_proc_freq is global -- can CPUs not have their frequencies adjusted
>> separately?
>>
>> It should be under the lock, if the lock is needed at all.
>>
> 
> There is only one ppc_proc_freq. no lock.

I realize there's only one.

I'm asking whether CPUs can have their frequencies set indpendently --
if the answer is no, and this function is not specific to a CPU, my only
concern is the lock.  Either this function can be called multiple times
in parallel, in which case the ppc_proc_freq update should be inside the
lock, or it can't, in which case why do we need the lock at all?

-Scott
