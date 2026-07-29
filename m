Return-Path: <linuxppc-dev+bounces-25035-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC997C53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:35:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9KGh1XGVz2ygW;
	Thu, 30 Jul 2026 03:35:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=51.210.91.36
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785346508;
	cv=none; b=IMdlB0MEoVrpOdqz6F22R+cwK9gXyp2lCdVjmFB8JJY5lr49DcK06FF+zA3237EQAmr1q+KW/GE+pc3rW2LN2IRQfyYAggHBXVBLqs5UKJgTuYI9IOAo1o9QhpXE6ih867hYueXwa8+QYlR08T3+QWB0r0D6gsodgFM5iVR9mVCYytG1ZxDmvkwZ/9GKt1hirMblo+Ezzv/A6liMnZVuCmnpppwkzRUe5W0oeIRKQqkFLDX0TImYwoIJPpP6kf16v2O2D8dDglqIIcrimomc1sUx0+Yjcot4dtNNSc+tM6TPxVHdZVeMCR+Y6AOkwIzrld3oO+ZMgJCJ7T0IWUllXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785346508; c=relaxed/relaxed;
	bh=AtH8qwldBvQcSsnwoUSrG9aPBel69UyrD7lBMTuVt00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPHSQNAldQ7NdikKLNN4ilyeXpGyAHsUbsCkvPntFA/SGWxteg8nnytmdM8Jmco3g++YXbiyNcXIS01yRlONNnK1BbaeY2mHrtiQ9Mr1EmrM2LDZgvbXriTA0ZCnVEjkH4BWcHO2BeooEiHCpuWUL5fByaSCrw7rxaxqmNziBtL2U4ADQ5JBqvcJuenLQOU1diFoi4DA4rusaQXzZXk28kGRqgiSGKWtpsfbCDhho4MjkU547b3z8D/R8K1J5eWnl1LJhS7JOsXvmA/19ZpwWFBJlTNV/Tp12e0KK/4Qpz7h/FOVm30iQvIlkVabWY7zUACHiXbQzZulFCGgBySKpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kaod.org; dkim=pass (2048-bit key; unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=CKMe+UB+; dkim-atps=neutral; spf=pass (client-ip=51.210.91.36; helo=smtpout7.mo538.mail-out.ovh.net; envelope-from=clg@kaod.org; receiver=lists.ozlabs.org) smtp.mailfrom=kaod.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kaod.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=CKMe+UB+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kaod.org (client-ip=51.210.91.36; helo=smtpout7.mo538.mail-out.ovh.net; envelope-from=clg@kaod.org; receiver=lists.ozlabs.org)
Received: from smtpout7.mo538.mail-out.ovh.net (smtpout7.mo538.mail-out.ovh.net [51.210.91.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9KGg3ZJKz2ylp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 03:35:07 +1000 (AEST)
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net [79.137.60.36])
	by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4h9KGZ3G0gz6H0X;
	Wed, 29 Jul 2026 17:35:02 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net. [127.0.0.1])
        by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <gouhaojake@163.com>; Wed, 29 Jul 2026 17:35:02 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.254.17])
	by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4h9KGZ2TBzz20sp;
	Wed, 29 Jul 2026 17:35:02 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.6])
	(Authenticated sender: clg@kaod.org)
	by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 8C22B12E3E5B;
	Wed, 29 Jul 2026 17:34:59 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-104R00588784869-de6c-4e6d-89b7-8837ff72a873,
                    8FFE599222FA429370CFDB2A71624BCB30E75F05) smtp.auth=clg@kaod.org
X-OVh-ClientIp:82.64.250.170
Message-ID: <f20637f3-f06a-42bd-9ce2-0323b280371a@kaod.org>
Date: Wed, 29 Jul 2026 19:34:59 +0200
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
Subject: Re: [PATCH v3 4/5] powerpc/xive: defer setting cause_ipi until IPI
 init succeeds
To: Gou Hao <gouhao@uniontech.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, namcao@linutronix.de,
 peterz@infradead.org, sshegde@linux.ibm.com, kees@kernel.org,
 lgs201920130244@gmail.com, srikar@linux.ibm.com, ynorov@nvidia.com,
 nilay@linux.ibm.com, benh@kernel.crashing.org, miltonm@bga.com,
 mkchauras@gmail.com, akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 gouhaojake@163.com, kernel@uniontech.com
