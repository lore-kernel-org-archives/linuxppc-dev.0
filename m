Return-Path: <linuxppc-dev+bounces-27895-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3013FC982FA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 07:36:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpsN74WlXz2yhD;
	Tue, 22 Sep 2026 17:36:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790056956;
	cv=none; b=YEjGncrhaOpy6LoJE9wJ3PUOgUvMMofaSbXYZzL5vu09jrSFSsBvo1nt2zPzqRZltphnDr2+ciyKF4EVdCXnnYfpruLtBaAbrmEYU81kFt7N1zm4+eWp+gtOBGVnFCJDfzfeC9CDMbg1JQIQqp0qPbaZvV/kBrFS4bCaDUuqcZ3PSgudrVPI8Y85B6LwAFiR1MHMBvPTeIA50wM1Uvta/DVk3eD9a/q2z+C3h8DwX593KEwa9H138v9kdz2hGBcMT3AKnH5Q5JFmdT3YzpMRJy4mg51PZKPSho9sRtAsjaHNTzszYxLE3zzcYe3uYhpCfMUJR2V8yrEliE7C6xq+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790056956; c=relaxed/relaxed;
	bh=uQ3bgQN5Dp8+Qvmy62hDVi5O4cZCEw7wjVOCUUXKBjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDNObPHRoOkWzvACwmvtmoZpoBf+SZ2UnpphSXFRD6pGROKLCwVlYHt14X1An6DKgs5GP01vJInfBxzGeACvMbB9X23AX2JJISOaAj+R9pLzGo5nTd/m7UR+GKpVBtaywaFYjQSCi11F6qhcXbD8jL9iB4R+3AvrJfI0VgzxVxBVZwA0HTXTL7CDSTBjsC7HxU69ovyArwTYd8hv5Ima+g1DiOABPhxQu4irKXequf1qnJr5TK5xxAaQXAM9c6i9z6CveFnwXDqIxVUAdES1AdZQpKAH11sPfVADt5Gh51d13alxAg13eIBOtRIKAPRmrm86QWFjtC5PfyBzKNinTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NltHKEsa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=chancel.liu@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NltHKEsa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=chancel.liu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpqJC45Pdz2yHT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 16:02:35 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-39647184c73so526848a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 23:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790056953; x=1790661753; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uQ3bgQN5Dp8+Qvmy62hDVi5O4cZCEw7wjVOCUUXKBjk=;
        b=NltHKEsapAT89rkj66Me07o4mH2rBMzaENmGrQnoXGaFwMgCAs10aNrHxpsk/r1PXK
         78TvEY2LeiwPju/6/RgcX5DvnbF5bUg7gZAwEHJzgyiCfc5QxbDxRgiQX+lVPMQBSDni
         yZY9mFP6xeaQ7t4SPnOgl5/bEANvc0fSD0t5zWbOCkHO+6FazuM7b10uQdKGVqbA/Rik
         1Qw22U6UL7sFrl+PBU1q64cuk3wkE/UFSlxNHY5KWOwY65uu15wginRdy7dtxKxpsWf+
         zLum11+bRhfvjLZHAfeHuF1gTjsoyU7mjbAUJEhWnSVYRNOnzlwRhuNVFzIu2AHWE0ze
         wYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790056953; x=1790661753;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uQ3bgQN5Dp8+Qvmy62hDVi5O4cZCEw7wjVOCUUXKBjk=;
        b=GH3uzzCl7+hJwlCktnRVSYCqFcIk2YjHO06Yu6IpFVOQ93jhCJZxP2Zpsr+WDdPEbb
         WY5AdKedSipt2yRnx/xO0RreYqwwx/SSP9lvjW8+WDx+WvvEUqINTJh9AQewsICNjR3L
         gkXmJayoNFDS9P+LumxwkqmYI1jwjXKPGWI4rfzCCatCsypI89Tgtv3hIm65aPZu5901
         0Nw3IrDSeUda+yXGBcX9hM5HIoJABYuharDps9R2lnD6MUuBwlyXmyNDvSfTRwUoqY/E
         /0fmgvn4xQEjexzathUyfo8qSajZIfT9A4YUzDF2c5IvmqCTj+vJim2yG5kIshUzvsRa
         p3Qw==
