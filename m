Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFED606A32E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qThjBClT
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQ9zp4TVzz2yKn;
	Thu, 12 Nov 2026 17:52:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794466326;
	cv=none; b=msGY5+suklOzJ+M0DC9t7IN78hJJcP5iXTW8WjjHA3IiMpUy+RNeo0Mf1ZqOHF9jSxGrXBYzmBt7I6ETpxslUcnhBvGXOJnrWaQgRFhRy46KC7Xshq8G8+Dmho3yAtIf3Uxh+oIXniGBjoFJCCwpWrgKlxRHX8QT617A/ESZPuzcWf+sZdrRJw+ICOt1EafuT2P2+jS0TSjggBW9cowOLjez9ArPnlWxGOoU6oZTkLAf4qm51F1Q0xNmcEbqhQDYIJD4Q1bExqwK440pefWc/3MaiyOXQfrfKV6PzQUiC/mtb7e69So2T+gIPaQmH5v+BBHRjkDrxdIieaRDaFNd9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794466326; c=relaxed/relaxed;
	bh=D3JLsp1QTj4757jMDwdQmMwnwAa2ZsC4IeFz9uGfVhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPP9KupplTcooGkfXSaNrJQXZ/0icUxTHu1kD58oZJ9nlekgonHBAl2rBtjfqnpKNOv/z99HpgK6ALxI3TS1cqemKLOg4pa4orlY/QUkYnrQfdgBJc+y1Rjz2qL50ZZHO9EtvikNcFexDrBZmqDU9+O64dNBckrgBSDEIRfF+CU9POwfpm7036bmv1M82IS603UxuE4sEnHbCEkmYvjAHtZXDb1umaTKjHVRTNEzWE4fuhkgdu6HVHcohXhd7PIlRb5YdcoAUnIYPpUI0FfQ/HfW2nIE2Leg0ZuZZLmvBU7HEU5SspVkHxkU9wqzF2ivj4Ml0mzG2IyGJisqnHiqWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qThjBClT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qThjBClT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQ9zn1nnZz2xmV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 17:52:04 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-3b179528d56so1023366a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 22:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466321; x=1795071121; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D3JLsp1QTj4757jMDwdQmMwnwAa2ZsC4IeFz9uGfVhA=;
        b=qThjBClTBdkPiAhnV7R0kp/e0uZq1s/IjOGJ+Bi/YtIrWeyryb3X8CW3flIZ3ytoAu
         LJLfhxKYFB0xxg+EDKEfEGZsEYaSuO/GPNPh6Hvhpo0toC/mdC9uwfyHwvM3TO/oE/Om
         WV10Rg2rALP9uyPzUSJTxRoMoU2/pXA+zhaq6qWCvv8qjNAkPoMVpM4e5Z22P4m1r8qG
         hpwiP2mtmnBgUhurEFr0aqeKRBGeLGuW9WSAyMdWIwpLFWGeEY+5+OTUsxfDC6ABLMp0
         vgDnB8NZ6csPxujc32cwJC4GjRZQt5AcgsPzB59El3oGiw+uJPmguQPrgD21Fd0a9Xhh
         tDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466321; x=1795071121;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D3JLsp1QTj4757jMDwdQmMwnwAa2ZsC4IeFz9uGfVhA=;
        b=kqL6P+KQdbjsFz1G/B8ZeNEyQfLLj5JDo+fEasZTfIsVXxWPQVCrqEcGoFHE0PG2pd
         XheOjUw1EpaGzUDspBiO6bLjIgv/n0Vw6NDVKDofJJf6GNQ+A19tMPZJ4GtTFojeFbbj
         jxqbu73y4GILPP+8FbqU2J7pBs5GhEFnJ8VuPNSnJTM+N3Yi6IpERE0fUkd3puVQlUW4
         bscMooFBdt3Q+Usup8qWCeGHP5uUwvM2ZRYnLU0nA0MxHoZUHqx2MsQRLBn7hQ+HEtcT
         OuQNlzvUDNk4GdT0Pshox44B/ku5QjQm9uMxK724lf0+QyaHRsKo5RtUyDhYPgqx1hjn
         lm9w==
X-Forwarded-Encrypted: i=1; AL+hErENWsx+zNSrOqdR5qJwnQnkqiS+BbsnFjpkH7q7Rbvi2Y9QgoCJryb0uSGB9Jm7wKUV7b7T2UF3Kt8YppI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/FyR1oQF69uL14ycAxM4652dpIX5eOmnMWsY9qMOHF/7gRYWRh
	StIsvulK1ARZilmI0uh65zUYXAMGNqy8uMmXftUEjJs1/plioN18tXow
