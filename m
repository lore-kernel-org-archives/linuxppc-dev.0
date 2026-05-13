Return-Path: <linuxppc-dev+bounces-20819-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8750CD484C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 03:30:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFf9g3K9Bz2xld;
	Wed, 13 May 2026 13:30:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778643031;
	cv=none; b=PNfK5qZmFY65Va9rOwNsI8yS7za6ddB1dzz7uhrB9cqi7JFwx4F7jwDxIazgbTv5fOpTgKq54Q8tHeamza27QErl8gqshfeH1fIWiY0cjgZ73XeaG33o0guYWJHlLywldR1ae47UgIgaZsJdFN1h6R3zsx8sTvBTapnb/UVUII9eV+ku49aCtK2aFygknviN6P+QVmk6vLIvPBVZoLmkqB4Pc24sMK/YbcbhFpsZGCFxmDMirn9jQel0++YHiow5qUW50mHI7uxjeWRykV1/MJIsJom5K/Y3bF7tRnmHtMgjgMRFGOcYPlJL5RtWQPFRvTkCUD3yNnWBw5qgvpTsrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778643031; c=relaxed/relaxed;
	bh=pqkZzYqVpdf77W53Sw/ScZCotUHs99LkzilZL1EWsNI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=mc6C77Y52gvIuntlah1xtFdgCh0J70el8GM4BX3LZXr3C6B4Eb34zhLL5iVte3WVy/Gyhq3/2Unje9VF1rKn11zXY57N/pRWhO2EBA/qZo3uqoKrUyPFFafWAsqKe0DKa7VUHhnDunctH+BUes0L4vRqLv5Uw/msscoroJrvwfIqe5IvtzsBfwf/FetUivPMwH7cNNXpbcdiR013Wug/Mkx6m0DmVM+7kElFz0Iy7QJxpKGIs/7AikUBM+YVLwXkryhkuuZtiXNv5/Elewqb5GLhYLLVen1jcyv4ulmoZfltQCtFJteskM1byRX1tz7nHPZcjHuiqoSD8duPbWa6+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JX5JETbE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JX5JETbE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFf9d4Mgcz2xGX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 13:30:28 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-3665a90bcd3so4550961a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 20:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778643026; x=1779247826; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pqkZzYqVpdf77W53Sw/ScZCotUHs99LkzilZL1EWsNI=;
        b=JX5JETbEqedbb9+PNgw3HtSmJ8hcZA+hvKJatn0bzRoaJJrsGP7FNjmCPTMG8aBRR5
         u7t3wDv4g76lcCFf5okp5wMl4oUSl4w/MKoL/0ZbM9KguPeENVFodYBMx0+mgiBrqje8
         Mk9XmXpl3tTpawEJlEn236a2bDxbwmdAqMJ1a1E4g2ls9658VGxIC4zcg5lsyERnbge/
         xf3hpkioZRKvor1Bmxff+o4SBQqAmNun0F7UtDEiDEx1TKzNtBo+umTReyTfv7HoHmu7
         UJ7PHj7R13bCRjano31kkpPYWQdUn5nluePOVtLnI9aQONrVduOOuK48aWye/cSFMozR
         7XdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778643026; x=1779247826;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqkZzYqVpdf77W53Sw/ScZCotUHs99LkzilZL1EWsNI=;
        b=pisxrQaXSOTwUHbeYDRyncVn9tcz+LfScX64oEWcewkOf50+JFTUqQsM72ffYDv8sP
         cFa1vqxx5lYk8Lyb8Cb6meDP0mRQZ6xZ18xT6oRfb3KcjWkla2OQyv0ciSn4K5oThK7o
         sakieJ+ZtRoCqNqkdhsxJ4VszYu3cXlt860F/fMGeJ1RTLJzKbvE6ydfIokBiGgxbwzU
         coQsQQ2vyeyc2sVU3+BE29iG+ebOq9ieNfh57/X2dpGJaoQjGImINwhbdzFmMbBjV4vE
         xTQi7f53I1T5p1jroKqEFjZQ5FFFI8Er0gSV+4s+5EwEkPAC9zg6YR6J6K4fBAn+58RE
         ZDGw==
X-Forwarded-Encrypted: i=1; AFNElJ9MJmh1VWhjQVANtsDf2cWBozfIDnpqCqa4eoD5nnl+hGABCS2GmnUdcEem2s7XOxbUQS04WleMilJ5OLU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YztCpXl3i5q/y1D7mN99lKsIubtTRamnmrvmSVnS04EgWlwZ5nN
	6mdqKaj5K3oE4j7SX53z0lkz8wStmPuD4FUHz8u95O44HPLosUScv8G+
X-Gm-Gg: Acq92OH0jpqC+RSBqf0JBviwn4Cr7yPvQ+4TJytTp1dXWppw1FJ9zy4y6MLdf9/S7f8
	UcOWJGOtU8VmFdCCAUYx3fVk5CkHm2tyTKsAltg9vmAWU2ae92L/Y35Ha2SOT+3sk8Qjj39rjZ2
	AhgkM4Sd/8m3i1PoVED9rmrq/Kxvjv1wYRHHL5Yplvmt5XpIyDEqCEgW7/aRNYPuZRXzoWi85Px
	ED13OPEFPlLGE1gRKxJkYUy1OzUHAmzyuw3rwIeZ1gJI33v1UJvrWj8AxgyA2R+hRxTPnlZ1zNz
	uJAoVU3ojX0VY+JGJtVPl571B/1VGT9Zg3IbrDEIozMVkNAjb+Fjr/OxyNg+Tm11oJDcAsRoaCr
	zJ/+VFx0coJ/LAejPaAeyrfTqhjUIryPO/lDnWDZlM4V6EoDpopNBhqo3Cfej4WvgIxon15lUtz
	6DqqGWQBZuAAHGHU4ucqTF6w==
X-Received: by 2002:a05:6a20:728a:b0:3a2:ccb5:abc7 with SMTP id adf61e73a8af0-3af809790b7mr1486042637.13.1778643025638;
        Tue, 12 May 2026 20:30:25 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267710262sm13455532a12.18.2026.05.12.20.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 20:30:23 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "David Hildenbrand (Arm)" <david@kernel.org>
Subject: Re: [PATCH 8/8] powerpc/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE
In-Reply-To: <20260511-bootmem_info_prep-v1-8-3fb0be6fc688@kernel.org>
Date: Wed, 13 May 2026 08:55:05 +0530
Message-ID: <wlx8q9da.ritesh.list@gmail.com>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org> <20260511-bootmem_info_prep-v1-8-3fb0be6fc688@kernel.org>
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

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> register_page_bootmem_info_node() essentially only calls
> register_page_bootmem_memmap(). However, on powerpc that function is a
> nop. So there is not benefit in using CONFIG_HAVE_BOOTMEM_INFO_NODE
> anymore, let's just drop it.
>
> We can stop including bootmem_info.h.

Yup, the following patch [1] removed the usage of bootmem more than a
decade ago. Thanks for cleaning up the remaining unused pieces.

[1]: https://lore.kernel.org/all/1410933504-28564-1-git-send-email-anton@samba.org/

LGTM. Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


