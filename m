Return-Path: <linuxppc-dev+bounces-21502-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6C5CD5BCF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 07:09:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPkQ84nd9z2y8t;
	Tue, 26 May 2026 17:09:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779779360;
	cv=none; b=JOuKjEdYCu9rAuCy43agosQfr/SdVq+18UsmxP9vXgN+Ne4G23equj1il7z7BrWv2l2xZi9bxGOSoznC4R2jWbhfhuI11X8R7toW+SLfxttDOGBIeJfHYka/S8bBMpDnrJRiltTeqLMN7YuxKy2uw+2A+RB94o0GoRru6yT8y2eRrCgrHhv/1AiVtk26l8stYJDWKG2ZJv+JAWZUBkl/gKVyNw8PoeVa7UA/T2oJFlmYKttpVfX1/Wb5E0eL7jgYc5CdPORRRPKf1IJJgTJria2QS5JTuJRgAA+RJ1GLS/MhbOmejqVIAm7nNpG6Qk5ABoaKKigOxEDbVth2o/tlpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779779360; c=relaxed/relaxed;
	bh=YmZiORvQA99B6/TCT7VZGgnHu1QCgAzxvQxxkh40HDE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mMRt3nNc/NIqrAdkCpj5YKBAa+bpiqC0DxPrBuNSU8qKaIf214pdkIMd4waf0FDK3eeaMK+TMaIqclWh1La7XpFr3X8ic4qEym4UoYHDDOSn8hc3uZyo54tSLoRPV2YaPqp/o+nNeKKVPyvq4DybyEo6l0F+iRLp5fpChUrvLcKq76xPDpSt2zT3ZbE3EG/eIWVCJdSgi/Xgd4hXpmZGZ1SrpV5pSHtZ5cU5H0C194sGLLtNB5kmYi76olxvgMVfSnltFbFWIGtKbDuabQKudw+dhuxZTav2RehMhaJdmTQOpZFfIKs5UYp1YtuhoYLaYW0qBeFPsccaHhDiB3ZfiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass (client-ip=114.242.206.163; helo=mail.loongson.cn; envelope-from=maobibo@loongson.cn; receiver=lists.ozlabs.org) smtp.mailfrom=loongson.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=loongson.cn (client-ip=114.242.206.163; helo=mail.loongson.cn; envelope-from=maobibo@loongson.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 116 seconds by postgrey-1.37 at boromir; Tue, 26 May 2026 17:09:18 AEST
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPkQ62KHjz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 17:09:17 +1000 (AEST)
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxsOqhRhVq700NAA--.38078S3;
	Tue, 26 May 2026 15:07:13 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJDxaeCdRhVqLmCRAA--.14119S3;
	Tue, 26 May 2026 15:07:09 +0800 (CST)
Subject: Re: [PATCH] KVM: Validate irqchip index for LoongArch and PowerPC
To: Yanfei Xu <yanfei.xu@bytedance.com>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com,
 sashiko-reviews@lists.linux.dev, seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, caixiangfeng@bytedance.com,
 fangying.tommy@bytedance.com, isyanfei.xu@gmail.com,
 Sashiko <sashiko-bot@kernel.org>
References: <20260525070154.495455-1-yanfei.xu@bytedance.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <875c4486-2d88-f5c7-b921-7d33639f2e88@loongson.cn>
Date: Tue, 26 May 2026 15:04:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
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
In-Reply-To: <20260525070154.495455-1-yanfei.xu@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxaeCdRhVqLmCRAA--.14119S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar1xuF47GrWUWFyUJw4rXrc_yoW8ZrW5pF
	WUAa909rn5Grykt3Z0vw4kWr4jq3WkGr42g3WkWrZ2yry0qFn5K3W8ZrnrXr18t3yrGF40
	9F4IgF9IqF45CacCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07joc_-UUU
	UU=



On 2026/5/25 下午3:01, Yanfei Xu wrote:
> Sashiko reported that irqchip index is not validated for LoongArch and
> PowerPC. Add validation and reject out-of-range irqchip indexes to avoid
> indexing past the routing table's chip array.
> 
> Fixes: de9ba2f36368 ("KVM: PPC: Support irq routing and irqfd for in-kernel MPIC")
> Fixes: 1928254c5ccb ("LoongArch: KVM: Add irqfd support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/kvm/20260525051714.485D51F000E9@smtp.kernel.org/
> Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
> ---
>   arch/loongarch/kvm/irqfd.c | 3 ++-
>   arch/powerpc/kvm/mpic.c    | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/loongarch/kvm/irqfd.c b/arch/loongarch/kvm/irqfd.c
> index f4f953b22419..40ed1081c4b6 100644
> --- a/arch/loongarch/kvm/irqfd.c
> +++ b/arch/loongarch/kvm/irqfd.c
> @@ -51,7 +51,8 @@ int kvm_set_routing_entry(struct kvm *kvm,
>   		e->irqchip.irqchip = ue->u.irqchip.irqchip;
>   		e->irqchip.pin = ue->u.irqchip.pin;
>   
> -		if (e->irqchip.pin >= KVM_IRQCHIP_NUM_PINS)
> +		if (e->irqchip.pin >= KVM_IRQCHIP_NUM_PINS ||
> +		    e->irqchip.irqchip >= KVM_NR_IRQCHIPS)
>   			return -EINVAL;
>   
>   		return 0;
> diff --git a/arch/powerpc/kvm/mpic.c b/arch/powerpc/kvm/mpic.c
> index 3070f36d9fb8..fb5f9e65e02e 100644
> --- a/arch/powerpc/kvm/mpic.c
> +++ b/arch/powerpc/kvm/mpic.c
> @@ -1833,7 +1833,8 @@ int kvm_set_routing_entry(struct kvm *kvm,
>   		e->set = mpic_set_irq;
>   		e->irqchip.irqchip = ue->u.irqchip.irqchip;
>   		e->irqchip.pin = ue->u.irqchip.pin;
> -		if (e->irqchip.pin >= KVM_IRQCHIP_NUM_PINS)
> +		if (e->irqchip.pin >= KVM_IRQCHIP_NUM_PINS ||
> +		    e->irqchip.irqchip >= KVM_NR_IRQCHIPS)
>   			goto out;
>   		break;
>   	case KVM_IRQ_ROUTING_MSI:
> 
Hi Yanfei,

That is important fixes, thanking for your efforts.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>


