Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCC4C433F5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Nov 2021 20:04:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7DEE60F59
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Nov 2021 20:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7DEE60F59
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HmBLN2xH0z3c4q
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Nov 2021 07:04:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=f5rhbj9p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::42c;
 helo=mail-pf1-x42c.google.com; envelope-from=seanjc@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=f5rhbj9p; dkim-atps=neutral
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HmBKd1PqXz2ybM
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Nov 2021 07:04:03 +1100 (AEDT)
Received: by mail-pf1-x42c.google.com with SMTP id g18so5036957pfk.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Nov 2021 13:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=PN/lxoi+e5tCVO5pPjxKDOBewixY35Ifh+V+MQmKh2Y=;
 b=f5rhbj9pb5GgTT0825+tujieonyli7SwThgHMXaD3NP3Mog1A094HPsqZZlkGOJ/Q+
 r3ZJnNzRBB3NhkN8VE/G5vrgRKhdENk2u9DuDgAERoqocOOeFGdBNvbmuevHRGuv/PzT
 2oM9e8uLyVHxjP0SBflIjCbS2YVvFiGTQPV4FXb1yFhkAV2Dwb/b8vz1V1fKzExBfVLb
 Xj15HqIIyyCqzeQTYv54iKEeMFkAbdprvcVA6NgVuqrrvC5EFRz5/vl/ehO9cRPXvPHn
 fwuRS81bHhHxNVlMCQCaLVr17+7bYqD4G5MIyYU1T+K/ui2sRBFDHO8DZRxHvFM9pN8W
 0Kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PN/lxoi+e5tCVO5pPjxKDOBewixY35Ifh+V+MQmKh2Y=;
 b=NlAQnAeDtOBd2quA2BMv+TVjVM2I5blG9hNGwsHoFQYZjOuONl40/vMwyuXfZmoiLJ
 GzmHZjBeFgas0A8SXL6wilyD/2PPHfOuAYmFDLTkGPjM+HnEgxddkaaLCVysC9vcHsB7
 Ct1TrlYr2g+5fXLtHz4kcLgjEPvQn6muPL7Qshl/FMOO2cSU/1f2OTZ1/U9c5k4MzpLy
 /LltqOGFcqcYQ0VSn6Uhylt9Biy8ah6C9vmL7ixt6XAdTAMdjr4fmUKRH3LvbzCXRjt7
 JmV1GK2nb3YdxblZJPiFc01NFCBPCdP5IJt5i7Cu5o9YYKqj1goE2mXU02QokiivWaek
 /Yvg==
X-Gm-Message-State: AOAM532XLure2Sg6/JTKhdeLpk4o+PKvi3XpzcOhzvINhiQ+HO59jNJO
 fPnJNNF3VGbmpyzgATiJiFy7ng==
X-Google-Smtp-Source: ABdhPJyd4QYc+InpdUIun9J0aiQkUM13aDBr60E6YJVxeHTQZZxRXWXSmp46OuKH+1B6vf2ZVsVbyQ==
X-Received: by 2002:a05:6a00:22d1:b0:494:72c5:803b with SMTP id
 f17-20020a056a0022d100b0049472c5803bmr10239284pfj.84.1636142638330; 
 Fri, 05 Nov 2021 13:03:58 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com.
 [35.185.214.157])
 by smtp.gmail.com with ESMTPSA id c198sm6639870pga.6.2021.11.05.13.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Nov 2021 13:03:57 -0700 (PDT)
Date: Fri, 5 Nov 2021 20:03:53 +0000
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 4/5] KVM: x86: Use kvm_get_vcpu() instead of open-coded
 access
Message-ID: <YYWOKTYHhJywwCRk@google.com>
References: <20211105192101.3862492-1-maz@kernel.org>
 <20211105192101.3862492-5-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105192101.3862492-5-maz@kernel.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Juergen Gross <jgross@suse.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>, Anup Patel <anup.patel@wdc.com>,
 Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>, David Hildenbrand <david@redhat.com>,
 linux-mips@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Atish Patra <atish.patra@wdc.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paul Mackerras <paulus@samba.org>, James Morse <james.morse@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kernel-team@android.com,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kvmarm@lists.cs.columbia.edu, Suzuki K Poulose <suzuki.poulose@arm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 05, 2021, Marc Zyngier wrote:
> As we are about to change the way vcpus are allocated, mandate
> the use of kvm_get_vcpu() instead of open-coding the access.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/x86/kvm/vmx/posted_intr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
> index 5f81ef092bd4..82a49720727d 100644
> --- a/arch/x86/kvm/vmx/posted_intr.c
> +++ b/arch/x86/kvm/vmx/posted_intr.c
> @@ -272,7 +272,7 @@ int pi_update_irte(struct kvm *kvm, unsigned int host_irq, uint32_t guest_irq,
>  
>  	if (!kvm_arch_has_assigned_device(kvm) ||
>  	    !irq_remapping_cap(IRQ_POSTING_CAP) ||
> -	    !kvm_vcpu_apicv_active(kvm->vcpus[0]))
> +	    !kvm_vcpu_apicv_active(kvm_get_vcpu(kvm, 0)))

Huh.  The existing code is decidedly odd.  I think it might even be broken, as
it's not obvious that vCPU0 _must_ be created when e.g. kvm_arch_irq_bypass_add_producer()
is called.

An equivalent, safe check would be:

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 5f81ef092bd4..a3100591a9ca 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -272,7 +272,7 @@ int pi_update_irte(struct kvm *kvm, unsigned int host_irq, uint32_t guest_irq,

        if (!kvm_arch_has_assigned_device(kvm) ||
            !irq_remapping_cap(IRQ_POSTING_CAP) ||
-           !kvm_vcpu_apicv_active(kvm->vcpus[0]))
+           !kvm_apicv_activated(kvm))
                return 0;

        idx = srcu_read_lock(&kvm->irq_srcu);


But I think even that is flawed, as APICv can be dynamically deactivated and
re-activated while the VM is running, and I don't see a path that re-updates
the IRTE when APICv is re-activated.  So I think a more conservative check is
needed, e.g.

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 5f81ef092bd4..6cf5b2e86118 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -272,7 +272,7 @@ int pi_update_irte(struct kvm *kvm, unsigned int host_irq, uint32_t guest_irq,

        if (!kvm_arch_has_assigned_device(kvm) ||
            !irq_remapping_cap(IRQ_POSTING_CAP) ||
-           !kvm_vcpu_apicv_active(kvm->vcpus[0]))
+           !irqchip_in_kernel(kvm) || !enable_apicv)
                return 0;

        idx = srcu_read_lock(&kvm->irq_srcu);


Paolo, am I missing something?
