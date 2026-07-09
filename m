Return-Path: <linuxppc-dev+bounces-23917-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF13C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 08:33:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwpBS1GNHz3cDk;
	Thu, 09 Jul 2026 18:33:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783575938;
	cv=none; b=exIqjH2XD5Jsq5qGsGgh8BNIHJKlDXq5h+bEjoKY2K/0T4k+5V7YpwhCRgVmpYi4gjafuXGkHWmsJKMCtJYCHgSLaC/jFiQ6pSV8m686WnSWneVOI3rQx8wpc0alZcQMtRlzOJbCOYZ1pXJ2hZIpX8MtIH04YrdTL6mNnxK83VZUKPo5X/yHdU7LocXoXnKco6Yb3jqcLi57YBJtCKrcFV8Lr3yxhVzXXED8tZKCKdDhTWpBFfzP44M2EUtOp0BwNCwdSlDW4Zklh+2QVeGmSo0hkfXkXxXCFh2I2wiFFLVGAyz1VDe5FMW1GU2w8wUZzARa4gqfdvYlVH+1Fkd0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783575938; c=relaxed/relaxed;
	bh=yNOQxL4FXDmHyD0Kjq23REAu9LFdCtb3Pm7cOHC959s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dfPCobT1YYIxMBje+D19ucUQXbNdmoBx1tbkXSv/huposEAv9rGoId+HdAlEM5Zt5PUV8SNgtrEb4mYBYBauIRcLgtWl614HpA5pNf1J7i7YaRwm5XhKZTr+wkHbYHZCFLdyMrWYiJmJnhjm5UpN6BN4d490DOxmB56yPlVWsOmxoTKPV2bF3rqyYq5Dx1wzk/ufEV2fgEWdCwd1spCmmgJK6EO5gKFeQ2/5YNSOSUWEPYj5qmxvmL05dRkbqrfpksRoTeBnXz2ehseQeSVRAbdRnrV6swLrkU3M8nRP/e4GbB8AfO39c+oCGtALsTIsmK5/wyha7S1CmL2o/EK6xQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R2QoQ8+m; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=leenollei@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R2QoQ8+m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=leenollei@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwkTD71sfz3c9k
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 15:45:36 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2cca24023edso7703345ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 22:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783575934; x=1784180734; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yNOQxL4FXDmHyD0Kjq23REAu9LFdCtb3Pm7cOHC959s=;
        b=R2QoQ8+mLt9LukrbF6D5tuYIHzmm3EnzALfJNgoE/tDOESDsTjTn2HaAqg0rL78IXT
         tDW1lvguoeAL0Yunz65M+4HqR+BwI3jZRLsHtrwfYoPHe8b9ALjWYj3DaLOvqaeqKoQp
         uGAo925iWaTz+9cXJ4SQy/+/sr+RZ0nqMC/TFm/m1fYwrian+lNPnVSFaRBG9Xs22+tU
         +5h+6Zj4Z3gBuha5QVJPf+VYjfYjky9MWpH1s5J5An7oLYn/sCn6cWKJBhNbkz4Mxf2G
         RpatrXVL/hbmy0ijugrBob7Js9uze1dzAyd/18DOuYvqgUG1Efmnrdw3XjljV1xUyXMP
         Mz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783575934; x=1784180734;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yNOQxL4FXDmHyD0Kjq23REAu9LFdCtb3Pm7cOHC959s=;
        b=illp63y23nrCrQqbp2MRVYgAcKLdGNEK+PlfHuGkGTc2vXyhTzVTB52aZhAL1FeKE/
         DAaNBnGDQawAMIARuzVslesyLoc9mA4XkhmFBpftclMXAGp7GaiS0m9POaFuchxOCLQ9
         4coL5vIjb8cFjl8VjO/OzhDSj1TNJGRkUkk6Jr2M8j6tLt9mU0GLHhpVJn1Lkl13ykey
         EcVUOx8PsBUDrKXrtUqB3RFFo2mZ9OEJL/AsFwFKsT410zoI1WU3Kc+IahfEGT7aZJ/7
         ZfGP9y4yaJOUvjaOk7asELlGRBqqmih3GyAW3u2oS22/409ne0fuWGtB1ackqjjjiFX1
         0P/g==
X-Forwarded-Encrypted: i=1; AHgh+Rpj7gySo3GXehdPg7fo3JfphaQmE1Yk1UwXCxyRov9iWKttF2rTklVioJAOxnTWaF+o4z5KGYlkQ/iqB1M=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwScFgZsX1UANQkyzPicRFZXUXFFdi6k5NWVzsBKZzVdR+MCKbu
	WyPBHIzxBkE8gno5rT9hyQxtQ2VxQTIHb/TWo/+9hIwprgSnHXnZl+uW
