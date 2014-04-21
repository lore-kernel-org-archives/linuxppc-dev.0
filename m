Return-Path: <viresh.kumar@linaro.org>
Received: from mail-ob0-f171.google.com (mail-ob0-f171.google.com
 [209.85.214.171])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6F02B1400B0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 15:51:51 +1000 (EST)
Received: by mail-ob0-f171.google.com with SMTP id uy5so3873122obc.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Apr 2014 22:51:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1397728407-13909-1-git-send-email-geert+renesas@glider.be>
References: <1397728407-13909-1-git-send-email-geert+renesas@glider.be>
Date: Mon, 21 Apr 2014 11:21:48 +0530
Message-ID: <CAKohpon6BvgtwrHWQn8va49ZbNF0XbDDHf4ytP=vA5zudRYzgg@mail.gmail.com>
Subject: Re: [PATCH 1/3] cpufreq: ppc: Add missing #include <asm/smp.h>
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17 April 2014 15:23, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> If CONFIG_SMP=n, <linux/smp.h> does not include <asm/smp.h>, causing:
>
> drivers/cpufreq/ppc-corenet-cpufreq.c: In function 'corenet_cpufreq_cpu_init':
> drivers/cpufreq/ppc-corenet-cpufreq.c:173:3: error: implicit declaration of function 'get_hard_smp_processor_id' [-Werror=implicit-function-declaration]
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/cpufreq/ppc-corenet-cpufreq.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
> index b7e677be1df0..e78f9c806de4 100644
> --- a/drivers/cpufreq/ppc-corenet-cpufreq.c
> +++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
> @@ -22,6 +22,8 @@
>  #include <linux/smp.h>
>  #include <sysdev/fsl_soc.h>
>
> +#include <asm/smp.h>
> +

Probably similar to what Srivatsa did:

+#include <asm/smp.h> /* Required for cpu_sibling_mask() in UP configs */

??
