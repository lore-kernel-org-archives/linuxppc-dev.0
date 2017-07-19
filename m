Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pg0-x22a.google.com (mail-pg0-x22a.google.com
 [IPv6:2607:f8b0:400e:c05::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC6n13nr6zDrTG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 16:38:45 +1000 (AEST)
Received: by mail-pg0-x22a.google.com with SMTP id k14so25731939pgr.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 23:38:45 -0700 (PDT)
Date: Wed, 19 Jul 2017 12:08:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Patrice Chotard <patrice.chotard@st.com>, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 kernel@stlinux.com
Subject: Re: [PATCH] cpufreq: Convert to using %pOF instead of full_name
Message-ID: <20170719063840.GD352@vireshk-i7>
References: <20170718214339.7774-14-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170718214339.7774-14-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18-07-17, 16:42, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: kernel@stlinux.com
> ---
>  drivers/cpufreq/pmac64-cpufreq.c | 2 +-
>  drivers/cpufreq/sti-cpufreq.c    | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
> index 267e0894c62d..be623dd7b9f2 100644
> --- a/drivers/cpufreq/pmac64-cpufreq.c
> +++ b/drivers/cpufreq/pmac64-cpufreq.c
> @@ -516,7 +516,7 @@ static int __init g5_pm72_cpufreq_init(struct device_node *cpunode)
>  		goto bail;
>  	}
> 
> -	DBG("cpufreq: i2c clock chip found: %s\n", hwclock->full_name);
> +	DBG("cpufreq: i2c clock chip found: %pOF\n", hwclock);
> 
>  	/* Now get all the platform functions */
>  	pfunc_cpu_getfreq =
> diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
> index d2d0430d09d4..47105735df12 100644
> --- a/drivers/cpufreq/sti-cpufreq.c
> +++ b/drivers/cpufreq/sti-cpufreq.c
> @@ -65,8 +65,8 @@ static int sti_cpufreq_fetch_major(void) {
>  	ret = of_property_read_u32_index(np, "st,syscfg",
>  					 MAJOR_ID_INDEX, &major_offset);
>  	if (ret) {
> -		dev_err(dev, "No major number offset provided in %s [%d]\n",
> -			np->full_name, ret);
> +		dev_err(dev, "No major number offset provided in %pOF [%d]\n",
> +			np, ret);
>  		return ret;
>  	}
> 
> @@ -92,8 +92,8 @@ static int sti_cpufreq_fetch_minor(void)
>  					 MINOR_ID_INDEX, &minor_offset);
>  	if (ret) {
>  		dev_err(dev,
> -			"No minor number offset provided %s [%d]\n",
> -			np->full_name, ret);
> +			"No minor number offset provided %pOF [%d]\n",
> +			np, ret);
>  		return ret;
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
