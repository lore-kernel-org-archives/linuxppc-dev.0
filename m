Return-Path: <linuxppc-dev+bounces-25033-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE103C53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:34:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9KFd4lTqz2xwP;
	Thu, 30 Jul 2026 03:34:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=51.210.91.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785346453;
	cv=none; b=d+nsjjpwGASVSZrKrWeseInfporuETtY0kcpaJV76Io5B503sVkCOPvhFSqq32TmujM5NtbW4SMXYL6fuh1mpVjMVnugcex2iqxl8c6iLVgfQIRNGFbkBQeAI137qojhziM4+YYFaAC5kChT5B94xI0ej3JSgjza7WOfmzlo5cGt9d9XjrecVCzU8wYEQJZ5ph9PZiYGeL2qcYFOgLNCjtIcEQ8UyHrIQhpDFxhf/mseZ4cj953sND59wdLxgeKjQMsOgd5gn8KZUWun5Mt9DRTDZVv0Ob8Bemynp+vcx8orN04UQVjhf494ocuk9/UOM25Q5rG6JStZI4e5ir4IHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785346453; c=relaxed/relaxed;
	bh=yqqIhslfQ4qpV20q+pEBj9d4z4LkslwJPQh8RPXNRXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mhgL1JRRUm2FqSzxOtR3Bmn/nz72pl3zcpqLVkvETS6B8y+A3nwTKZ52PKfDsIeerW4imeykdj+BHJr5FrSJpjpracWD9yBVAmf2jWydhf9DLzms4PhrcO0BvnJ1ZdgkBuDk9Sj9cLIzpViwgiL5vfzoHpLuZAK3w45NTIq7bzlmlwlIGMiV0M6yIPIA3Djsedw5f+40iX51Hu+Vx2w1j/+8j90XQUZ5YHXbgoyXiZZJFLQOr12aLukz/7diBh6TdVdx7B2jFvNyTml6TFW44t9vLpgAXb6KzcehHlUxQWhibczwOhUet91E3FtYUUbY5IdZONAAT4+3/w0HexgQZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kaod.org; dkim=pass (2048-bit key; unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=Mxy87uUV; dkim-atps=neutral; spf=pass (client-ip=51.210.91.18; helo=smtpout9.mo536.mail-out.ovh.net; envelope-from=clg@kaod.org; receiver=lists.ozlabs.org) smtp.mailfrom=kaod.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kaod.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=Mxy87uUV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kaod.org (client-ip=51.210.91.18; helo=smtpout9.mo536.mail-out.ovh.net; envelope-from=clg@kaod.org; receiver=lists.ozlabs.org)
Received: from smtpout9.mo536.mail-out.ovh.net (smtpout9.mo536.mail-out.ovh.net [51.210.91.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9KFY18CBz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 03:34:06 +1000 (AEST)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net [152.228.215.222])
	by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4h9KFM6mHdz88sr;
	Wed, 29 Jul 2026 17:33:59 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net. [127.0.0.1])
        by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <gouhaojake@163.com>; Wed, 29 Jul 2026 17:33:59 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.113.22])
	by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4h9KFM5kF7z5vZb;
	Wed, 29 Jul 2026 17:33:59 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
	(Authenticated sender: clg@kaod.org)
	by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id E7B691B43E63;
	Wed, 29 Jul 2026 17:33:56 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-110S0046666ee26-d8bc-4e48-988c-648345bd9bac,
                    8FFE599222FA429370CFDB2A71624BCB30E75F05) smtp.auth=clg@kaod.org
X-OVh-ClientIp:82.64.250.170
Message-ID: <7b146356-d24c-43b9-b521-373d08b06803@kaod.org>
Date: Wed, 29 Jul 2026 19:33:56 +0200
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
Subject: Re: [PATCH v3 2/5] powerpc/xive: add error return value to
 xive_smp_probe()
