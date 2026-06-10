Return-Path: <linuxppc-dev+bounces-22411-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8431CD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 12:59:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb5TH3j8Cz2yfD;
	Wed, 10 Jun 2026 22:59:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::44a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781096371;
	cv=none; b=YeOEfGxyTSfIAjsfHO8RwYLVWjzDFX4U0XCARUq0LiqAqsOfFg+LXobO1TPc1GVcfzbMKbWilpdxyEBPYQYu0RI4a4U9rGK4NIylHTVPqJmqjk9uVnJDESMhO33KLEzyI9wLSrTFiJNQr9MOjj/L7stY7XTrZEMfwGRg4hXiGfv8tnee9s4MygyIU5XuMPV3lpJ4sT2AcjnmLZtqjx5M0XE2uZ4qaXtf026egpKkt3ptPcvbUzvYSAd1DZyoVPPxvnmARElTS+W6IzqSwXJYSIbwg7MzQujo2EKFaMtTltPv+XA03pmsQwS5x4/DqH2JDTxAtuCdNQw5bi1Fq+/i0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781096371; c=relaxed/relaxed;
	bh=1NbKBk0OFMtK3aDv+gUztpO8HwlNLStu40uQDPANIdU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eQ2jTaRyF22gLAtIIxc+nKlBQH5awiw5WDNmICZ3E8/gNyOcMsrb1BUNrhESJKd3Yw4ZBuF8KioNUZRDLO2KQgWBiCu9jfh28GeqP5NhMC9l3MUq3xuT4SuB/sQcGLcR9pfsglBlaTZsz2FzhkzVKyXsruhHR/Kctv3j+wDRIOArrYWfzCdk8U/ALF/LiFcg288pQVbbnjErbofP6KsCl4JFYUOrlMlXN+6wVi4C0EK4gYXB5pgj16giBbpTNkn7QNDQlCQ2SQT0Eikx1WBMRcOnz5YJ33+a60c/5hqiC/uIBlzNo+6p+toPZAKohEEy5yzm3Ezta3TXheinDG9+4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KGHW1To/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3rl8pagykdgsbnjwslpxxpun.lxvurwdgyyl-mneurbcb.xiujkb.xap@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KGHW1To/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3rl8pagykdgsbnjwslpxxpun.lxvurwdgyyl-mneurbcb.xiujkb.xap@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb5TG2xcnz2yNn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 22:59:29 +1000 (AEST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-8425a9979e1so4621373b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 05:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781096367; x=1781701167; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1NbKBk0OFMtK3aDv+gUztpO8HwlNLStu40uQDPANIdU=;
        b=KGHW1To/3+HJLjcxGLu2EcVXbPrWZQspxdNYjnL7BvDMrGXt4rk9DYjmhjAXQzQIkn
         yK7wNEH2Ftt1daKxj0FvS8rr1QDdw/EpwGTYzJaDOTfFeQHYDW/3UItJmg20oet+kTxV
         aXupKHV44P+2c1wr+5EbhsBD2D86lBiNj/HCWFk1sdAThufDRBsbQgKFh5hbC1EZtSK4
         6G6s49451q9+MYYHqk4nul91UtVoMIqwxVRxJxJf9Xgr9n/ma9lW3XkjQuNhyVA0DRDK
         CkTvmQVKyeNLjXuISYDULu87ZWFVisN7zE3tpFZzQ2yPEuGavs8Il15PYxgURJGKl7D/
         UNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781096367; x=1781701167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1NbKBk0OFMtK3aDv+gUztpO8HwlNLStu40uQDPANIdU=;
        b=Zc3Sv8AgpzwzYpv3YBlXGPEod9wWBgFtRsUeR44XcoVHqaYnv0BcgB+69055QlGNND
         3pfVDDWFIQy2fTYsTtXoVRsUFEftdE8//jggaXSM8gF+k5nvcoP7t5vo6u8IzB8ALzd9
         +LtGPxf+tBPfQeWJEmAyUk5/uemGPxkCm8y4FN2R9/WMK3pdxnNCxCqkV5hHefdR+L+P
         fhK2gOR9LnkMQzlfO67O72M4ivWOioAWwPD/iTE6YPOFb5lme9VTHQ1qyT5nMSsss8EB
         HYD0Tj3BKzAY+dTBMLPCSJPDbvwb1WkwQ5lXjeJmKhcuwzAwk/BRbMtFgqzmwZ84v4T8
         gUqQ==
X-Forwarded-Encrypted: i=1; AFNElJ9z318qPGs4wYqa5lR3SEwKMFC3iy/FxXy19x/tOwBRPXe5DDIsKMEyiy+TMlS1KLqSHKztO9ZJo083C9Y=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxM9GMItB92oZmgosOfhUdnN3w/WpMIv0q2SNeI6fI+GJkveel3
	bAMyA3r13s3KFoouP7GmuWQ2wsTYkkcrQXr24eZ40pvl8FKjeAT64O8EFEIJ+IPUaO2gwVi1jeM
	6Ruo6Og==
X-Received: from pfrg6.prod.google.com ([2002:aa7:9f06:0:b0:83f:1941:b9bc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c85:b0:842:48ae:1d56
 with SMTP id d2e1a72fcca58-8430a742437mr8863146b3a.35.1781096366425; Wed, 10
 Jun 2026 05:59:26 -0700 (PDT)
Date: Wed, 10 Jun 2026 05:59:25 -0700
In-Reply-To: <2d2c46be7f051c7f1c645afaec67f57067d37a81.1781093720.git.ritesh.list@gmail.com>
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
References: <cover.1781093720.git.ritesh.list@gmail.com> <2d2c46be7f051c7f1c645afaec67f57067d37a81.1781093720.git.ritesh.list@gmail.com>
Message-ID: <ailfrWKNI9SfBNRh@google.com>
Subject: Re: [PATCH v3 RESEND 05/10] KVM: selftests: Print the vcpu_id when
 KVM_CREATE_VCPU ioctl fails
From: Sean Christopherson <seanjc@google.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
> Print the vcpu_id and errno when the KVM_CREATE_VCPU ioctl fails, for
> debug purposes.
> This helped in debugging an issue with KVM on PowerVM, where KVM_CREATE_VCPU
> only supports max 2048 vcpus, because the PAPR_HCALL H_GUEST_CREATE_VCPU
> ("Documentation/arch/powerpc/kvm-nested.rst") supports only up to 0-2047
> vcpu_id. However KVM_CAP_MAX_VCPUS capability extension always reports max_vcpus
> as NR_CPUS of the host.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index e00a25f59416..6319e2037882 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1354,6 +1354,13 @@ struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
>  	vcpu->vm = vm;
>  	vcpu->id = vcpu_id;
>  	vcpu->fd = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(unsigned long)vcpu_id);
> +	if (vcpu->fd < 0) {
> +		int saved_errno = errno;
> +
> +		pr_info("Failed KVM_CREATE_VCPU for vcpu_id %u with errno %d\n",
> +			vcpu_id, saved_errno);
> +		errno = saved_errno;

Sorry, but NAK.  There are myriad failures where printing extra information can
help debug a failure/assert, I don't want to create a slippery slope where the
codebase is littered with extra print statements that someone found useful at
some point.

