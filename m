Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE007606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 03:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ww/2ydUq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTnqP3z9cz2xqv;
	Wed, 18 Nov 2026 14:57:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794974241;
	cv=none; b=Wz/yGKq55lDV+yZAIowOLBLr/7FBBH8u+m7tyPjuRk+Wm9D9MOLUBhpPH2X5fhD63P1JeZTuY4e3K8El2wiGYSesz7/ltEmdmaCHzQhXHmS52JIlpZu0236Z+xXOv1lYnNV/v+k3S1OU2Abc39hZhdhvdHtLiW89R7DacC+rJ3SZ2EF4o9CCTQCvGgCgIEQNU78E3gFNzP2fvLQDigdFBaZmDwkdRUDO4KoClAvP6XhRszMfRcu4yB7DO0M460BJP92IxiUejkT1AQ1iLEoaMBIEvhmKdP5arKfFgzUxdgbz5GVbLPZWU4/3W6RGZpKEudEVKhUMyqS7tawocU/vmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794974241; c=relaxed/relaxed;
	bh=a0NP+fQWEKAFgHd8mgesU2gFtSULnLoO4NfwAVHm5y0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Pki/RHoNvwg9pSzwfXESuAhrY8XJuo5UiK5k7Ok8x7v7InguaAx4pWShKdZbYH5wgkzOoe1CQRj1jYWPXNDcV+0FEVIWHPjqwd7MldfEA4h83wf6UcFouqpzVDBLazusaqWXnu9490vD8rRbjTc3p0fl8pNArjvYfHmoWQiwkOPvz8grRJSWCv17AsIog/7U3AkASLt6PsWvo4j/qsc2B/Foed16QiFsZ6poMZ1y98N6K1CfLb54rCa8WodaRux2AE8Wi8lgbyaj2RGvBqdynoj8+SskC0jhMqVX+F9DIxSWwBHqCd2Vzq//cNPDDUTRncfbXdcUibInFAy/fSJ+aA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ww/2ydUq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=mdshahid03@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ww/2ydUq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=mdshahid03@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTnqN5Ll6z2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 14:57:20 +1100 (AEDT)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-38190551625so1085865eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 19:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794974238; x=1795579038; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a0NP+fQWEKAFgHd8mgesU2gFtSULnLoO4NfwAVHm5y0=;
        b=Ww/2ydUqNzTIYws2pS45BJIdSFtYasauFHaO3ttGdW5ADXI//PHaDvN6rMhylUBkAV
         tqB2zBt2/CcJT0qIvecm9JepzfH+bYTJYTs1nHsNfqNtIpZzRot+3jpg2nFPbSvdRvR3
         xTZbUJvyItcc8fQ81YUkCSCKBhPrgGBsFCXC6bE/d7L+C/43LT2onbn54VEul4GC25PD
         Vp2h1ygyZZ5Jiv1kbFRsTvATEZP9jrpM4+7kWvN+oT9RjLeb9hER8FfJGZZHHAsG3g4P
         i79VFJVRNeVHITqL9C4tAiC3DE1a5GbMQZ+2T8s+h2PT8lCOfD1pcJtsSS8eHpIHtn4L
         apzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794974238; x=1795579038;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a0NP+fQWEKAFgHd8mgesU2gFtSULnLoO4NfwAVHm5y0=;
        b=UDex5MWVMAY5QGoIkE+qvIuRBAIrFKN/Ebb2dG1m93NWiPp27jWShRNxGshLkwDHtj
         2gx2CerrvXMojGb/HIUuszkI68pLwIwHuas1uN2vIA0ltRs1xJzYCBSa5gVJLqNdor4G
         Mldw3lnhKkQrSZfUzqZuqQ0KBUZPogmR5VeYNTnhTGGqiFn8nPlRq2Qa+PkDdQXD5ZUR
         Pt1+/a+QPTyz9CYwBgIzWvofH2oe0ZgOQlp5dV5EIP+PUcwgkynrEjjLFRREZ/pTCCbt
         nDG1TVD8h/gmTRnoyNvOAHZvHyR9XGn8epkkRFs9OeabPAToVrt0RKcofW0GQ35Wcaqj
         dgrg==
