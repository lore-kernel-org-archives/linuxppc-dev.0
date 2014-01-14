Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DB3062C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 22:05:47 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 14 Jan 2014 06:05:43 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id B3FA638C8047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 06:05:41 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0EB5fDI3146018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 11:05:41 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0EB5egL011490
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 06:05:41 -0500
Message-ID: <52D51938.6020105@linux.vnet.ibm.com>
Date: Tue, 14 Jan 2014 16:32:16 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 svaidy@linux.vnet.ibm.com
Subject: Re: [PATCH] cpuidle/menu: Fail cpuidle_idle_call() if no idle state
 is acceptable
References: <20140114060516.6109.14901.stgit@preeti.in.ibm.com>
 <52D4E07E.204@linux.vnet.ibm.com> <52D4E93C.3050503@linux.vnet.ibm.com>
In-Reply-To: <52D4E93C.3050503@linux.vnet.ibm.com>
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

On 01/14/2014 01:07 PM, Srivatsa S. Bhat wrote:
> On 01/14/2014 12:30 PM, Srivatsa S. Bhat wrote:
>> On 01/14/2014 11:35 AM, Preeti U Murthy wrote:
>>> On PowerPC, in a particular test scenario, all the cpu idle states were disabled.
>>> Inspite of this it was observed that the idle state count of the shallowest
>>> idle state, snooze, was increasing.
>>>
>>> This is because the governor returns the idle state index as 0 even in
>>> scenarios when no idle state can be chosen. These scenarios could be when the
>>> latency requirement is 0 or as mentioned above when the user wants to disable
>>> certain cpu idle states at runtime. In the latter case, its possible that no
>>> cpu idle state is valid because the suitable states were disabled
>>> and the rest did not match the menu governor criteria to be chosen as the
>>> next idle state.
>>>
>>> This patch adds the code to indicate that a valid cpu idle state could not be
>>> chosen by the menu governor and reports back to arch so that it can take some
>>> default action.
>>>
>>
>> That sounds fair enough. However, the "default" action of pseries idle loop
>> (pseries_lpar_idle()) surprises me. It enters Cede, which is _deeper_ than doing
>> a snooze! IOW, a user might "disable" cpuidle or set the PM_QOS_CPU_DMA_LATENCY
>> to 0 hoping to prevent the CPUs from going to deep idle states, but then the
>> machine would still end up going to Cede, even though that wont get reflected
>> in the idle state counts. IMHO that scenario needs some thought as well...
>>
> 
> I checked the git history and found that the default idle was changed (on purpose)
> to cede the processor, in order to speed up booting.. Hmm..
> 
> commit 363edbe2614aa90df706c0f19ccfa2a6c06af0be
> Author: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Date:   Fri Sep 6 00:25:06 2013 +0530
> 
>     powerpc: Default arch idle could cede processor on pseries

This issue is not powerpc specific as I observed on digging a bit into
the default idle routines of the common archs. The way that archs
perceive the call to cpuidle framework today is that if it fails, it
means that cpuidle backend driver fails to *function* due to some reason
(as is mentioned in the above commit: either since cpuidle driver is not
registered or it does not work on some specific platforms) and that
therefore the archs should decide on an idle state themselves. They
therefore end up choosing a convenient idle state which could very well
be one of the idle states in the cpuidle state table.

The archs do not see failed call to cpuidle driver as "cpuidle driver
says no idle state can be entered now because there are strict latency
requirements or the idle states are disabled". IOW, the call to cpuidle
driver is currently based on if cpuidle driver exists rather than if it
agrees on entry into any of the idle states.

This patch brings in the need for the archs to incorporate this
additional check of "did cpuidle_idle_call() fail because it did not
find it wise to enter any of the idle states". In which case they should
simply exit without taking any *default action*.

Need to give this some thought and reconsider the patch.

Regards
Preeti U Murthy
> 
> 
> Regards,
> Srivatsa S. Bhat
> 
