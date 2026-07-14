Return-Path: <linuxppc-dev+bounces-24254-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8107FC4450A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 16:02:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h03xC6Q5kz2y7W;
	Wed, 15 Jul 2026 02:02:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784044975;
	cv=none; b=e9rZ6cJAQIbF4zuGGLe0nDlPmzidhAyiQL2bs9c9ZLyN+bX30AhC2sTtHDl68PvNX/XKrQZjchihFH8E/wBTZ1zJIX/S2vCtmD53IL6woowvexJwGmvv8KkBHhO+auQIsbIoICd9rrE6HbyY/nDrM/aVC9nQTYx5bb86kU6GO29+bESIEFN0y3CQ2ogae6X5Qe3IRTN5gLS1Ip4dCv0cx0ARifwBq2G3KkOLZ3c/Ydqvz93IcoNUcyHaxZutUSO8wjfSTdlmK1f2pfMFM+UXWxpgva+vHhmvw5Z7vKn0U2mjwcq9lAME7uaYcuUwV6VmG9pJ8b6IxVY/n0XE/QPtlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784044975; c=relaxed/relaxed;
	bh=7nN5GbMz2pX/C2hqinG3iHem3CBL/RHh2Lj+bj6Coew=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IzPSFTeeGFMrsRM7wLHRmi3+K3owwD/gjUmR++tXFRYIVrTwHxUqdcv384ArlZcWKru5gYBaPl7UE9BufjSIQ2DWBh/CY+Fyx6sWGtdCMTYiLN7E8n5BZMLWYXmfWmPPB+ajGjpCEaSjk6gTc8DBTtsn9XewTXNpIeO5erpmiGrIb4rBljDwEaWcBL2e0tetbUstTy0r0J2cMjEXfluZP/ze5aUROQfhSIoD6p2rnyqOLJ4jq2tILcqSUfHF2evwMJmsk22U1t96yi1JbMid6Z+DS7Wtr9QBNtYqPol9ZBkmL28cA8pP2CqKHTzm04pYDnUIGLQB+YJ0uIMJGkdgsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PTY6zM2l; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PTY6zM2l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h03xB6kvHz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 02:02:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=7nN5GbMz2pX/C2hqinG3iHem3CBL/RHh2Lj+bj6Coew=; b=PTY6zM2li9KkBPMrSYiKyWNbWj
	kvAsWzD0rektMS0X5iCsA0g/X26qkFG6ZAlgaZlbDNDbrYsFaNiUW7f8Wmthu2UvQYNnTAPeOXw+L
	CxeUxqISVuHLANcdeRIdJY/mEiq4AvIJZBAdXGomw0/LmDS+R3CcRJ0mo1t6WJ6OSPqs/7NWAZ2eI
	YwtssM+36WqlioZv+yRv9ha94b3zkktdjbcaCB8x+selLQx8Rh4JvJ1ZuGbbBqOedx+gDpb4/4Q/W
	sIASCrpibEAl08bmqyBusPFhiF/uSJb40XbSErP4ZvoDBs796dKCnLGS4/W1B/E2alO5iuQxz2wi+
	uVsjLdMw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjfar-0000000CcJ4-1tsW;
	Tue, 14 Jul 2026 16:02:49 +0000
Message-ID: <4bafe3da-893a-4888-8194-b588ac899cec@infradead.org>
Date: Tue, 14 Jul 2026 09:02:48 -0700
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
From: Randy Dunlap <rdunlap@infradead.org>
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
 <1a885ccd-77bb-4537-89c9-6b031c2f3812@infradead.org>
Content-Language: en-US
In-Reply-To: <1a885ccd-77bb-4537-89c9-6b031c2f3812@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/14/26 8:57 AM, Randy Dunlap wrote:
> 
> 
> On 7/14/26 3:20 AM, Mark Brown wrote:
>> On Mon, Jul 13, 2026 at 06:44:32PM -0700, Randy Dunlap wrote:
>>> Don't use "/**" for a non-kernel-doc comment.
>>> Use kernel-doc notation to document the parameters and return value of
>>> ntpfw_load().
>>
>> As mentioned in submitting-patches.rst when submitting a patch series
>> you should supply a cover letter for that patch series which describes
>> the overall content of the series.  This helps people understand what
>> they are looking at and how things fit together.
> 
> Are you saying that my cover letter was insufficient?
> 
> https://lore.kernel.org/all/20260714014445.569992-1-rdunlap@infradead.org/
> 

Ah, somehow I missing sending that one directly to you. My bad.

Should I resend the series?

thanks.

-- 
~Randy


