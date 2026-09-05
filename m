Return-Path: <linuxppc-dev+bounces-26610-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02808C624D6
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2026 17:37:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcgWb0WdWz2ygW;
	Sun, 06 Sep 2026 03:37:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788629834;
	cv=none; b=dCPX6qXfMS2BOcGS2Fyk/qooovmrhwPovO9GIwuvbDaKKIC77h0YG5MKPHT4TH31YI/x9t708bAPDOpYbY2byWf2sJm16LJBYrRgyO8slwfAJzjto2FkzPMeRTRbtGmsRQJjRVgbvGO2Hn8RRxDaOX+XueFiNiLjgH+u/lFup/fBOb85fFzloH18UNnE2LnNhjnwtb3AY8cCzb8Me4VgtRnWqCZCzGwUo2gV3jQStrS4tFRlQ+cgmdVsEl4O0joOOmPwBOMUzbSpBx2q3kxT9SGDdY525bV7qhcVEqndCyhGQ2aGRb7HkkAo8Qol9bc46qd/GzVp1nReGKuPhNmehg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788629834; c=relaxed/relaxed;
	bh=PIqPxs7eb4gTjHdnlSe3CwUKszgqStjxZDSTejcnjgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mV1KgzQmsMBilD43fNetb7xng9+k3GTaOYJuTrre6YIaWY2rYd8xjAjT8WlU/S0Q64C0Yv8OS+q81vMNmE9G5IwSjWIWl5vY8dOsZUIfbr0k38LAj4aK4tqa/P0ASg9rDaNnKu+dVLQJ/to7vTvdpbtzMFCEJyaai19l9OYdsL9QKFpKhw+PlySZvo+u9fh1XYczCA5HvdPk2RAWNV86T4ikxqLtB32twyMvhuLEit4DA8FU7+YM9XRm5kJjs0JuSH4b5xM6FI6PmQCjLb9E2yytcCAHCJP6LYN1m2ks6GeLaX1RKi4yumOC98INOULBVzKbztzzm0W0NWwSnxV3PA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XMNLdWJP; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XMNLdWJP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcgWS0fG3z2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 03:37:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=PIqPxs7eb4gTjHdnlSe3CwUKszgqStjxZDSTejcnjgg=; b=XMNLdWJPVHFto2VS3phDmLEn4z
	IlGgFzXVRQY6XZU8pO1lz0cHXT2GSPjvNlKYVdSdkGooea03uDRPUXoyn38rk9Z00qIRcDmOy/pd0
	L4m3QxyNoeF9rSCJcFOz8IfTA6VgoXCBirYbqdlw34ytLFRzNXFARdNgrEwYL9PAVX0HYwllfDH4E
	QdLlKYilhyq52H9qdjjzMV5yRqGnIhpjcAxlEa5gamDvntwl7DCwpa+n3fRK44j5mdggoo5VoU+Gi
	CurOXX/rRGvfjPWy76PtRVrv9nHXzLbMaQjwVQPkQIk/cUxP1a81DbI4IMDz78Dx+gG/S8B68GrQu
	moeFvWPA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2uJy-00000004IKJ-237q;
	Sat, 05 Sep 2026 17:36:54 +0000
Message-ID: <491168f4-64f4-4781-b0f7-4eda2e899dc4@infradead.org>
Date: Sat, 5 Sep 2026 10:36:53 -0700
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
Subject: Re: [PATCH] docs: powerpc: vas-api: Use the uapi structure name in
 the example
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Haren Myneni <haren@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260905104313.43620-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260905104313.43620-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/5/26 3:43 AM, Karl Mehltretter wrote:
> struct vas_setup_attr does not exist; the name is struct
> vas_tx_win_open_attr.
> 
> Use struct vas_tx_win_open_attr.
> 
> Fixes: c12e38b1d52e ("Documentation/powerpc: VAS API")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/arch/powerpc/vas-api.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/powerpc/vas-api.rst b/Documentation/arch/powerpc/vas-api.rst
> index 1d0d055356e3..00d98cfd95c9 100644
> --- a/Documentation/arch/powerpc/vas-api.rst
> +++ b/Documentation/arch/powerpc/vas-api.rst
> @@ -265,7 +265,7 @@ Simple example
>  		{
>  			int rc, fd;
>  			void *addr;
> -			struct vas_setup_attr txattr;
> +			struct vas_tx_win_open_attr txattr;
>  
>  			fd = open("/dev/crypto/nx-gzip", O_RDWR);
>  			if (fd < 0) {

-- 
~Randy

