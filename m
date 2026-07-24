Return-Path: <linuxppc-dev+bounces-24769-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CBEC531F9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 04:55:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5wg001S0z2yYd;
	Fri, 24 Jul 2026 14:55:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=51.210.91.25
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784868955;
	cv=none; b=gvxejHBRg7igTkaFiHwxAV805PCS2rBePHTEU/6Qi39SMqEpX74yr+vNSwJLv686cdO31fctvGpP+3DGY7Wba5zHu5DEJu3Ai509GpuQbP62VwO5lueAMHHWi/9LRkJ1BXK7hhxnBU72BKZO0CMOt2rFuVAvvZJzoamXMq1h7PLE4Kdxb+KqncSH6X1kYjs6Eqqb+fZKWbjTmlp4tu4gmE780r/xB5YmU6ocaWdjscnl2NuFy5eTBHWmTT2vA+ky697/4D+LmLN+DpI09+dQzEpyM8px35BISkBQ+Vrteh7XMFTqZnvPzG2vW1bP/3hkrQMsLGyMPHo3s6ZuIGg79w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784868955; c=relaxed/relaxed;
	bh=lpsNKuaDzpZhNqp4w16ugJf4ExexmLy2gskQEsg/tcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XW+cm2QxIxBsQB91yjuRtJGDcKA7LQVG0h9biau4BPzsK0+HqMcUIq6QaZwMqFOD4P11j9Tms1LV1ZR+hAUuEk+9bvuHqMxisE6g1Cwzj/MXJrk11Q67X/0D+KCElaR7heLallIRORtypX97fHLjZHozh67tCF9tU1pd7cvib64YHjjQsDVsHwrvQKT+Guw+5BIiuqmeVZoCycLe++mjPGN8Mn9HYwT5ihlE9C8A9rDYF9IAN0IwXkebM2BCdqRUMkl0VOYuaVV3nEME3y8KRmIKc/UbAPQ9+o54JWLzo+/NY+/Mxw0R5Px9EZ5FtIfZ1gIAgi0REBe3K2sTtqY5+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kaod.org; dkim=pass (2048-bit key; unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=fptsVdey; dkim-atps=neutral; spf=pass (client-ip=51.210.91.25; helo=smtpout6.mo537.mail-out.ovh.net; envelope-from=clg@kaod.org; receiver=lists.ozlabs.org) smtp.mailfrom=kaod.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kaod.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=fptsVdey;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kaod.org (client-ip=51.210.91.25; helo=smtpout6.mo537.mail-out.ovh.net; envelope-from=clg@kaod.org; receiver=lists.ozlabs.org)
Received: from smtpout6.mo537.mail-out.ovh.net (smtpout6.mo537.mail-out.ovh.net [51.210.91.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5wfz1VRhz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 14:55:54 +1000 (AEST)
Received: from director5.derp.mail-out.ovh.net (director5.derp.mail-out.ovh.net [57.128.106.70])
	by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4h5wfr2v2qz3yvC;
	Fri, 24 Jul 2026 04:55:48 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net (director5.derp.mail-out.ovh.net. [127.0.0.1])
        by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <gouhaojake@163.com>; Fri, 24 Jul 2026 04:55:48 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.0.198])
	by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4h5wfq6fzlz7t8k;
	Fri, 24 Jul 2026 04:55:47 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
	(Authenticated sender: clg@kaod.org)
	by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 809112403E2D;
	Fri, 24 Jul 2026 04:55:44 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-114S00855f22b5d-b6d8-4a3d-b7a1-ab384e72409e,
                    4BD6B7741D2B27CC5BC6F5428A99E4613CF72FD8) smtp.auth=clg@kaod.org
