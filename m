Return-Path: <linuxppc-dev+bounces-19987-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38230FAD3F0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 03:02:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1LVS48jyz2yjs;
	Thu, 23 Apr 2026 13:02:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776913344;
	cv=none; b=UxjFTE2+Mfs/wvOM5z2ZfugwMBtW+zdx+/sRt4Ieerqnjn29t2HgbHdTC7R3xIZtxvwFf4N5aJtDLwu98dwJV84Fw0PksDzhz9i1o7tAmVQVDBgvC/DAkesb9WDrvZ4FNDyq0RGN6Zpe5IyZIUyr9T20kTdJE8RN6UKFKwUBL3APh7m6hHjZQ4B45dKuBSTPGxLwK1wz8F0xVkDsQNDlyZaVH8DcWx6rpek9ZLqdmpkDF1mhA+nge5N+G1aGoFMxIg/svba/WMI/XxpmwjZPmQDkXv7kutlMyzhuAX0aJMD1GbRUpW0LWoPzplzGslBMKncM4vwoYhb88Aw9NYxfmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776913344; c=relaxed/relaxed;
	bh=lLlIP0jPgYGLQzrxBdIe3Ph9dd1xygD2miCaAl1qIPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OmjjWX0Pw+Mwxo/HHlN0H7Y+FQ6IqfFGnKKnkY0Xi7sFuwLyC1PQxZe4Y10piBEGKvYEAufUEZShc8fRRXSTIgASPwCTC2TCPdyhgRGYiRPZITUeunO10AdA5ZXfJs6WJIFhXvWA8fFfBPc3xnqaiIaw8Wg9AyflMVt6ZxbaCqXd0kZacuhatYBZXfme3uxPDZA/29N+4eGFN5/WlM4R8hOIbFx8I6ZDbs9JXhLLsfNRQPUCQOGbD895FK9AsyN0kesoe54N9c9f0JbDJbsJBFjmIkHC3fiYRJH9ILRmrbs4T7xd9Y5NmfVpmKHolx8AXDZOi/9xBUJeEeT2w5aDiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=OwYGU869; dkim-atps=neutral; spf=pass (client-ip=178.251.229.89; helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=lists.ozlabs.org) smtp.mailfrom=nabladev.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=OwYGU869;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nabladev.com (client-ip=178.251.229.89; helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=lists.ozlabs.org)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1LVQ1NL6z2ygh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 13:02:21 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50804114A93;
	Thu, 23 Apr 2026 05:02:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776913337;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=lLlIP0jPgYGLQzrxBdIe3Ph9dd1xygD2miCaAl1qIPI=;
	b=OwYGU869bg+DL4hfEC+w4PW1E8Ho9x8OqCvekLC17vWbf1T88rQ5yYa8IwVvJ6VMbOGM2M
	i7EkZyjCoyIWegNIVoFJD65ipEZcvIUCUIPE8uhvW21+S8L07aytHD8AXpbCeBuVS/0RDA
	QZc88dzxN58jfw0tUQ4ZZzgJuz33f8yMP2qwxDlQHmNf3GRVgUCB3USyLArPBZocAXBJSQ
	WCv0hk3zGwHFkdfLU9PDy2k4C5k74YdFseopa6WAUEzhfvVGNQGTy25+1jUrT6LsoAPbEb
	8/vmtX/RNA3Qu4ZucGo0jqxmHzsY6uHkhw1n/OfB4um3QMrHLuD4RaYXEYn+wQ==
Message-ID: <39ac804e-af26-44be-b8f4-aeda68833ba4@nabladev.com>
Date: Wed, 22 Apr 2026 21:32:23 +0200
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
Subject: Re: [PATCH v2 2/2] ASoC: fsl_sai: Add RX/TX BCLK swap support
To: linux-sound@vger.kernel.org
Cc: Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Rob Herring <robh@kernel.org>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20260404183547.46509-1-marex@nabladev.com>
 <20260404183547.46509-2-marex@nabladev.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260404183547.46509-2-marex@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 4/4/26 8:35 PM, Marek Vasut wrote:
> Add support for setting the Bit Clock Swap bit in CR2 register
> via new "fsl,sai-bit-clock-swap" DT property. This bit swaps the
> bit clock used by the transmitter or receiver in asynchronous mode,
> i.e. makes transmitter use RX_BCLK and TX_SYNC, and vice versa,
> makes receiver use TX_BCLK and RX_SYNC.
Is there anything left over to do with this patch ?

