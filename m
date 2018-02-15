Return-Path: <lvivier@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zht3K45XMzF1Jv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 21:35:56 +1100 (AEDT)
Subject: Re: [PATCH v2] powerpc/via-pmu: Fix section mismatch warning
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20180207194439.32680-1-malat@debian.org>
 <20180214211519.15683-1-malat@debian.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <ff457b6d-3bc4-f6c1-42da-65fec78e5978@redhat.com>
Date: Thu, 15 Feb 2018 11:35:50 +0100
MIME-Version: 1.0
In-Reply-To: <20180214211519.15683-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/02/2018 22:15, Mathieu Malaterre wrote:
> Make the struct via_pmu_driver const to avoid following warning:
> 
> WARNING: vmlinux.o(.data+0x4739c): Section mismatch in reference from the variable via_pmu_driver to the function .init.text:pmu_init()
> The variable via_pmu_driver references
> the function __init pmu_init()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Suggested-by: Laurent Vivier <lvivier@redhat.com>
> ---
> v2: pmu_init() is really an init function, leave __init marker
> 
>  drivers/macintosh/via-pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
> index 94c0f3f7df69..fc56c7067732 100644
> --- a/drivers/macintosh/via-pmu.c
> +++ b/drivers/macintosh/via-pmu.c
> @@ -198,7 +198,7 @@ static const struct file_operations pmu_battery_proc_fops;
>  static const struct file_operations pmu_options_proc_fops;
>  
>  #ifdef CONFIG_ADB
> -struct adb_driver via_pmu_driver = {
> +const struct adb_driver via_pmu_driver = {
>  	"PMU",
>  	pmu_probe,
>  	pmu_init,
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
