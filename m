Return-Path: <rjwysocki@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqcTL6LpMzF1TP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 20:48:22 +1100 (AEDT)
Received: by mail-oi0-x244.google.com with SMTP id j79so10157761oib.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 01:48:22 -0800 (PST)
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <14e2fe70-7628-4377-664d-3c4b0071e08d@linux.vnet.ibm.com>
References: <1518430876-24464-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180212102900.GU28462@vireshk-i7>
 <14e2fe70-7628-4377-664d-3c4b0071e08d@linux.vnet.ibm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Feb 2018 10:48:19 +0100
Message-ID: <CAJZ5v0gw1_xDRW+QuxXC4GO93A4v+Hw6T7NObd45qK6J+n6hMg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: powernv: Check negative value returned by
 cpufreq_table_find_index_dl()
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 12, 2018 at 11:33 AM, Shilpasri G Bhat
<shilpa.bhat@linux.vnet.ibm.com> wrote:
> Hi,
>
> On 02/12/2018 03:59 PM, Viresh Kumar wrote:
>> On 12-02-18, 15:51, Shilpasri G Bhat wrote:
>>> This patch fixes the below Coverity warning:
>>>
>>> *** CID 182816:  Memory - illegal accesses  (NEGATIVE_RETURNS)
>>> /drivers/cpufreq/powernv-cpufreq.c: 1008 in powernv_fast_switch()
>>> 1002                                         unsigned int target_freq)
>>> 1003     {
>>> 1004         int index;
>>> 1005         struct powernv_smp_call_data freq_data;
>>> 1006
>>> 1007         index = cpufreq_table_find_index_dl(policy, target_freq);
>>>>>>     CID 182816:  Memory - illegal accesses  (NEGATIVE_RETURNS)
>>>>>>     Using variable "index" as an index to array "powernv_freqs".
>>> 1008         freq_data.pstate_id = powernv_freqs[index].driver_data;
>>> 1009         freq_data.gpstate_id = powernv_freqs[index].driver_data;
>>> 1010         set_pstate(&freq_data);
>>> 1011
>>> 1012         return powernv_freqs[index].frequency;
>>> 1013     }
>>>
>>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>>> ---
>>>  drivers/cpufreq/powernv-cpufreq.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
>>> index 29cdec1..69edfe9 100644
>>> --- a/drivers/cpufreq/powernv-cpufreq.c
>>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>>> @@ -1005,6 +1005,9 @@ static unsigned int powernv_fast_switch(struct cpufreq_policy *policy,
>>>      struct powernv_smp_call_data freq_data;
>>>
>>>      index = cpufreq_table_find_index_dl(policy, target_freq);
>>> +    if (unlikely(index < 0))
>>> +            index = get_nominal_index();
>>> +
>>
>> AFAICT, you will get -1 here only if the freq table had no valid
>> frequencies (or the freq table is empty). Why would that happen ?
>
> I agree too. There is no way we can get -1 with initialized cpu frequency table.
> We don't initialize powernv-cpufreq if we don't have valid CPU frequency
> entries. Is there any other way to suppress the Coverity tool warning apart from
> ignoring it?

In principle you could use BUG_ON(something_impossible) to annotate
that kind of thing to the static analysis tools, but that would
generate extra code.
