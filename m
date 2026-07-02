Return-Path: <linuxppc-dev+bounces-23396-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E8AC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 12:51:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grcG631wBz2xlw;
	Thu, 02 Jul 2026 22:51:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.189
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782996702;
	cv=none; b=VFuXPt3PUSFSfzLANkVFgDlDsBLc4sCpyxCf4+MGbtsr/JmCezXQO+TE/mSA95VvGdfsU9r/LLsv1la/Vz3v0rwJERBRbucm0cCKuoVMfpy20IfzkS/pvjiNQkXeGqqyQhs7lXupjYY9EVN+DIWr1EREA0Usgb7j1h1HVNRzJqeNcIGBHB/JICR8uYnS0s8/d6mbUmqYw5JkuNBjwnlYD5NYSO6XpOkemfZAcaRIobIWU4CB9F6Ue9KMnW+2zWrj9NXOJYhwsFZlnCJ27nu3TpmxX6cDQ4yInajp+VTSDqVCjjiWqLFXrBcZHnOOgGLnNYoR4aTVoCQqmbXXJ5w9xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782996702; c=relaxed/relaxed;
	bh=KCmq1hZLLl7GOyWtL6cRPjjbHfWJ5jvpchLdwXolxL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AmIj0VMEkvtmg9bLqosaG8erol9abOl6c3O+s4sy6oSO7iz07wgQm+e2mq5hzGevocRkS06nbrWDsgCfcWqBHZKk5kWqMM6LwimDPuKFDjqIZNM1w4beKi9e5u2Kt5esF27l9CE36XlDt9dZl6lnbiCzDgWLvTQb79RFPZHQsNJjO+O+8uusjXmBCHC0ZKYWkZH2KI08NQgUBKlGvjMAyKT4e1SEhkl40098hSi4r2W3BYIDO9x/XnXxGjSny18vP12PO8CXZq2BjHUEjhTmL32jQq7qNQXMTQyFqJeQKafqPQRQzSoZsaUhJtpPDzWktSd/S5PL2jJSxJm3FBYZOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F4ZVf9Bv; dkim-atps=neutral; spf=pass (client-ip=95.215.58.189; helo=out-189.mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F4ZVf9Bv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.189; helo=out-189.mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grcG303qdz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 22:51:37 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782996675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KCmq1hZLLl7GOyWtL6cRPjjbHfWJ5jvpchLdwXolxL8=;
	b=F4ZVf9BvB+hLAf9gQChbe4sRNb4sLCrUWRBNFM0pPt8IAzUbVhXxDEH/DvD8axflIDk2vm
	3zmwuSmbnQ/BvpRKYzyKP8V+Wt7x4/jYspjeo/Nuwy87WFjjbKm5Us6Gqkc64N1S5Bi0bl
	Qu3WpSOCEMC/DqM+tZU+hrTjGqJDt6Q=
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	tsbogend@alpha.franken.de,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	l.stach@pengutronix.de,
	inki.dae@samsung.com,
	sw0312.kim@samsung.com,
	kyungmin.park@samsung.com,
	krzk@kernel.org,
	peter.griffin@linaro.org,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	robin.clark@oss.qualcomm.com,
	lumag@kernel.org,
	lyude@redhat.com,
	dakr@kernel.org,
	tomi.valkeinen@ideasonboard.com,
	hjc@rock-chips.com,
	heiko@sntech.de,
	andy.yan@rock-chips.com,
	thierry.reding@kernel.org,
	mperttunen@nvidia.com,
	jonathanh@nvidia.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	zack.rusin@broadcom.com,
	matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	oleksandr_andrushchenko@epam.com,
	deller@gmx.de,
	bcrl@kvack.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	hughd@google.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jannh@google.com,
	pfalcato@suse.de,
	kees@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org,
	xen-devel@lists.xenproject.org,
	linux-fbdev@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 09/13] mm/vma: update create_init_stack_vma() to use vma_flags_t
Date: Thu,  2 Jul 2026 20:50:52 +0800
Message-Id: <20260702125052.19248-1-lance.yang@linux.dev>
In-Reply-To: <34689784ee6856f100c02ad4eabeaa4db643713a.1782760670.git.ljs@kernel.org>
References: <34689784ee6856f100c02ad4eabeaa4db643713a.1782760670.git.ljs@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, Jun 29, 2026 at 08:25:32PM +0100, Lorenzo Stoakes wrote:
>Replace use of the legacy vm_flags_t flags with vma_flags_t values in
>create_init_stack_vma().
>
>As part of this change we add VMA_STACK_EARLY and VMA_STACK_INCOMPLETE
>vma_flags_t defines, and slightly rework create_init_stack_vma() for
>clarity.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
>---

Nothing looks off to me ;) Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>

