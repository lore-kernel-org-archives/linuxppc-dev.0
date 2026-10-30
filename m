Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E879606A329
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 09:39:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGGK30hgcz30gY;
	Fri, 30 Oct 2026 20:39:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.176
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793353175;
	cv=none; b=iK0XEXkBaMnthFf5uh4ePq8kJJIDYCDVUstHvRTpOGzWPNFoAISTwGkKlVTClhqtuqe+mNLzol6OXcLnK1vbTHtv7thfo7I5I53vVX96aNmnSsGSsLYrpSgw8c7EYWG7HqMmNfMdSg9593jz3N4PL+woi3pjeWOlpT+kxOCLq3FgHDi4DqCUHUXO0Rcd1gjOAFIrGK9EQ20ncwG53FYPOkwO1KpnxvHc8+NKypums51Cgt/jurQ/U/2axjXONpbYqpxjz8RKfO0D+/NIQ5IHdOLv0a08uJFpblX05aH/ybfnj9q+LDv7JCcExxRJo0lSGwFDTKm7WXd/Nx/ImH7feA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793353175; c=relaxed/relaxed;
	bh=UvOO6JqfZMd+v5QBaFPCO17vd6AxfiDuRyj9QuuRkjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSyRhvPiEzl+cEqx1DPd0J3ryRMMowiZQBRiyfIbM0ZUSadsR6Z2/iwoylP5RDiNDRyf7xDNGmsBbzVdPtKw/jAvdMehQ9ABabt93b77SbtAqmFdfexaiK3T1jIZ9qNpwKMy9PmGmXUCgm66PWKV8Kt76ZHFaFzYSO1hiqqb9Vx+ir8C2K9/aAaeaCLcpl7yCiZSAViPnIBDC0sImYIhoAh8coasul1LajNNSXKCY2qU8Jhh1lY7VnX0UVqRJjqNkdp5y127JCg6SbkC0jE+q9tbiRSDbr7+ZMfASqWNaWqVNxyd5Ksm1DM9kdj7OZ2wvnB33KyEEXKBKSE1U2U2rg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.221.176; helo=mail-vk1-f176.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.176; helo=mail-vk1-f176.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGGK21T0zz30VV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 20:39:34 +1100 (AEDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5ec6f271883so180273e0c.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 02:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793353171; x=1793957971;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UvOO6JqfZMd+v5QBaFPCO17vd6AxfiDuRyj9QuuRkjg=;
        b=Es9uDTOg8LPs/eb67NeAcO7OCyXVKy8Xo2/PN1ohJnwe73Uw0kZ70wbgsOuc8NrSAA
         Oke8GMYX34X2BaIgcrhBZP6Z647k8nemUJmu8T+ws9TU00As4IdDskKHIioqZcr2hAdP
         Zbm3fEqczEbnxXf/OA3npzQF1p+jP2YKMGJug3AMcemw1J31Br8HhCVvEcK4xho/xgRa
         VZ2YpkkvoUyCweD/IgAt1AuhJZVKlcysUWL/fc1azaYp7fTVMVEfFrhU95gSCWs8YhsD
         rwJBu7++7oiFtEBFdxyv3jnyn4Z39b58dAfi5cBHeM+0O4UHzm85JDHH6Od9LMtpiLrs
         +S3g==
X-Forwarded-Encrypted: i=1; AKwUvBw7GC4eMyDqBW5SX4kA758EISh/8LuE94yewLDIznzCuKTW3hXBqskmYthUR5C0yqZIBduK527GQFdqjdU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLhU+7zxm8aDwrkDTN2dxU6MF5ZRHEpOPMdzSV834caOH4eG1vt
	006WCMlaDrxFjvTWbVud8R5AAks354wRb+2q6mLltgln5DKPx5N2z+XdAXljymRB
X-Gm-Gg: AYBFou0RVCcZpN30o33McOXiZ+hy2p2FN0NJ0b06siT8kI6/Q2+AoJUIdty+nk0clBe
	EbX5yty+emB4zxJVuweJQMUhVDoJy3pYzeBwqIoLxBP83XPwe0K1tNQ6ceJUcUlbOv6dLYWxM3F
	M3xITmNKYySZijcrg1Fy8tVjrEMaJYkXA+dkTfj8RGqSPbao6s8KJSmgWNQPx7vgmwZUA2pYD76
	YKm33V9A1tMae3ORXDobogFBmHKDNHg0Vw9mcTooRo9bIofniIEBBy/9ZCxEuc8Nw/Qlg8S78UP
	2atL+slYDJITs8fZ+QS2bnCv91ZzHKjmpFFUFMwMq1kzji+3nyxRwvmaYoJoMiWWBY9I3feBw+e
	Cb/l0BOoMrjRDF8fPUvdO1oWpMvsbv9XqQobTfi8sEN0HDTnxjmE4+N5pCo+rXrynBRik2vpAdf
	2yNx6fHES1rMeO3RfVbII9G9+h+UGVzS87TLCkKiJWRy+HugoKw73QLgfic+sP09Y2gQXaQf/Ex
	TuwryuP4Um6f08Y/cI6Bwymw/mylINVAhqwF5CTuEqzeTlS2PNmUDD+KjH+EVm/KYfNFAbs8ZK4
	qykbcxq+rTDDwgG1zx0+z0UtlGDfmgoxu6IP83rQm6IKetJ25pAt1WFO6B9/QJPWBgNFTbQBBQ+
	O3K+BiZ9PQ0dP
X-Received: by 2002:a05:6122:3b83:b0:5e6:82ca:c551 with SMTP id 71dfb90a1353d-5ec689bf92cmr811905e0c.22.1793353171596;
        Fri, 30 Oct 2026 02:39:31 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c5d183sm1772024e0c.13.2026.10.30.02.39.30
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 02:39:30 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-98fea7e52b7so338877241.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 02:39:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz3Gp68slfdgVfN+rUaOgCaXippNyGZFNB5NJORNsQEvboyUvQB163sRyxRj5GoxTE2s+ODtVt5l14yvNU=@lists.ozlabs.org
X-Received: by 2002:a05:6102:14a3:b0:7c3:1395:a090 with SMTP id
 ada2fe7eead31-7d0726152famr950274137.6.1793353170421; Fri, 30 Oct 2026
 02:39:30 -0700 (PDT)
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
References: <20261030083800.599152-1-songmuchun@bytedance.com> <20261030083800.599152-3-songmuchun@bytedance.com>
In-Reply-To: <20261030083800.599152-3-songmuchun@bytedance.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Oct 2026 10:39:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVYbJOGCd82fNm8dD5kXTWQvRnymkx3w2PFH-dKnH7G8g@mail.gmail.com>
X-Gm-Features: AclHuK8vFqi3dqWRxr6f8_rNGo4Y5wLrZ0prryPEwyIfD0-s59WP5msq_iDtOig
Message-ID: <CAMuHMdVYbJOGCd82fNm8dD5kXTWQvRnymkx3w2PFH-dKnH7G8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: remove redundant pagetable_dtor() calls
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>, Alistair Popple <apopple@nvidia.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 09:38, Muchun Song <songmuchun@bytedance.com> wrote:
> pagetable_free() now runs pagetable_dtor() for constructed page
> tables. Calling the destructor immediately before freeing the page table
> therefore duplicates the lifecycle handling at each caller.
>
> Remove the redundant calls and let pagetable_free() handle the
> destructor. No functional change is intended.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/m68k/include/asm/mcf_pgalloc.h    | 1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

