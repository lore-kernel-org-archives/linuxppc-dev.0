Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x241.google.com (mail-ua0-x241.google.com
 [IPv6:2607:f8b0:400c:c08::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40yMFZ42lVzDrph
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 10:16:50 +1000 (AEST)
Received: by mail-ua0-x241.google.com with SMTP id c23-v6so11950294uan.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jun 2018 17:16:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180601045433.GA17425@in.ibm.com>
References: <1527768909-32637-1-git-send-email-ego@linux.vnet.ibm.com>
 <CAKTCnz=WhC_vamKPZruEqc04WKpD5ZqZm0zTcCtagRHib6OZPw@mail.gmail.com>
 <20180601045433.GA17425@in.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Sat, 2 Jun 2018 10:16:45 +1000
Message-ID: <CAKTCnznToaF_b9-Z6dH95DQOAu19q3otQc8ugAYXeQj76a5SHA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle:powernv: Make the snooze timeout dynamic.
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 1, 2018 at 2:54 PM, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> Hi Balbir,
>
> Thanks for reviewing the patch!
>
> On Fri, Jun 01, 2018 at 12:51:05AM +1000, Balbir Singh wrote:
>> On Thu, May 31, 2018 at 10:15 PM, Gautham R. Shenoy
>
> [..snip..]
>> >
>> > +static u64 get_snooze_timeout(struct cpuidle_device *dev,
>> > +                             struct cpuidle_driver *drv,
>> > +                             int index)
>> > +{
>> > +       int i;
>> > +
>> > +       if (unlikely(!snooze_timeout_en))
>> > +               return default_snooze_timeout;
>> > +
>> > +       for (i = index + 1; i < drv->state_count; i++) {
>> > +               struct cpuidle_state *s = &drv->states[i];
>> > +               struct cpuidle_state_usage *su = &dev->states_usage[i];
>> > +
>> > +               if (s->disabled || su->disable)
>> > +                       continue;
>> > +
>> > +               return s->target_residency * tb_ticks_per_usec;
>>
>> Can we ensure this is not prone to overflow?
>
> s->target_residency is an "unsigned int" so can take a maximum value
> of UINT_MAX. tb_ticks_per_usec is an "unsigned long" with a value in
> the range of 100-1000. The return value is a u64. The product of
> s->target_residency and tb_ticks_per_usec should be contained in u64.
>

Fair enough, looks reasonable to me

Balbir Singh.
