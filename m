Return-Path: <SRS0=7u3Q=IU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE53C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 08:40:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD8361919
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 08:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD8361919
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F3nxf3VBRz302K
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 19:40:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.a=rsa-sha256 header.s=20150623 header.b=MyXE2Ry4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.ru (client-ip=2607:f8b0:4864:20::429;
 helo=mail-pf1-x429.google.com; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=MyXE2Ry4; dkim-atps=neutral
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F3nx7394zz2xgP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Mar 2021 19:39:36 +1100 (AEDT)
Received: by mail-pf1-x429.google.com with SMTP id x26so10446604pfn.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Mar 2021 01:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=YDk3M29WK38ED6rO/E7cSXZFIP5TSdF9UVZ8+hEukoA=;
 b=MyXE2Ry4BWBpg8VJu8ZcuHZ1ddGC7IwxI9EwlUHS9BlVnY3EsrdZxmkuJ8FUUGQ0xV
 FU6m6fxfXGUAQOakMd/HK204nHMiqaqu7fwCa9/7ujHdizbClhGT7WTbrrgfNjNdYM6x
 KlD4oI0DIKdpWoDMIL0MkyOeNxdVpZFFOz26XTOIihP8t4uLab9lt6uzOmK3SfMZwwta
 U0MkHPJL19jCN0tA/IjVfhcT8OOtg/JnVJji9OPMav/+QPEaOwDud5jjkew2Yd04vFT5
 w9ov5DpHmP8rNt1uv8qosGBbZbyjtGib7nNVvfGhIogWIzIjmJGFVTJ99I8ZjJ5kweFR
 7AXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=YDk3M29WK38ED6rO/E7cSXZFIP5TSdF9UVZ8+hEukoA=;
 b=LCOkEUSZHPlLuFf2MtASQXKf9Yi41JngQEQo5Mc1gy+09fVXWLNx6ADXZGcCoZymJ8
 Z1Ns8b0/2gV78vKQKF153C1trnF23VfSo9T8oId1qNulgpmaPM/vlr3mxaw4048QbfGr
 Z05xQkj4q/3WkmikLUlFNmCBIsYAb4EWAhG+QZwsFFsR/UZb7reYA3eJS4jk+E1NWYhb
 ZMn65uiVmWzCNNXtqurkPYtnONCiYPhg7IhFf4Fw0nCOlrdm8XtY3H9xkeLNSeqDhb8R
 w7rI3m5hjWKXfRj/TYSkzqAT2qSxBHlhKloKzH0m4EcmG8TPVK4pcPQDOQgVpgdVSdk5
 MUJg==
X-Gm-Message-State: AOAM532Q7E14m4FyEqbifkgPW1pqXZdTXaU/6O4tEsqfMNYCyCwPAitW
 lZaL1qfvfFRmWFw74tu//xnb0+QS4mXKq1GO
X-Google-Smtp-Source: ABdhPJw46kRhbdEbKjJn0I7N+u7IU/TkW3uxt0PCicci+R0A+zJinqevR2PWJR6/hp99OWjVc/Yojw==
X-Received: by 2002:a63:f247:: with SMTP id d7mr7717891pgk.112.1616402373698; 
 Mon, 22 Mar 2021 01:39:33 -0700 (PDT)
Received: from [192.168.10.23] (124-171-107-241.dyn.iinet.net.au.
 [124.171.107.241])
 by smtp.gmail.com with UTF8SMTPSA id t4sm12976444pjs.12.2021.03.22.01.39.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Mar 2021 01:39:33 -0700 (PDT)
Message-ID: <21be26e7-d8c9-6681-d89d-4ffdf46d23f7@ozlabs.ru>
Date: Mon, 22 Mar 2021 19:39:29 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:87.0) Gecko/20100101
 Thunderbird/87.0
Subject: Re: [PATCH v3 20/41] KVM: PPC: Book3S HV P9: Move setting HDEC after
 switching to guest LPCR
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org
References: <20210305150638.2675513-1-npiggin@gmail.com>
 <20210305150638.2675513-21-npiggin@gmail.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20210305150638.2675513-21-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 06/03/2021 02:06, Nicholas Piggin wrote:
> LPCR[HDICE]=0 suppresses hypervisor decrementer exceptions on some
> processors, so it must be enabled before HDEC is set.

Educating myself - is not it a processor bug when it does not suppress 
hdec exceptions with HDICE=0?

Also, why do we want to enable interrupts before writing HDEC? Enabling 
it may cause an interrupt right away a

Anyway whatever the answers are, this is not changed by this patch and 
the change makes sense so

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> Rather than set it in the host LPCR then setting HDEC, move the HDEC
> update to after the guest MMU context (including LPCR) is loaded.
> There shouldn't be much concern with delaying HDEC by some 10s or 100s
> of nanoseconds by setting it a bit later.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   arch/powerpc/kvm/book3s_hv.c | 19 +++++++------------
>   1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 1f2ba8955c6a..ffde1917ab68 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -3505,20 +3505,9 @@ static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit,
>   		host_dawrx1 = mfspr(SPRN_DAWRX1);
>   	}
>   
> -	/*
> -	 * P8 and P9 suppress the HDEC exception when LPCR[HDICE] = 0,
> -	 * so set HDICE before writing HDEC.
> -	 */
> -	mtspr(SPRN_LPCR, kvm->arch.host_lpcr | LPCR_HDICE);
> -	isync();
> -
>   	hdec = time_limit - mftb();
> -	if (hdec < 0) {
> -		mtspr(SPRN_LPCR, kvm->arch.host_lpcr);
> -		isync();
> +	if (hdec < 0)
>   		return BOOK3S_INTERRUPT_HV_DECREMENTER;
> -	}
> -	mtspr(SPRN_HDEC, hdec);
>   
>   	if (vc->tb_offset) {
>   		u64 new_tb = mftb() + vc->tb_offset;
> @@ -3564,6 +3553,12 @@ static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit,
>   
>   	switch_mmu_to_guest_radix(kvm, vcpu, lpcr);
>   
> +	/*
> +	 * P9 suppresses the HDEC exception when LPCR[HDICE] = 0,
> +	 * so set guest LPCR (with HDICE) before writing HDEC.
> +	 */
> +	mtspr(SPRN_HDEC, hdec);
> +
>   	mtspr(SPRN_SRR0, vcpu->arch.shregs.srr0);
>   	mtspr(SPRN_SRR1, vcpu->arch.shregs.srr1);
>   
> 

-- 
Alexey
