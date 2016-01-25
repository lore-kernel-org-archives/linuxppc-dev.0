Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D15A1A02E6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 16:49:27 +1100 (AEDT)
Received: from mail-pf0-x22b.google.com (mail-pf0-x22b.google.com
 [IPv6:2607:f8b0:400e:c00::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 79445140326
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jan 2016 16:49:26 +1100 (AEDT)
Received: by mail-pf0-x22b.google.com with SMTP id q63so78489868pfb.1
 for <linuxppc-dev@ozlabs.org>; Sun, 24 Jan 2016 21:49:26 -0800 (PST)
Date: Mon, 25 Jan 2016 11:19:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 rjw@rjwysocki.net, linux-pm@vger.kernel.org, pc@us.ibm.com,
 anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com
Subject: Re: [PATCH v6 1/5] cpufreq: powernv: Hot-plug safe the kworker thread
Message-ID: <20160125054920.GA3183@vireshk>
References: <1453447145-17722-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1453447145-17722-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453447145-17722-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22-01-16, 12:49, Shilpasri G Bhat wrote:
> In the kworker_thread powernv_cpufreq_work_fn(), we can end up
> sending an IPI to a cpu going offline. This is a rare corner case
> which is fixed using {get/put}_online_cpus(). Along with this fix,
> this patch adds changes to do oneshot cpumask_{clear/and} operation.
> 
> Suggested-by: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
> Suggested-by: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
> Changes form v5:
> - Fix the kbuild-error:
> drivers/cpufreq/powernv-cpufreq.c:428:2: error: implicit declaration of
> function 'get_online_cpus' [-Werror=implicit-function-declaration
> 
>  drivers/cpufreq/powernv-cpufreq.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
