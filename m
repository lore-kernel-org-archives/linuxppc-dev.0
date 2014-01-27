Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
 [74.125.82.173])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D1DF92C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 04:12:58 +1100 (EST)
Received: by mail-we0-f173.google.com with SMTP id t60so5533398wes.18
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 09:12:52 -0800 (PST)
Message-ID: <52E69395.9020004@linaro.org>
Date: Mon, 27 Jan 2014 18:12:53 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/9] ARM: get rid of arch_cpu_idle_prepare()
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-2-git-send-email-nicolas.pitre@linaro.org>
 <52E6175F.1050401@linaro.org> <20140127160736.GP15937@n2100.arm.linux.org.uk>
In-Reply-To: <20140127160736.GP15937@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-kernel@lists.linaro.org,
 linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/27/2014 05:07 PM, Russell King - ARM Linux wrote:
> On Mon, Jan 27, 2014 at 09:22:55AM +0100, Daniel Lezcano wrote:
>> On 01/27/2014 07:08 AM, Nicolas Pitre wrote:
>>> ARM and ARM64 are the only two architectures implementing
>>> arch_cpu_idle_prepare() simply to call local_fiq_enable().
>>>
>>> We have secondary_start_kernel() already calling local_fiq_enable() and
>>> this is done a second time in arch_cpu_idle_prepare() in that case. And
>>> enabling FIQs has nothing to do with idling the CPU to start with.
>>>
>>> So let's introduce init_fiq_boot_cpu() to take care of FIQs on the boot
>>> CPU and remove arch_cpu_idle_prepare(). This is now done a bit earlier
>>> at late_initcall time but this shouldn't make a difference in practice
>>> i.e. when FIQs are actually used.
>>>
>>> Signed-off-by: Nicolas Pitre <nico@linaro.org>
>>
>> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> What kind of review did you do when giving that attributation?

I did the review to the best of my knowledge and with good will.

I read your comment on this patch and I learnt one more thing.

Today, I am smarter than yesterday and dumber than tomorrow :)


   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
