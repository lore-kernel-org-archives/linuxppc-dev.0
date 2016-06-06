Return-Path: <viresh.kumar@linaro.org>
Received: from mail-qg0-f47.google.com (mail-qg0-f47.google.com
 [209.85.192.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNg8p3PL8zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 02:27:38 +1000 (AEST)
Received: by mail-qg0-f47.google.com with SMTP id 93so44837666qgx.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jun 2016 09:27:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hR+XM3KM1Q9c9_kK8n3QbkNzCr7V73m09-nP8KBKq=3Q@mail.gmail.com>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
 <20160603234854.GF14579@graphite.smuckle.net>
 <20160606035231.GZ16176@vireshk-i7> <1649758.V7uyzAJShK@vostro.rjw.lan>
 <CAKohponw8wjFTXA+JyH0A2yXwtF4DxPSVCLcji4=yYV14OC3fw@mail.gmail.com>
 <CAJZ5v0hR+XM3KM1Q9c9_kK8n3QbkNzCr7V73m09-nP8KBKq=3Q@mail.gmail.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 6 Jun 2016 21:55:34 +0530
Message-ID: <CAKohpoms8AquTkv9ZB0w390eS2WcB2PeeNLVo4UUcwPNskwsBg@mail.gmail.com>
Subject: Re: [PATCH V3 8/9] cpufreq: Keep policy->freq_table sorted in
 ascending order
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Steve Muckle <steve.muckle@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, Shawn Guo <shawn.guo@freescale.com>,
 Steven Miao <realmz6@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6 June 2016 at 18:27, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Jun 6, 2016 at 2:24 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> On 6 June 2016 at 17:40, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> On Monday, June 06, 2016 09:22:31 AM Viresh Kumar wrote:
>>
>>>> I agree with that, though that requires larger changes across multiple
>>>> sites.
>>>
>>> What changes and where?
>>
>> s/larger/some :)
>>
>> So we can change all the callers of cpufreq_frequency_table_target(),
>
> But why?
>
> It just works as a static inline wrapper around cpufreq_find_index_l()
> for the code in question after this patch, doesn't it?
>
> So if the caller knows it will always ask for RELATION_L, why bother
> with using the wrapper?

Sorry, I got a bit confused. Are you saying that we should do that change
right in the patch?

Because I am also saying that yes, there is no point calling the wrapper.

I can update this patch to make direct calls to the relation specific routines
if you want.

> Also I'm wondering about the cpufreq_for_each_valid_entry() used all
> over.  Can't the things be arranged so all of the entries are valid?

Yeah, there would be multiple opportunities available to optimize code
after this series is in. The policy->table after this series is all sorted
properly and all the entries are valid as well.

But surely that should be done in a separate series
