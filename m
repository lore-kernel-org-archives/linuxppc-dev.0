Return-Path: <rjwysocki@gmail.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNpVN2JVWzDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 07:58:19 +1000 (AEST)
Received: by mail-wm0-f67.google.com with SMTP id m124so18584118wme.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jun 2016 14:58:19 -0700 (PDT)
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <CAKohpoms8AquTkv9ZB0w390eS2WcB2PeeNLVo4UUcwPNskwsBg@mail.gmail.com>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
 <20160603234854.GF14579@graphite.smuckle.net>
 <20160606035231.GZ16176@vireshk-i7> <1649758.V7uyzAJShK@vostro.rjw.lan>
 <CAKohponw8wjFTXA+JyH0A2yXwtF4DxPSVCLcji4=yYV14OC3fw@mail.gmail.com>
 <CAJZ5v0hR+XM3KM1Q9c9_kK8n3QbkNzCr7V73m09-nP8KBKq=3Q@mail.gmail.com>
 <CAKohpoms8AquTkv9ZB0w390eS2WcB2PeeNLVo4UUcwPNskwsBg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 Jun 2016 23:56:13 +0200
Message-ID: <CAJZ5v0hG9X_zoHHFBiiZnn5x0rMfukF4RpFMxr73r3C0VzrUHw@mail.gmail.com>
Subject: Re: [PATCH V3 8/9] cpufreq: Keep policy->freq_table sorted in
 ascending order
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Steve Muckle <steve.muckle@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, Steven Miao <realmz6@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 6, 2016 at 6:25 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 6 June 2016 at 18:27, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Mon, Jun 6, 2016 at 2:24 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>> On 6 June 2016 at 17:40, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>> On Monday, June 06, 2016 09:22:31 AM Viresh Kumar wrote:
>>>
>>>>> I agree with that, though that requires larger changes across multiple
>>>>> sites.
>>>>
>>>> What changes and where?
>>>
>>> s/larger/some :)
>>>
>>> So we can change all the callers of cpufreq_frequency_table_target(),
>>
>> But why?
>>
>> It just works as a static inline wrapper around cpufreq_find_index_l()
>> for the code in question after this patch, doesn't it?
>>
>> So if the caller knows it will always ask for RELATION_L, why bother
>> with using the wrapper?
>
> Sorry, I got a bit confused. Are you saying that we should do that change
> right in the patch?
>
> Because I am also saying that yes, there is no point calling the wrapper.

OK

> I can update this patch to make direct calls to the relation specific routines
> if you want.

I'm not sure if I like this patch at all in the first place.

>> Also I'm wondering about the cpufreq_for_each_valid_entry() used all
>> over.  Can't the things be arranged so all of the entries are valid?
>
> Yeah, there would be multiple opportunities available to optimize code
> after this series is in. The policy->table after this series is all sorted
> properly and all the entries are valid as well.
>
> But surely that should be done in a separate series

So I'm reading this as "I will add overhead to that code now, but I
can remove it later" which makes me go "What?!" right away.

Moreover, you seem to be saying something like "all of the entries are
valid now, but I'm using cpufreq_for_each_valid_entry() to walk freq
tables anyway, so that I can get rid of it in a future patch" which
makes me go "What?!" again.

Since you are adding new code, you can write it so it doesn't do
unnecessary checks from the start.

While at it, the "if ((freq < policy->min) || (freq > policy->max))"
checks in cpufreq_find_index_l() and cpufreq_find_index_h() don't look
good to me, because they very well may cause those function to return
-EINVAL even when there's a valid table and that may cause
acpi_cpufreq_fast_switch() to do bad things.

Also, if you are going to return an index, why don't you iterate over
indexes and avoid using pointer subtractions to compute the return
value?

With that, cpufreq_find_index_l() would look like

static inline int cpufreq_find_index_l(struct cpufreq_policy *policy,
                       unsigned int target_freq)
{
    struct cpufreq_frequency_table *table = policy->freq_table;
    int i;

    for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++)
        if (table[i].frequency >= target_freq)
            return i;

    return i > 0 ? --i : 0;
}

and that can go into cpufreq.h IMO (ie. no need for the new header file).
