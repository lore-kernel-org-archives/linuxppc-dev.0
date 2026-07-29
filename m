Return-Path: <linuxppc-dev+bounces-25034-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357D7C53219
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:35:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9KGV4916z2yDr;
	Thu, 30 Jul 2026 03:34:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=51.210.91.52
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785346498;
	cv=none; b=mjFaCqfnpXL/E50+ABkIKNbH1SyVba52Q+md0uBQNy/iIVRe+l56O+4ZGuUAlTr1Oq3nE134hXCrerRJNmjM9ZwSN41PWlIlDFi3W0yP9Xiq0biYZqF2u9vfMGsShJbF6PfTwbAmUzsqa8G5O08q3AdpqSAf45fBBoAXvIZx5VpJ2HAK9pSNh4W6QBG4Q59ws6Kp6enda+iUfUt1mzlSkxIPcZAeA4NH9gswU9JcNSgE+d7SsBoyYpTLMuI+wnfOlbU6b2LKr7qUJZfKF2Xe5TGBM9hWU6ntW8JWyfK7wuVYvXcFBXTJwSnTp4wIQz7avSuiELp7h2N7wR0QxXb/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785346498; c=relaxed/relaxed;
	bh=QwEu9HYXiQhk1G1u+XrBSF+2nlcfy+kdtq3Cs4ZMFxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDrBoYruvJMsJnhugSTWrkkcmqCMxO7/WNTinWjtUamfUWEwXVl22Ddi027OY6aJh8Mcka9nlhhgE0fgRI3ahGeEpQ8AmsXm9E2k3apaTnFBpH8UqstnXuOaxfUZBukTs0PhOS9BoiozakoQ4E6nZtdMJL+IrHZJWCQOW6rRcH5ba0HE24KwiV17oZkEefQYAatKiV6Gk9T2hyihS5dA6WUglUO3BaSXpIj8s8863SvKBpZRNUIoCN9Q1KZfjUHUqa5eXJtZ3ew0uIs9/liT82L3YXwJvlPYqbAeDxcYVNKxcJ+6IMOa2dJgEWMHvLNGbJA4iycxcBgSiO/6fcHAcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kaod.org; dkim=pass (2048-bit key; unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=Ooy7+L7V; dkim-atps=neutral; spf=pass (client-ip=51.210.91.52; helo=smtpout3.mo540.mail-out.ovh.net; envelope-from=clg@kaod.org; receiver=lists.ozlabs.org) smtp.mailfrom=kaod.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kaod.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=Ooy7+L7V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kaod.org (client-ip=51.210.91.52; helo=smtpout3.mo540.mail-out.ovh.net; envelope-from=clg@kaod.org; receiver=lists.ozlabs.org)
Received: from smtpout3.mo540.mail-out.ovh.net (smtpout3.mo540.mail-out.ovh.net [51.210.91.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9KGT4R4Nz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 03:34:57 +1000 (AEST)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net [79.137.60.37])
	by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4h9KGN4Gd7z4bcF;
	Wed, 29 Jul 2026 17:34:52 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net. [127.0.0.1])
        by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <gouhaojake@163.com>; Wed, 29 Jul 2026 17:34:52 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.188.190])
	by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4h9KGN2Nv0z1xpl;
	Wed, 29 Jul 2026 17:34:52 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
	(Authenticated sender: clg@kaod.org)
	by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 8F8171923E23;
	Wed, 29 Jul 2026 17:34:49 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-103G005b4dc8d1b-879f-4f21-95bc-f616272571e0,
                    8FFE599222FA429370CFDB2A71624BCB30E75F05) smtp.auth=clg@kaod.org
X-OVh-ClientIp:82.64.250.170
Message-ID: <83503d1c-ba9e-421f-88f7-fde331d8501a@kaod.org>
Date: Wed, 29 Jul 2026 19:34:49 +0200
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
Subject: Re: [PATCH v3 3/5] powerpc/xive: propagate IPI init errors to prevent
 use-after-free
To: Gou Hao <gouhao@uniontech.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, namcao@linutronix.de,
 peterz@infradead.org, sshegde@linux.ibm.com, kees@kernel.org,
 lgs201920130244@gmail.com, srikar@linux.ibm.com, ynorov@nvidia.com,
 nilay@linux.ibm.com, benh@kernel.crashing.org, miltonm@bga.com,
 mkchauras@gmail.com, akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 gouhaojake@163.com, kernel@uniontech.com
