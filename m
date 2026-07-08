Return-Path: <linuxppc-dev+bounces-23837-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBE2C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 16:40:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwP3R5btKz306N;
	Thu, 09 Jul 2026 02:40:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::44a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783528835;
	cv=none; b=ldbY2HtAg+gtfqg9OwN5oYfdt+Y0J+2OU2nQ/+IqN8Z+mE6Cm0f+fkasOUMbCmDeAQbUuAA6npMy02PBFgWDuD7thWKK3euo70F0HXt2t2bgjlksmjxl32samSb0aADIcvXueBpoPLSYJkW7O59rZx5nTgt7v11uFf6lFXiHHU54KRErF/fLsOQYDnzma1e5OP5YJhv10bYI1/BJfAREd6Orl/334ivxqMumujYYg+fRW4K9Lvh5FUYv+5c2DjQcjgGgfud5ZfJE1vEZAFnifxuLRyeIApXrRp2eEu8t9DiMU78Lz2nouSLpcqk1ToYg5UNrI1mLqC7m7kSDGydaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783528835; c=relaxed/relaxed;
	bh=zFGoN9qGAHVZ4QAdcm49XPHorQEUZRxj5glJ1u7VDTg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jZDjtHWGk8hHl8ma12qSPRNwdANDwMgufLt2NEdcvoMnLEgiTkipJKlgIWMxMsxTuaZYuqENENX8P7YkIBiVCETvL3quluay0N6YGCBX05EYGZUoP32/jHJt0s16P+9gmLtrMFdT6uvQyAWJr7CIenOPinTf0mnl3wyGP6ri0OMxWbdC9NEJOdYufNWWbzrgowIENwDQo7duNVovkxSDrt2MOzYeGpqYtybCad5Puoj3iP1rCibgv2Whdj5H1+TueHWs0cKU6eDMie+kub4UGvE/DjZ4Z2J1y1Px2lvHFnpVohs2pWHXbyjKDv0SgqPwCONJEBgCg36KOvYtGH1ang==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=URuzFUbQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3f31oagykda46so1xqu22uzs.q20zw18b33q-rs9zw676.2dzop6.25u@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=URuzFUbQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3f31oagykda46so1xqu22uzs.q20zw18b33q-rs9zw676.2dzop6.25u@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwP3Q2rgjz2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 02:40:33 +1000 (AEST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-84842381150so1349705b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 09:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783528831; x=1784133631; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zFGoN9qGAHVZ4QAdcm49XPHorQEUZRxj5glJ1u7VDTg=;
        b=URuzFUbQ5Cmn+JGj85YGTmm69rYKICEJx5DNQLdWJ3itXrHxxgFjCJvn+iYieqUMEd
         +qhb2Jzlt4t5vez/o9w7RAQcVW9Skw88qtWVdTZ1Zo6ku2TGHoBuYz9IURu78CMeBC/U
         fVkb3RlJMBrr6OYtbva+g8J7QFOYdPFxnrhxFn871LzE6bOs43FB6/YizPoVmSrtgTzQ
         2VbVGgAWKgUk0nlcFGN7hAlzRERP86b7/FqQxgV7MsQOQ49seVzoH6PjlwKa5WrWAseA
         U0KoWtnpWe+4ArZwVTgtyZEo+6iQK49GXeLWwGIoZFnx4WeaDXsQivU1IFqP8IrPrDUV
         9Cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783528831; x=1784133631;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zFGoN9qGAHVZ4QAdcm49XPHorQEUZRxj5glJ1u7VDTg=;
        b=WyqIkfHnqUx9hO6iga+TbKqCJbDK2K7qSnBI0fz5rtE7ntfdEZlVTPH3GYSgrBE5iQ
         0EiA2GvFmkQS5NXs3pZclcvQxTe7U3Cz5pDFyXBH4cTQZ9Bzti9PbWZdEKEx5qmIEgxN
         ZovXsq7ka0HZJ+3zB45VX7gNBYqwCfBJS1zrAcABLt97TWtG6WK/epcnitOp7eme9tQS
         D/atgYnWanSlzcOxSoYMXOt8bl/QNJkpoily1GOf9TPK0LljjrdLJGt3NygmQbXazUfw
         j9pTALnBSdbvwLQBdrLOiNgGET3b1bPHKuqboPemvSrX+nYN/b4bYnO3ypQvz1ROlQAg
         8Dug==
X-Forwarded-Encrypted: i=1; AHgh+Rq2VJNIIibgc7e6PdyrH46JGUJbTifcVdo/Rjr09kVY2A+ocHKoymPs2jUBVGbA/yVZzEbghpiurl9Dr6Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxccPFo1th05WE8PfLa+M631rNZ0ce8OoVs7wJk9Rk2zkS22RsY
	Lx924OxoItGNOiYtxbG49LP5Z2o43aDfFuj97nmEmMCRkrjO4xzf5O2Xa86WmIgrsiKGph/QAYv
	YoSIzrw==
X-Received: from pfbmy25-n1.prod.google.com ([2002:a05:6a00:6d59:10b0:847:9499:46c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9487:b0:848:4b27:36a3
 with SMTP id d2e1a72fcca58-8484b274223mr1645594b3a.72.1783528831076; Wed, 08
 Jul 2026 09:40:31 -0700 (PDT)
Date: Wed, 8 Jul 2026 09:40:30 -0700
In-Reply-To: <1782119051448443.14545.seg@mailgw.kylinos.cn>
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
Mime-Version: 1.0
References: <1782119051448443.14545.seg@mailgw.kylinos.cn>
Message-ID: <ak59frQUBl9Gs3Qn@google.com>
Subject: Re: [PATCH] KVM: Nullify irqfd->producer when add_producer() fails
From: Sean Christopherson <seanjc@google.com>
To: leixiang <leixiang@kylinos.cn>
Cc: stable@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@ozlabs.org>, 
	Suresh Warrier <warrier@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 22, 2026, leixiang wrote:
> The x86 and powerpc add_producer() callbacks set irqfd->producer before the
> fallible setup and never clear it on error.  The bypass manager doesn't
> register a producer whose add_producer() failed -- producer->eventfd is
> left NULL, so the later unregister early-returns and del_producer() is
> never called -- so nothing ever drops the pointer.
> 
> For VFIO PCI the producer is embedded in struct vfio_pci_irq_ctx and freed
> when the vector is disabled, after which a routing update dereferences the
> dangling pointer via kvm_arch_update_irqfd_routing().
> 
> Nullify irqfd->producer on the error paths.
> 
> Fixes: 77e1b8332d1d ("KVM: x86: Decouple device assignment from IRQ bypass")
> Fixes: c57875f5f9be ("KVM: PPC: Book3S HV: Enable IRQ bypass")
> Cc: stable@vger.kernel.org
> Signed-off-by: leixiang <leixiang@kylinos.cn>

Please post the PPC patch as a separate patch.  x86 and PPC are separate maintainer
domains and the backports will likely need to go to different LTS kernels.

I'll grab/extract the x86 change from here (and I'll massage the changelog as
appropriate).

> ---
>  arch/powerpc/kvm/book3s_hv.c | 4 +++-
>  arch/x86/kvm/irq.c           | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3..14919b76fb32 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -6114,9 +6114,11 @@ static int kvmppc_irq_bypass_add_producer_hv(struct irq_bypass_consumer *cons,
>  	irqfd->producer = prod;
> 
>  	ret = kvmppc_set_passthru_irq(irqfd->kvm, prod->irq, irqfd->gsi);
> -	if (ret)
> +	if (ret) {
>  		pr_info("kvmppc_set_passthru_irq (irq %d, gsi %d) fails: %d\n",
>  			prod->irq, irqfd->gsi, ret);
> +		irqfd->producer = NULL;
> +	}

Unlike x86, AFAICT there's no need to set irqfd->producer before configuring
the passthru/bypass stuff.  So I think that fix could be this?

diff --git arch/powerpc/kvm/book3s_hv.c arch/powerpc/kvm/book3s_hv.c
index 61dbeea317f3..ff7b25629125 100644
--- arch/powerpc/kvm/book3s_hv.c
+++ arch/powerpc/kvm/book3s_hv.c
@@ -6111,12 +6111,12 @@ static int kvmppc_irq_bypass_add_producer_hv(struct irq_bypass_consumer *cons,
        struct kvm_kernel_irqfd *irqfd =
                container_of(cons, struct kvm_kernel_irqfd, consumer);
 
-       irqfd->producer = prod;
-
        ret = kvmppc_set_passthru_irq(irqfd->kvm, prod->irq, irqfd->gsi);
        if (ret)
                pr_info("kvmppc_set_passthru_irq (irq %d, gsi %d) fails: %d\n",
                        prod->irq, irqfd->gsi, ret);
+       else
+               irqfd->producer = prod;
 
        return ret;
 }

