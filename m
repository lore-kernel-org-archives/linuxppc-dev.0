Return-Path: <linuxppc-dev+bounces-23183-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BEFC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 10:24:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqK4w1jQzz2yYs;
	Tue, 30 Jun 2026 20:24:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782815056;
	cv=none; b=iLB6LkOk1QY+pmfsv9FOgRrsfyxYGDSPPUCSYnLfu6N2Tz/VvCGxR1D2ekSMKc53TO4xaeBJ7RWTRUxwOZ8qEcxrR2G+rsWsVBKK1UQTw4pegWBQ7QGMHYeEu8jpvqN/WHlcBfegJKPubOdG7liDVuZMlhZhiJXzVxRptOoqPqH8t9G6Ale1bah6BWUbhehku268a6DG6SlieDuv/cJ6g36wmtz6MX1diuQIl4lxnK0XJHu8F54swG2omqkhAw5ZYA3XD3HOaz1epbCHl3MFZ4u5+GnimVOhI2OPvX6Vrr+yYZ84AxrJzWd64h3V9cF/TeT95rwIehb0ucIWcYqdNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782815056; c=relaxed/relaxed;
	bh=yYZN8QcmTZB0XuTqOpasOlloDru9xfoOYzlyz+jRrVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iGCjpzfj0N80gVusCQrinDnPeMlh8pSElKYOSvn9iVA6rbnVBsg2j4+h6PSZvDrJrWaH+uM+57Dfl658qUIcLLIMfHzM/hSvvuo9SZigJvz5HMHaax6gR1/Q/aTAEC+TFG6dBhufkBsKTnH+OqDDnJW0iJKyAQ5NfTHWKJ8G3xmD72lXwsUH6/ROsbih/uk9YxWVGmT1OLuSMNMM3cqr+DDIrUcGXhyg8DnKm4aIC1nD1ZBLDotqezoEs4cAEb4p9y3PBMr7A024O8+3IDk7ClSBS80NOcJy/m4RQoxVc5ZcSbisn0CrPG6WoFR+LxQjY84uwO+EQnF9f5QJUUiPcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jY8HKonJ; dkim-atps=neutral; spf=pass (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=jani.nikula@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jY8HKonJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=jani.nikula@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqK4r4kzGz2yY1
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 20:24:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782815053; x=1814351053;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ktunQaDDS5EVOVO47fVPmptPD5p+avnAGjEgEXLkbp0=;
  b=jY8HKonJpx6eXpLlDTt+998mHCae6iGmxmVe7+cOi7lyrJt7/aj+YsvT
   hBB5+nZtTmvSO5Q8Fy8AVSuHZLmEIdVDyH8TgYsO17rpSV4dfK/u0WM7S
   M57/7PVlps80rYDRh5+usjy1L7FbXQDS+MISaJ8ULjXhqw/0XOhbMOT7v
   8LP5aCju8BfFGCrnBavciy9gMrrqkKKIPwXM4isrk+Ij57lTCyobl1zjY
   gdhXm1XiOX8UZYY1ls1/p6cKH9kXgiZlk4+Xj+jk4F0flrtJ9us20zYAA
   3DjfsED/r0tJHRAOpQRTSfpMSOwH8ATH5hzfCAQ3GYbpvyQasPPub/Tth
   w==;
X-CSE-ConnectionGUID: 6yUJD2P3R2y7sYrZQbNZJg==
X-CSE-MsgGUID: ytdH5enuS36I5egAaxpCIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83581409"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="83581409"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 03:24:04 -0700
X-CSE-ConnectionGUID: jgq2xSQuTZCC6QLcUYS3Dw==
X-CSE-MsgGUID: Tgh3e1tLRQ2N4h0xSzOsDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="245877673"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.148])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 03:23:47 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Lorenzo Stoakes <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Lucas Stach
 <l.stach@pengutronix.de>, Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim
 <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin
 <peter.griffin@linaro.org>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, Lyude
 Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, Tomi
 Valkeinen <tomi.valkeinen@ideasonboard.com>, Sandy Huang
 <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan
 <andy.yan@rock-chips.com>, Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Zack Rusin <zack.rusin@broadcom.com>,
 Matthew Brost <matthew.brost@intel.com>, Thomas Hellstrom
 <thomas.hellstrom@linux.intel.com>, Oleksandr Andrushchenko
 <oleksandr_andrushchenko@epam.com>, Helge Deller <deller@gmx.de>, Benjamin
 LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, David
 Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <liam@infradead.org>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev
 Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang
 <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Kees Cook
 <kees@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
 virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
 xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org,
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-sound@vger.kernel.org
Subject: Re: [PATCH 08/13] mm: introduce vma_get_page_prot() and use it
In-Reply-To: <3bb8bdc4788230c33102166d56cbc5abfad9d4cb.1782760670.git.ljs@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <cover.1782760670.git.ljs@kernel.org>
 <3bb8bdc4788230c33102166d56cbc5abfad9d4cb.1782760670.git.ljs@kernel.org>
Date: Tue, 30 Jun 2026 13:23:44 +0300
Message-ID: <d6d75626287ddd46d7da136cf013f7b21b1afc06@intel.com>
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
Content-Type: text/plain

On Mon, 29 Jun 2026, Lorenzo Stoakes <ljs@kernel.org> wrote:
>  drivers/gpu/drm/i915/gem/i915_gem_mman.c    | 12 ++++++------

For i915,

Acked-by: Jani Nikula <jani.nikula@intel.com>



-- 
Jani Nikula, Intel