X-Forwarded-Encrypted: i=1; AL+hErGNLbQDfSGkic32XoA4HxoA3RJ+aPqhGT9yCu2Obae4S4lN7op/DYeKeKlG1JpFFRXtPThl0eYLQdks78U=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8SQGi8+cnaQl9e6BYteX3x/1tY0qn/DMokNuhR7KwxzORkifdi
	AMtcu0BiqZA0A1HetzEPMvSvbVAfwomErTMaIeTYWTiQmB+LTPdr5nru
X-Gm-Gg: AZFdTZfOtsETQVN+5717NFE0X1BE9T7a/+j3ucRNHhRLNC41O8sRBGGVKtIBYk+pDLq
	VXs7XKHeWOIj3//IQh/bi+aYs4DG/paGVzXn7ZEwm20iCLkvOvF+btWzHVGUQuJEKkfLZPMgAHx
	rMzmViOh5IvN5SDqy4WAmRgoOrj5ezLEehrsqROwZu193alWq6bqACSbrxQk6kx0PV3GU1SngET
	4Qy1NaB3/9gU2PMBg8Eg93v8ksF/0XTfTr2qTogvmrepRDc0zzW2YBUqwuV2+nJP+CHc8DscMW5
	480vHdC6g4EBRYzxICI1hpmpFpGGohH744kt/HIMUjBlyKgnHyw7G148kqYAYNc65TJ7fuLruW4
	E7+aXrtqIzYOiAlGJGZsnNxJREHl4tV3ikmngdvr5LWpCe1X6Z/R+CXsTHg5PF38YAhLbaqSt+1
	4hW0tm3H0OHrzQm/ujUKut3inhpnnGTLWSATw1Y3yklSM7sf2AQt77oh9hBLUoNddsCql2qBCCa
	Tj+kKo9sZdiQ5J1yvzIA8sc8OuCi2UQLFOLZsT2AahfZPcVV1wfnWxxezVzQQebewkEO8urg5mA
	Fo0I9AmkzgpVPWLpgOpBOsAIdlESIXlLZtA05Q==
X-Received: by 2002:a05:693c:88d3:20b0:37e:9a3b:76a3 with SMTP id 5a478bee46e88-3827fa88224mr1366335eec.11.1794974238122;
        Tue, 17 Nov 2026 19:57:18 -0800 (PST)
Received: from [192.168.29.85] ([2405:201:8026:213e:efcf:4622:136c:bde5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a6df02adsm3026859eec.14.2026.11.17.19.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 19:57:17 -0800 (PST)
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] powerpc/perf: vpa-dtl: fix resource leak on allocation
 failure
From: mdshahid03@gmail.com
To: mdshahid03@gmail.com
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
 chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261112134455.6880-1-mdshahid03@gmail.com>
References: <20261112134455.6880-1-mdshahid03@gmail.com>
Date: Wed, 18 Nov 2026 09:26:56 +0530
Message-Id: <179497421642.52973.303842528916649405.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Could you please check this patch and give your feedback,when
time permits.

Thanks
Shahid.

On 2026-11-12 19:14 +0530, mdshahid03@gmail.com wrote:
> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> vpa_dtl_event_init acquires dtl_access_lock when initializing the
> first vpa_dtl PMU event.
> 
> If vpa_dtl_mem_alloc() fails,the function returns -ENOMEM without
> releasing the semaphore.
> 
> Release the semaphore when buffer allocation fails and no other
> PMU events are active.
> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
>  arch/powerpc/perf/vpa-dtl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/perf/vpa-dtl.c b/arch/powerpc/perf/vpa-dtl.c
> index 3e3d65b6c796..20eafeaffa6b 100644
> --- a/arch/powerpc/perf/vpa-dtl.c
> +++ b/arch/powerpc/perf/vpa-dtl.c
> @@ -396,6 +396,8 @@ static int vpa_dtl_event_init(struct perf_event *event)
>  
>  	/* Allocate dtl buffer memory */
>  	if (vpa_dtl_mem_alloc(event->cpu)) {
> +		if (dtl_global_refc == 0)
> +			up_write(&dtl_access_lock);
>  		spin_unlock(&dtl_global_lock);
>  		return -ENOMEM;
>  	}
> -- 
> 2.43.0
> 
> 
> 