X-Forwarded-Encrypted: i=1; AKwUvBzdTmVaZubvnMYlRuDR+O8q8PMNSrsghGUHCAeKVVzXtbcZCZVlO+s7JGqNjMGHWjcJuoyFa285dJf1XL0=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kXBPYd9zS6ESDT72zNx0I3HZv3kM6rT2hiuZDmOLjoapwev/O6
	DGLGm5CNFU2ah5pqdIM2EgX2tGrwoMSRUF9kt/EZP1TlpMtigA9IQT3u
X-Gm-Gg: AYBFou00dZGVCtRQA4tx3n/cMuDmccDNPpnYZ+eD/UuTvB4tWo1+FDP0H//HE1/xmRc
	F7lMwKuzjA1iQ27GhwTq5LPJ5HR86UlmeIovsUpqToGPAG5YJIVRR2xwl83QuvC9GqJyKmi7Blz
	kEe/L0efKDLs8BwAvvUAUmEJc/kJ7P8G3H09GdFkKEvHB9F1sl83VwPJi/IsE57vXgi2jIZUr3C
	cQ4L2LCXVt3xfww1zC5mKptf3q7bqpr01kxCf6fyQtHMMLbNETIVrvgeMwU1IcOUHGXFQJ0Sa9a
	dLYCJOeu2Bu1jVg4WceWJkdc0GU5RfxvgdghxxvXDcXZ9JvEjQRmq5VCXZUQezs0xpWmTgi83BS
	ZX8jrSuoZ6UfZSLKATqJrJuBjG8ttARcoo+dlpFnuu50yuTCIpPGNATK/CtDpopurpJFCchdmm5
	s1Gz4AcmVjLKhWI3K7lJrcZ759emcKl+PJk4JapoIuB+1GV6H08Oll8n5ffakdhYcm7tXRXnlxq
	4JWnBzhHzH+UD9kKrA=
X-Received: by 2002:a17:90b:3fcc:b0:39d:e78d:32d2 with SMTP id 98e67ed59e1d1-3a0730cbed4mr111836a91.13.1790056953102;
        Mon, 21 Sep 2026 23:02:33 -0700 (PDT)
Received: from [10.25.133.25] ([165.85.205.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e61340e56sm3366245eec.30.2026.09.21.23.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 23:02:32 -0700 (PDT)
Message-ID: <976f828a-bf48-4788-adb1-7204c27dda60@gmail.com>
Date: Tue, 22 Sep 2026 14:02:24 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v5 5/5] ASoC: fsl_easrc: expose individual DAIs per
 conversion path
To: shengjiu.wang@oss.nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 shawnguo@kernel.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com,
 perex@perex.cz, tiwai@suse.com, linuxppc-dev@lists.ozlabs.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
References: <20260922033428.1690822-1-shengjiu.wang@oss.nxp.com>
 <20260922033428.1690822-6-shengjiu.wang@oss.nxp.com>
Content-Language: en-US
From: Chancel Liu <chancel.liu@gmail.com>
In-Reply-To: <20260922033428.1690822-6-shengjiu.wang@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/2026 11:34 AM, shengjiu.wang@oss.nxp.com wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> The i.MX EASRC hardware supports four independent conversion contexts
> (A, B, C, D). The driver previously registered a single DAI with generic
> stream names "ASRC-Playback" and "ASRC-Capture", which prevents
> multiple independent conversion paths from being used simultaneously.
> 
> Replace the single fsl_easrc_dai instance with an array of four DAI
> drivers to allow up to four independent conversion paths to be active
> at the same time:
> 
>   easrc-0 -- ASRC-Playback / ASRC-Capture (backward compatible)
>   easrc-1 -- ASRC1-Playback / ASRC1-Capture
>   easrc-2 -- ASRC2-Playback / ASRC2-Capture
>   easrc-3 -- ASRC3-Playback / ASRC3-Capture
> 
> easrc-0 retains the original generic stream names to preserve backward
> compatibility with existing machine drivers and board configurations.
> Each DAI retains the same channel, rate and format capabilities as the
> original, including IEC958 subframe support on the capture side. Update
> the devm_snd_soc_register_component() call to register all four DAIs.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Chancel Liu <chancel.liu@gmail.com>

Regards,
Chancel Liu


