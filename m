Return-Path: <R1AAHA@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5F22E2C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 06:36:20 +1100 (EST)
Date: Wed, 27 Mar 2013 14:32:36 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: <Yuantian.Tang@freescale.com>
Subject: Re: [PATCH 3/3] cpufreq: Add cpufreq driver for Freescale e500mc SOCs
Message-ID: <20130327143236.7cb4613b78ad18d79bfbcc57@freescale.com>
In-Reply-To: <1364265391-26077-3-git-send-email-Yuantian.Tang@freescale.com>
References: <1364265391-26077-1-git-send-email-Yuantian.Tang@freescale.com>
 <1364265391-26077-3-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: rjw@sisk.pl, linuxppc-dev@lists.ozlabs.org, cpufreq@vger.kernel.org,
 linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 26 Mar 2013 10:36:31 +0800
<Yuantian.Tang@freescale.com> wrote:

> +static int __init ppc_corenet_cpufreq_init(void)
> +{
> +	int ret = 0;
> +	struct device_node  *np;
> +	const struct of_device_id *match;
> +
> +	np = of_find_matching_node(NULL, node_matches);
> +	if (!np)
> +		return -ENODEV;
> +
> +	match = of_match_node(node_matches, np);
> +	freq_data.cpus_per_cluster = (long)match->data;
> +	mutex_init(&freq_data.cpufreq_lock);
> +	of_node_put(np);
> +
> +	ret = cpufreq_register_driver(&ppc_corenet_cpufreq_driver);
> +	if (ret)
> +		return ret;
> +
> +	pr_info("Freescale PowerPC corenet CPU frequency scaling driver\n");
> +
> +	return ret;
> +}
> +
> +static void __exit ppc_corenet_cpufreq_exit(void)
> +{
> +	cpufreq_unregister_driver(&ppc_corenet_cpufreq_driver);
> +}
> +
> +module_init(ppc_corenet_cpufreq_init);
> +module_exit(ppc_corenet_cpufreq_exit);

this needs to be a module_platform_driver.

Kim
