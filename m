Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x243.google.com (mail-ua0-x243.google.com
 [IPv6:2607:f8b0:400c:c08::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xVlK6CFdzDrbW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 00:51:09 +1000 (AEST)
Received: by mail-ua0-x243.google.com with SMTP id d4-v6so15182396ual.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 07:51:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527768909-32637-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1527768909-32637-1-git-send-email-ego@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Fri, 1 Jun 2018 00:51:05 +1000
Message-ID: <CAKTCnz=WhC_vamKPZruEqc04WKpD5ZqZm0zTcCtagRHib6OZPw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle:powernv: Make the snooze timeout dynamic.
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 31, 2018 at 10:15 PM, Gautham R. Shenoy
<ego@linux.vnet.ibm.com> wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> The commit 78eaa10f027c ("cpuidle: powernv/pseries: Auto-promotion of
> snooze to deeper idle state") introduced a timeout for the snooze idle
> state so that it could be eventually be promoted to a deeper idle
> state. The snooze timeout value is static and set to the target
> residency of the next idle state, which would train the cpuidle
> governor to pick the next idle state eventually.
>
> The unfortunate side-effect of this is that if the next idle state(s)
> is disabled, the CPU will forever remain in snooze, despite the fact
> that the system is completely idle, and other deeper idle states are
> available.
>
> This patch fixes the issue by dynamically setting the snooze timeout
> to the target residency of the next enabled state on the device.
>
> Before Patch
> ==================
> POWER8 : Only nap disabled.
>  $cpupower monitor sleep 30
> sleep took 30.01297 seconds and exited with status 0
>               |Idle_Stats
> PKG |CORE|CPU | snoo | Nap  | Fast
>    0|   8|   0| 96.41|  0.00|  0.00
>    0|   8|   1| 96.43|  0.00|  0.00
>    0|   8|   2| 96.47|  0.00|  0.00
>    0|   8|   3| 96.35|  0.00|  0.00
>    0|   8|   4| 96.37|  0.00|  0.00
>    0|   8|   5| 96.37|  0.00|  0.00
>    0|   8|   6| 96.47|  0.00|  0.00
>    0|   8|   7| 96.47|  0.00|  0.00
>
> POWER9: Shallow states (stop0lite, stop1lite, stop2lite, stop0, stop1,
> stop2) disabled:
> $cpupower monitor sleep 30
> sleep took 30.05033 seconds and exited with status 0
>               |Idle_Stats
> PKG |CORE|CPU | snoo | stop | stop | stop | stop | stop | stop | stop | stop
>    0|  16|   0| 89.79|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00
>    0|  16|   1| 90.12|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00
>    0|  16|   2| 90.21|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00
>    0|  16|   3| 90.29|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00
>
> After Patch
> ======================
> POWER8 : Only nap disabled.
> $ cpupower monitor sleep 30
> sleep took 30.01200 seconds and exited with status 0
>               |Idle_Stats
> PKG |CORE|CPU | snoo | Nap  | Fast
>    0|   8|   0| 16.58|  0.00| 77.21
>    0|   8|   1| 18.42|  0.00| 75.38
>    0|   8|   2|  4.70|  0.00| 94.09
>    0|   8|   3| 17.06|  0.00| 81.73
>    0|   8|   4|  3.06|  0.00| 95.73
>    0|   8|   5|  7.00|  0.00| 96.80
>    0|   8|   6|  1.00|  0.00| 98.79
>    0|   8|   7|  5.62|  0.00| 94.17
>
> POWER9: Shallow states (stop0lite, stop1lite, stop2lite, stop0, stop1,
> stop2) disabled:
>
> $cpupower monitor sleep 30
> sleep took 30.02110 seconds and exited with status 0
>               |Idle_Stats
> PKG |CORE|CPU | snoo | stop | stop | stop | stop | stop | stop | stop | stop
>    0|   0|   0|  0.69|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  9.39| 89.70
>    0|   0|   1|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.05| 93.21
>    0|   0|   2|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00| 89.93
>    0|   0|   3|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00| 93.26
>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  drivers/cpuidle/cpuidle-powernv.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 1a8234e..d29e4f0 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -43,9 +43,31 @@ struct stop_psscr_table {
>
>  static struct stop_psscr_table stop_psscr_table[CPUIDLE_STATE_MAX] __read_mostly;
>
> -static u64 snooze_timeout __read_mostly;
> +static u64 default_snooze_timeout __read_mostly;
>  static bool snooze_timeout_en __read_mostly;
>
> +static u64 get_snooze_timeout(struct cpuidle_device *dev,
> +                             struct cpuidle_driver *drv,
> +                             int index)
> +{
> +       int i;
> +
> +       if (unlikely(!snooze_timeout_en))
> +               return default_snooze_timeout;
> +
> +       for (i = index + 1; i < drv->state_count; i++) {
> +               struct cpuidle_state *s = &drv->states[i];
> +               struct cpuidle_state_usage *su = &dev->states_usage[i];
> +
> +               if (s->disabled || su->disable)
> +                       continue;
> +
> +               return s->target_residency * tb_ticks_per_usec;

Can we ensure this is not prone to overflow?

Otherwise looks good

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
