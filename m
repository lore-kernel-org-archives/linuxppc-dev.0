Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BC8606A31A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QQ/YEWWV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFzxd4q7Tz2yYK;
	Fri, 30 Oct 2026 09:51:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793314309;
	cv=none; b=EBHI+RJdVRRGBaCsMgim+3j5LbR5NA1nYphvpPSGP9OVb9OWEcHKwRS9ESLnwRuZUhMsSY0e0WiM98+uQBqU3yW2KkOHtr2A8/D/+Klh2vlrvhaLXejaHw775oc40hT3L9GU7M97SiZNdpqG2y+e9O+rMLVE6F3SjO+51rslDaZcEZCZiU42Fy1LX7TOU2Tmopyne36NQ2aSXJ3/KANUYFsHFjYAuBh2payLHl/T8YUB0fbFfkoUS7XtZSmA2SpxMtMlOo0nngT6ysLqc38AW3vVd3xXW6zXvHUFa+jYtVCRRmUb0YDfIYl6PSF0DCN0a53QKh9bwkcKRIvsAISyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793314309; c=relaxed/relaxed;
	bh=8klQKhRThQNppUw+KcbxhoOsS/2ZZK1Ciz6dr6p1ntU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B69QDTze8xUINrot0kOLWlTMACENaoFjSaVo+gqUFtqKRZnwhzBXCvmGl3p9sKXT2lvYJ/IHw35JuycbTA0RvuODQ53nsbeEfWf7viz9bvgj1KnAVLXOycHrDRfqcowmro7cVT6Pdno6zZCd16U24QYdh8j475RptQy1qjH76EEeMPN7MxN7PG0fSvBe+mvpITLpvELzdak1EJ9kMbpKwisLv2Cd6TLpFFdzzVLs21B4uugroR93iNWJS4K+gk6X1lYxsGo4UVzekfodpJAf+3yGd0k53WoR1mFhLaf4N6gqTFVCjgVBE71ORWvGEUbrSmiya3NgqfP1K8X8LftA8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QQ/YEWWV; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QQ/YEWWV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFzxc01rSz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 09:51:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=8klQKhRThQNppUw+KcbxhoOsS/2ZZK1Ciz6dr6p1ntU=; b=QQ/YEWWVWGkexK71Z1Vv4C8qip
	eXrah04WIy38xEnmrJViH1kekXz9n1Kpi7ZgJAiDSB107I2RFnuzdRcxY/KQ8m/nHclvlER057/+R
	Vt0xAsucJF5ljF1Y/4K/nrNpg3PYCJM8rH7WAxC7g3uK5heXKNQiAnAZ0b/KahUSgY7/acmrlAcux
	cLggaEgQP1anT3pXl1a2K5nRcEZbrmb15wC5nki40sc4glJD4hyaCo7F0CCIA4xDT3Jf/fL8rZz2F
	Bq/IaHgZQRTudWAIAby7GF+Py6ZBCayPp8seZsi6nyPIA0UKNfc5B/zqVIqDZBgzhroP0Zf1zj112
	90wdJkhQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMYyF-0000000AVGi-1qwq;
	Thu, 29 Oct 2026 22:51:43 +0000
Message-ID: <90d34011-24ec-4fdb-9b71-f4c3d0f316d2@infradead.org>
Date: Thu, 29 Oct 2026 15:51:41 -0700
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] powerpc/ps3: repair some kernel-doc comments
To: patches@lists.linux.dev
Cc: Geoff Levand <geoff@infradead.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
References: <20261029201326.2672284-1-rdunlap@infradead.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261029201326.2672284-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 10/29/26 1:13 PM, Randy Dunlap wrote:
> Patches 1 and 2 eliminate all kernel-doc warnings in their
> respective files.
> Patches 3 and 4 target certain classes of kernel-doc warnings
> but don't eliminate all kernel-doc warnings in those files.
> 
> 
>  [PATCH 1/4] powerpc/ps3: platform.h: fix enum ps3_spu_resource_type kernel-doc
>  [PATCH 2/4] powerpc/ps3: htab.c: fix enum ps3_lpar_vas_id kernel-doc
>  [PATCH 3/4] powerpc/ps3: mm.c: clean up kernel-doc issues
>  [PATCH 4/4] powerpc/ps3: os-area.c: fix some kernel-doc warnings
> 
>  arch/powerpc/platforms/ps3/htab.c     |    4 ++--
>  arch/powerpc/platforms/ps3/mm.c       |   10 +++++-----
>  arch/powerpc/platforms/ps3/os-area.c  |    5 +++--
>  arch/powerpc/platforms/ps3/platform.h |    7 ++++---
>  4 files changed, 14 insertions(+), 12 deletions(-)
> 
> 
> Cc: Geoff Levand <geoff@infradead.org>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Cc: linuxppc-dev@lists.ozlabs.org

This should have been labeled with "RESEND" since I also sent this
patch series on 2026-08-31.

-- 
~Randy


