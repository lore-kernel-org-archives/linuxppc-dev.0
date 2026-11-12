Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06190606A321
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VQExNxhi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQBHJ5Qtcz2yLY;
	Thu, 12 Nov 2026 18:05:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794467132;
	cv=none; b=NX7yT0Diwo1cdu6hSG4KgedEY74ZN0HryRW+7bJV8P3nsiegtobRoJQcF6Ltd32lPj/qcTfw93Q4NPhYFhnP2fYcV6/Vog7Roy6fpyZUNHG9BvR83ZMYXn209rs2kSZFYunTPybzYhT88Yi5nVGyDZYHlvFgJ0/13UQTfkScJM1D3OXmN3JCIpYDndgZirbDyf4Ua44rhFpgZ9R4peznk0F2U7+ZKvqyXtn2+bfUvCOlw7iFIVCzE3UUb6GRKG1eRkHzMMR5OnU0AnIcPl6pIveiCwn3cCTZM86MDKRyCeu1cVNGRvKTeejrwWauj0bT9CwDdGb/8h4m9IkdzSytfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794467132; c=relaxed/relaxed;
	bh=vvOcZzthIG5GlUnds+7TlPOozWrdyPRuf7q82N1WgUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/sg+EBb8VF5igIcfcXrhZw0m1bErtysRyLmniPW+mZxqQ53NH7Z7mdsQAB0pnSKyH9fxqyeoLkKfto9GNq5oMY9ftvnLu2yFOHfZVv46Alx0EhlTUWSA/xQTiqxBkv9mgzm69RrSrIaIrqo3VktudjgPhOs7SEO4lpgv6MiDdEGd3Tbl/+RYvMJKN/eHvXd9pvzGwrg1G1mhCjFjHsZRVQExI1yxnB733XIIsdPGRrcEKV9Z722gIHjAJT8ue67vI0atOJb3oguR+xxKqsN82igsBYxDGr02wXaKE1Wd0zobDD2+cfosUopAmDZDJU/7BcHQgD6IvxAcdZNYKzvQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VQExNxhi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VQExNxhi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQBHJ0K21z2yKn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 18:05:31 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2e98798cbddso18628275ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 23:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794467129; x=1795071929; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vvOcZzthIG5GlUnds+7TlPOozWrdyPRuf7q82N1WgUw=;
        b=VQExNxhifx2S8rWyOwGbjE3CNjhBM+gREqKGQO3LFQ129k6c3bz4XfM0Uj2ZKBpUns
         K55QG8SjLeZb8V6NVBCb3hq6cvpNBzE7D0oQE/EDj0q9ZjjluiavD1IZIs7Nx78ejttf
         gB9boOhfNwuAeE6tKDKOTGgsitsJxV2I8KDuLwf5Y1TTd/B7V/c1VlCovt+5N39mEhoh
         zeGmAKqqZOCJfpzwD0ZugAZPqejnJmrhZdlBTwK37YB99kBi8l/XuI7a0I9eL7rBDkKd
         N+Wpa+g1OU7q/xM9fc9phgrv7a5zz6azxL+WNCwxlHemcWe8opDW81F7Zd7tBCAsmvtc
         hYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794467129; x=1795071929;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vvOcZzthIG5GlUnds+7TlPOozWrdyPRuf7q82N1WgUw=;
        b=yvvCY2zB7JR9H9JNWTZ0eYmAhQ7QxZtlHt6tPlkVv52UKX+OKSlGwLHXDKT+TcskMt
         OcRcm90C32TvXwtCA+MwMyAdSSpjyL6jb6tMzVe+920SFIaSV+vJmH1PT4dsE+IQ9YhK
         dAxvI3Ea6zGpWOcdq1AncZWvxksN8SDizt75avIT6vmFPrKmGFk9/5/m+eChc7+3oWJD
         VgW/MB21tLuxzEgkYu2eDYozGwTwTIYgmIt3a4nIoPXVg/TZV8qzw1v0X9KHYjuO5WsZ
         F3Z+DBst2s+o6EAcXJXDS6UZxC3UF6Eb6abivIB/qaYSnCaPMtaQMPxWZQ7HPq+KtUP7
         IjaA==
X-Forwarded-Encrypted: i=1; AL+hErE991Ekz68Dryjj03aUHqhNxlXGX81jid5lKaNd0xygDO54cNmJpaOz2B0RPwbdTNp4L80Puar7IksauUc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z++Y9/eJdO1Acaz6Y9avDuFig9FVqWfkEaKaSdoXBuJPJ8vaQps
	m6wGr7ZoEcOSjMn3ykOIm9UEEJYkm8iCOZNN2Yug18m9/HJSVKO5Q0BK
