Return-Path: <preeti.lkml@gmail.com>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 21E972C01FA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 20:04:43 +1100 (EST)
Received: by mail-vc0-f179.google.com with SMTP id f13so1363865vcb.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 01:04:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1352944590-8776-1-git-send-email-jwerner@chromium.org>
References: <CAODwPW873M32d9zFT9fpJT9+PuMbz8htzUxdF1TNE+J1zR3jYA@mail.gmail.com>
 <1352944590-8776-1-git-send-email-jwerner@chromium.org>
Date: Thu, 15 Nov 2012 14:34:41 +0530
Message-ID: <CAM4v1pPhaP=pVnFMXUU_nmrOxhY5yPNtbBdQsT5MH37MndK6LQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Measure idle state durations with monotonic clock
From: Preeti Murthy <preeti.lkml@gmail.com>
To: Julius Werner <jwerner@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kevin Hilman <khilman@ti.com>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 Trinabh Gupta <g.trinabh@gmail.com>,
 Lists Linaro-dev <linaro-dev@lists.linaro.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-pm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org,
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

Hi all,

The code looks correct and inviting to me as it has led to good cleanups.
I dont think passing 0 as the argument to the function
sched_clock_idle_wakeup_event()
should lead to problems,as it does not do anything useful with the
passed arguments.

My only curiosity is what was the purpose of passing idle residency time to
sched_clock_idle_wakeup_event() when this data could always be retrieved from
dev->last_residency for each cpu,which gets almost immediately updated.

But this does not seem to come in way of this patch for now.Anyway I
have added Peter to
the list so that he can opine about this issue if possible and needed.

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>


Regards
Preeti U Murthy
