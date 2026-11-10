Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E192360A261E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIbXPQ/7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP5sB4fYYz2yQJ;
	Tue, 10 Nov 2026 23:42:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f33" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794314558;
	cv=pass; b=VcABT0kQFOQe35VDwfRjwQnePSu6HJ4en0O4lUJKv/7ek/y/PvacFR3K+iO8qlCw46ewKdYjQn5cG3FHAQ28gyEyplrxo8h8DZrkp9g3GAbo9cI9C+51gl8CGVxGXQGL3AlROHTiGe1QccWbpVdfO4War02xvD/1RaM/6Pu7XWBRc6ONhKQc2Tu/+qtA8fFc3AFKEm+bQw6YoP8qIYqPwZm46j5goV1zYKBoO/myqQbaxPZh7m8LXRB3kpJcqs7Q+c6AR+MnIe7Fr0pKP0XyB8PfnasvXdwT2T/xLZKlSLDToxxLgOoIwbKtwyyptmEEM+V5ElQAJrMW/wlBm2xASg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794314558; c=relaxed/relaxed;
	bh=10UT92sr+vRIVo9wGLbCQyuS9MFs0Bc9LyaIXMh/H9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StAJfH2sA8EpjxFIGZL3U43LutVK6YRgeBXClaj3YO1PUmL1i98LJn71053R+qKZ8GwyaCjeKL35SwJZl0jcWQXVX8pYgF8/ngOzXHIr5m3mrR8pTD4Ihi3GObIVOckjvHiB6ixCIpahWV2K0dne1yTSOt3PuOaip0HdUBzob3UXv2HyC58bjei9oIdj+PM89pYUo8lz3EwVKf6tf3KBJIZkinAtFrlvNnBHcp/YjGARIl+ql9hckKfuuEP3KmytBvS4HwDufK0r3dkNY79n0tPCkBUykwggUlin6QiN4rkNRm7CuyGeBdRzFk6VrPq7lpWrQJD7T1lXhOVd1VzjeQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIbXPQ/7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f33; helo=mail-qv1-xf33.google.com; envelope-from=jcmvbkbc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIbXPQ/7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f33; helo=mail-qv1-xf33.google.com; envelope-from=jcmvbkbc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP5s95szvz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 23:42:37 +1100 (AEDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-91ec14f4369so20735536d6.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 04:42:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794314555; cv=none;
        d=google.com; s=arc-20260327;
        b=BE5uTp+6lUQ7/zwWQ52N5woyOgnSEn8mxSike4Qb7gFoASCyw4IqzMJ4FCBZ69RUs0
         oV3WS1HslVgbsyHphKZ+EVpzlXivNdTwtGE9YGLxYS41QPtkCjpBmbxx2uvHLeKvmj6w
         detXchPZy9h7dSSrG8Kq+ojrEoO/ADiaflV3jM5nKwoPJ36KuS1IP5R3HPPI9HhTz8Ua
         oOG3Dk3ioPZntgTXZOuXmIrkMUdzjot0aMxgDdzRtuAIakcu+cCrb1gv5KcFG+IxzwJB
         UM+B13ljAHe9BSdaO7wOg1XJCGhswD7CkYinX35PyJW/6aFOIgj/qij8PQ84q10pSkyP
         6bKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=10UT92sr+vRIVo9wGLbCQyuS9MFs0Bc9LyaIXMh/H9I=;
        fh=EbIGDsOKOaQOrVmvfVlxzMucHFUBAjnQgSv67P4HnyI=;
        b=JJ3YhXBfHtxiHCPRlf/voQ6ti+zv2WtJxLbOqJ92wYQBPXdVqjYUORCARGuvgdm/nO
         kMMxK6dTi7ss1bcOOuT67IVZhnefkrxPAoxEWuftRUHm6k6GbMbg0D7JJPVMurxx094p
         hmdauUy0P7yDJqrcN5O/g0ZHEBvqO5lCYKMHsrKPnzE5xHXR/p7HcKcJx/CdRJtGNqcR
         tol3f4H2KEpxAXE9nZpIj9YxeqorcZvqWhPrwFWWjHid6fRf8V+iQD2JD8ReDoVm8eiu
         e++urYCxlC6UrWWPqG8phWjWUxRUg5Avpnu4aCs220Z68qzcJyJ3jeC794CG5JHXr3pt
         pOvA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794314555; x=1794919355; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=10UT92sr+vRIVo9wGLbCQyuS9MFs0Bc9LyaIXMh/H9I=;
        b=VIbXPQ/7AoIrH1GqNHICZL90FsDarzBq/BeXGDwyqr6CbLRAl7UqkzIZY+/Ip1Mzv6
         kgGFKtYdWlqcpTEAQ6j1AiL5kA81FNMCT0xlCkH0CrmPtbWLUCJmMpToRsqV0Bfi22BT
         02TkJpEcgQ6rNbkTIQIo3ZC/mydN4Thn98ImO0e5Asx8h9NAhonhy6OecD802V27JpB/
         wXBDXrMGXgkv2873sFkkZi8VwugiPsN85yiTk69b/QqK3H5DY7+LiyjG2twPQYp10M+S
         uRg133Ad2OqbWkp2gzeqaS8t4G4Cr16JmF9c4SN+vsDfyv5Fqh5/w4gNI1NC9Uoo58ow
         /2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794314555; x=1794919355;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=10UT92sr+vRIVo9wGLbCQyuS9MFs0Bc9LyaIXMh/H9I=;
        b=V7+PHKgHhlJoVakXbGALbhxZYquAJs6oMGmFO93uKXzONUY7NguPnsqlZJVZvSrq7z
         dc8vwG+zWh8S4DAKKHE4DZzkM01jn/k5WYT5wbGxIewH90MSm2/0ATVDn4vm1tLBxMuE
         F9ExE9LFjKueCzKoIowFSR4UEIZbNucQtTod+gC/pBjFD0jDwt7A+S/f2wFiAtVYJ8XD
         ECgt/KhcXDjl3357VVz/JVGPP9Ls6SsjnEFX9gPzc1xHb0JYHy70G9PbFK0bqcRR4gTb
         d5eDAMQzTom4C1wSevgVRhsfy84+PnglN+h/GsIN6P2mUsbwSNZRjTausrK1qKBHCvPa
         HMkg==
X-Forwarded-Encrypted: i=1; AL+hErGsreWevJiVMJut7GoHoKiTs1KqMdGDcF0/6zaIGNwx+pV+xgfIepXcJAK2DTWpLz3ZMSQz6f0sOBJrfcY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/nWfUMTxIF8TAI9ol31mHc9qwuQLGWy49okdbB6lzyOonb/EaL
	VcSwjpjMw+f/nE3NLpxHhXR9gtq5XNk9VJAfCdqeuAHkEbWHNWcVCjcnPt8wrbE2gYIbimmkVBN
	M59DCXKy8UFnHAx+HcS9YcZsdEMlp0Hc=
X-Gm-Gg: AYBFou36PuTK7qJU/IDsyp81bJwdpqkm6L46GeSBUINRLDhLVihgQyVUd9rs9C/cP2p
	CDausTqzPyKzJXPEYHO6hk2LETPNiSW5K68vwCuLYm4u24j8kOugpGHe/MFpqin/L8qFgx1RNnS
	C7oES1mafibqd+TsUa1xI/LD5SJb+n6Qot/KY/3ziPd08oV7lmh3SX11WBs96K4Zn6lHQc1PMP2
	ZI1qwN9WAocT1gMu7dV1uIJTSKUPaUJpPGG6wLwU+O/kWUT0hmyuBkMoHpSEr7dYdO01VrNasL2
	4Feg9jISradDI9DqKY0XA7xKQAfbjqKuRgvuSEgcPP43v4z6PE4DsrMsZ1om/I+eezl/zWlnx9f
	VU7/XrBTHeoiuNYInszRZ3YcnxFuv7WhZ7ueQUkg9EWLeN2oOp4vFf2vpB1n9/uhSqvfS66xGGS
	alPeRQNglDrRBFcn9fmIZf
X-Received: by 2002:a05:620a:461f:b0:93e:c12c:f137 with SMTP id
 af79cd13be357-9479f368c54mr360445785a.82.1794314555301; Tue, 10 Nov 2026
 04:42:35 -0800 (PST)
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
References: <CGME20261110094848eucas1p2577d7a3c60643a040e599dfa1bf97f08@eucas1p2.samsung.com>
 <20261110094830.2081847-1-m.szyprowski@samsung.com> <20261110094830.2081847-3-m.szyprowski@samsung.com>
In-Reply-To: <20261110094830.2081847-3-m.szyprowski@samsung.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 10 Nov 2026 04:42:23 -0800
X-Gm-Features: AclHuK-FeNynpA1_RJvncVNma0nOMx7dW4op-Ljg-ln5a78S2ORxIIsRcrITnr8
Message-ID: <CAMo8BfKENmH3rZU5jyCdVOBzRAQ+KBJmVyjEWG97XYxBNaZ=qQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] xtensa: handle highmem pages in arch_dma_prep_coherent()
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
> arch_dma_prep_coherent() performs the cache maintenance on the address
> returned by page_address(). xtensa with CONFIG_HIGHMEM uses
> HASHED_PAGE_VIRTUAL, so page_address() returns NULL for a highmem page
> that is not kmapped, and the cache operation then works on the virtual
> range starting at 0 instead of the buffer, leaving any dirty cache lines
> of the buffer in place.
>
> Highmem pages do reach this function: dma_alloc_contiguous() can return
> a highmem CMA page, which dma_direct_alloc() handles by forcing the remap
> path and calling arch_dma_prep_coherent() on that page before creating
> the uncached mapping.
>
> Fix this by reusing do_cache_op(), which the arch_sync_dma_for_*() hooks
> already use and which maps highmem pages one page at a time with
> kmap_atomic(). For lowmem pages it does a single cache operation over
> the whole range, so the behaviour is unchanged there. A small wrapper
> is needed because __flush_invalidate_dcache_range() is a macro on cores
> with a write-through data cache.
>
> Fixes: 0f665b9e2a6d ("xtensa: use the generic uncached segment support")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/xtensa/kernel/pci-dma.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

