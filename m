Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51976606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dqAaW705
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDpJM0Hjvz2yTQ;
	Wed, 28 Oct 2026 11:33:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::c33" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793147634;
	cv=pass; b=ge0mRVyxZAkPH1/JzSd17pfPZaosAUG8rypVgnqQQaKQ9gAA6dzWyi1uA4WBrkvetjmV7mCN5aP2ObdmSjk8ZhC+sD1etSVhLTGbt/JYL6FHLjC69v7SlK0HfgXC3mSlwvA+jRDqtmgz1NUS4zpCHV9XpBmtIbQtmhLHZRBgcg29H0/xVYJml00AKoFXUGI9ntkaf9K8//p7v+kqILUb8bU2+vcZoDW37bOmU3DjuiOrshXYmo0CYPjgjfG7pY+9HV5Nd6NFA2Tk2FrKjMne6OeB2lRQSaFCCxrfuHnP5OuGBh+fGdRQtbV/V7oRU6PfKoSksqt/IkmQFNr+rrpUmA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793147634; c=relaxed/relaxed;
	bh=a/g709wCzxTBAV5yLrw3H5BO2UbCvR/yueVUmZTiqJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGPUiNDkUaQt2UOq2Cplu8R5CMU9dx4KEuok5gY8D74ig+nG77mKb2gS8AzMNXS41mv6fWPLO+7cUhDZ1wYxa+ldxG6k2AHs+n/yfAE2Bu+OaOgDVBX9+HoFI86wBwj1yvmHv9AqlfrTmGB2jvy39KlwOytLpKrDhWZ5cdX7BsNfWjRtpksan5UAo46FLDb5cAZjsX6/tIgKEMJrjbbrQQWzfKQCgr8C7Rj5U18f1xXM2hxuNJX0aapimSi08esGWM45G/OOl9AvbBfO00tEfF8Qf41jhMSgzsJ/l89lAwIQHMmxu7a/fumEhtY7xbZZzFRP2nur5UPzsmSNG4vPCg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dqAaW705; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com; envelope-from=jthoughton@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dqAaW705;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com; envelope-from=jthoughton@google.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDpJK5HNSz2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 11:33:53 +1100 (AEDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-6aa9606ddadso425976eaf.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 17:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793147630; cv=none;
        d=google.com; s=arc-20260327;
        b=QQl47KlcVFDczq1l3t+Ye38J7ADbRGYYqN3J1zBbcpPcSvmHBBrcki0cpGVMcI30+S
         hEi6ab/SAnD1rg99sxw2ogKPexl3btLUJ2URCIL3zIFoU56AEXWgSIN04nPZ6B9BPBK2
         ix1MvDXamRrmAQTTdRpQ32AXZRetteF024UlBFOvVKxmf23TfEnWLdf/BUE2Yckw0mqi
         EPUEPzWvR93h5o+MXb8Phiuw/dElmibkxfwZzr3hyTkr7rI7lmP9k7fMiuHvsbiM5ov8
         rVjGRCVbcvA+/zoGVtwiTwwhNUBqMgOBuafVy7nu/oRucrwBgc8vq98v/Q4wAOGXS4Bc
         YxXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a/g709wCzxTBAV5yLrw3H5BO2UbCvR/yueVUmZTiqJQ=;
        fh=qzjDrxdpyWYqnSesFtZgWqF3BPvHcuHykwClffg2pbs=;
        b=lyHP2Y+IJ3dgP/eGb86fewCcqpiW6Zsdo6wJt8ypH2BQDLatnx8oZITziDdyIKEB4T
         uFPDzex9/4zhATBqFAjDflk+8H5UcmJ6rGaK+DjRiLseu5FgC0XKSytE9iQTwZOfcxdm
         ERQeTvLvAA5aXfiuHEyhgvPAYyO9Kc2V2UGs4TKOJO8ZOAOH/iFR4da61ahG5kex7JUj
         0KhpIVhjGXcHCuEs9l5R85gVh0cgxoWq3GZ6rozXXa6oBastuWTqOaonyYZG1mYYbIt8
         mA1yTYtpDtV2j6LB6hEP+Sx0+0+1dw9JvoVRYJcFXP7EpF+ZK1VUhmce8MZ3qVlYRhIY
         HYTA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793147630; x=1793752430; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a/g709wCzxTBAV5yLrw3H5BO2UbCvR/yueVUmZTiqJQ=;
        b=dqAaW705Yp6IcgbLLwLGKIjTRVwGGrhQF1xKVdZuKJf/Ov5Lzpn3yf0XYLIBUs9SJY
         d/sfIuInBFEZVzMpyalIZQkQGF5u7aywsmx/AtFEug+hbhesz2YKIHPdKBHJJ6OeVXdq
         EsH3gupwvA5zdUmQ6nNathghDuTJMkcZAMJGHmu+BweL1FhJMXZsyOL/zuG1pw9UCGrw
         Ge1RjAYagnSZsiDhx/qZND2qqs6AoyFQA4krLhAirKqCsE/QEZQDtCtogFiD5YML+f+p
         R+V78EhhjlfEF0TwbFZSSRFBWlths2WY7EsRSOpqvL5PHURs68KUCF7qMtTAIg0GX+Re
         3NhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793147630; x=1793752430;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a/g709wCzxTBAV5yLrw3H5BO2UbCvR/yueVUmZTiqJQ=;
        b=danJZSpQ67TG4FAmlM/fiPBdL7tQdS16FT+S1sGcwJacEDdfP0zdsL1hasKdEdmhdB
         wo6Vo8nvnLG64TZ7ZNANYsK3lv5WBboY3T4+6JX+1yN9zh1c/oRdutfXhGSW8FiJ1v60
         KVRmPTTAJfux8sfsMfmKiLQQgM6MfOX4tNA4NNQfmSPu9q+AEM3Pm21tFJYPlfSlQEYS
         vmXdOIVXur2SiutS0NJ1pmm1KUJ+eXb3Li9XL2Bgx4bxOrLOoPMnpGUYwpMc80r1rcUJ
         SkOMmafS1PBbLNd2Auy46QUp3hpu+SW3eqRklBRauQVhTtUxJ0+dqXj7vL2vfYYRncSh
         jPnA==
X-Forwarded-Encrypted: i=1; AKwUvBy0yjsYTbjZgce5OfdwpuiOKb4DwLWwOoLbJH5mosmuzYssmO+2CXfT7Rxq8dltNmxEo230dbZt0sqyC8g=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJABzMpdSNfCJkIEE946hl92nigVkL499S4shXHRUaRjGoJxVmw
	iKsjiUSGIQqE0FTNXaOpkNMiU3UPOjF2lIExjUHNp6F6v50ida/QripD73B/5AmQzhsbMNZKhvc
	a4O/rU40mW7drplplE657EiyIBloSe4Cf/mJZrVpP
X-Gm-Gg: AYBFou3tKJvDvhBl3z5FrlXzOAW+Qw2hlTJDaoiB0Auv2J9ngZpUdkzVEJYyZJt89ap
	dL1az4V415itlnynybj6CyHt/WW0MwZEq3TB8iKReo5KPSIo7k5pCqbqvVdg96z8qO+ol1MaDUi
	tR1UN6m9GA/zNa//JM1SWRySGjNCPgC0UMIsETlvGmXNikpzoT7njz+HxItYTVe1sG74PJM6xaP
	T/M6wSmR6UyeNNb+Xu3vhGqUjEFAmhbKeqQwYRIRdyOp0nOVjYaysKkmB/2FG5h+A3MAdvFVbPW
	jZmFiMmJThuIFpWfphBfs3r4Fi+1MmThEYCVj7pNFrEuTjBCM2vFYbMwaRzv+bOxrjD12YaV/LT
	bCCwipcAB1hF0GSsS5GgB9984nlvx/Keaj0o+oafz+RxiO+IAPfBnb62c6Xo02uUuXEKzMRxuYB
	qgNN7b576TdsHUCtey7T+bmUf+K0UC5XeTwNYoa61dJEeug1dBGcJOKmW2olUbHj/Zbu1MeCPLf
	nTQWKVd
X-Received: by 2002:a05:6820:2207:b0:70a:4053:52ec with SMTP id
 006d021491bc7-713eb0544damr493322eaf.4.1793147629845; Tue, 27 Oct 2026
 17:33:49 -0700 (PDT)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027221209.1560865-1-seanjc@google.com> <20261027221209.1560865-11-seanjc@google.com>
In-Reply-To: <20261027221209.1560865-11-seanjc@google.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 27 Oct 2026 17:33:10 -0700
X-Gm-Features: AclHuK-F0YzeAsS0pikjvH3kUnFLPGjUCM-xAT7i-6P6IT1kD4-v_r0V8PDPxPE
Message-ID: <CADrL8HXMT8zBoB8ec2LP1UQWf1qn8qx8rqixvVpcsuO+Sb4p3g@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] KVM: VMX: Explicility free vmcs01, not the
 current VMCS, in vCPU free paths
