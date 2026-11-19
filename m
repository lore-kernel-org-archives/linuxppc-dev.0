Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B91606A324
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0XGHWrx5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVlTl09Rmz2xLF;
	Fri, 20 Nov 2026 04:15:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795108522;
	cv=none; b=ZnK9FlqMI5A73Nzjxtc9bLF9+6aEVems6SkkxzpiSwxdmP/j0+94Su1Uys7PXIS0OYwQM0wzcXE9WDOQtOH4+Fb0DVzOT6ZuO40LhBuRMEzA0FcIsbZ5IIlQga/lOH8mpdt4gt1jYuzMuxNrk+5Ki6neJLO54TWNy3/DoWGOXQwh3MQazJtBE6hGEyBZgALyIsbVF4lNRBtoKZQq80UDfzG3kHGlXAn2qJ0JO1ncnXopPY1brYepkpc7R/DVCGlX2noJ+x4lHY5+VTMiPNHyRcR4IetwFfNEiGJgJjMjhbSziSrWODzav+v/132p4LeLpRGzO7u8WXgIzE7bywhdvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795108522; c=relaxed/relaxed;
	bh=QLlAlF6sccc/yijrm/66Ncx3qXiAKuk+bopz8N9+Jgs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=N6Z22kXVW5zs5yz3qZ0NmbSPa5OC0MIFk96aCwh1wSA8JX2JdVW68raLsbvXsXLqjWWAukeJ/JgYQS9v98sbbPMkcdfjJBhu+wbonXbFGRLs/VE7o+m+PMU4uw129Z+KdSev4M5W3uC2yZigxtEqL5hW4KXiHBXSrG913bqdr9UQBheuIM2LmtLCDMbemRrXgGOwSlntMQOFqSbp3yoLfnVb72ss8VPi0uldkYDe1Tc7TyKL7pBXdaFR13BBZJjHiKgWxyWk1dRfrB/GDbPoxNMHAIA2g9v0LzMBZ81Tg0ZALKCQ10Sia33mgm3lNGGvUjTLw9Lf243pOfI4ZNw44w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0XGHWrx5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0XGHWrx5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVlTj56v6z2xL1
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 04:15:20 +1100 (AEDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-3b3a9a4a765so43522a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 09:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108517; x=1795713317; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QLlAlF6sccc/yijrm/66Ncx3qXiAKuk+bopz8N9+Jgs=;
        b=0XGHWrx5IExO3js7ZbL0Uajne7B6AAk5soGxO6H35kEHIn1optkmcgFylUpaVueaop
         mBzv2XL5czwjlTaYb+9I03A5ihqOGzn2Q/RP0N87d2er935pWwA+NfzzNuHN+zBDqmMu
         H/BnJmyAAt4WoJe1pLU7tiVAUenaasoRl+NWc2Tsi2rbpTaneLLJL5id3qQNuzRCocxx
         MmzWQUlCbqybRpEaGxTAZTYbHwzqVEMWRt6JQkhP9OLT3p0gG/x3NyACLp2LFV9WnCRS
         oWv2rpXYUzufwTDq8dnb3ccMbgdGwRVRdNDfINRUc5UQQk+yTZNjY6LYSMd5CwQlH2Jm
         UgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108517; x=1795713317;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QLlAlF6sccc/yijrm/66Ncx3qXiAKuk+bopz8N9+Jgs=;
        b=iMkNUZFHWPKHLftrY/sTO52RB5q7IfTKqLHJs+mwqFnFN0OrZ/6oQFkUTwFMywVKc4
         29kFtvzlPajR6ExXsDEsCN0oR31tw1EkN4ZsNIwxJSKX9si7s4tpitqSXTjlmfQaeaCr
         kZBOLxndAbjzf/235OvyMVdVLwdTziQkO1q9hJpZKjfH31Kb0bl+X2tLFR8pc//veBcK
         gXATKzGpQBicgwqUFKRTg1SjGlOz0ea62MvBtIQnvXTAbt9dJq1x0xhWrNCNmsXqG0Wy
         HQLUjVfyxLdifLmc7Zw3dFgkHaw693NlVUuoEfhKd0xi2xysxVnsMMX0Rs+BKJZmMnlp
         BDSw==
X-Forwarded-Encrypted: i=1; AL+hErHWHebQ9z7iQqFyuUc2DvaHjH1r3yoNt1whGmTocKZwAQU2V3wY2Y5vbJYV51HMR19fOLqzUKRE238INm8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+VwNbkXsk/r+AS47VGUw2LZQ+zFfLyvCuQv84CnkRXc9J3hjiQ
	krIZi+cSYx5grakTjr+cGSMzyOy1Au2I+/AJ2f28SGfa3t+kPT3EqL/M
X-Gm-Gg: AZFdTZd5h6zVjE3MHdIhxt9O62sppt9H+GjKdo3NGWaLBxmDgi9ercDSzPUutWgtMw7
	qis3oqKuqqSGHzm+34c+Hiq1MbTGnvxxqFv0JjtUnuPAk/NjGivp2Q0WxnQizuVY3yGJcexp9/u
	8Bb58A8BqHYaikdj6ZjXOJdW9dPgqK3/nMvoCXN7rDyp0c3V76rv0Bd8fileYCOOL9J27Eg0VMC
	FS/IOPlnxfv+Qcm7kGhKaXeyIyhIDVQgb9S/yhGDkO0swYlWR4PlWS7Ddw2ORHuCjNsQnbGdohR
	xPaWfgulKbK4OX0TUyJl+2eWPI07A9qbFACbleueHo9sb8JehjXOvyXdaqHuL9fRRY8Di3jBo4f
	ie4GgQXJ3csxNzkFyHFsOxFXvPsdXitDJsIoJpA7DW7TmsHvFH9EO2wuI2/qXl6SJLQclfhFsTy
	1JbtkqMz6iidDRYq87A2JgdWRM1cGvtFzSwyHIdDNtHGTeg3yKxD0bGl64oiRV0DP52eAs9ZLhH
	kNjI4JACwvRn3bCY4DPMwCVyl2sN6QGVUMXl/LFkh4SDGhUWR1xgiOHQ+a8O5tgPgRBZLN9Rlxc
	VzV9L3MwZpZSpGbqItPEpVlp1Mo=
X-Received: by 2002:a17:90b:288e:b0:3b3:ec88:72a6 with SMTP id 98e67ed59e1d1-3b41c85284amr34574a91.3.1795108517546;
        Thu, 19 Nov 2026 09:15:17 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d96bd3sm3418882a91.12.2026.11.19.09.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:15:16 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, Thomas
	Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
	Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v3 4/8] powerpc/mm: skip kmap for lowmem pages in __dma_sync_page()
In-Reply-To: <20261119151520.2383226-5-m.szyprowski@samsung.com>
Date: Thu, 19 Nov 2026 22:43:30 +0530
Message-ID: <4idclp6t.ritesh.list@gmail.com>
References: <20261119151520.2383226-1-m.szyprowski@samsung.com> <CGME20261119151530eucas1p1724ca5c2a4cb0e5a7d9ad91c936a2c6f@eucas1p1.samsung.com> <20261119151520.2383226-5-m.szyprowski@samsung.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> With CONFIG_HIGHMEM enabled, __dma_sync_page() unconditionally goes
> through __dma_sync_page_highmem(), which disables interrupts and
> kmaps the buffer one page at a time. This adds needless per-page
> overhead to every streaming DMA sync on such kernels.
>
> Use the per-page kmap path only when the buffer reaches into highmem
> and do a single __dma_sync() on the linear mapping otherwise.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/powerpc/mm/dma-noncoherent.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Thanks for taking care of this. LGTM.

Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