X-OVh-ClientIp:82.64.250.170
Message-ID: <82bebd8a-0376-4fd6-8e8b-125bd895208e@kaod.org>
Date: Fri, 24 Jul 2026 06:55:43 +0200
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
Subject: Re: [PATCH v2 2/6] powerpc/xive: add error return value to
 xive_smp_probe()
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
 <20260724022851.466017-3-gouhao@uniontech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260724022851.466017-3-gouhao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 17317466469420608744
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFag79TUuknUcEyJ+fUBsqHM0xcaveY2xgVNjxV+qnKwhwsNTHa/2zdKcagVjzZotwGF8tiTuYDFnLfCREPZ40TItmps8VQlgCYXtQ5s/8YhU27P1l3fNA5vFk0wHWnMhXlAGEERA1YXEkq6NvX3J7mbulyb4PCNyOiCS02W8K6KQos/fdl/UFRJLB+bcrtLX5zpkrqLCS8UVIBGkLg2pXo1dt253286tHqmpjN4aJU4Momxnq4NCIh4qjGOU8oLxiXXbSRp93kS9K9HRz8GsPUGJVR2g6ypPWuPrcsxVVwSadqKe62E2LhGeYWeQK5G59ftKSi6eFNdIHZZqSwCU/JaoOMXGmkxCnRclM/OCuhglaDeN3BHUfDx3r50MC2T73P2UNZ4JGhwl2sLnvSRV5LGbJuTiqZGgGzrzVM58GD4zLNB/RZeH1wc/0zRk//2Xue9NMmuW3qm/WtzV0vO0tyeZ6VmTIaU8OL/f9xBiPfV0fE/kMqrHEve6qNThviQfG/EHH3yRZxfJigHWxirAmm9MAf+s4tK0hD0PvourVEzAQseAzpPKZt+8rZhPPA6izowE5nGl+xljFZggcijL58lcU0Yms0/rAA2LHfWPtHKlO6eeyK0wVywjt04umh2B8l/lldWqZzfzJYrhkT2FaXaL+nW6q+n2cziaIMo66PEg
DKIM-Signature: a=rsa-sha256; bh=lpsNKuaDzpZhNqp4w16ugJf4ExexmLy2gskQEsg/tcU=;
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1784868951; v=1;
 b=fptsVdeywA8AchGltVZrfsyqfHnxUSVi6auYkCr/g+DeI4HXpU8HYp+DbN7oTXhYVS2ihiKM
 4b69/7eP+iHECpIXC2LTivylvJ98jAv0CMv3u85/H74PB67ZB4u19dNmFN3fhoLr2igRhuRorVL
 5Eh+uV+CGcQJ2/NOqO2nTQb9bZPtg8O0vEXVncHpTp+XokQWucfrtmkurvAXbAv8RHiaMCg1jFc
 6G3Tomtqc5CGsr8TvF/Fq5RYYeCLQAyy7kMYRDt1Z32/CHdfoZuS8+YrrvNvhICbwMvmJ3tzjU8
 avuwNOU2N25aPFejN/Y4ZZC0k/R8/U/JNu484CDDGZbmQ==

On 7/24/26 04:28, Gou Hao wrote:
> xive_smp_probe() calls xive_init_ipis() which can fail, but its
> return value is currently ignored.  Change xive_smp_probe() to
> return int so that errors can be propagated to callers.
> 
> This is a preparatory patch for the next one.
> 
> No functional change yet; the return value is always 0 at this point.
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> Reviewed-by: Wentao Guan <guanwentao@uniontech.com>
> Reviewed-by: jiazhenyuan <jiazhenyuan@uniontech.com>
> ---
>   arch/powerpc/include/asm/xive.h   | 4 ++--
>   arch/powerpc/sysdev/xive/common.c | 4 +++-
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
> index efb0f5effcc69..4e3e3358993c0 100644
> --- a/arch/powerpc/include/asm/xive.h
> +++ b/arch/powerpc/include/asm/xive.h
> @@ -91,7 +91,7 @@ static inline bool xive_enabled(void) { return __xive_enabled; }
>   
>   bool xive_spapr_init(void);
>   bool xive_native_init(void);
> -void xive_smp_probe(void);
> +int xive_smp_probe(void);
>   int  xive_smp_prepare_cpu(unsigned int cpu);
>   void xive_smp_setup_cpu(void);
>   void xive_smp_disable_cpu(void);
> @@ -153,7 +153,7 @@ static inline bool xive_enabled(void) { return false; }
>   
>   static inline bool xive_spapr_init(void) { return false; }
>   static inline bool xive_native_init(void) { return false; }
> -static inline void xive_smp_probe(void) { }
> +static inline int xive_smp_probe(void) { return -EINVAL; }
>   static inline int  xive_smp_prepare_cpu(unsigned int cpu) { return -EINVAL; }
>   static inline void xive_smp_setup_cpu(void) { }
>   static inline void xive_smp_disable_cpu(void) { }
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index f2904a5c2b7bf..f9a1229cede73 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -1254,7 +1254,7 @@ noinstr static void xive_cleanup_cpu_ipi(unsigned int cpu, struct xive_cpu *xc)
>   	xive_ops->put_ipi(cpu, xc);
>   }
>   
> -void __init xive_smp_probe(void)
> +int __init xive_smp_probe(void)
>   {
>   	smp_ops->cause_ipi = xive_cause_ipi;
>   
> @@ -1263,6 +1263,8 @@ void __init xive_smp_probe(void)
>   
>   	/* Allocate and setup IPI for the boot CPU */
>   	xive_setup_cpu_ipi(smp_processor_id());
> +
> +	return 0;
>   }
>   
>   #endif /* CONFIG_SMP */

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


