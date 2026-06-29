Return-Path: <linuxppc-dev+bounces-23125-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22ECC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 18:47:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpwHl1MTyz2yH4;
	Tue, 30 Jun 2026 04:47:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782758835;
	cv=none; b=WpZfX7QY0Dku0iYprnzUa8tVfglOAqkq5eDw5oFqKbOQPQ/HEG91lHs6K8WYjcZQtk2sW7QkfO3Kqcr99JaH8Cjk5L2Y7uIZ5rttX7ntdkfeWrWos5JNE+2dzGC3sKgBrRwZVDLVNUkmw9rcQLL0KK15kJ7ozmct+ohUPFfvEbKNURsdmpd5CgZnteK6Fd6poReL847dEs3Ghub9PCIguCwJ/SOY215RIVZhgeXNkr9lT1hMBXAn3UVZpk3irnTl2iiiat4fLeVWU7Xx9YaVEqFg5Fmgzi2kHFcX3rkDRpwX7mEkqUmEUk7LjIgLO6hSaHKnzoC4BN/NgIbTKgGBMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782758835; c=relaxed/relaxed;
	bh=pSgBVAPBB9xsQxek5fY18KbTNXVt834G10JH70EWozU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2GTO7Q4LIN8HC4MrnsXIRfgqYsDnw9k6gYQTsiwEgbt7n28dIdzFPQvn4q7sgMPKm9WkBVwKttFjWzEB0L3297ZYMJn0Nf4X3PN2plRvK4ADz1kOP0iy1a18IrhrYii1upP8LP0VdgcGf7QFehmyVR/+dEBCiK8lVsZ6IKd0a57rDmJo3bz2HEXzX/GiD0BI0zZEPnAve/o+3MyEE0fdRfCctvIDo81x5eGuoMZ3d2vQVthOoX4ikb7WArv730jcwPV3C/t9gWRydMFYpHv8bwYy/rJV35CMW/YEVhrtQIsh/KSopRL/ue5J9u2ZI7xA+ZtaC0IDQ3A0kQ0/1s1XA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWtctKaJ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWtctKaJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpwHj34kWz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 04:47:13 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6E17360008;
	Mon, 29 Jun 2026 18:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B611A1F000E9;
	Mon, 29 Jun 2026 18:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782758830;
	bh=pSgBVAPBB9xsQxek5fY18KbTNXVt834G10JH70EWozU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NWtctKaJD+09V8wyK/qnFMLkpaS71wFZCmariqaedWVtN6lBpRx5GFIR36vzNb6HP
	 ZXqJpITx90gbGUpZiI0slDwKD6lDTj9EOTatt+KMP9thMuwO8SpHKnReAce/hEN3Lz
	 ni3iPsidb/vRw2cjnm0uHX+fFgtynD6XRfxxhtgmEnbKqSGhGNMj8DPTQEY3CY4Xv2
	 HbWOCFJPRZguXS22Qx/rfXMKgWGJyRg2qTukj07ZNmhasRm5zUPYspyo9zTZ/2UKbW
	 FjCxB5aWURUJFJTITAjFa2amfJd0I5TzYmRDS7bNvyXeACqoHZceqJZ5RHwasvQ93V
	 U25qoPHBtd4eg==
Message-ID: <20c972b7-02f1-4e92-8bb5-5696ae64696d@kernel.org>
Date: Mon, 29 Jun 2026 20:47:04 +0200
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
Subject: Re: [RFC 1/3] powerpc/perf: Register PMU from device tree and expose
 events
To: Shivani Nittor <shivani@linux.ibm.com>, maddy@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, atrajeev@linux.ibm.com, tshah@linux.ibm.com
References: <20260629061101.43119-1-shivani@linux.ibm.com>
 <20260629061101.43119-2-shivani@linux.ibm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260629061101.43119-2-shivani@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/06/2026 08:10, Shivani Nittor wrote:
> Introduce a DTS-based PMU driver that discovers PMU information
> from the device tree and registers a PowerPC PMU instance at
> runtime.
> 
> The driver parses basic PMU properties such as the number of
> counters and MMCR register definitions, creates sysfs event
> entries from the device tree event descriptions, and registers
> the PMU with the perf subsystem.
> 
> To support dynamic PMU registration, add PMU unregistration
> support and create a platform device for PMU nodes described
> in the device tree.
> 
> This forms the foundation for moving PMU descriptions out of
> architecture-specific kernel code and into device tree data.
> 
> The driver implements the following functionality:
> 
> Device Tree Parsing:
> - Reads PMU properties including counter count (nr_pmc), PMU name,
>   version, and platform information
> - Parses MMCR (Monitor Mode Control Register) definitions from the
>   sprs/mmcr node hierarchy, storing the MMCR register SPRNs
> - Extracts event definitions from the events node, supporting both
>   32-bit and 64-bit event codes
> 
> Dynamic Event Registration:
> - Creates sysfs event entries dynamically from device tree event
>   descriptions
> - Generates event attributes with format "event=0x<code>" for each
>   discovered event
> - Exposes events under /sys/devices/<pmu-name>/events/
> 
> PMU Registration:
> - Registers a power_pmu instance with the perf subsystem using the
>   device tree-provided PMU name
> - Adds PMU unregistration support to enable proper cleanup
> - Creates platform device for "ibm,power-pmu" compatible nodes
> 
> Sysfs Interface:
> - Provides format attributes (event, pmcsel) under
>   /sys/devices/<pmu-name>/format/
> - Exposes device tree debug information (nr_pmc) under
>   /sys/devices/<pmu-name>/dt/