X-Gm-Gg: AYBFou3p6wbtJVdOmRDpjEoF/1k0S8Fux3C5Bet3iVuWDEU8bmVZF9KP6oCeg5K79vl
	VipXZGjgrVbKu0vfj9x8DcIXEqAOavjJup7vef/jUD89P7BRXcVpvhgBV/xgU2dpOaLSv8bAV/7
	++3c+mTLuzq1qb3hfd9GKmaFcxQfL0nyKgR1wVFvK8Xe9kBGIFQkr1BiLFO7AlsALp1HXNl+8ts
	d7k38n7QhvKnYrbjsNCRMh3P3FO5sQlnm0Kyrn7kd3gL9nA0fl6sQ5pN5dVsrOUU4KjCjQuJvFV
	N60qWUqHNGfNYD4cv+HzPK1gif1WAuWHHWMT21FRCDcdCBPbZb4/aLUIruNT7XiQYqUzNcfVuG4
	M4ckNfSBSICGmUVtnBha3g+fevipddnMA1dTVCSKIHsOVqi73dkVjpwZF0IjRkvZCliOH/+SecR
	Xr9OwMQ+Nhj4Um+HAVBruAE1+GaNPZOSeOMssmo7SvmxN37SgZyJPtGk62IaRvaDw4fLrrdKsIG
	Exp3VazDdk365M60gQnnWP1Y3umNejxbsxb4tDBxcUXlkgDZ8aGuvwv92/Uj61ulmfVec74gHbh
	H3ZQt94ZpTm/frVEgXrb01Aered0908202HJYUaHg+5FDdSY8IjsEo8+Jk4unu2NbghjVMyeZw=
	=
X-Received: by 2002:a17:90b:224b:b0:3ab:c674:d83c with SMTP id 98e67ed59e1d1-3b182f1fdd0mr4254605a91.27.1794466321050;
        Wed, 11 Nov 2026 22:52:01 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0f6e0sm3052617a91.9.2026.11.11.22.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:52:00 -0800 (PST)
Date: Thu, 12 Nov 2026 12:21:53 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	chzigotzky@xenosoft.de, mpe@ellerman.id.au, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, msuchanek@suse.de, 
	ritesh.list@gmail.com, harshpb@linux.ibm.com, gautam@linux.ibm.com, 
	amachhiw@linux.ibm.com, venkat88@linux.ibm.com, nnmlinux@linux.ibm.com
Subject: Re: [PATCH v2 1/3] powerpc/irq: Add ppc_hard_irq_disable()
Message-ID: <avVh_YWoIgomwEP1@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20261110053238.3794500-1-sshegde@linux.ibm.com>
 <20261110053238.3794500-2-sshegde@linux.ibm.com>
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
In-Reply-To: <20261110053238.3794500-2-sshegde@linux.ibm.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 11:02:36AM +0530, Shrikanth Hegde wrote:
> Add a flavour of interrupt disable which could be used in
> multiple places which also takes care of lockdep in both 32 and
> 64 bit archs.
> 
> On PPC64:
> - Disable hard interrupts using hard_irq_disable. It takes care of
>   lockdep and tracing. local_irq_disable only alters softmask's state.
> 
> On PPC32:
> - Interrupts are hard disabled with local_irq_disable. It also takes
>   care of lockdep and tacing.
> 
> Subsequent patch uses this API in KVM code to avoid the warnings.
> Wider use of it is possible, but it will be taken subsequently.
> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/hw_irq.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index b7eee6385ae5..075442366e1e 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -516,6 +516,23 @@ static inline unsigned long mtmsr_isync_irqsafe(unsigned long msr)
>  
>  #define ARCH_IRQ_INIT_FLAGS	IRQ_NOREQUEST
>  
> +/*
> + * Hard-disable interrupts while keeping the IRQ tracing state
> + * consistent.
> + *
> + * On PPC64, local_irq_disable() only soft-disables interrupts, leaving
> + * a window where an interrupt can be recorded in irq_happened before
> + * interrupts are hard-disabled.
> + *
> + * On PPC32, hard_irq_disable() does not update the IRQ tracing state, so
> + * use local_irq_disable().
> + */
> +#ifdef CONFIG_PPC64
> +#define ppc_hard_irq_disable()	hard_irq_disable()
> +#else
> +#define ppc_hard_irq_disable()	local_irq_disable()
> +#endif
> +
>  #endif  /* __ASSEMBLER__ */
>  #endif	/* __KERNEL__ */
>  #endif	/* _ASM_POWERPC_HW_IRQ_H */
> -- 
> 2.52.0
> 

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

