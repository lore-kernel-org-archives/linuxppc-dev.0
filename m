Return-Path: <linuxppc-dev+bounces-25732-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55327C5B574
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 07:36:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hK3NC04zgz301Y;
	Tue, 11 Aug 2026 17:36:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786433802;
	cv=none; b=iIrtXHoDAMZLhdsL02hA/F4tcRO9PcEPapdDS45s00muJCm/2GgSjj7lzTrj/m3ESOBv7voVLiSgpe/B2u6kcEQR8QUHrGbCp1I7zVLG2cFfbruKN+Yfho6lP4dMDP/17t0dOdhmQ+VAQXDBm1M44LuAwbzHOXjLsVv0bgS5zsuPXEa6RCHZXQGiiMPzpl3jHfiAOz8T5LOz1PHKFmvNe7BgokIa+tjui79wEehLUOyS3gvpCqX1C8fTQl2YfAIUWjW5GwxnPaPKeb4sGfsftrcZHypZhhVeNvNeBet3+Ovh/ij5lMYrl3r6jeIGgWTXV6NQzZ5CxENogly41+d4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786433802; c=relaxed/relaxed;
	bh=sm0uTopbtQIPYWHArdgLDCR9McJR9msl4aDukPKx09U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M91IocMqViphOuWZipAu9Sz+Ba0/ZAcUSEJcJa3rvuIqFw42bioRaKC4CWFacsUzWYHHOxEAu6rd5zXKqIYEKp8AwyAbM5bycIisEJWphAMzb3VAxtNKLDTbqhR2iNJ/FAvyF1FCwCfVoftqzs6VTScITEUdbheUIDKfJGS3yUE9xeOSJCGFwHnMB/Us41lb7OLjnKh7FIArQIAZrXaolq1vm2/Tvpnc5dtza4pR6YlmoBaYdVcUt0nKgVyj98/5mFbyUdZigbo60ZOgCsbHNMfvZ00fUlnF2d3SglH7/7aj+qsNyNXvcj20v2o3ppUW5u4FDJng7cWiieJjPDnkJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+BJgD/G; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+BJgD/G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hK3N8323wz2yvG
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 17:36:40 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1DD9B42E75;
	Tue, 11 Aug 2026 07:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914641F000E9;
	Tue, 11 Aug 2026 07:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786433797;
	bh=sm0uTopbtQIPYWHArdgLDCR9McJR9msl4aDukPKx09U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=H+BJgD/Gc17A7PiIzhrIMWFn1ug3BaRxVwxzv+2fKz+woWOhSXp+qY1Si3Mcm6v9R
	 is+EW+upc3uCKE3hdnWqzk1hsVnEAdHQ8yynZwQW9hz8TQguA7hdx7mkzc8FOPWGxy
	 MLm0XIkalG1Vlq6szZvEOJ+X6sAGwqqsfu2AAmr5IIYh+McMNeHD8LWtFFNxcir+Go
	 LXFyMUX8odqaEJ57csQ9KTbZAc+JsZN4pE6uw7brqXpZONMpoq9JnnxotCe+szZAH9
	 JJ1xzirftaJnnkNUeBiI1d5pZV25UhiPyJzRoCH4Ev593YAzu3rfBXgTvfwOsPS2I3
	 VzV+esD87WMdw==
Message-ID: <3219a2e7-d11b-478e-ad2e-5f1ec2bbdf27@kernel.org>
Date: Tue, 11 Aug 2026 09:36:26 +0200
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
Subject: Re: [PATCH v3 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port
 binding to support multiple paths
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: shengjiu.wang@oss.nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 shawnguo@kernel.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com,
 linuxppc-dev@lists.ozlabs.org, Shengjiu Wang <shengjiu.wang@nxp.com>
References: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
 <20260804100218.49587-2-shengjiu.wang@oss.nxp.com>
 <20260810-normal-cuscus-of-argument-4b230b@quoll>
 <CAA+D8AM9s7EX-G246Hf2=DOx5q2qXWg_MjUCaoJ8RggOjp+5cQ@mail.gmail.com>
 <dc40dcae-3017-4e61-8c6d-7e6127e4ee77@kernel.org>
 <CAA+D8AOQ_y7BdR4h+X6qxFygPU6h1iFV0cYXHN4KB370yM2Bkw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <CAA+D8AOQ_y7BdR4h+X6qxFygPU6h1iFV0cYXHN4KB370yM2Bkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/08/2026 09:33, Shengjiu Wang wrote:
>>>>
>>>> Why mentioning upstream in the first place? Either this change breaks
>>>> ABI or not, explain that.
>>>
>>> The deprecated 'port' property is retained, so this change is fully backwards
>>> compatible and does not break ABI.
>>
>> So why? Drop redundant parts.
> 
> Ok, I will remove the sentence below in the commit message.
> 
>     No existing upstream DTS file for fsl,imx-asrc uses the previously
>     documented single 'port' node, so this change does not break any
>     in-tree device tree.
> 

Honestly, it's redundant, because you are not dropping it. So even if
DTS was using the port, what would change?

Best regards,
Krzysztof