X-Gm-Gg: AfdE7ck43zXZg273hRgLvIe+Vk72At6F/+fFRe37PBxkGLV3VY+CbmgXp/1FxvFD1nn
	7fTIC1MKg1u6ZjfKi/OhyO1ovn1tMY5Y28qa59T6CPrWEI9/G2TJDiY1t9J0NohNDdThbQBY+L0
	1aVCQSvTAd4eZYkHamv2hhxK3aGXkMJCF8uX9Diy053UQhDMu7IZiygDR9m3i+GWYNdyKuL1T2C
	Wu2eSie2vkK2NeFeIUp4CUbJ49XsVpcqVi+ft78/3Zli3JEfTQbeijVgeSRYfugXAy15gIaIhdc
	SqPlsDY8Ah/Cnb4bdBYPpbcMer3pZ4RceIjvcRMNowMHqItqo6CcGrWSnm9QuF351cET9X+Kin/
	APB388Rje6JyOJtIoegriLnFJBKLK/ezrVVIgW4gH0qhl2sokWcwZ1wq83rzB9odCro049ZRUjZ
	4TlrsqYBx68Afk4XT0
X-Received: by 2002:a17:903:3903:b0:2cb:14b3:4cfe with SMTP id d9443c01a7336-2ccea582ae2mr60334915ad.45.1783575933576;
        Wed, 08 Jul 2026 22:45:33 -0700 (PDT)
Received: from [10.42.12.77] ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc99cc5aasm38156905ad.0.2026.07.08.22.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 22:45:32 -0700 (PDT)
Message-ID: <c12700ab-7f0c-452d-b8de-8e23ca48f1bd@gmail.com>
Date: Thu, 9 Jul 2026 13:45:23 +0800
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
From: leixiang <leenollei@gmail.com>
Subject: Re: [PATCH] KVM: Nullify irqfd->producer when add_producer() fails
To: Sean Christopherson <seanjc@google.com>
Cc: stable@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@ozlabs.org>,
 Suresh Warrier <warrier@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 leixiang <leixiang@kylinos.cn>
References: <1782119051448443.14545.seg@mailgw.kylinos.cn>
 <ak59frQUBl9Gs3Qn@google.com>
Content-Language: en-US
In-Reply-To: <ak59frQUBl9Gs3Qn@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/26 00:40, Sean Christopherson wrote:
> On Mon, Jun 22, 2026, leixiang wrote:
>> The x86 and powerpc add_producer() callbacks set irqfd->producer before the
>> fallible setup and never clear it on error.  The bypass manager doesn't
>> register a producer whose add_producer() failed -- producer->eventfd is
>> left NULL, so the later unregister early-returns and del_producer() is
>> never called -- so nothing ever drops the pointer.
>>
>> For VFIO PCI the producer is embedded in struct vfio_pci_irq_ctx and freed
>> when the vector is disabled, after which a routing update dereferences the
>> dangling pointer via kvm_arch_update_irqfd_routing().
>>
>> Nullify irqfd->producer on the error paths.
>>
>> Fixes: 77e1b8332d1d ("KVM: x86: Decouple device assignment from IRQ bypass")
>> Fixes: c57875f5f9be ("KVM: PPC: Book3S HV: Enable IRQ bypass")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: leixiang <leixiang@kylinos.cn>
> 
> Please post the PPC patch as a separate patch.  x86 and PPC are separate maintainer
> domains and the backports will likely need to go to different LTS kernels.
> 
> I'll grab/extract the x86 change from here (and I'll massage the changelog as
> appropriate).

Thank you for the review and guidance.  I will submit a separate PPC patch.

>> ---
>>  arch/powerpc/kvm/book3s_hv.c | 4 +++-
>>  arch/x86/kvm/irq.c           | 4 +++-
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>> index 61dbeea317f3..14919b76fb32 100644
>> --- a/arch/powerpc/kvm/book3s_hv.c
>> +++ b/arch/powerpc/kvm/book3s_hv.c
>> @@ -6114,9 +6114,11 @@ static int kvmppc_irq_bypass_add_producer_hv(struct irq_bypass_consumer *cons,
>>  	irqfd->producer = prod;
>>
>>  	ret = kvmppc_set_passthru_irq(irqfd->kvm, prod->irq, irqfd->gsi);
>> -	if (ret)
>> +	if (ret) {
>>  		pr_info("kvmppc_set_passthru_irq (irq %d, gsi %d) fails: %d\n",
>>  			prod->irq, irqfd->gsi, ret);
>> +		irqfd->producer = NULL;
>> +	}
> 
> Unlike x86, AFAICT there's no need to set irqfd->producer before configuring
> the passthru/bypass stuff.  So I think that fix could be this?
> 
> diff --git arch/powerpc/kvm/book3s_hv.c arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3..ff7b25629125 100644
> --- arch/powerpc/kvm/book3s_hv.c
> +++ arch/powerpc/kvm/book3s_hv.c
> @@ -6111,12 +6111,12 @@ static int kvmppc_irq_bypass_add_producer_hv(struct irq_bypass_consumer *cons,
>         struct kvm_kernel_irqfd *irqfd =
>                 container_of(cons, struct kvm_kernel_irqfd, consumer);
>  
> -       irqfd->producer = prod;
> -
>         ret = kvmppc_set_passthru_irq(irqfd->kvm, prod->irq, irqfd->gsi);
>         if (ret)
>                 pr_info("kvmppc_set_passthru_irq (irq %d, gsi %d) fails: %d\n",
>                         prod->irq, irqfd->gsi, ret);
> +       else
> +               irqfd->producer = prod;
>  
>         return ret;
>  }
Agreed. Your approach is cleaner.

