Return-Path: <SRS0=XJaO=A2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50B2C433E1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 15:34:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47069206D5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 15:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47069206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B6Lzc4NW9zDql9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 01:34:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.167.196;
 helo=mail-oi1-f196.google.com; envelope-from=rjwysocki@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B6LvY0QZDzDqjl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2020 01:31:20 +1000 (AEST)
Received: by mail-oi1-f196.google.com with SMTP id h17so2524028oie.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2020 08:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BBW6K8+TvI8uJGpxP7UFZC6IWDomv3WMlukBT2EREJ8=;
 b=Gd66mKw43hg4aq/kLN4y8LldSvV0y+iUPwp/wred1IxcTd4SCGYtewjBGQJlXJBUZY
 nHJiad9MUZosyDUZk9cqGi1BCAfS142xXmI9xomMAcCROnozdsyamddKLCpOnI1XbMzF
 OemL2EEGJKSCHME8+qHZhaq538HFcGCWQpiuCHaY81Q0egc1+riT76n0tDyXk8URnDQV
 rR5cWuuObMcNBolm7VQWq5nb1A1r56YYtuIQGdfUSGWsKjZB904BDlS0qqDgoZ/eDBX7
 hKRBxhrQ3HOkMw7n6SrIWk3Cou8dT+aD3JXM52hKgEycKicifb6owEffrbof+FKNn9L0
 IUXw==
X-Gm-Message-State: AOAM531nOhOYSAHkomb+kXDYa/zyAKnbKo4hCoXUwE+eDMcKUIz9Jdr3
 NDG9TKtawtderCEBnPyKK2g2fPYXu37VfHMZhns=
X-Google-Smtp-Source: ABdhPJyPcMAbwjPmcWXoE1l3sJ3/XyN5pkKKHAxynAZQ8Iv3h7e9wh++pvMgo+IR4QFp5JObqq90pO3v8JlDpOpXUmQ=
X-Received: by 2002:a54:4e87:: with SMTP id c7mr251044oiy.110.1594827078031;
 Wed, 15 Jul 2020 08:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200714142355.29819-1-weiyongjun1@huawei.com>
In-Reply-To: <20200714142355.29819-1-weiyongjun1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Jul 2020 17:31:06 +0200
Message-ID: <CAJZ5v0j17uaQ6zUufyn8LeKS88kS5GQLOMFF0QkNR4dP5-7+ZQ@mail.gmail.com>
Subject: Re: [PATCH -next] cpufreq: powernv: Make some symbols static
To: Wei Yongjun <weiyongjun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hulk Robot <hulkci@huawei.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jul 14, 2020 at 4:14 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> The sparse tool complains as follows:
>
> drivers/cpufreq/powernv-cpufreq.c:88:1: warning:
>  symbol 'pstate_revmap' was not declared. Should it be static?
> drivers/cpufreq/powernv-cpufreq.c:383:18: warning:
>  symbol 'cpufreq_freq_attr_cpuinfo_nominal_freq' was not declared. Should it be static?
> drivers/cpufreq/powernv-cpufreq.c:669:6: warning:
>  symbol 'gpstate_timer_handler' was not declared. Should it be static?
> drivers/cpufreq/powernv-cpufreq.c:902:6: warning:
>  symbol 'powernv_cpufreq_work_fn' was not declared. Should it be static?
>
> Those symbols are not used outside of this file, so mark
> them static.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 8646eb197cd9..cf118263ec65 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -85,7 +85,7 @@ struct global_pstate_info {
>
>  static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
>
> -DEFINE_HASHTABLE(pstate_revmap, POWERNV_MAX_PSTATES_ORDER);
> +static DEFINE_HASHTABLE(pstate_revmap, POWERNV_MAX_PSTATES_ORDER);
>  /**
>   * struct pstate_idx_revmap_data: Entry in the hashmap pstate_revmap
>   *                               indexed by a function of pstate id.
> @@ -380,7 +380,7 @@ static ssize_t cpuinfo_nominal_freq_show(struct cpufreq_policy *policy,
>                 powernv_freqs[powernv_pstate_info.nominal].frequency);
>  }
>
> -struct freq_attr cpufreq_freq_attr_cpuinfo_nominal_freq =
> +static struct freq_attr cpufreq_freq_attr_cpuinfo_nominal_freq =
>         __ATTR_RO(cpuinfo_nominal_freq);
>
>  #define SCALING_BOOST_FREQS_ATTR_INDEX         2
> @@ -666,7 +666,7 @@ static inline void  queue_gpstate_timer(struct global_pstate_info *gpstates)
>   * according quadratic equation. Queues a new timer if it is still not equal
>   * to local pstate
>   */
> -void gpstate_timer_handler(struct timer_list *t)
> +static void gpstate_timer_handler(struct timer_list *t)
>  {
>         struct global_pstate_info *gpstates = from_timer(gpstates, t, timer);
>         struct cpufreq_policy *policy = gpstates->policy;
> @@ -899,7 +899,7 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>         .notifier_call = powernv_cpufreq_reboot_notifier,
>  };
>
> -void powernv_cpufreq_work_fn(struct work_struct *work)
> +static void powernv_cpufreq_work_fn(struct work_struct *work)
>  {
>         struct chip *chip = container_of(work, struct chip, throttle);
>         struct cpufreq_policy *policy;
>

Applied as 5.9 material, thanks!
