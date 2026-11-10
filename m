Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7EC60A263B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A81ysJtC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP5qL2lPYz2yQJ;
	Tue, 10 Nov 2026 23:41:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::733" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794314462;
	cv=pass; b=lil1+Gs1VghpXKnHSnr+tNoSQdyOGBTyCh68GahElWqEFrMu82n7DjOY3fvZF/8Z9vuReG6hnnAb3AuZJzTfpQR6/2wBgBwgNKUCa6idK+NQoTMwMj5D2Ug6Xh6lWtjEXO5nYfG5dlXkxUXca2ZLzYYUvbgL4QYKPfXXHDQ5xUes/yoy3o+9bRYQW6798zY3sJsJQx9Ie6FaX1XyepJe16ncpU3fcBmIGMhrNhEK7XxIyY2hhOoJvLowxhaWvOwEJgCCxQtev/83CzMy5H8hnbUblY7V3t9Vl+1c3+8cv4LxCbep48R6b62HG4gD+uye1dfvZ+or7tqrro3B+vqIew==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794314462; c=relaxed/relaxed;
	bh=D4gMZ1PVA/qgtmCoqERD1UHw3rhXprh1G5vdxXe7myk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADZQCjblmkpaainZdfaivCSoXz3c49ZJemcBPaddzWnKoPcca8iwPnGGY74q5K2NyqOFUTeDe+2k9uxfZjBuUB3GiHJ3YaTg6NLkeYuhJX3iuz0ZdTEkbPtDpa8V+6UsN9ayllwxIybiTLt3dqg+o9H9P3T/PvWOwX55iE/gZKXqDaNQtY+awc4j8kpknnyxoWgtsBBRkvaONcpDhfLQtShl7RqLEODVboMo31K9/F3UB+mrfSMKTrdU99eH9s4kH9Fz8yqB1EkExPwGiua+DRQwgnPlYMQQhUdXUx/N1qywHaZpLN4sP7Bqz3VDOGVYHLqHmU1Zc2bbH6rIKijNOw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A81ysJtC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::733; helo=mail-qk1-x733.google.com; envelope-from=jcmvbkbc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A81ysJtC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::733; helo=mail-qk1-x733.google.com; envelope-from=jcmvbkbc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP5qK1HzVz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 23:41:00 +1100 (AEDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-93e64d52949so174548785a.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 04:41:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794314457; cv=none;
        d=google.com; s=arc-20260327;
        b=cafZYOVfJXXhcJfdT2jCEeCi9hiFoo1sAe3xWjBVD1dx1XjDLA+Ji71taDxNg7RUQ3
         sQ++/BPN4K2ySP1dIYQTkP+1BOdY1O+loRPlRtduYc+pUGT5EHFspRyvDvXr82a+dJ/K
         Xvwg0U6TmLDIn+BoyX6U2emsmKnvKAWFhWlFQZ8qeJyl+BHNXDROHPzz+1x1Cz7S+h7t
         FNzJ8Xm7kaiNmEa03yga7aHj4Eo8PZ1uVZX59cxiFXpGkQu+BrWGWQU2sVJ2hB6i9uMC
         Ty93d400ynVnUxh3U8Po9ru5nG15Yf+sn8quBe+JOQctd5DQbHFRIyF9erdFS8GzoeKx
         q9Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D4gMZ1PVA/qgtmCoqERD1UHw3rhXprh1G5vdxXe7myk=;
        fh=dsKqR+1xyujgPMPEDC9LBCDaOrkFKniXYD2/T3v88vA=;
        b=qil3s8MWdfOMT5aimFX/xG1+Qucd8DnPYtZyTO5LTr3+BHozbERNPdvgQq4ssfiqz1
         /mFaPaonvG/Ha00/geq/lHHuZuR0t+wtexP4VuAi6pHcphPKtiB5s3b1PODlhGEXb8uV
         +naShO7CSv+RZzO4Z8Nf8Zo+h+a6LU1eIFvbQbE1M+2gcQKWd57KVnD+KtOIQnRX2hbV
         fjo8skS314BMk+LEaIl2jxTZ2LI16DE5K0zFp8t/bB8JZccRecMhQ2pFWV8RxFD11eop
         vzv9Tzm62xBDl1iAG4F+Xox/agjOLI2eB4RM1vIfpIn2f2//MAb8Z/ZGOG3/PYLqwxs8
         ds1A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794314457; x=1794919257; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D4gMZ1PVA/qgtmCoqERD1UHw3rhXprh1G5vdxXe7myk=;
        b=A81ysJtCRYS2DbkVN4aBVGlAkTFlVEdQoTNQzIGCIX6jU48UciHD/wEuI8CiWgr4tt
         U7Lm5rzevP9fGFm+9+BwbtouKC/ookgxGbhIoiRPyJ7In6XgszVOAY/vGZ+XJJ3QM+hD
         pPHRB+uMcYcKeJ3J5P0851B+ViP6sN0Stq6mTWqh7dBylJ3neEQBY8+vfJYuVpNnNRsW
         ZwwYxqXXU8uxz+TvxyO7+3rBEFsJlTbr71kaPT+QO6AM3Dw0xAK969nWX77J1RlBWB4L
         VMBK8OX8fvY7scjyrA5CCZcYBKxAszixUxuwjAbfpwSAoMPWtlPzpWjcFv/rcpaZoEe9
         cptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794314457; x=1794919257;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D4gMZ1PVA/qgtmCoqERD1UHw3rhXprh1G5vdxXe7myk=;
        b=KpBuN/ulyEAy9QbTjCY+YExhQ9VN78l5VKepRjYxR1+/tVEaHi5eugJkIDEJeqNmkN
         I2ZVq33Nm1/PmyH+MpK3nXwSbqzkO15xBcKSEKZOJdYjSeQhS+bDhGnHFahA/z3cnzs9
         8+/ehMkfGbUueF6+dkUlH1NL4nSmkm3arvRA0Sli4baFwRrsvNX05SeYh2WWSXMWyJll
         myULIBTmG6NnyNiTWlkdfAaojc0ZT193ReENV0Y7LhTfRA5m0pltIF2iRDkBgt0OEh9u
         spbKrwp83ewU6gG9E5UOceoZsuz5+l+nNqEF1bWzUdlV4w3It5baDXctIDUvRcljGlpF
         693A==
X-Forwarded-Encrypted: i=1; AL+hErEyaJNMYV0yfnXfTwa2k8923K4cjDfwZd+qG563lncLkydhZu7M5Fjx8z9S2q5G4FPsttW577nT5wX6c18=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9Tn1zpxfCiuVvdKkc1yhDFPMoI5yLd0E+s+x+XRwHdieyty2X/
	3rUwya5xw+18IfBc1Nkf0tPRzkOxi309hGM+aFj4gN//IbM7s3NeUMxV/wv40YEraIvgR1mrkof
	4q5rEOCT7kQU4oWXbwhlE61FgzhDqLis=
X-Gm-Gg: AYBFou0lfrLNe/GReoayLNOzFVRtFaM2YHmTWuKWcoeYN4Uy+GjL3zAl19XJf8gMxJM
	DboE6qlEb9bc4NAsiTm7yTTChXm59/eGUNhy/Y46iSETiVsIfL91Dzh7GZSk2fjln+q2MnpY5Sj
	bZgn7Xl7AO60HCKs337erv27QgBio/nsnV/1D+hnBn/zT37vJ5CEQnTF9MvnOJTy/L7jDHsLdu/
	FthOvjxCCepOsBgeAHkETocxHmTvH0c7vHHtviSYjgbEOO+2IzjP/krf9jFNr+XUYfx7cYKupcF
	D+nqVJSd6gdxwxrg75dp+kW4Xh/k9iR/LqTKqsVwnk4sUCcyiwx6xyS3Qa8XcOn/n4aLup/JfHI
	8aQT8ymWICXKzfeL6v7oWedBHMFKsb6kE5YTrAmFCe969gLOd8jb1gSePaov7cPUBsqlfNZYwHv
	9D6cTysi0LBhmeWrAeDOsJ
X-Received: by 2002:a05:620a:450d:b0:93c:b6db:8c with SMTP id
 af79cd13be357-9479f093b28mr391627885a.0.1794314457277; Tue, 10 Nov 2026
 04:40:57 -0800 (PST)
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
References: <CGME20261110094847eucas1p125691a852f3621482adae13de1205223@eucas1p1.samsung.com>
 <20261110094830.2081847-1-m.szyprowski@samsung.com> <20261110094830.2081847-2-m.szyprowski@samsung.com>
In-Reply-To: <20261110094830.2081847-2-m.szyprowski@samsung.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 10 Nov 2026 04:40:44 -0800
X-Gm-Features: AclHuK83CWJc5YlF2QehrZfUW5W7mZ4EuCDQrpmAsXstQoXrFuDrYSPavdO9f3s
Message-ID: <CAMo8BfL04-yz8VppH6P+dcBTJEvM5zPR-=d9GMdRG4F2B78YXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] xtensa: write back dirty lines in arch_dma_prep_coherent()
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 1:48=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> arch_dma_prep_coherent() is expected to remove any dirty cache lines
> covering the buffer, so that they are neither lost nor evicted later on
> top of data written through the uncached alias or by the device.
> xtensa implements it with __invalidate_dcache_range(), which uses the
> DHI instruction and discards dirty lines without writing them back.
>
> This loses data written through the cached kernel mapping right before
> the call. dma_direct_alloc() zeroes the buffer with memset() on the
> cached linear mapping and only then calls arch_dma_prep_coherent() and
> switches to the KSEG bypass alias via arch_dma_set_uncached(). On cores
> with a write-back data cache the zeroes still sitting in the cache are
> dropped, and dma_alloc_coherent() returns a buffer with stale content.
>
> Use __flush_invalidate_dcache_range() (DHWBI) instead, which writes the
> dirty lines back before invalidating them. On cores with a write-through
> data cache it maps to __invalidate_dcache_range(), so nothing changes
> there.
>
> Fixes: 0f665b9e2a6d ("xtensa: use the generic uncached segment support")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/xtensa/kernel/pci-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

