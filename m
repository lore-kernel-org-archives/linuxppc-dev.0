Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C8D611A1A02
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 19:27:04 +1100 (AEDT)
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4648E140A98
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 19:27:04 +1100 (AEDT)
Received: by mail-pa0-x22a.google.com with SMTP id yy13so19528861pab.3
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 00:27:04 -0800 (PST)
Date: Thu, 28 Jan 2016 13:57:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 rjw@rjwysocki.net, linux-pm@vger.kernel.org, pc@us.ibm.com,
 anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com,
 bsingharora@gmail.com, mpe@ellerman.id.au
Subject: Re: [PATCH v7 1/6] cpufreq: powernv: Free 'chips' on module exit
Message-ID: <20160128082700.GH3935@vireshk>
References: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1453965941-7363-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453965941-7363-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28-01-16, 12:55, Shilpasri G Bhat wrote:
> This will free the dynamically allocated memory of'chips' on
> module exit.

Though it has a 'space' issues before 'chips', but I don't really care
much about that and so you aren't required to resend, unless you have
to send a v8 for something else.

> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 547890f..53f980b 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -612,6 +612,7 @@ static void __exit powernv_cpufreq_exit(void)
>  	unregister_reboot_notifier(&powernv_cpufreq_reboot_nb);
>  	opal_message_notifier_unregister(OPAL_MSG_OCC,
>  					 &powernv_cpufreq_opal_nb);
> +	kfree(chips);
>  	cpufreq_unregister_driver(&powernv_cpufreq_driver);
>  }
>  module_exit(powernv_cpufreq_exit);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
