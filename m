Return-Path: <linuxppc-dev+bounces-24770-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D96C531F9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 04:59:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5wkh2mdGz2yPR;
	Fri, 24 Jul 2026 14:59:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=46.105.34.251
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784869148;
	cv=none; b=lbsvAeQvtRIyP5argshZWN3XA0iKvBkKdSFFzjV8W5LAOkBOp2TOTi5fB7bc9WEwZCwWoDrBEucOIe3ONGsS/oOb5KwjvegdEBr9k4Cg+7SFQKgCqEly4+JJSqeZL7rtShZOQPLZXihmoROvRi0um5eDuq4wv0jzaBv/R+lX6Xv0H0ZPigIl+U1z7hI+m/wULylym1xwD59y7LEAkwir63ovVZZnwKZ6QWh3sO1S5n44yX5L4WNAUT0f8uGXnnZ1mvrfUY2FfHoKWcH6W2LdeeQEhyLPzjj58+QKWNdqXqO5KI9rV5wFguSuhs6+njdX+iWKfG6vycDl9cqK37hEow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784869148; c=relaxed/relaxed;
	bh=CufKqRzRWGP5C9wDDHrJPSM5oQL0vrGLL/dJi11OdLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZF+bLQtfi3aRRIN75xjFEXlVrWtmFk2GuQ1fjUp5ul7Yo9WB1VKbIxemurczr4ocEEVtd7InWWJiwSB7Fjx6K3MEzeQnqIPY1lV8R/4nuET9INzqK+uJBiWlb5yf6x00p7U8Ux1yiW7a3+FclULYh6M3fOynYR/tJbnrhpw7JN4/BlwmLYz6pZNa49tsrADEOIeqYs25e3Ti3aSsC4JwF5+MsWkXl76qe6hW2Zj+OKUEvRRJWhjcPCc4I5Imb4AHFQX7hJBqI+ny6QisNjRiaMrXK9lXPndidEdzVmZkr35HfS+VBtPbg8IomLCPeqjHWyc+2iB+CAYwZRCqGsycFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kaod.org; dkim=pass (2048-bit key; unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=Oi9DC1Sq; dkim-atps=neutral; spf=pass (client-ip=46.105.34.251; helo=smtpout1.mo528.mail-out.ovh.net; envelope-from=clg@kaod.org; receiver=lists.ozlabs.org) smtp.mailfrom=kaod.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kaod.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=Oi9DC1Sq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kaod.org (client-ip=46.105.34.251; helo=smtpout1.mo528.mail-out.ovh.net; envelope-from=clg@kaod.org; receiver=lists.ozlabs.org)
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5wkg4qVgz2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 14:59:06 +1000 (AEST)
Received: from director5.derp.mail-out.ovh.net (director5.derp.mail-out.ovh.net [57.128.106.70])
	by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4h5wkW3LJQz65Y5;
	Fri, 24 Jul 2026 04:58:59 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net (director5.derp.mail-out.ovh.net. [127.0.0.1])
        by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <gouhaojake@163.com>; Fri, 24 Jul 2026 04:58:59 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.254.225])
	by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4h5wkV75Bsz7t8k;
	Fri, 24 Jul 2026 04:58:58 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
	(Authenticated sender: clg@kaod.org)
	by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id A7BCB203E0D;
	Fri, 24 Jul 2026 04:58:55 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-114S008995c4a97-46e5-4ed8-9387-61dacf530b60,
                    4BD6B7741D2B27CC5BC6F5428A99E4613CF72FD8) smtp.auth=clg@kaod.org
X-OVh-ClientIp:82.64.250.170
Message-ID: <988bb08e-3c6b-49ff-9e33-0263b9216a65@kaod.org>
Date: Fri, 24 Jul 2026 06:58:54 +0200
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
Subject: Re: [PATCH v2 3/6] powerpc/xive: fix use-after-free of xive_ipis
To: Gou Hao <gouhao@uniontech.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 bharat@chelsio.com, jgg@ziepe.ca, leon@kernel.org,
 akpm@linux-foundation.org, namcao@linutronix.de, ynorov@nvidia.com,
 sshegde@linux.ibm.com, nilay@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, gouhaojake@163.com, kernel@uniontech.com
