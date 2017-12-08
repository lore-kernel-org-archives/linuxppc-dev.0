Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x242.google.com (mail-ua0-x242.google.com
 [IPv6:2607:f8b0:400c:c08::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ytJBj22FVzDrZW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Dec 2017 14:44:45 +1100 (AEDT)
Received: by mail-ua0-x242.google.com with SMTP id q13so6724898uaq.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Dec 2017 19:44:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1512626365-22845-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1512626365-22845-1-git-send-email-ego@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Fri, 8 Dec 2017 14:44:40 +1100
Message-ID: <CAKTCnzkWRm6BOoHLvO+rTmXh8frCJW4uGuccHLSW+WQnWseuhQ@mail.gmail.com>
Subject: Re: [v2 PATCH] cpufreq: powernv: Correctly parse the sign of pstates
 on POWER8 vs POWER9
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, huntbag@linux.vnet.ibm.com,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 7, 2017 at 4:59 PM, Gautham R. Shenoy
<ego@linux.vnet.ibm.com> wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> On POWERNV platform, Pstates are 8-bit values. On POWER8 they are
> negatively numbered while on POWER9 they are positively
> numbered. Thus, on POWER9, the maximum number of pstates could be as
> high as 256.
>
> The current code interprets pstates as a signed 8-bit value. This
> causes a problem on POWER9 platforms which have more than 128 pstates.
> On such systems, on a CPU that is in a lower pstate whose number is
> greater than 128, querying the current pstate returns a "pstate X is
> out of bound" error message and the current pstate is reported as the
> nominal pstate.
>
> This patch fixes the aforementioned issue by correctly differentiating
> the sign whenever a pstate value read, depending on whether the
> pstates are positively numbered or negatively numbered.

Yikes! Is there no better way of fixing this?

>
> Fixes: commit 09ca4c9b5958 ("cpufreq: powernv: Replacing pstate_id with frequency table index")
> Cc: <stable@vger.kernel.org> #v4.8
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Tested-and-reviewed-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 43 ++++++++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index b6d7c4c..bb7586e 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -41,11 +41,14 @@
>  #define POWERNV_MAX_PSTATES    256
>  #define PMSR_PSAFE_ENABLE      (1UL << 30)
>  #define PMSR_SPR_EM_DISABLE    (1UL << 31)
> -#define PMSR_MAX(x)            ((x >> 32) & 0xFF)
> +#define EXTRACT_BYTE(x, shift) (((x) >> shift) & 0xFF)
> +#define MAX_SHIFT              32
>  #define LPSTATE_SHIFT          48
>  #define GPSTATE_SHIFT          56
> -#define GET_LPSTATE(x)         (((x) >> LPSTATE_SHIFT) & 0xFF)
> -#define GET_GPSTATE(x)         (((x) >> GPSTATE_SHIFT) & 0xFF)
> +#define GET_PMSR_MAX(x)                EXTRACT_BYTE(x, MAX_SHIFT)
> +#define GET_LPSTATE(x)         EXTRACT_BYTE(x, LPSTATE_SHIFT)
> +#define GET_GPSTATE(x)         EXTRACT_BYTE(x, GPSTATE_SHIFT)
> +

Can you hide all of this in pstate_to_idx(), do the casting inside? I
was reviewing this
code earlier before being distracted with something else, this did
come across as
strange and I was looking at using abs values to simplify the code,
but I did not get
to it.

Balbir Singh.
