Return-Path: <linuxppc-dev+bounces-23362-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82184C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 07:35:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grTFg4J0Nz2xJT;
	Thu, 02 Jul 2026 17:35:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::b6"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782977751;
	cv=none; b=L+DhfcuJltj4AlzY/FQAZ1Yc4hgy6EIhY2vXBj96DzO+zU+08Cnv0O+lzYt/eLzXI1i1zNe/56hP2uCqJf8YM+rl3mjXZwgmpUDK7sFL5spxWy7qk/om/9xCNUwuiWqJfmUhWabu1W9jRtIuSaXLL1iUuCiKIaSbm1woiGxCHS0/tCNLP1i6MhTku4W+KLwEYnqnzANJqXm9+O3eYx+Ec1PVBHVAa+nXAQvX6IF2BBUBR+fQLrKrR0t0RoYNerCwNs4teWcFZFuvUcVghwmsVgQgWRqNwTHYWce1Bsj9Xfwd8xvSeJwsphsfvgj/BpnZJJIVJUZxadXDH8W/F+JT2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782977751; c=relaxed/relaxed;
	bh=cdXAMvaGTLXZ4tRHqX+15mFjqPO5NJv7/lbzInUeZeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTvBNct8JQQY+nOwKX/ymb/05ZuMHBsmE3FqXFwcwWagfdJWQ/hhBK8eS56tCARdGpUX5XNLlxgIV9VbGDdfeuVZrdDIK5Zg/BHdBQVAqQTn9aSFiSJIvxiq8KsKBIPs1x/kwLsvNACAjL23lcyo0RYBj4OxeBJLOou5WdKmZIyM1+Z/oJb6vI3FixI6mwbAsswOl2xEW7yZ1WCI0bARzMd4eHqDwLSxy+oBSuZQdSy7M+HaaKQNEqL5w4Jwd74iMKTpFzNhLlb5z9uLAMDROTNLHRf9tAHfbWnZZBM+J55wTGJDo3vNxJkOnD/5nVIaWvgKXP/NqLJaC5rmJNpjVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UUw36nfQ; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::b6; helo=out-182.mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UUw36nfQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::b6; helo=out-182.mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 426 seconds by postgrey-1.37 at boromir; Thu, 02 Jul 2026 17:35:46 AEST
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [IPv6:2001:41d0:203:375::b6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grTFZ4GK4z2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 17:35:45 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782977290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cdXAMvaGTLXZ4tRHqX+15mFjqPO5NJv7/lbzInUeZeM=;
	b=UUw36nfQUDO4ek5W5MoGxv/bQdNbTQycY1qQKAEoJymjql+ZXc8a2FUo9eNrafl6xDrEni
	1302Z8Y+Ma+0qxdUDhBISoxry5nus7uGAN8fTkB0ZcU/zUf+14Ol9iIljWhjg5Yh/mt933
	8BhSh84bNWygA1To4TaXOltx56F5hgs=
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
Subject: Re: [PATCH 01/13] mm: introduce vma_flags_can_grow() and vma_can_grow()
Date: Thu,  2 Jul 2026 15:27:50 +0800
Message-Id: <20260702072750.45641-1-lance.yang@linux.dev>
In-Reply-To: <f2e8c32515d328db62279cc8bab8398ea278d74f.1782760670.git.ljs@kernel.org>
References: <f2e8c32515d328db62279cc8bab8398ea278d74f.1782760670.git.ljs@kernel.org>
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


On Mon, Jun 29, 2026 at 08:25:24PM +0100, Lorenzo Stoakes wrote:
>These test whether the VMA has stack sematics, i.e. is able to grow upwards
>or downwards depending on the architecture.
>
>In order to account for arches which do not support upward-growing stacks,
>introduce VMA_GROWSUP whose definition depends on the architecture
>supporting it, and use vma_flags_test_single_mask() in vma_flags_can_grow()
>to account for this.
>
>Update the VMA userland tests to reflect the changes
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
>---

Nice cleanup! Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>