References: <20260724022851.466017-1-gouhao@uniontech.com>
 <20260724022851.466017-4-gouhao@uniontech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260724022851.466017-4-gouhao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 17371228191519649000
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGaLDmC1sGz9F5x4qvEOawfsm4Qoc4PI5XkON1B5NhPBXhuasc2fQjXH+VDsmM8u20AJO5uw9QqMPdxtLUwzW4JHiund27yNotetwU2aoTKlSByjpVbPXNhOAm6Sbrj0YxwiaiRSE6c9ur3YhDfD71mXV5UmnBjw55DxC2402dux2yrfi55r5CK/DrF2UJJtPJ286dwRRmaSI8PMt00k91NBWQVZLH0x/WvzQLiEKxFqHDIN+rylQfVV+7TlQk8VLKe6IPkp1wpOzMV2quZF6Z2kCTGNe4BGIGTxDslcGATaCAjurvDo0ZhXXEBlCGlV6DzbWEZMkizxW3KZwTMjfSZFbyKXqSekAL1vm6pEBopH+PbZpV31cz44toPdcY+W23WTq2U2Z2wWgGPyHgTbrR/SjTpmdKXRd3WA/OL1C3MxvCbRXaEc2zN/xMgjFDHTdX/FZLFtDVoXf5m7gzWokQlFyav3Gx8WNXx8JUPWH5a4rm2+dD4+YexO+u0xNT9DMrGjkVABvkpWiVQ0EREuN2imnjX8yREyvRhjttusUNeEFdCWn82sNpOatRzHBukjfhAoZ0DzsOseDDPycnEnVJUpfFexpqRW0I+K2A0QazKCQPVe0HDupddfFM8R0YlH/d6o6GujYiFMJZBncFaPO7+LdSOLohtnsFrXxlz0sL4TA
DKIM-Signature: a=rsa-sha256; bh=CufKqRzRWGP5C9wDDHrJPSM5oQL0vrGLL/dJi11OdLg=;
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1784869142; v=1;
 b=Oi9DC1SqdS+C169kqp7ZTc1rba+g6496Rbb8hgeNT6xdrYDQgtoU2Epb3yN+SadIbIyWphHo
 4/zyeJEaLnxlIVrcy2hJRVSHdtMSEjuRS/jee9HRb0LH90GlXQBVvwmpZfsm4YXeTaxLCMppjQt
 RDtSBO48JUD2v8/Af6T1Wz50Rw3/mE5JnwKDAg8rgubPuruBP+F+TvXbhPq0lAva4mbyAOPWPX4
 OIhzq2b8OkwIUynO8AThJKeWDgflQt4VvdHRCP/fsUDlKIXh7zrmvG8fULQEK1tc8XqIb3Kckzm
 KaItUQ9ikaeZFd0wYoD2ZSOd3I5OaCZGTj8lCb+U/jf+Q==

On 7/24/26 04:28, Gou Hao wrote:
> When irq_domain_alloc_irqs() fails in xive_init_ipis(), the error
> path frees the global xive_ipis array via kfree().  However,
> xive_smp_probe() ignores the error return and proceeds to call
> xive_setup_cpu_ipi(), which dereferences the already-freed xive_ipis
> pointer, resulting in a use-after-free.
> 
> Propagate the error from xive_init_ipis() through xive_smp_probe()
> and check it in both pnv_smp_probe() and pSeries_smp_probe() so that
> IPI setup is aborted cleanly on failure.
> 
> Fixes: 7dcc37b3eff9 ("powerpc/xive: Map one IPI interrupt per node")
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> Reviewed-by: Wentao Guan <guanwentao@uniontech.com>
> Reviewed-by: jiazhenyuan <jiazhenyuan@uniontech.com>
> ---
>   arch/powerpc/platforms/powernv/smp.c | 8 +++++---
>   arch/powerpc/platforms/pseries/smp.c | 8 +++++---
>   arch/powerpc/sysdev/xive/common.c    | 6 +++++-
>   3 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
> index 8f41ef364fc6f..b1201dbafcaf6 100644
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
> index db99725e752bd..14cd0634eeca8 100644
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
> index f9a1229cede73..bb6ce07c1699e 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -1256,10 +1256,14 @@ noinstr static void xive_cleanup_cpu_ipi(unsigned int cpu, struct xive_cpu *xc)
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
>   	xive_setup_cpu_ipi(smp_processor_id());

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