References: <20260727104215.184786-1-gouhao@uniontech.com>
 <20260727104215.184786-4-gouhao@uniontech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260727104215.184786-4-gouhao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 4160200155803528252
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGLmrFPhnnCyhAOTPZ6zDI4OyuBO5OAfFOy8CmEOT0LSGLRypcb0uc0m2E7dFMcH9qEr43tS2zxVf+fpPh+fi+5X1m85dSYqfEFDe19qYGJyKZdqYSLW7lhXAIYsO+yZKGPB6rzuXEZ5qB+RuHJKu0UJetWTWzG1BipWCFl39fsRdTsQ7jR4xqTWQU4rcFnDw9hAheO+L5HFiOIKqzhRMFomVGAOuG70pF7M4uig08i5FQsBMhB6/py/KEdUC7N6tSn7YXFN07YdOYmOVM43xv85XImC3+/9yaVw0r/q1AZDS3oobdatojWeJSzT5YfngDlxxyfT2QfiLZYjz5rOx9XUnLXsfuENQcsTIDPZ2BETB+oXUIiSTq/mZQv591q6ccin4Lq2yPzdOL0iDFXXbJOzCRYYoMFGQlhopnd5oGzU5/8hSL1pQdc5pPVk50geip67Xx8maVugmfNqBQlTx2iRTEvDlOtpiz/1dZTZ/5SKnuaYKFZitxzfH8nHatHn8XgmSYRD3Z49tmrsS3Q6muQuDvqtoTnNVkzQbl2TeTdONFN0fvBqjzD7lNPlqBP8IvXN1tSyK6OZ8z1wY6wo7HHF0v6G2Ns/HA/ihM3DJkfinpuMbBqRVkTvNBRbtMbgP6NFJl5v/3RcfUNHsNi55avtkQLogukur2q/5IIOU0NwQ
DKIM-Signature: a=rsa-sha256; bh=QwEu9HYXiQhk1G1u+XrBSF+2nlcfy+kdtq3Cs4ZMFxo=;
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1785346493; v=1;
 b=Ooy7+L7VH28XXoOm7su+l14PIHTQyx3aBxpF6Ho3kRbnwLXWyaXFOXIxIJl2CKZX0KHzmxBJ
 7VhzwZMYN4gO0wDutDUqPLQ97EHNaMrdjuuxLT87JryrjTh0frX56lCuCWRGMP0e3EeoKaOAlOi
 tXkqBR/ibgYbltld+4TUCwv9NGSLkdD9jI8vW7iJp21eVPhhc7IlVpQb8L04snkCax5lkZPd9or
 BgbGs1c1MWPIOVzJyqKhFz1zlzT3QaW1u48O8aR4emlPj5wgk/n7eefhPM1vT/lVApCyBn85kwD
 KKT27UmoOzOGl6AbjlEN3Jb7ZrELIstzFHBcjiJgbbQTg==

On 7/27/26 12:42, Gou Hao wrote:
> When xive_init_ipis() fails (e.g. irq_domain_alloc_irqs() fails),
> the error path frees the global xive_ipis array.  However,
> xive_smp_probe() previously ignored this failure and proceeded to
> call xive_setup_cpu_ipi(), which dereferences the already-freed
> xive_ipis pointer -- a use-after-free.
> 
> Now that xive_smp_probe() returns int (previous patch), propagate
> the error from xive_init_ipis() and xive_setup_cpu_ipi() through
> xive_smp_probe().  Check the return value in both pnv_smp_probe()
> and pSeries_smp_probe() so that IPI setup is aborted cleanly on
> failure, avoiding the use-after-free.
> 
> Fixes: 243e25112d06 ("powerpc/xive: Native exploitation of the XIVE interrupt controller")
> Fixes: cbc06f051c52 ("powerpc/xive: Do not skip CPU-less nodes when creating the IPIs")
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> Reviewed-by: Wentao Guan <guanwentao@uniontech.com>
> Reviewed-by: jiazhenyuan <jiazhenyuan@uniontech.com>
> ---
>   arch/powerpc/platforms/powernv/smp.c |  8 +++++---
>   arch/powerpc/platforms/pseries/smp.c |  8 +++++---
>   arch/powerpc/sysdev/xive/common.c    | 10 ++++++----
>   3 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
> index 8f41ef364fc6..b1201dbafcaf 100644
> --- a/arch/powerpc/platforms/powernv/smp.c
> +++ b/arch/powerpc/platforms/powernv/smp.c
> @@ -332,10 +332,12 @@ static void pnv_cause_ipi(int cpu)
>   
>   static void __init pnv_smp_probe(void)
>   {
> -	if (xive_enabled())
> -		xive_smp_probe();
> -	else
> +	if (xive_enabled()) {
> +		if (xive_smp_probe() < 0)
> +			return;
> +	} else {
>   		xics_smp_probe();
> +	}
>   
>   	if (cpu_has_feature(CPU_FTR_DBELL)) {
>   		ic_cause_ipi = smp_ops->cause_ipi;
> diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
> index db99725e752b..14cd0634eeca 100644
> --- a/arch/powerpc/platforms/pseries/smp.c
> +++ b/arch/powerpc/platforms/pseries/smp.c
> @@ -194,10 +194,12 @@ static int pseries_cause_nmi_ipi(int cpu)
>   
>   static __init void pSeries_smp_probe(void)
>   {
> -	if (xive_enabled())
> -		xive_smp_probe();
> -	else
> +	if (xive_enabled()) {
> +		if (xive_smp_probe() < 0)
> +			return;
> +	} else {
>   		xics_smp_probe();
> +	}
>   
>   	/* No doorbell facility, must use the interrupt controller for IPIs */
>   	if (!cpu_has_feature(CPU_FTR_DBELL))
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index 9f80c16be23f..bbe7c85274ea 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -1267,15 +1267,17 @@ noinstr static void xive_cleanup_cpu_ipi(unsigned int cpu, struct xive_cpu *xc)
>   
>   int __init xive_smp_probe(void)
>   {
> +	int ret;
> +
>   	smp_ops->cause_ipi = xive_cause_ipi;
>   
>   	/* Register the IPI */
> -	xive_init_ipis();
> +	ret = xive_init_ipis();
> +	if (ret < 0)
> +		return ret;
>   
>   	/* Allocate and setup IPI for the boot CPU */
> -	xive_setup_cpu_ipi(smp_processor_id());
> -
> -	return 0;
> +	return xive_setup_cpu_ipi(smp_processor_id());
>   }
>   
>   #endif /* CONFIG_SMP */

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


