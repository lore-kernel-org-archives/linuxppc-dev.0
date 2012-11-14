Return-Path: <jwerner@google.com>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6B16A2C0081
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 04:16:02 +1100 (EST)
Received: by mail-wg0-f45.google.com with SMTP id dq12so323189wgb.14
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2012 09:15:58 -0800 (PST)
MIME-Version: 1.0
Sender: jwerner@google.com
In-Reply-To: <50A37ADD.8040000@linaro.org>
References: <1352843563-16392-1-git-send-email-jwerner@chromium.org>
 <50A37ADD.8040000@linaro.org>
Date: Wed, 14 Nov 2012 09:15:58 -0800
Message-ID: <CAODwPW873M32d9zFT9fpJT9+PuMbz8htzUxdF1TNE+J1zR3jYA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Measure idle state durations with monotonic clock
From: Julius Werner <jwerner@chromium.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
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

> Maybe you can remove all these computations and set the flag
> en_core_tk_irqen for the driver ? That will be handled by the cpuidle
> framework, no ?
>
> Same comment for the intel_idle driver.

Yeah, I thought about that, too. I was a little too afraid of touching
the sched_clock_idle_wakeup_event() parameter that is tied to the
measurement, but it seems to have been vestigial for some time now and
other drivers also just set it 0. I will whip up another version of
the patch (won't change the PPC further though, if this version works
I would just leave it at that... thanks for testing, Deepthi).
