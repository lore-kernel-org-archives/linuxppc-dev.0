Return-Path: <dmatlack@google.com>
Received: from mail-oi0-x22f.google.com (mail-oi0-x22f.google.com
 [IPv6:2607:f8b0:4003:c06::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqQbR4p1JzDqMK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 03:21:07 +1000 (AEST)
Received: by mail-oi0-x22f.google.com with SMTP id r2so80175543oih.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 10:21:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5785DA9E.7020701@gmail.com>
References: <1468220912-22828-1-git-send-email-sjitindarsingh@gmail.com>
 <1468220912-22828-5-git-send-email-sjitindarsingh@gmail.com>
 <CALzav=ep=8DJixnnoT3czrjZB7WFNxFbnjE1VOX6So3bywAtcA@mail.gmail.com>
 <57848B93.7050808@gmail.com> <5785DA9E.7020701@gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 13 Jul 2016 10:20:46 -0700
Message-ID: <CALzav=faUCAVKkQX4Z4sP756+GQfDFenGCUD1L261ePaYq0M9A@mail.gmail.com>
Subject: Re: [PATCH V2 5/5] powerpc/kvm/stats: Implement existing and add new
 halt polling vcpu stats
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, mpe@ellerman.id.au,
 paulus@samba.org, benh@kernel.crashing.org, kvm list <kvm@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, agraf@suse.com,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 12, 2016 at 11:07 PM, Suraj Jitindar Singh
<sjitindarsingh@gmail.com> wrote:
> On 12/07/16 16:17, Suraj Jitindar Singh wrote:
>> On 12/07/16 02:49, David Matlack wrote:
[snip]
>>> It's possible to poll and wait in one halt, conflating this stat with
>>> polling time. Is it useful to split out a third stat,
>>> halt_poll_fail_ns which counts how long we polled which ended up
>>> sleeping? Then halt_wait_time only counts the time the VCPU spent on
>>> the wait queue. The sum of all 3 is still the total time spent halted.
>>>
>> I see what you're saying. I would say that in the event that you do wait
>> then the most useful number is going to be the total block time (the sum
>> of the wait and poll time) as this is the minimum value you would have to
>> set the halt_poll_max_ns module parameter in order to ensure you poll
>> for long enough (in most circumstances) to avoid waiting, which is the main
>> use case I envision for this statistic. That being said this is definitely
>> a source of ambiguity and splitting this into two statistics would make the
>> distinction clearer without any loss of data, you could simply sum the two
>> stats to get the same number.
>>
>> Either way I don't think it really makes much of a difference, but in the
>> interest of clarity I think I'll split the statistic.
>
> On further though, I really think that splitting this statistic is an
> unnecessary source of ambiguity. In reality the interesting piece of
> information is going to be the average time that you blocked on
> either an unsuccessful poll or a successful poll.
>
> So instead of splitting the statistic I'm going to rename them as:
> halt_poll_time -> halt_block_time_successful_poll
> halt_wait_time -> halt_block_time_waited

The downside of having only these 2 stats is there is no way to see
the total time spent halt-polling. Halt-polling shows up as host
kernel CPU usage on the VCPU thread, despite it really being idle
cycles that could be reclaimed. It's useful to have the total amount
of time spent halt-polling (halt_poll_fail + halt_poll_success) to
feed into provisioning/monitoring systems that look at CPU usage.

FWIW, I have a very similar patch internally. It adds 2 stats,
halt_poll_success_ns and halt_poll_fail_ns, to the halt-polling code
in virt/kvm/kvm_main.c. So if you agree splitting the stats makes
sense, it would be helpful to us if we can adopt the same naming
convention.