Where did you document the ABI?

...


> +static struct power_pmu dts_pmu = {
> +	.name           = "cpu_dts",
> +	.n_counter      = MAX_PMU_COUNTERS,
> +	.attr_groups    = pmu_dts_attr_groups,
> +};
> +
> +/* Device Tree match */

That's obvious. Can of_device_id be something else than DT match?

> +static const struct of_device_id pmu_dts_of_match[] = {
> +	{ .compatible = "ibm,power-pmu" },

Where is ABI documented?

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pmu_dts_of_match);
> +
> +/* Probe function */
> +static int pmu_dts_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node, *child, *events_np;
> +	struct device_node *sprs_np, *mmcr_np, *mmcr_child;
> +	struct pmu_dts_event *evt;
> +	u64 code;
> +	u32 code32, sprn;
> +	u32 code64[2];
> +	u32 code128[4];
> +	int cells;
> +	const char *str;
> +
> +	pr_info("PMU DTS probe node = %s\n", np->full_name);

This does not look like useful printk message. Drivers should be silent
on success:
https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/coding-style.rst#L913
https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/debugging/driver_development_debugging_guide.rst#L79

> +
> +	if (!of_property_present(np, "nr_pmc")) {
> +
> +		for_each_child_of_node(np, child) {
> +			pr_info("child node = %s\n", child->full_name);

Why are you sending debugging code?

> +
> +			if (of_property_present(child, "nr_pmc")) {
> +				np = child;
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (of_property_read_u32(np, "nr_pmc", &pmu_dts_nr_pmc)) {
> +		pr_err("pmu_dts: nr_pmc not found in %s\n", np->full_name);

Why isn't this using dev interface?

> +		return -EINVAL;
> +	}
> +
> +	if (!of_property_read_string(np, "pmu-name", &str))
> +		pr_info("PMU Name: %s\n", str);
> +
> +	if (!of_property_read_string(np, "pmu-version", &str))
> +		pr_info("PMU Version: %s\n", str);
> +
> +	if (!of_property_read_string(np, "platform", &str))

No, you cannot just add bunch of undocumented ABI and call it a day.


> +		pr_info("Platform: %s\n", str);
> +
> +	sprs_np = of_get_child_by_name(np, "sprs");
> +	if (!sprs_np) {
> +		pr_err("pmu_dts: no sprs node\n");
> +		return -EINVAL;
> +	}
> +
> +	mmcr_np = of_get_child_by_name(sprs_np, "mmcr");
> +	if (!mmcr_np) {
> +		pr_err("pmu_dts: no mmcr node\n");
> +		return -EINVAL;
> +	}
> +
> +	mmcr_count = 0;
> +	for_each_child_of_node(mmcr_np, mmcr_child) {
> +
> +		if (of_property_read_u32(mmcr_child, "sprn", &sprn))
> +			continue;
> +
> +		mmcr_regs_sprs[mmcr_count++] = sprn;
> +		pr_info("pmu_dts: MMCR[%d] = %u (%s)\n", mmcr_count - 1,
> +				sprn, mmcr_child->name);
> +
> +		if (mmcr_count >= MAX_MMCR)
> +			break;

Where is cleanup?

> +	}
> +
> +	if (!mmcr_count) {
> +		pr_err("pmu_dts: no MMCR SPRs found\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Parse events */
> +	events_np = of_get_child_by_name(np, "events");
> +	if (!events_np) {
> +		pr_err("pmu_dts: no events node found\n");
> +		return -EINVAL;
> +	}
> +
> +	dts_event_count = 0;
> +	for_each_child_of_node(events_np, child) {
> +		if (!of_device_is_available(child))

Why are you open-coding available variant of loop?

> +			continue;
> +
> +		cells = of_property_count_u32_elems(child, "event_code");
> +		if (cells == 1) {
> +			if (of_property_read_u32(child, "event_code", &code32))
> +				continue;
> +
> +			code = code32;
> +
> +		} else if (cells == 2) {
> +			if (of_property_read_u32_array(child, "event_code", code64, 2))
> +				continue;
> +			code = ((u64)code64[0] << 32) | code64[1];
> +
> +		} else if (cells == 4) {
> +			if (of_property_read_u32_array(child, "event_code", code128, 4))
> +				continue;
> +			code = ((u64)code128[1] << 32) | code128[3];
> +
> +		} else {
> +			pr_warn("pmu_dts: invalid event_code for %s\n", child->name);
> +			continue;
> +		}
> +
> +		evt = kzalloc(sizeof(*evt), GFP_KERNEL);
> +		if (!evt)
> +			continue;
> +
> +		snprintf(evt->name, sizeof(evt->name), "%s", child->name);
> +		snprintf(evt->config, sizeof(evt->config), "event=0x%llx", code);
> +
> +		sysfs_attr_init(&evt->attr.attr);
> +		evt->attr.attr.name = evt->name;
> +		evt->attr.attr.mode = 0444;
> +		evt->attr.show = pmu_dts_event_show;
> +		dts_events[dts_event_count] = evt;
> +		pmu_dts_events_attrs[dts_event_count] = &evt->attr.attr;
> +		dts_event_count++;
> +
> +		if (dts_event_count >= MAX_DTS_EVENTS)
> +			break;

And node cleanup?

> +	}
> +	pmu_dts_events_attrs[dts_event_count] = NULL;
> +
> +	/* Register PMU */

No.

> +	pr_info("pmu_dts: registering PMU\n");

No.

> +	return register_power_pmu(&dts_pmu);
> +}
> +
> +/* Platform driver */

This is ridicilous comment.

> +static struct platform_driver pmu_dts_driver = {
> +	.probe = pmu_dts_probe,
> +	.driver = {
> +		.name = "pmu_dts",
> +		.of_match_table = pmu_dts_of_match,
> +	},
> +};
> +
> +static int __init pmu_dts_init(void)
> +{
> +	pr_info("pmu_dts: init\n");

NAK, init functions do not print anything. RFC does not mean you can
send debugging code with poor quality and...


> +	return platform_driver_register(&pmu_dts_driver);
> +}
> +
> +static void __exit pmu_dts_exit(void)
> +{
> +	pr_info("pmu_dts: exit\n");
> +	platform_driver_unregister(&pmu_dts_driver);
> +	unregister_power_pmu(&dts_pmu);
> +}
> +module_init(pmu_dts_init);
> +module_exit(pmu_dts_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Shivani Nittor");
> +MODULE_DESCRIPTION("PMU DTS driver");
> diff --git a/arch/powerpc/perf/internal.h b/arch/powerpc/perf/internal.h
> index a70ac471a5a5..11154ee31f8e 100644
> --- a/arch/powerpc/perf/internal.h
> +++ b/arch/powerpc/perf/internal.h
> @@ -2,6 +2,7 @@
>  //
>  // Copyright 2019 Madhavan Srinivasan, IBM Corporation.
>  
> +void unregister_power_pmu(struct power_pmu *pmu);
>  int __init init_ppc970_pmu(void);
>  int __init init_power5_pmu(void);
>  int __init init_power5p_pmu(void);
> diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
> index 2b3547fdba4a..e11d1bbbc27b 100644
> --- a/arch/powerpc/perf/isa207-common.c
> +++ b/arch/powerpc/perf/isa207-common.c
> @@ -7,6 +7,7 @@
>   * Copyright 2016 Madhavan Srinivasan, IBM Corporation.
>   */
>  #include "isa207-common.h"
> +#include <asm/dts_pmu.h>
>  
>  PMU_FORMAT_ATTR(event,		"config:0-49");
>  PMU_FORMAT_ATTR(pmcxsel,	"config:0-7");
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 1946dbdc9fa1..35be67eef2c6 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -947,6 +947,18 @@ static void __init opal_imc_init_dev(void)
>  
>  	of_node_put(np);
>  }
> +#define PMU_DTB "ibm,power-pmu"
> +
> +static void __init opal_pmus_init_dev(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, PMU_DTB);
> +	if (np)
> +		of_platform_device_create(np, NULL, NULL);
> +
> +	of_node_put(np);
> +}
>  
>  static int kopald(void *unused)
>  {
> @@ -1032,6 +1044,9 @@ static int __init opal_init(void)
>  	/* Detect In-Memory Collection counters and create devices*/
>  	opal_imc_init_dev();
>  
> +    /*Detect PMU node and create device*/

.... with completely broken indentation style.

> +	opal_pmus_init_dev();
> +
>  	/* Create leds platform devices */
>  	leds = of_find_node_by_path("/ibm,opal/leds");
>  	if (leds) {


Best regards,
Krzysztof

