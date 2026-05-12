Return-Path: <linuxppc-dev+bounces-20751-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EADCD4855
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 07:46:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF7vC0DLCz2ygG;
	Tue, 12 May 2026 17:46:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778571974;
	cv=none; b=ZVDn4qSCMcCOjO6aiqG8BNczkfadNIpavVBzKIJmA4r48dzb6bY1sutEQyrw+VbPb+x5gStC5MtpCS4J9Ct1YMKdtB+bjHLmJGza3aonb8OXzxwKwhO1KMCqAUTSGECIa7tg9yslTA6tMw+pk8aGvxySaW9s6sdHKzmEqwN7TXgHpg4CPP15wO32vcQZoR2tYwfeTFDuvu6bcxc2kBPJ9woQH1bwQxlf8aJn8wKMxIauc6P6hd/CF0mz+en8DUYD7pr6Fy5JevXF+sn4Wpn735m+ClQLIOgSOXlo89dr+uTdUZIt10xQ9Qk9oc5O5LDO3pQWUn4WfGejdbuQVDkiPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778571974; c=relaxed/relaxed;
	bh=MV3zAoldwoclbqs7qOGs2hdICyTLCe/Y0G+BfFOFXqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNJYblbuz3PGRMZkZfAuz7FiB45QdDAVUZvNbopPC2h98qA8BzQODz2ChWXtz01UaSUk12eCVuDI1zzMptPojqwMc/fnVK76wmar7aLkkYfoRL+me6ZLy7DYUnbjI/Fm53S0pECbwBsLIsRZLq3zavxaVk2eMmxlarYxj7OAShWTb9nakh7XdVw102Q8DXnMcqhC7cYzhJTRAZWmQMYzuyLlF9OC1GLbc1Max3VjNdAnQHlyqGg1sooyum1jW5nIg4Dmq4gmJ1Y6MXSZS/2F9EEcU4hpOGwJaqqdWof0/m6SaxeUJwmB8EyaJJeSSQAqzG93TSmeUGlRVhQanGIy2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Rz8Rw7jA; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=mhocko@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Rz8Rw7jA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=mhocko@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF7v95JJVz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 17:46:13 +1000 (AEST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso35646805e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778571971; x=1779176771; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MV3zAoldwoclbqs7qOGs2hdICyTLCe/Y0G+BfFOFXqo=;
        b=Rz8Rw7jAYEX4dwphaPSC9qTVWI2xKcOFMvyd0NAlrBEK4bTWKJHGls6gYrhcqqO7MZ
         P+PDrnIG2QQqW7KhXHY+o7ZWJqjn25vjyngPoIvAQ3+kmsO4/svx8DFZlYa76u2cLD0e
         VKenZvqoaREclEL4AkMNjAm0v9yOGbVobryHBg0mZVWIA+HIj+0PGo6yaZX6Yx3lYt+b
         JmnYLgwHkMnt37dbj99CmZkFOlCdSTrVLNpSwszzo0Fk5ecc4BO6iM6nR57Uzn1FaPFH
         toSW5YtHen1BujBXM23ZVKfRMGuvRIa1HfO/kud6Th1faJGEuuxb0LVDQ3vwQpO6kcWi
         EK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571971; x=1779176771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MV3zAoldwoclbqs7qOGs2hdICyTLCe/Y0G+BfFOFXqo=;
        b=syD6DMa15dYvrn1QT57Xcqos3vT0bhwXwK9omcYCY4ijN2KEywZ8unsbOraf+sdE+6
         tj623MiGQM5LakAMj1xaDgXSCJrO+hS3EgZEhoRzFoVwL3+q1MEv8qAtYPJ3Hy6eBC9t
         /g7TogZBJo8q0aP2jdyfrgTZUG8v9WbpdlSYtc35TM3ZVlE5iD/Jd+F4uv0pCXSwoP82
         ulXwoDfoPRRLu0n2n0nVkZxKHbrdDjbiA5/HmJM5C+Z4BUzbTITz80Ftroz12Z9AMEhY
         6T/y1qAc++Ud4+z+Wz0BqNeE+v4Z5XFJ7rAupn7Lm6qxQehLDBGKaNaZJLLDu51AbsrM
         /s5w==
X-Forwarded-Encrypted: i=1; AFNElJ+eJ8CMTcOFv+UUVRFvRgvdlKlOH7Vcn2VmDLaqSQ8xDDKxdWCYTEqKIZjDf8zl0jxU+1exCNjxiR4AvTs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyIweOVzRkqx65/gqE7BozewpWjJE1BwQxbGyPDGpLN4x+o7gFi
	amF4owO3Z4Ck0wvK5MvgkEJivWPrh/QREIsxA+y2k8nPkdbZ+n8eKmNEF69y89ANF5Q=
X-Gm-Gg: Acq92OGJEbQkje21nCQsgmSm3Ab50rS8g+8U5t2VS7YqEe9sJfDNZH9oZzxqoUDxv+m
	7la/752RadzL0GoLAQtdT2uVVxN9Cetf+XV3H8LgmpMUAcmeYW3lEQfCH4Fd8sH9C4sTwbeByUu
	jK033tqiRgWC8QXXdXsd69AhrSJRosWHMEgQEpovLcbAUQOgrkurHQsjiNZknTAV6D/dmR8X/ry
	KB8Ak+//iC+LWDaJsSUTFExCBJdl9MR3gAbbFQo8jrxTm+PmbBT3MuciSszt2YGDWi5FuF/A72N
	ec+m89BBtURz6xc0FnlVZgtQmuvC+Hp7I+fQhpMnXm+sXFAkM3qu/jUd6D1p1jrWmiUiMB2jiDg
	pFEyEcAGxrFJtqY/RYacgOonhTSqWiSusb97I0LmY2c6llIZffisrIjWMk7Jb3QGDDqE4Wk6Bwv
	wyuo9U6SZN8ErRaIoZNO/MVTTtqbmrqAAh7TVE
X-Received: by 2002:a05:600c:a02:b0:48a:6798:52e9 with SMTP id 5b1f17b1804b1-48e67244c53mr274594475e9.0.1778571970739;
        Tue, 12 May 2026 00:46:10 -0700 (PDT)
Received: from localhost (109-81-80-123.rct.o2.cz. [109.81.80.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e908cb62dsm42830055e9.10.2026.05.12.00.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:46:10 -0700 (PDT)
Date: Tue, 12 May 2026 09:46:09 +0200
From: Michal Hocko <mhocko@suse.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/8] mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE (Part 1)
Message-ID: <agLawTyWlnuC9Rz1@tiehlicka>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>

On Mon 11-05-26 16:05:28, David Hildenbrand wrote:
> We want to remove CONFIG_HAVE_BOOTMEM_INFO_NODE. As a first step,
> let's limit the remaining harm to x86 and core code, removing
> sparc, ppc and s390 leftovers, starting the stepwise removal by removing
> and simplifying some code.
> 
> Once a related x86 vmemmap fix [1] is in, we can merge part 2 that will
> remove CONFIG_HAVE_BOOTMEM_INFO_NODE entirely.
> 
> Tested on x86-64 with hugetlb vmemmap optimization in combination with
> KMEMLEAK, making sure that the problem reported in dd0ff4d12dd2 ("bootmem:
> remove the vmemmap pages from kmemleak in put_page_bootmem") does not
> reappear -- hoping I managed to trigger the original problem.
> 
> Heavily cross-compiled, but let's let build bots run on it for a bit.
> 
> [1] https://lore.kernel.org/r/20260429-vmemmap-v2-1-8dfcacffd877@kernel.org 
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
> David Hildenbrand (Arm) (8):
>       sparc/mm: remove register_page_bootmem_info()
>       mm/bootmem_info: drop initialization of page->lru
>       mm/bootmem_info: stop using PG_private
>       mm/bootmem_info: remove call to kmemleak_free_part_phys()
>       mm/bootmem_info: stop marking the pgdat as NODE_INFO
>       mm/bootmem_info: stop marking mem_section_usage as MIX_SECTION_INFO
>       s390/mm: use free_reserved_page() in vmem_free_pages()
>       powerpc/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE
> 
>  arch/powerpc/mm/init_64.c    |  8 --------
>  arch/s390/mm/vmem.c          |  3 +--
>  arch/sparc/mm/init_64.c      | 20 --------------------
>  include/linux/bootmem_info.h |  1 -
>  mm/Kconfig                   |  2 +-
>  mm/bootmem_info.c            | 25 ++-----------------------
>  6 files changed, 4 insertions(+), 55 deletions(-)

Good clean up. Feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>
to all patches but kmemleak one which I do not feel qualified to judge.

Thanks!

-- 
Michal Hocko
SUSE Labs