X-Gm-Gg: AYBFou19c2yXqyCgHi8E9SlQ1HtwOYa+LnFbVAP38HhWKajNvCmttu1fVNuATQHuKxJ
	8g8JiEd7GEviELi//gUMe8OCPkFmrf2PTTLuXwv+TmFTFk/3qu+s1ZqhctfjV80mfIJMPPNq/gD
	CsrfVwyO9IVOlIPemdqzUuYYO5J19/LqKTO4Xu9KHVFPGMsIvaAxoR2hDhP19PCLTnuFvrmPAmq
	hNwXVa46GFNBwS3oBRLGmKICNaknTh5e3maHpy1ibV9RtLF+eDwcfV1Ax46xW8KJrKnfrUyLKBD
	VtQBjilFf2g4/0vb/CmEn8wS2luDueCDWasE0aON7XsR3s6GLIEKmd1FBTTTmOdXH8+Dcb/iMVh
	CfO+CDv5nVLzzy7Pn1ngOqo+eS0Daw6N33/FzSZigO8PzDwVQH0NFc0Tl0fHvXY8yJKwYvdQ4GD
	UrLOzesHsUi1CkBBaIEmxXBdEyWpcGUaORRWBFUbWnk1vL0ThfEQgcLlb5CKDfP6E3mYdXSgAVZ
	+zUOW27OTarOLRhrsxdSjlail+Hu63KiOlslckzIhCCiTrrpLooeDPjtTq0MsmDHBkF/ss3zr1+
	Fjku8Y1EdljdbnMdOfY7oCH8BdlmjArhf8U6eU+GCoR5IbppKkLFXQPsDLzBL0fsNOi54mgQgA=
	=
X-Received: by 2002:a17:902:ebc7:b0:2e6:913:57ed with SMTP id d9443c01a7336-2edd768c309mr50026705ad.14.1794467129023;
        Wed, 11 Nov 2026 23:05:29 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d7d964sm29274135ad.32.2026.11.11.23.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 23:05:28 -0800 (PST)
Date: Thu, 12 Nov 2026 12:35:22 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	chzigotzky@xenosoft.de, mpe@ellerman.id.au, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, msuchanek@suse.de, 
	ritesh.list@gmail.com, harshpb@linux.ibm.com, gautam@linux.ibm.com, 
	amachhiw@linux.ibm.com, venkat88@linux.ibm.com, nnmlinux@linux.ibm.com
Subject: Re: [PATCH v2 2/3] KVM: PPC: BookE: Load FP and Altivec before
 enabling the interrupts
Message-ID: <avVkgrSY8v8yWCUz@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20261110053238.3794500-1-sshegde@linux.ibm.com>
 <20261110053238.3794500-3-sshegde@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110053238.3794500-3-sshegde@linux.ibm.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 11:02:37AM +0530, Shrikanth Hegde wrote:
> Christian reported that booting preemptible kernel on FSL Cyrus+ board
> causes boot hang.
> 
> The logs pointed that system was busy in printing below warning.
> 
> WARNING: at .enable_kernel_fp+0x30/0x78, CPU#3: qemu-system-ppc/4884
> Modules linked in:
> CPU: 3 UID: 1000 PID: 4884 Comm: qemu-system-ppc Not tainted 7.3.0-rc1-powerpc64-smp-preempt #1 PREEMPT
> NIP [c000000000003338] .enable_kernel_fp+0x30/0x78
> LR [c00000000005de84] .kvmppc_load_guest_fp+0x30/0x80
> Call Trace:
> [c000000085ca7700] [c00000000005de84] .kvmppc_load_guest_fp+0x30/0x80
> [c000000085ca7780] [c00000000005f2a0] .kvmppc_handle_exit+0x5bc/0x5cc
> [c000000085ca7830] [c00000000006204c] .kvmppc_resume_host+0xb8/0x10c
> 
> Which is...
> 
> void enable_kernel_fp(void)
> {
>         unsigned long cpumsr;
>         WARN_ON(preemptible());
> 
> And...
> 
> Though irq's are hard disabled after kvmppc_prepare_to_enter, but
> kvmppc_fix_ee_before_entry enables the softmask's IRQ state.
> That causes the irqs_disabled to return false.
> Hence leading to the warnings.
> 
> Fix it by re-ordering the code to load the FP and Altivec
> before enabling the softmask IRQ state.
> 
> Fixes: 3efc7da61f6c ("KVM: PPC: Book3E: Increase FPU laziness")
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Closes: https://lore.kernel.org/all/33342fbf-eb7b-bde6-2c8c-254fe8bfb993@xenosoft.de/
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  arch/powerpc/kvm/booke.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 13ad4cf5fa71..c35e98d544ec 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -1404,10 +1404,13 @@ int kvmppc_handle_exit(struct kvm_vcpu *vcpu, unsigned int exit_nr)
>  		if (s <= 0)
>  			r = (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
>  		else {
> -			/* interrupts now hard-disabled */
> -			kvmppc_fix_ee_before_entry();
> +			/*
> +			 * Interrupts are still hard disabled and soft enabled
> +			 * after loading the FP and Altivec.
> +			 */
nit:
Do we really need this comment here. Moving kvmppc_fix_ee_before_entry
at the end is self explanatory.
>  			kvmppc_load_guest_fp(vcpu);
>  			kvmppc_load_guest_altivec(vcpu);
> +			kvmppc_fix_ee_before_entry();
>  		}
>  	}
>  
> -- 
> 2.52.0
> 
Apart from the above nit:
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