To: Sean Christopherson <seanjc@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 3:12=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Explicitly free vmcs01 instead of the currently loaded VMCS when freeing =
a
> vCPU, as relying on loaded_vmcs to point at vmcb01 is unnecessarily risky
> and confusing.  E.g. during vCPU creation, the error path relies on setti=
ng
> loaded_vmcs and obfuscates that it should be impossible for vmcb02 to be
> allocated, let alone active.  Similarly, if KVM were buggy and left vmcb0=
2
> as the current vCPU when freeing a vCPU, operating on loaded_vmcs would h=
it
> a use-after-free *and* leak vmcs01.
>
> Because KVM isn't buggy, no functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: James Houghton <jthoughton@google.com>

> ---
>  arch/x86/kvm/vmx/vmx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index d433cd846ac4..2ef1f634e7ec 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7515,7 +7515,7 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu)
>                 vmx_destroy_pml_buffer(vcpu);
>         free_vpid(vmx->vpid);
>         nested_vmx_free_vcpu(vcpu);
> -       free_loaded_vmcs(vmx->loaded_vmcs);
> +       free_loaded_vmcs(&vmx->vmcs01);
>         free_page((unsigned long)vmx->ve_info);
>
>         if (vmx_can_use_ipiv(vcpu))
> @@ -7614,7 +7614,7 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
>         return 0;
>
>  free_vmcs:
> -       free_loaded_vmcs(vmx->loaded_vmcs);
> +       free_loaded_vmcs(&vmx->vmcs01);
>  free_pml:
>         vmx_destroy_pml_buffer(vcpu);
>  free_vpid:
> --
> 2.56.0.307.g5fe7bd680c-goog
>

