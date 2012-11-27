Return-Path: <lenb417@gmail.com>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BF63E2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2012 17:14:36 +1100 (EST)
Received: by mail-qa0-f51.google.com with SMTP id t11so4205994qaa.17
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 22:14:33 -0800 (PST)
Sender: Len Brown <lenb417@gmail.com>
Message-ID: <50B45A47.9050600@kernel.org>
Date: Tue, 27 Nov 2012 01:14:31 -0500
From: Len Brown <lenb@kernel.org>
MIME-Version: 1.0
To: Preeti Murthy <preeti.lkml@gmail.com>
Subject: Re: [PATCH] cpuidle: Measure idle state durations with monotonic clock
References: <CAODwPW873M32d9zFT9fpJT9+PuMbz8htzUxdF1TNE+J1zR3jYA@mail.gmail.com>
 <1352944590-8776-1-git-send-email-jwerner@chromium.org>
 <CAM4v1pPhaP=pVnFMXUU_nmrOxhY5yPNtbBdQsT5MH37MndK6LQ@mail.gmail.com>
In-Reply-To: <CAM4v1pPhaP=pVnFMXUU_nmrOxhY5yPNtbBdQsT5MH37MndK6LQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kevin Hilman <khilman@ti.com>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 Trinabh Gupta <g.trinabh@gmail.com>,
 Lists Linaro-dev <linaro-dev@lists.linaro.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-pm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 Julius Werner <jwerner@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Sameer Nanda <snanda@chromium.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/15/2012 04:04 AM, Preeti Murthy wrote:
> Hi all,
> 
> The code looks correct and inviting to me as it has led to good cleanups.
> I dont think passing 0 as the argument to the function
> sched_clock_idle_wakeup_event()
> should lead to problems,as it does not do anything useful with the
> passed arguments.
> 
> My only curiosity is what was the purpose of passing idle residency time to
> sched_clock_idle_wakeup_event() when this data could always be retrieved from
> dev->last_residency for each cpu,which gets almost immediately updated.

sched_clock_idle_wakeup_event() is part of the scheduler.
The scheduler doesn't know what a cpuidle_device is, and
probably should not grow such a dependency.

cheers,
-Len Brown, Intel Open Source Technology Center

> But this does not seem to come in way of this patch for now.Anyway I
> have added Peter to
> the list so that he can opine about this issue if possible and needed.
> 
> Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> 
> 
> Regards
> Preeti U Murthy
> 
