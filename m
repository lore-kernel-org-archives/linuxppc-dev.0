Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F3BE2C033E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 21:52:27 +1100 (EST)
Received: by mail-bk0-f51.google.com with SMTP id ik5so602206bkc.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 02:52:24 -0800 (PST)
Message-ID: <50A4C963.9060808@linaro.org>
Date: Thu, 15 Nov 2012 11:52:19 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Julius Werner <jwerner@chromium.org>
Subject: Re: [PATCH] cpuidle: Measure idle state durations with monotonic clock
References: <CAODwPW873M32d9zFT9fpJT9+PuMbz8htzUxdF1TNE+J1zR3jYA@mail.gmail.com>
 <1352944590-8776-1-git-send-email-jwerner@chromium.org>
In-Reply-To: <1352944590-8776-1-git-send-email-jwerner@chromium.org>
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Hilman <khilman@ti.com>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 Trinabh Gupta <g.trinabh@gmail.com>,
 Lists Linaro-dev <linaro-dev@lists.linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
 linux-acpi@vger.kernel.org,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Sameer Nanda <snanda@chromium.org>, Len Brown <lenb@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/15/2012 02:56 AM, Julius Werner wrote:
> Many cpuidle drivers measure their time spent in an idle state by
> reading the wallclock time before and after idling and calculating the
> difference. This leads to erroneous results when the wallclock time gets
> updated by another processor in the meantime, adding that clock
> adjustment to the idle state's time counter.
> 
> If the clock adjustment was negative, the result is even worse due to an
> erroneous cast from int to unsigned long long of the last_residency
> variable. The negative 32 bit integer will zero-extend and result in a
> forward time jump of roughly four billion milliseconds or 1.3 hours on
> the idle state residency counter.
> 
> This patch changes all affected cpuidle drivers to either use the
> monotonic clock for their measurements or make use of the generic time
> measurement wrapper in cpuidle.c, which was already working correctly.
> Some superfluous CLIs/STIs in the ACPI code are removed (interrupts
> should always already be disabled before entering the idle function, and
> not get reenabled until the generic wrapper has performed its second
> measurement). It also removes the erroneous cast, making sure that
> negative residency values are applied correctly even though they should
> not appear anymore.
> 
> Signed-off-by: Julius Werner <jwerner@chromium.org>

Tested on a Core 2 Duo (processor_idle driver).

Tested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
