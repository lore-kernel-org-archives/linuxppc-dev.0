Return-Path: <viresh.linux@gmail.com>
Received: from mail-ve0-f179.google.com (mail-ve0-f179.google.com
 [209.85.128.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2AC7B2C00DA
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2013 00:52:31 +1100 (EST)
Received: by mail-ve0-f179.google.com with SMTP id cz11so1323114veb.10
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2013 06:52:29 -0700 (PDT)
MIME-Version: 1.0
Sender: viresh.linux@gmail.com
In-Reply-To: <1364536350-23788-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1364536350-23788-1-git-send-email-Yuantian.Tang@freescale.com>
Date: Sat, 30 Mar 2013 19:22:28 +0530
Message-ID: <CAOh2x=k2cchYWnX0AitOjCOfP_mC-=cm2sm4qhrGv0S9ywzP2g@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: Add cpufreq driver for Freescale e500mc SoCs
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yuantian.Tang@freescale.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linuxppc-dev@lists.ozlabs.org,
 "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>,
 Linux PM list <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 29, 2013 at 11:22 AM,  <Yuantian.Tang@freescale.com> wrote:
> diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c

> +static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{

> +       for (i = 0; i < count; i++) {
> +               table[i].index = i;

One more thing, you don't need to set index at all as you aren't using it.
And cpufreq core never uses it.

> +               clk = of_clk_get(data->parent, i);
> +               table[i].frequency = clk_get_rate(clk) / 1000;
> +       }
