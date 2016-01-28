Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 323451A0325
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 22:11:00 +1100 (AEDT)
Received: from mail-yk0-x244.google.com (mail-yk0-x244.google.com
 [IPv6:2607:f8b0:4002:c07::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 94E29140BCE
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 22:10:59 +1100 (AEDT)
Received: by mail-yk0-x244.google.com with SMTP id y10so2922511ykf.0
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 03:10:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Date: Thu, 28 Jan 2016 22:10:57 +1100
Message-ID: <CAKTCnzn6o6fxP+f4FzsBr3+F9_cBubtUs6sQZod0A6BWdBZzmA@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] cpufreq: powernv: Redesign the presentation of
 throttle notification and solve bug-fixes in the driver
From: Balbir Singh <bsingharora@gmail.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 rjw@rjwysocki.net, viresh.kumar@linaro.org,
 linux-pm@vger.kernel.org, pc@us.ibm.com, Anton Blanchard <anton@samba.org>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>, shreyas@linux.vnet.ibm.com,
 mpe@ellerman.id.au
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 28, 2016 at 6:25 PM, Shilpasri G Bhat
<shilpa.bhat@linux.vnet.ibm.com> wrote:
> In POWER8, OCC(On-Chip-Controller) can throttle the frequency of the
> CPU when the chip crosses its thermal and power limits. Currently,
> powernv-cpufreq driver detects and reports this event as a console
> message. Some machines may not sustain the max turbo frequency in all
> conditions and can be throttled frequently. This can lead to the
> flooding of console with throttle messages. So this patchset aims to
> redesign the presentation of this event via sysfs counters and
> tracepoints. And it also fixes couple of bugs reported in the driver.
>
> - Patch [1] fixes a memory leak bug
> - Patch [2] fixes the cpu hot-plug bug in powernv_cpufreq_work_fn().
> - Patch [3] solves a bug in powernv_cpufreq_throttle_check(), which
>   calls in to cpu_to_chip_id() in hot path which reads DT every time
>   to find the chip id.
> - Patches [4] to [6] will add a perf trace point
>   "power:powernv_throttle" and sysfs throttle counter stats in
>   /sys/devices/system/cpu/cpufreq/chipN.
>

Looks good to me. You've got the reviews and acks you need.

Balbir Singh
