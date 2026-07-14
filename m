Return-Path: <linuxppc-dev+bounces-24253-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD860C4450A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 15:57:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h03ph20h1z2yRl;
	Wed, 15 Jul 2026 01:57:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784044636;
	cv=none; b=feQPifvPhU39RgXfpnx7sz+YQjjZw/Ug/1q8n0mPK8P27eB8Hrxron/KGAxWeuoQEkpLtegf/ApTzU3CfzIycgmsKGhBGaTbq2HPsQi+gycGvkLJ49yWNcSj84WklHPz2LkIBkUQZcAkMTf3XjQiXZEKKbDbkEKNZWa+mfXCy1+MRrYfYndzplacf4XQ7DLJytWUnuWHQxavywBsh0+sRSfiYh76Wymj3NvPiLTm+nC1eg1ODQVSc2GQInDLpE5ap4wElzu5fzsoVQd3RwwkHCTYZLuMMyRyx15a8smG+J5yaFTDGz6vmYGXZWFGhA1gtv0TNQCZDTzN02EDwDqUwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784044636; c=relaxed/relaxed;
	bh=4EdELFsK3TvoDo1OMXUEr2bHgQdAjo0lXA1gte5k2tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FmxNcxLVFmDH6MAZ3JuPPvzICoZn41UYc8jxp1I8fl79mOpVvRtyD1y3si1QuBNLB2zbpYtLgyLWMiCM+fDXyJExSGrdrC3MZXRlrHwlePYl8waiLOaVl4IQ9wkGxSjLs60GR0ymV7IaECslLQt09YLYXQ9bOkFWKq3n3HFHOSBer+wbwzR/rECwkpuJ2KUIjupLY7YxNN7zxOdErfyCZtvWtanjYCK6v3bkb/CPCWcKG0JvUEC3l2pc6AMJKRh1qzaptz0GWZSW+YZVGjFGXsXf1ojzoOz2GafZKX30/wol83aIA/Z9/qLsj4fy3cMrTf46QL49n+PK0zSIz7//Wg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BaFalSuM; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BaFalSuM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h03pf2bcRz2y7W
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 01:57:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=4EdELFsK3TvoDo1OMXUEr2bHgQdAjo0lXA1gte5k2tg=; b=BaFalSuMIYIBOpv5sb8ytE9jq+
	9UFkYQr90pmZseA7QDTg6VAsshHx1w2EUJ5xT9v4t1wzW762jSKWLMXiMWFv+wkcADAxaftVRTqb9
	4e20qv2O713Oth8rVW8uxvw12yDdTGNa8ojvklYCacQOVcchKiudwJ0mPTMeui6g4TPJFowpTpQjI
	wUlWEkQUVHLX8YnVFXUOmkR5+da1quumuUZbLlnR4iL01ibx55uEzJ+S4HR5wT873I/kuQAXPsSJl
	xmQ7FNrp8pG7SPk/sXREAAueh2OkCjpNPNN/KRTrlfx5uqGyk3Y2Epo61HnuUBzzeharizc2aToz5
	m/ddrYjg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjfVM-0000000CbSi-3elQ;
	Tue, 14 Jul 2026 15:57:08 +0000
Message-ID: <1a885ccd-77bb-4537-89c9-6b031c2f3812@infradead.org>
Date: Tue, 14 Jul 2026 08:57:06 -0700
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
Subject: Re: [PATCH 01/14] ASoC: codecs: NeoFidelity: repair the kernel-doc
 format
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Maciej Strozek <mstrozek@opensource.cirrus.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 patches@opensource.cirrus.com, Srinivas Kandagatla <srini@kernel.org>,
 linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
References: <20260714014445.569992-1-rdunlap@infradead.org>
 <20260714014445.569992-2-rdunlap@infradead.org>
 <4eddcb03-3c2a-4ef4-8825-e750e8109476@sirena.org.uk>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <4eddcb03-3c2a-4ef4-8825-e750e8109476@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/14/26 3:20 AM, Mark Brown wrote:
> On Mon, Jul 13, 2026 at 06:44:32PM -0700, Randy Dunlap wrote:
>> Don't use "/**" for a non-kernel-doc comment.
>> Use kernel-doc notation to document the parameters and return value of
>> ntpfw_load().
> 
> As mentioned in submitting-patches.rst when submitting a patch series
> you should supply a cover letter for that patch series which describes
> the overall content of the series.  This helps people understand what
> they are looking at and how things fit together.

Are you saying that my cover letter was insufficient?

https://lore.kernel.org/all/20260714014445.569992-1-rdunlap@infradead.org/

-- 
~Randy


