Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qTcXV3btyzDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 13:46:34 +1100 (AEDT)
Received: from mail-pf0-x235.google.com (mail-pf0-x235.google.com
 [IPv6:2607:f8b0:400e:c00::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qTcXT62YFz9s4n
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Mar 2016 13:46:33 +1100 (AEDT)
Received: by mail-pf0-x235.google.com with SMTP id x3so289128367pfb.1
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Mar 2016 19:46:33 -0700 (PDT)
Date: Tue, 22 Mar 2016 08:16:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 ego@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
 shreyas@linux.vnet.ibm.com, linux-api@vger.kernel.org
Subject: Re: [PATCH v11] cpufreq: powernv: Add sysfs attributes to show
 throttle stats
Message-ID: <20160322024627.GP27778@vireshk-i7>
References: <1458579591-27573-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458579591-27573-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21-03-16, 22:29, Shilpasri G Bhat wrote:
> +	create_throttle_sysfs = kcalloc(cpu_nr_cores(), sizeof(bool),
> +					GFP_KERNEL);
> +	if (!create_throttle_sysfs) {
> +		kfree(chips);
> +		return -ENOMEM;
> +	}
> +
>  	for (i = 0; i < nr_chips; i++) {
>  		chips[i].id = chip[i];
>  		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
> @@ -582,6 +655,7 @@ static int init_chip_info(void)
>  
>  static inline void clean_chip_info(void)
>  {
> +	kfree(create_throttle_sysfs);
>  	kfree(chips);
>  }

Why do you need this at all?. You can use policy->driver data, isn't
it ?

-- 
viresh
