Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E3241A004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 18:11:28 +1100 (AEDT)
Received: by pacdm15 with SMTP id dm15so12819620pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 23:11:25 -0800 (PST)
Date: Tue, 24 Nov 2015 12:41:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jia Hongtao <hongtao.jia@freescale.com>
Cc: edubezval@gmail.com, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 scottwood@freescale.com
Subject: Re: [PATCH] cpufreq: qoriq: Register cooling device based on device
 tree
Message-ID: <20151124071121.GM5258@ubuntu>
References: <1448348129-46675-1-git-send-email-hongtao.jia@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1448348129-46675-1-git-send-email-hongtao.jia@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 24-11-15, 14:55, Jia Hongtao wrote:
> +	/* Register CPU cooling device for QorIQ platform */
> +	for_each_node_with_property(cpu_np, "#cooling-cells") {
> +		of_property_read_u32(cpu_np, "reg", &cpu_id);
> +		cpufreq_get_policy(&cpu_policy, cpu_id);

That's not the right way to do it. You already have DT node for the
CPU, look at how it is done from ->ready() callback for cpufreq-dt.

-- 
viresh
