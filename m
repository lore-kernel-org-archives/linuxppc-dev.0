Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1004C432BE
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Aug 2021 00:10:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7D8160E90
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Aug 2021 00:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C7D8160E90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gxv4F1BxZz306F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Aug 2021 10:10:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=rFQSsr9R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=desiato.20200630 header.b=rFQSsr9R; 
 dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gxv3Q5tMQz2xsT
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Aug 2021 10:10:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=EaN8NsPelxHrvU9ofAOrjRtk0WsMGCySofzS1ta0LL8=; b=rFQSsr9R9EiuFOn4iq4RDbszO7
 fyAMZk8WbJPtAI5zR8nO3a/p5REX476tl9mC/UH8580CwSQfLkMSlgN2ofiTAfvpvHYLvVGLgNj3q
 fUyByVWWnobgsvT/b1BFUsbw30727eWMcT0TBqpNfsEmY+hd40IqiJZDZfeqD9qtMgTgHDb69Y40j
 PrDWB2Eckw+rxIiKParyR5aKp5+phAvcgnQkT15EfsMUnEEuiu1iKO5MC0TqLhWbs5x1BV3m7nn3/
 h41FF2qzwS1rRMm9wVruv/GESqJVJBuSuenrOFDSvNiell4ywVuotbiUnt+wQTXcL7mHgmGGlSwUu
 24a09n6Q==;
Received: from [2602:306:c5a2:a380:1dfb:b2e0:5ace:2d5]
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mK8OU-00DzjX-2F; Sun, 29 Aug 2021 00:09:50 +0000
Subject: Re: [PATCH] net: spider_net: switch from 'pci_' to 'dma_' API
From: Geoff Levand <geoff@infradead.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 kou.ishizaki@toshiba.co.jp, davem@davemloft.net, kuba@kernel.org
References: <60abc3d0c8b4ef8368a4d63326a25a5cb3cd218c.1630094078.git.christophe.jaillet@wanadoo.fr>
 <4f3113d1-b76e-a085-df2d-fd97d4b45faf@infradead.org>
Message-ID: <2b1a0085-de94-dc41-9b9d-3ba1fcdbb6f4@infradead.org>
Date: Sat, 28 Aug 2021 17:09:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4f3113d1-b76e-a085-df2d-fd97d4b45faf@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christophe,

On 8/27/21 6:34 PM, Geoff Levand wrote:
> On 8/27/21 12:56 PM, Christophe JAILLET wrote:
>> It has *not* been compile tested because I don't have the needed
>> configuration or cross-compiler.
> 
> The powerpc ppc64_defconfig has CONFIG_SPIDER_NET set. My
> tdd-builder Docker image has the needed gcc-powerpc-linux-gnu
> cross compiler to build ppc64_defconfig:
> 
>   https://hub.docker.com/r/glevand/tdd-builder

Just to follow up, I applied your patch to v5.14-rc7 and built
ppc64_defconfig. No warnings or errors were seen.

Thanks for your contribution.

Acked-by: Geoff Levand <geoff@infradead.org>

