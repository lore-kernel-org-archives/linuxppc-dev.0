Return-Path: <linuxppc-dev+bounces-21715-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4E1CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 12:25:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRjH3605Cz2ySg;
	Fri, 29 May 2026 22:25:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780057503;
	cv=none; b=iqECJ4JIeC0ba+Zvm1triP1CAksWPCLXqcycJvYWpHJlXNMCGDv0Qlj2ChYsheGhip8bbnu8+EWMDys5WeUWs3+VHL+T8ZSO4Dglp3IPykcnRPhCrsudV3Lj1317NkGnMyI5sx5VuwEZzapJPI2QusHvTBWZjTN0fgYAyBuww6U3N78ixsThfCk4TpEJrylKP6qU9PIV/RrPXDdXmRaVo0gL6SsC3oA8Sn6+996gPYGvL02o/n02JT/9Ru3BLizGaAvRgaCSr/18Q1tt6NMtlEUfTO37+5WJcAr6UZTGYYHfZi0WLHOPTH8lOCXRc4rAO8stPfRyxGISBxYNAespXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780057503; c=relaxed/relaxed;
	bh=gVmSosWVR03VFqHWnt6o4akcFkrY0K1Ci86tJ8TgpAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGWr40zOhGcA9ISuhrFnHa7aDmSpC6EIrbsKLS/Hcdmmoeo+MUrv7XwdTbln86HEEf1PvCY6MuzBy5zIm5xiX9k0xBirMsUKaVJU6JA1Lkf3zctZBPomPQhwiKzOyO5hkAgoJqcghL/kizBnprbThR/eRhtMz5TWimuJ3SU0n7EbP415QIQ/L0/meItRlTzleKYrbfxgTEi13tlaMsQp5sY64WCRuVqYQU3+YopuvVVDHS5Z1ZcRGww2YybkWnYwjHJDyFqhIM/Y6oH/lEhvjI2BYvcygj2k/EScyql9rdJ0tIuVeAasyG2zQIkhWt91FIccd4BawRBrYngpWU+qhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=aPrsjUKC; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=aPrsjUKC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRjH00zQxz2yQL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 22:24:58 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45FEC204C;
	Fri, 29 May 2026 05:24:20 -0700 (PDT)
Received: from [10.57.37.50] (unknown [10.57.37.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16BE13F632;
	Fri, 29 May 2026 05:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780057465; bh=fjbO4t8XdyU8NOb41mG4ChhG+m/bzPP3BywWNtdYqoA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aPrsjUKCk50s149VeWZk4F2Llmjdo90qP4DWtdM9ATKguxbUU6gRebVq07f2uJFK0
	 YVnIN2oOqMRDRFm11YWBgDWM/xTptKipB8Q9REDRnovKPHG2ooZaALp7Zti/C2KUQ+
	 b4qPfWs6v4eF/TgyfabaRYMbwAxOu8OUsO69761s=
Message-ID: <3a4e22fe-b8ce-4e62-9139-113e0cd4f16b@arm.com>
Date: Fri, 29 May 2026 13:24:02 +0100
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] psci: simplify hotplug_tests()
To: Yury Norov <ynorov@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Russell King <linux@armlinux.org.uk>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham
 <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 Heiko Stuebner <heiko@sntech.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Moritz Fischer <mdf@kernel.org>, Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Will Deacon <will@kernel.org>, Jiucheng Xu <jiucheng.xu@amlogic.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>,
 Linu Cherian <lcherian@marvell.com>,
 Gowthami Thiagarajan <gthiagarajan@marvell.com>,
 Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
 Khuong Dinh <khuong@os.amperecomputing.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Yury Norov <yury.norov@gmail.com>,
 Kees Cook <kees@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Besar Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>,
 Chengwen Feng <fengchengwen@huawei.com>,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-perf-users@vger.kernel.org, linux-acpi@vger.kernel.org,
 driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-fpga@vger.kernel.org,
 linux-rdma@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-cxl@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260528183625.870813-1-ynorov@nvidia.com>
 <20260528183625.870813-2-ynorov@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260528183625.870813-2-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-05-28 7:36 pm, Yury Norov wrote:
> Switch to pr_info("... %pbl"), and drop the temporary buffer allocation.

I would say this is simply an improvement in its own right, regardless 
of whether cpumap_print_to_pagebuf() deserves to be removed or not. For 
the change itself, FWIW,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> This prepares for removing cpumap_print_to_pagebuf().
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>   drivers/firmware/psci/psci_checker.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
> index e67ba9891082..ecd745bb90bf 100644
> --- a/drivers/firmware/psci/psci_checker.c
> +++ b/drivers/firmware/psci/psci_checker.c
> @@ -186,7 +186,6 @@ static int hotplug_tests(void)
>   {
>   	int i, nb_cpu_group, err = -ENOMEM;
>   	cpumask_var_t offlined_cpus, *cpu_groups;
> -	char *page_buf;
>   
>   	if (!alloc_cpumask_var(&offlined_cpus, GFP_KERNEL))
>   		return err;
> @@ -194,10 +193,6 @@ static int hotplug_tests(void)
>   	nb_cpu_group = alloc_init_cpu_groups(&cpu_groups);
>   	if (nb_cpu_group < 0)
>   		goto out_free_cpus;
> -	page_buf = (char *)__get_free_page(GFP_KERNEL);
> -	if (!page_buf)
> -		goto out_free_cpu_groups;
> -
>   	/*
>   	 * Of course the last CPU cannot be powered down and cpu_down() should
>   	 * refuse doing that.
> @@ -210,16 +205,11 @@ static int hotplug_tests(void)
>   	 * off, the cpu group itself should shut down.
>   	 */
>   	for (i = 0; i < nb_cpu_group; ++i) {
> -		ssize_t len = cpumap_print_to_pagebuf(true, page_buf,
> -						      cpu_groups[i]);
> -		/* Remove trailing newline. */
> -		page_buf[len - 1] = '\0';
> -		pr_info("Trying to turn off and on again group %d (CPUs %s)\n",
> -			i, page_buf);
> +		pr_info("Trying to turn off and on again group %d (CPUs %*pbl)\n",
> +			i, cpumask_pr_args(cpu_groups[i]));
>   		err += down_and_up_cpus(cpu_groups[i], offlined_cpus);
>   	}
>   
> -	free_page((unsigned long)page_buf);
>   out_free_cpu_groups:
>   	free_cpu_groups(nb_cpu_group, &cpu_groups);
>   out_free_cpus:


