Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F5F606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 06:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DiYilyc7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTsg40HQCz2y2B;
	Wed, 18 Nov 2026 17:50:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794984623;
	cv=none; b=kwCsR9E7/5Tmv9QmCBBolrypuTnadRaC1qpOR2R48eKOdO9EX0IOHpJ2n34yhMBrDff8kggh0Bq8ByDb026ZxAsO5Fk/sWZAtQrETkSUkY+WPFlq9dmiilZGvxFvcm1scLycbapsQ0h2saldB26vPX/MtEvAartZQU67NtLC0qCN3mC+8i6jnHt54p/FLxhKqL99e7w43UoqwjbAHQaCctAywoPMV4UPnvjDcZ7pKvGWczWtpSV+9mCFhg03UeRxOiVtBF+zV3vFpwYwUDMYSysKXGQRfBiHbJ5A/t41/yf44wQx+svKa1A53iNDhutVC8/ZgQ7vt89muuvDODaPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794984623; c=relaxed/relaxed;
	bh=U8jV7OnHEFz0j+0ag5AfooSr+IDZRuR+qja3G5heTVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vgq3JnhvlMIIWaX3x/8aQY+CFlS6EOJKtuCAxkkSvKQesQGbOfOqGEqwxnvPO6yUT7YgRH1y9F69yuJxsmS5iVJWyk0tsLOF3sgOukGxTcTo7VEl/Y0m9eQ8fiA9CJbXA6ImyP6kXF5P/7oB0UVZ+imSI1KUce2+wzmW3O3TPukJBbD2BVXmlTPnvvyGKqfy6so+ympekTqUqmhNU6JJwzmjnUkQ6E8lwTWcJE1shX9H4DZ2e9lRaN+YUoeYRcDEQm7ubOKNFkTS02FFmwZbAhIXCBVhSrr+vaWFyFFRTMPEWkMz4Z0WigCtAb1wjSRTjKd5g/xz+POM0i2QzN7uDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DiYilyc7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DiYilyc7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTsg26BRQz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 17:50:22 +1100 (AEDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-cdb45e96d2bso450747a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 22:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794984620; x=1795589420; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U8jV7OnHEFz0j+0ag5AfooSr+IDZRuR+qja3G5heTVk=;
        b=DiYilyc7QmVYbafy4WXCk80h8k785seVNFWH4jKfmb8RkAK08ECppgc34Vq9pqS7mW
         w7RqRwt/ERuxIuTYRdvpgcWsAbFHA1reJ6IA8PahTc4buolRqNd/F6b0ZXJxa7Lksa7q
         QrmbtQipZJNZ6gtL4cGYGxr4B/sSLO02SygUbBU0GMR0V0JLv/2rSrnAjSYdYIaz8hJK
         TdL+z3c6Q7j5E2ZcPJtsBQhZ6a4XGqO/CBTIJgEDmwxA8ap+3h9KO93yQfuED3ttlsTe
         jUDFuGKwMq8ycKJky0ELiE3PjbTqvZn4OUYPtFbvD+ZQBRN3WX6jW+n7WCpp+NgtJgin
         0AYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794984620; x=1795589420;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U8jV7OnHEFz0j+0ag5AfooSr+IDZRuR+qja3G5heTVk=;
        b=j/IlPtqRs5pPxpm27/k4fa4DY3l+1t5Sx+IpUAn14ZmZCok+MMtHzC43zN8HvOaQ0D
         fFrLaTbrU9Jwqt/VBBLdDuRaq2g8a7LPXltav+2iRSzNGoKVZiYEduDf35loR2tWbGve
         OExmpLYwmwHQVj7IGkVSk8k7KdviMQBVJ0oex9uEh+hlt4F32//XPABNwZ3/D9FcL7IA
         JbGdn3tPXIw3fET8XlMO3T27JpuYq40CFDbHQYuZRuHYWndw5lEcsvFbXvU1X+zytp/W
         vEYg/hqFyAJnWr5WXcpohiyGCbZppWcPFoo8xr9pV3YJQ5uzNG/FMreoeLWgCtKvX0ML
         1OaA==
X-Forwarded-Encrypted: i=1; AL+hErGj49CmG7ZWBkP5aZkduJkX+fML2gSsC5hBpcjLdkX4mYUYHbXWcHnZOH7yJP3D4vFyOJZlxyEpCxC+WQU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8PVwkovEYOW6RHa/g0shkI9ojLskkwVSwiMhx1ACn/Xxf/5D30
	efzzou2TzWdMhVozao6kVv3QciZ5Zrzr2BYN4ompiu7ExyUWH1rnuOoj
X-Gm-Gg: AZFdTZfWDrXZhMrAQkrO2porvRHBPDTddtY0+e1gYPX7WC8RVYJ1LZ9RJnhrJM6spu8
	/QOVs8/r/oVt/Bv6xXWhDqUo1R6AemiWBujoGXnKXHDuA+i7SytM2P3wjdYd+N0LCvaeN9v5vf7
	lRrUspWmX7LFbcugmXR4zEG6kPnJOwwoEBTzFXPw8c3HZpOknABfDg7JO7n/8EYzRSCh/r7/C4L
	0xtTez5ZXyw8aSljikfEtVcTUiL4OAwBKDurZFJKAbKE0Az762AglmFUWpgEdKG2rp8fFh7Whrx
	8wUxzGt7ZluqdJUcqdwUvyFGFdwlFNIpvr75hEcmATaMf+vIyo3eLd2c2t1zgkoBsdgMeI0bIL8
	9a1M2lnpfvzBIY8igJGsbAPXsrvYBLdwYwayJsXqsv1X/ki2OCMSnUx4JAiI98VPtxvtIYjyt7T
	D+7AKVQ5LGAMY4/WmXefqBjaYKN4WaLtHZdaN9+qxyGG9xQUveD6N2c0rNOqaqULcBJT9CUdcYk
	PNVg7bL3c2ehEO6SVAS/2w4bCOXTPbwB31fZWOeBr9vPfhvXpcZcDdrv88nsnq3YHm1daoqD/Mf
	2dDQKVusV/Za3xKvQudg5oQe9uEJC8y9iWHHOVEf9p37IIRMXgbB7fJNLdnUVVJIjjlKM0rsFZF
	nizhRkYcCVw3g+MPCfTM=
X-Received: by 2002:a17:902:cf10:b0:2ed:e22b:77a2 with SMTP id d9443c01a7336-2eff7560dd4mr16662645ad.55.1794984619740;
        Tue, 17 Nov 2026 22:50:19 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff62897d0sm7773615ad.64.2026.11.17.22.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:50:19 -0800 (PST)
Date: Wed, 18 Nov 2026 12:20:12 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	chzigotzky@xenosoft.de, mpe@ellerman.id.au, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, msuchanek@suse.de, 
	ritesh.list@gmail.com, harshpb@linux.ibm.com, gautam@linux.ibm.com, 
	amachhiw@linux.ibm.com, venkat88@linux.ibm.com, nnmlinux@linux.ibm.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v5 1/3] PPC32: Fix hard_irq_disable to follow tracing and
 lockdep state
Message-ID: <av1KYTtbzgwtDKn_@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20261118051419.783878-1-sshegde@linux.ibm.com>
 <20261118051419.783878-2-sshegde@linux.ibm.com>
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
In-Reply-To: <20261118051419.783878-2-sshegde@linux.ibm.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 10:44:17AM +0530, Shrikanth Hegde wrote:
> On PPC32, the code for hard_irq_disable has diverged and it doesn't
> do lockdep/tracing anymore, leading to use of both local_irq_disable
> and hard_irq_disable on PPC32 to overcome those.
> 
> That is un-necessary, instead simply calling local_irq_disable is
> enough. It disables EE bit and does lockdep tracking.
> 
> Subsequent patch uses this API in KVM code to avoid the warnings.
> Wider use of it is possible, but it will be taken subsequently.
> 
> Cc: <stable@vger.kernel.org> # v7.2+
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
> PS: New warnings would have started since commit 
> 12013e3d4695 ("KVM: powerpc: Use generic xfer to guest work function")
> which added local_irq_disable for 32 bit. The proper fix may date back
> years ago. To avoid backport complications, keeping it backported till
> 7.2. So removed fixes tag and cc'ed stable.
> 
> Also, 32 bit shouldn't need hard_irq_disable. But that can only be taken
> up subsequently.
> 
> Also, below fix isn't needed anymore.
> https://lore.kernel.org/linuxppc-dev/a14571be1897955f43d9994f0e093de3ada6ecde.1793447880.git.ritesh.list@gmail.com/
> 
>  arch/powerpc/include/asm/hw_irq.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index b7eee6385ae5..ddb850e62abd 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -464,7 +464,7 @@ static inline bool arch_irqs_disabled(void)
>  	return arch_irqs_disabled_flags(arch_local_save_flags());
>  }
>  
> -#define hard_irq_disable()		arch_local_irq_disable()
> +#define hard_irq_disable()		local_irq_disable()
>  
>  static inline bool regs_irqs_disabled(struct pt_regs *regs)
>  {
> -- 
> 2.54.0
> 
Cool, this makes things simple.


Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

