Return-Path: <viresh.kumar@linaro.org>
Received: from mail-ob0-f172.google.com (mail-ob0-f172.google.com
 [209.85.214.172])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1938A2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 15:32:25 +1000 (EST)
Received: by mail-ob0-f172.google.com with SMTP id wo10so11977526obc.17
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 22:32:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
References: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
Date: Wed, 24 Jul 2013 11:02:22 +0530
Message-ID: <CAKohponpyksxDUhawK4U76D9RWEriK0etmMuZWY08GNpUha-Hg@mail.gmail.com>
Subject: Re: [PATCH 1/3] cpufreq: pmac64: speed up frequency switch
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Nick Piggin <npiggin@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24 July 2013 01:54, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Some functions on switch path use msleep() which is inaccurate, and
> depends on HZ. With HZ=100 msleep(1) takes actually over ten times longer.
> Using usleep_range() we get more accurate sleeps.
>
> I measured the "pfunc_slewing_done" polling to take 300us at max (on
> 2.3GHz dual-processor Xserve G5), so using 500us sleep there should
> be fine.
>
> With the patch, g5_switch_freq() duration drops from ~50ms to ~10ms on
> Xserve with HZ=100.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  drivers/cpufreq/pmac64-cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Looks fine to me as well..

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
