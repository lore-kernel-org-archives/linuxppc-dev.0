Return-Path: <rjwysocki@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjmMP4KCrzDqnw
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 22:21:05 +1000 (AEST)
Received: by mail-wm0-x241.google.com with SMTP id 187so21302217wmz.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jul 2016 05:21:05 -0700 (PDT)
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <5102d9f9-3b38-17c3-98ce-cceb073da764@gmail.com>
References: <1467383054-1959-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <5102d9f9-3b38-17c3-98ce-cceb073da764@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Jul 2016 14:20:59 +0200
Message-ID: <CAJZ5v0jCTr607OTekNVuYGDmA=ObhgVKDrHdSWB-metEpuydXQ@mail.gmail.com>
Subject: Re: [PATCH v5] cpuidle: Fix last_residency division
To: Balbir Singh <bsingharora@gmail.com>,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Nicolas Pitre <nicolas.pitre@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 4, 2016 at 8:10 AM, Balbir Singh <bsingharora@gmail.com> wrote:
>
>
> On 02/07/16 00:24, Shreyas B. Prabhu wrote:
>> Snooze is a poll idle state in powernv and pseries platforms. Snooze
>> has a timeout so that if a cpu stays in snooze for more than target
>> residency of the next available idle state, then it would exit thereby
>> giving chance to the cpuidle governor to re-evaluate and
>> promote the cpu to a deeper idle state. Therefore whenever snooze exits
>> due to this timeout, its last_residency will be target_residency of next
>> deeper state.
>>
>> commit e93e59ce5b85 ("cpuidle: Replace ktime_get() with local_clock()")
>> changed the math around last_residency calculation. Specifically, while
>> converting last_residency value from nanoseconds to microseconds it does
>> right shift by 10. Due to this, in snooze timeout exit scenarios
>> last_residency calculated is roughly 2.3% less than target_residency of
>> next available state. This pattern is picked up get_typical_interval()
>> in the menu governor and therefore expected_interval in menu_select() is
>> frequently less than the target_residency of any state but snooze.
>>
>> Due to this we are entering snooze at a higher rate, thereby affecting
>> the single thread performance.
>>
>> Fix this by using precise division via ktime_us_delta.
>>
>> Reported-by: Anton Blanchard <anton@samba.org>
>> Bisected-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
>> ---
>
> This looks so much cleaner :)
>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Patch applied, thanks!