To: Gou Hao <gouhao@uniontech.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, namcao@linutronix.de,
 peterz@infradead.org, sshegde@linux.ibm.com, kees@kernel.org,
 lgs201920130244@gmail.com, srikar@linux.ibm.com, ynorov@nvidia.com,
 nilay@linux.ibm.com, benh@kernel.crashing.org, miltonm@bga.com,
 mkchauras@gmail.com, akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 gouhaojake@163.com, kernel@uniontech.com
References: <20260727104215.184786-1-gouhao@uniontech.com>
 <20260727104215.184786-3-gouhao@uniontech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260727104215.184786-3-gouhao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 4145281984094121020
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGLmrFPhnnCyhAOTPZ6zDI4OyuBO5OAfFOy8CmEOT0LSGLRypcb0uc0m2E7dFMcH9qEr43tS2zxVf+fpPh+fi+5X1m85dSYqfEFDe19qYGJyKZdqYSLW7lhXAIYsO+yZKGPB6rzuXEZ5qB+RuHJKu0UJetWTWzG1BipWCFl39fsRdTsQ7jR4xqTWQU4rcFnDw9hAheO+L5HFiOIKqzhRMFomVGAOuG70pF7M4uig08i5FQsBMhB6/py/KEdUC7N6tSn7YXFN07YdOYmOVM43xv85XImC3+/9yaVw0r/q1AZDS3oobdatojWeJSzT5YfngDlxxyfT2QfiLZYjz5rOx9XNNaPBQIuoJLXowXbF5rXGyTqW7R/xMzuCLUx/1sU3sBTG1IA0JeEhIOxp8ToIgUL6T85OsuMny9WtH3+nSn8WbAWkx1VTVsSoVh9vc9gBpa/9XoqOXNknTkhFqbuGDx0QYtbJwk53qSODfh3EkvzWPTKaiPN1T8Zg/YjYtreQHVL3MjEDiV+CN5Xax4BCO5Y/1QpsD7Py3RJKfgdn9Vx8/YV3egHm23Fm9ooq9Oesnyq8bPKAqdkILa2l9daNefYErGhFSJTtO/a5dMl0wkSl8SB7jPoHWCQJI/L/HbHGJTAwxFD399ndQl99wYa5Tq5EMqPPVis4HLYa0Z8BvXOqg
DKIM-Signature: a=rsa-sha256; bh=yqqIhslfQ4qpV20q+pEBj9d4z4LkslwJPQh8RPXNRXs=;
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1785346441; v=1;
 b=Mxy87uUVVPRWsLpM7axWEri078drNxvM4yN6/rDkSTO0Fg7DVAL7teXqoOgz8+DvtppNJEQT
 oif1zBJjvDsQZMy6KcOeq1DsWJW7x21K9jLRsWCRnMi4rGtaIy6gvQSR0YSNu/lhfo/2sPeS6xq
 Q2RsZB+Z14QwJsWLmGTKnXNTmfUPdRO9DRq0jRFQiCYZmFlFnuxFdlqrIcj3vQTogCoSvRMhx9L
 i1/neKqT+N8TffkKCGadLtyj3T507WpMQS/4FTZkU6EGmeoUqGQYwup+ibTJ33nLD9VJP4dt9rU
 +uKU+aMu8slxiZq028Gq5iLjslvBy6A3ASTilvfPhSLTQ==

On 7/27/26 12:42, Gou Hao wrote:
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
> index efb0f5effcc6..4e3e3358993c 100644
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
> index 86c78af1f68e..9f80c16be23f 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -1265,7 +1265,7 @@ noinstr static void xive_cleanup_cpu_ipi(unsigned int cpu, struct xive_cpu *xc)
>   	xive_ops->put_ipi(cpu, xc);
>   }
>   
> -void __init xive_smp_probe(void)
> +int __init xive_smp_probe(void)
>   {
>   	smp_ops->cause_ipi = xive_cause_ipi;
>   
> @@ -1274,6 +1274,8 @@ void __init xive_smp_probe(void)
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


