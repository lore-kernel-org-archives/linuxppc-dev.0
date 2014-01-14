Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BF8012C007A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 18:43:04 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 14 Jan 2014 17:43:03 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 83D0D2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 18:43:00 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0E7O6Ij59834508
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 18:24:07 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0E7gwW9005177
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 18:42:59 +1100
Message-ID: <52D4E93C.3050503@linux.vnet.ibm.com>
Date: Tue, 14 Jan 2014 13:07:32 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle/menu: Fail cpuidle_idle_call() if no idle state
 is acceptable
References: <20140114060516.6109.14901.stgit@preeti.in.ibm.com>
 <52D4E07E.204@linux.vnet.ibm.com>
In-Reply-To: <52D4E07E.204@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: deepthi@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
 daniel.lezcano@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 tuukka.tikkanen@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/14/2014 12:30 PM, Srivatsa S. Bhat wrote:
> On 01/14/2014 11:35 AM, Preeti U Murthy wrote:
>> On PowerPC, in a particular test scenario, all the cpu idle states were disabled.
>> Inspite of this it was observed that the idle state count of the shallowest
>> idle state, snooze, was increasing.
>>
>> This is because the governor returns the idle state index as 0 even in
>> scenarios when no idle state can be chosen. These scenarios could be when the
>> latency requirement is 0 or as mentioned above when the user wants to disable
>> certain cpu idle states at runtime. In the latter case, its possible that no
>> cpu idle state is valid because the suitable states were disabled
>> and the rest did not match the menu governor criteria to be chosen as the
>> next idle state.
>>
>> This patch adds the code to indicate that a valid cpu idle state could not be
>> chosen by the menu governor and reports back to arch so that it can take some
>> default action.
>>
> 
> That sounds fair enough. However, the "default" action of pseries idle loop
> (pseries_lpar_idle()) surprises me. It enters Cede, which is _deeper_ than doing
> a snooze! IOW, a user might "disable" cpuidle or set the PM_QOS_CPU_DMA_LATENCY
> to 0 hoping to prevent the CPUs from going to deep idle states, but then the
> machine would still end up going to Cede, even though that wont get reflected
> in the idle state counts. IMHO that scenario needs some thought as well...
> 

I checked the git history and found that the default idle was changed (on purpose)
to cede the processor, in order to speed up booting.. Hmm..

commit 363edbe2614aa90df706c0f19ccfa2a6c06af0be
Author: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date:   Fri Sep 6 00:25:06 2013 +0530

    powerpc: Default arch idle could cede processor on pseries


Regards,
Srivatsa S. Bhat