References: <20260727104215.184786-1-gouhao@uniontech.com>
 <20260727104215.184786-5-gouhao@uniontech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260727104215.184786-5-gouhao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 4163014909367397436
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGLmrFPhnnCyhAOTPZ6zDI4OyuBO5OAfFOy8CmEOT0LSGLRypcb0uc0m2E7dFMcH9qEr43tS2zxVf+fpPh+fi+5X1m85dSYqfEFDe19qYGJyKZdqYSLW7lhXAIYsO+yZKGPB6rzuXEZ5qB+RuHJKu0UJetWTWzG1BipWCFl39fsRdTsQ7jR4xqTWQU4rcFnDw9hAheO+L5HFiOIKqzhRMFomVGAOuG70pF7M4uig08i5FQsBMhB6/py/KEdUC7N6tSn7YXFN07YdOYmOVM43xv85XImC3+/9yaVw0r/q1AZDS3oobdatojWeJSzT5YfngDlxxyfT2QfiLZYjz5rOx9XVP5uy4XgVVxaTUi31S8BSLLs1m7kiRyPyvlyQo99ZtSlYD7YJqeml+6UrllZnhJfLg1MD6MPofheFkOGSHX8ljlbVV80lDrE3OzeaejKCHwpf/CAYGf1SrtkU7cuUa2zjQLbzIXmM+yE8rJlJR/EhR8KPJHe34OgfaqXTryqxpU+YXMN5q7I5P36EFHXMDXYozY6zbgcMLMnH53ql6vuDenehk6q1IcAAgM5Xm8JGU0MJW9NMTyth3SQEv0EG798ncfxzjJatNsWFdLRrDpTyFVlQffvhgN+CQvrN9l6KFlLgElYJrtm95y4eRsTxxnpoHLeZFmKcuVjME8ew4Kfww
DKIM-Signature: a=rsa-sha256; bh=AtH8qwldBvQcSsnwoUSrG9aPBel69UyrD7lBMTuVt00=;
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1785346503; v=1;
 b=CKMe+UB+qq9bzWl47reRXxnzxUIyVCYiiN+opSCmHjVc3MWfip7jRwT50Mxlj1GUDg5w2dks
 uikfFgOT59eWVZdLUY+zaSEB9eYoRIYC638F1xtzKZaIw8KvNfefOGT+Bpppnd7B92YCKvmH/Cr
 7l3TGbzAwXjeTIBUsxT5PGe6n5U/IikSA/VFN18vyuqt04GQlXRcnYvts/UzadlpDp8HWXHNMfo
 RKtJyh7xv6xE1CKDPdFVpamfaW9DdPzvx2PCxn6FbvZE4USSY8QQW3xw51BlbWA+iNAVWStrnT2
 LcHjzEqJN8i1c7dZnLTzmtcionRApE87ZY/H7LHQ6NLEw==

On 7/27/26 12:42, Gou Hao wrote:
> xive_smp_probe() currently assigns smp_ops->cause_ipi = xive_cause_ipi
> before calling xive_init_ipis() and xive_setup_cpu_ipi().  If either
> call fails, the platform probe handler returns early but cause_ipi
> remains pointing to xive_cause_ipi -- which accesses per-cpu IPI data
> (xc->ipi_data) that was never properly initialized, leading to
> a WARN and a crash.
> 
> Move the cause_ipi assignment to after both calls succeed, so that
> smp_ops->cause_ipi is only set when the IPI subsystem is fully
> initialized.
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: jiazhenyuan <jiazhenyuan@uniontech.com>
> ---
>   arch/powerpc/sysdev/xive/common.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index bbe7c85274ea..8ae088632337 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -1269,15 +1269,19 @@ int __init xive_smp_probe(void)
>   {
>   	int ret;
>   
> -	smp_ops->cause_ipi = xive_cause_ipi;
> -
>   	/* Register the IPI */
>   	ret = xive_init_ipis();
>   	if (ret < 0)
>   		return ret;
>   
>   	/* Allocate and setup IPI for the boot CPU */
> -	return xive_setup_cpu_ipi(smp_processor_id());
> +	ret = xive_setup_cpu_ipi(smp_processor_id());
> +	if (ret < 0)
> +		return ret;
> +
> +	smp_ops->cause_ipi = xive_cause_ipi;
> +
> +	return 0;
>   }
>   
>   #endif /* CONFIG_SMP */

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


