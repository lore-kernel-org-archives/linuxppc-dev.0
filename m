Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410W7B4XwmzF1lm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 22:18:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpuidle:powernv: Make the snooze timeout dynamic.
In-Reply-To: <20180605084529.GA5656@in.ibm.com>
References: <1527768909-32637-1-git-send-email-ego@linux.vnet.ibm.com>
 <87fu22bxlf.fsf@concordia.ellerman.id.au> <20180605084529.GA5656@in.ibm.com>
Date: Tue, 05 Jun 2018 22:18:40 +1000
Message-ID: <87zi09mnof.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:
> Hello Michael,
>
> On Mon, Jun 04, 2018 at 09:27:40PM +1000, Michael Ellerman wrote:
>> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
>> 
>> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>> >
>> > The commit 78eaa10f027c ("cpuidle: powernv/pseries: Auto-promotion of
>> > snooze to deeper idle state") introduced a timeout for the snooze idle
>> > state so that it could be eventually be promoted to a deeper idle
>> > state. The snooze timeout value is static and set to the target
>> > residency of the next idle state, which would train the cpuidle
>> > governor to pick the next idle state eventually.
>> >
>> > The unfortunate side-effect of this is that if the next idle state(s)
>> > is disabled, the CPU will forever remain in snooze, despite the fact
>> > that the system is completely idle, and other deeper idle states are
>> > available.
>> 
>> That sounds like a bug, I'll add?
>
> Yes, this is a bug-fix for a customer scenario which we encountered
> recently.

OK, the change log could have used some more scary words to make that
clearer ;)

I changed the subject to:

  cpuidle: powernv: Fix promotion from snooze if next state disabled

Which hopefully makes sense.

>> Fixes: 78eaa10f027c ("cpuidle: powernv/pseries: Auto-promotion of snooze to deeper idle state")
>> Cc: stable@vger.kernel.org # v4.2+
>
> This patch applies cleanly from v4.13 onwards. Prior to that there are
> some (minor) conflicts.
>
> Should I spin a version separately for the prior stable versions ?

Yes please, that would be great.

You might want to avoid "=====" in the change log too, as patchwork and
possibly other tools will think it's part of the diff.

cheers
