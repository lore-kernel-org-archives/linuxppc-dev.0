Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 031CB2C0142
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 03:07:52 +1100 (EST)
Date: Mon, 27 Jan 2014 16:07:36 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/9] ARM: get rid of arch_cpu_idle_prepare()
Message-ID: <20140127160736.GP15937@n2100.arm.linux.org.uk>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-2-git-send-email-nicolas.pitre@linaro.org>
 <52E6175F.1050401@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52E6175F.1050401@linaro.org>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
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

On Mon, Jan 27, 2014 at 09:22:55AM +0100, Daniel Lezcano wrote:
> On 01/27/2014 07:08 AM, Nicolas Pitre wrote:
>> ARM and ARM64 are the only two architectures implementing
>> arch_cpu_idle_prepare() simply to call local_fiq_enable().
>>
>> We have secondary_start_kernel() already calling local_fiq_enable() and
>> this is done a second time in arch_cpu_idle_prepare() in that case. And
>> enabling FIQs has nothing to do with idling the CPU to start with.
>>
>> So let's introduce init_fiq_boot_cpu() to take care of FIQs on the boot
>> CPU and remove arch_cpu_idle_prepare(). This is now done a bit earlier
>> at late_initcall time but this shouldn't make a difference in practice
>> i.e. when FIQs are actually used.
>>
>> Signed-off-by: Nicolas Pitre <nico@linaro.org>
>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

What kind of review did you do when giving that attributation?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
