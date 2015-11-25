Return-Path: <hongtao.jia@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0136.outbound.protection.outlook.com [65.55.169.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F37971A0351
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 19:00:09 +1100 (AEDT)
From: Hongtao Jia <hongtao.jia@freescale.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH] cpufreq: qoriq: Register cooling device based on device
 tree
Date: Wed, 25 Nov 2015 08:00:02 +0000
Message-ID: <BLUPR03MB14927B13BAA66ABBC86F875E1050@BLUPR03MB149.namprd03.prod.outlook.com>
References: <1448348129-46675-1-git-send-email-hongtao.jia@freescale.com>
 <20151124071121.GM5258@ubuntu>
In-Reply-To: <20151124071121.GM5258@ubuntu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Viresh Kumar [mailto:viresh.kumar@linaro.org]
> Sent: Tuesday, November 24, 2015 3:11 PM
> To: Jia Hongtao-B38951
> Cc: edubezval@gmail.com; linux-pm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; devicetree@vger.kernel.org; Wood Scott-B07421
> Subject: Re: [PATCH] cpufreq: qoriq: Register cooling device based on
> device tree
>=20
> On 24-11-15, 14:55, Jia Hongtao wrote:
> > +	/* Register CPU cooling device for QorIQ platform */
> > +	for_each_node_with_property(cpu_np, "#cooling-cells") {
> > +		of_property_read_u32(cpu_np, "reg", &cpu_id);
> > +		cpufreq_get_policy(&cpu_policy, cpu_id);
>=20
> That's not the right way to do it. You already have DT node for the CPU,
> look at how it is done from ->ready() callback for cpufreq-dt.
>=20
> --
> viresh

Thanks.

I made a new patch to use ->ready callback for cpu cooling registration.
I will send V2 after test.

-Hongtao.
