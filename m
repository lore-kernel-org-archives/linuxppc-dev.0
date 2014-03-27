Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 320DD140083
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 21:21:53 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Thu, 27 Mar 2014 15:51:50 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 5DAE3E0056
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 15:55:47 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2RALqO73146192
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 15:51:52 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2RALjMb025470
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2014 15:51:45 +0530
Message-ID: <5333FBA8.1040107@linux.vnet.ibm.com>
Date: Thu, 27 Mar 2014 15:51:28 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4] powernv, cpufreq: cpufreq driver for powernv platform
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAKohponPb+b=8Pa=te3CkiN6QPAUAukngqLSdG4vxc9pUkD8OQ@mail.gmail.com>
 <20140327093050.GA27777@in.ibm.com>
 <CAKohponOe9Au+pe5u9FpddW3+f5pegZB953+5fmYBDusE9j0HA@mail.gmail.com>
In-Reply-To: <CAKohponOe9Au+pe5u9FpddW3+f5pegZB953+5fmYBDusE9j0HA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/27/2014 03:29 PM, Viresh Kumar wrote:
> On 27 March 2014 15:00, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
>> As of now, I prefer this patch be based on code that is in the -next
>> tree. I'll get rid of the per-core locking once the serialization
>> patch of the core is accepted.
> 
[...] 
>>>> +       pr_debug("cpu %d pmsr %lx pstate_id %d frequency %d kHz \n",
>>>> +               smp_processor_id(), pmspr_val, freq_data->pstate_id,
>>>
>>> s/smp_processor_id/raw_smp_processor_id ?
>>
>> No. This function is called via smp_call_function(). So we have
>> preempt_disable on and it is safe to use smp_processor_id.
> 
> My question wasn't about being safe, but avoiding the complexity
> of debug_smp_processor_id(). raw_smp_processor_id() can execute
> very quickly.
> 

smp_processor_id() maps to debug_smp_processor_id() only if
CONFIG_DEBUG_PREEMPT is set. Otherwise, it is same as raw_smp_processor_id().
So I think its best to keep it as it is.

Regards,
Srivatsa S. Bhat
