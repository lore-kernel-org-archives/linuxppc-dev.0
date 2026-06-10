Return-Path: <linuxppc-dev+bounces-22418-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D932CD8CB2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 15:23:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gb8gh5LbRz2yfD;
	Thu, 11 Jun 2026 01:23:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::330" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781105024;
	cv=pass; b=PLOG1ALF1mH47vpWfC0vyB05X1aHliK851VlGlLgtDf8mPjKOLmlsHWGvC7BnsTj4I6ggc6u7V9WZaoNuBpb/l1CYV5hkAwLaA2ZIL1mWj+gI1t4L0/8yy/bKx+JQ8zJ18ZhY3sx3RIxWERd6e9OaG5dFZ7pCKq8Qxl0YKQ0gHMu9LlJhDgxbITHlHGrlWinZSiRCuasDBTuEnV0CQ2ltRkJq0mNytWKEKA3hJZcLz/LwRI+PWY1jaSTMuay+fT/G3Tv0kpcbqWv58+riuX7zlNdyDnsma1vh7SpEdUw8XRWZtmpEk4rawwZMNf+BLN2pA/5WTRUC8Ip3LyRX602fA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781105024; c=relaxed/relaxed;
	bh=HLSNIkxH7X+mkcTC4TNft77b6jFG+UTH6aJ4cVsmWLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AB3yicm8lTR6ujnthnh1JlCftDOX3NcIqF/6wn+QVMhljEVSH+sH4603qY6pBDi8hUkCDBku12b3BLsga7zS7kl/PBjuEm3tvdUY2dQ2Vr/XKBvVS9nFB5pBOqhEh1rXe3VLDR7slZenEAPBL6YJoB2/fdvF698jrrlECrHl7C4IKuHiNFfcvDkX1oUDY4YqgERYV0eucZ/1TFAOTpJTt4rBIiZkrgb/znggUPkQ4VnVwRBHCHzFsABqSsbCPQ/3sMHcjgoQ7qcZqHJNi7wamBLKjqehlqu5HY4xO4iPoOeSDehv8N7PM9+z68Oaf8uqOrdzVl8Ma77DAIOkBNDSSA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bKW7Kqjn; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=tjmercier@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bKW7Kqjn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=tjmercier@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb8gf75ZZz2yNn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 01:23:42 +1000 (AEST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-490b23c828aso57415e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 08:23:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781105019; cv=none;
        d=google.com; s=arc-20240605;
        b=lCTZkTErxoe+b3BGGE70p0yddwu73L1RsIhMCvLWriVHEw3LLhTlBioWsDVnAVaPwi
         /YwjP3ixZCDDQa02GSmfjPRyK1sOT3RkIsUNPtPMzPG5985X0nvBF1YG7vFZaEhEgC75
         nwe436DKMzKarapg7svG1KSruORqncZgUfXS2UDzY5RW4/AbVNAif5BMhMHAn+z5TNh4
         x1X+4j0EFBmC7w1aPMDXwamaXF38Vt7s/mIz07Tvbmh7LyTRyywTNAman0VdhlCnk+P+
         HSBQ/SG9ZhIJjGXIACvzO+DFjysKTwSeFiWF3oPVIyhb1rhZa2gqcrLnJ9dg9Irjrxa9
         Ot9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HLSNIkxH7X+mkcTC4TNft77b6jFG+UTH6aJ4cVsmWLs=;
        fh=ch/DcCoTRuj3sHoMbrm9DOaBgrRDI3N1JbiGgSkp460=;
        b=Gwu+B6NTLPSpNLPL+VIkSfIaTDEgaJK0bj9KryJ9GJFDssXIyZ6X+sRxDD99cFeVwi
         bjggJ6YXild4PWv6Fpu1qjYe30dMYTom2Dy55/UMB140UCdv6iVgILjGIoDe+doHLLrc
         njMadnLLE161eIpxEui+i1YRyQPuXD2XE4l21FF+o2D9IvCyJkl7Qwo5gjfWWEQxKBV5
         zqqS355FFIn2K0VHb2OECUoDegHZ3ozFmpGH+8BFfVsJHwttdWzIlaMnWEtj+zeLMhLc
         GmWMnbHWQPm+iiqkLl9cc3cZ6GKqiGBe97x4eECRoka6fTi3oYwKpVkRRYpjgChVdFEf
         LeLw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781105019; x=1781709819; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLSNIkxH7X+mkcTC4TNft77b6jFG+UTH6aJ4cVsmWLs=;
        b=bKW7Kqjn0+eoKd7LfjsmREzS6i1O9Yad4zBo7g1evRZPikpe7Lwcjqo9NGtBcFXxRI
         qpElLk1trU49sMqzqvq3iMTjhmt4YAvSXc5NjUJMogQvztV5BSywzHfSuK38H5/x8v1w
         x+igJhwpOwL6OK4+bIwGwjuAK07OdAuZC1znMxLo974wJ0dsVv3P2ZfEyGDxt/xy7UID
         krkaStMqREdI/clzlOZRNRcjMZXgOOPeqv5z7ENAtu6rZKWM4o+8jv6CSqsUJ1gj/3Du
         z/qKI0UiOM44BthNe+0w4RD6TUAkq7ZGR2K1UUljLcNm6l0bppTKq88u/j1rQcD2aJUs
         sI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105019; x=1781709819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HLSNIkxH7X+mkcTC4TNft77b6jFG+UTH6aJ4cVsmWLs=;
        b=C+jOTz0kyT6YGpAXBjB2+O5VaSNEG2QFTWfnzo8LwWDB8yIja3fGwwcyLAf/VIoUl3
         /zAZ9Mux5W67DKtrmlg+1iaXYe8slLHdzatDDL8xlNO2Z0I0zHPcb+5z68t2hSs8i9+4
         dWhbeOszqemzR88E5rTRk5MAuKmdg5FhH2V+i/dPOy/QjYCAUpjCxPSgdGdS7kyJg6te
         Lu/PWWZH9jLTJXE+gS2TsIiKIDSLYDeHD839OhiEXmbJDteUOG8bhX8DEZKNH/DitB+d
         uofpTHAJoN32ZRYfe00MzvBFnUqRLQfkPQfnLVEXgNHDXTF/x1QHgaxhZxpG3AT+LOW3
         ut7Q==
X-Forwarded-Encrypted: i=1; AFNElJ+XSdrIhtA4CzmJxGACCBzlLixQuQBRgWEdlSJ8y3Qod0gOrBwUgRKzOBUqSPWgFQ1TRBp2xZMfFtwkiNc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzRpj+yRqMIkwgL6cJgc+RZwZEgBY3V2gCt+7FAvxdH5zSD3XX0
	9wNbgFKC+qCMdh6SjjRGkgJkeD3RS6vnVHgKLQ9ad8jWzWBwWkFoRlPlm1bQ+wvK9KCjsfEVcp2
	VcQ73W5zK+TXf0Ee6uz0s7cFIDgO6wavRZv52trVy
X-Gm-Gg: Acq92OF0o6iTy6Hm8ef/n321k8FobF7X+JfepPhuJBI1JB3IDwqqDcvYq5A+Z0YEFTL
	4d+TpzBuQ28pcSkV0IDvDLBvviPB51NmeOhRNcSz0pkSgBpenzfVyyYx1v+K4gzZLo824mh02nJ
	T27oqCCA0OL7UyvO/2YnjyWZH8loF66pIRzeVLlIC4gvSNVWUciZzRVrz8lhbWrW2pmsvneEaEL
	W0t/MExcS+4j9xxR9UAXwiMc87yZDqONmo6LiEKUQKuuEyhShYNG+6oERKR0oOL41OCJH+GAvev
	7+m/vZVmYnAo0GO5iJYYcUW67u0OEnvt9UhHEv/Pvf2VBacji/GnyuVQJWj9rcub7Ae6HQE7jxb
	JfIob
X-Received: by 2002:a7b:c055:0:b0:48a:5aa3:ac1e with SMTP id
 5b1f17b1804b1-490e250419dmr39465e9.3.1781105018413; Wed, 10 Jun 2026 08:23:38
 -0700 (PDT)
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
References: <20260610142329.3836808-1-sumit.semwal@linaro.org>
In-Reply-To: <20260610142329.3836808-1-sumit.semwal@linaro.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 10 Jun 2026 08:23:24 -0700
X-Gm-Features: AVVi8CeKPjOw-ulqerfXTIRQXgt0wS2BLRdaHk4b32zpbgZavKZyW6IeEygncls
Message-ID: <CABdmKX0K22aaPTrk7Xs_8859ePYQsPNuqcG3v4oMZHK3T0xqKQ@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: move system_cc_shared heap under separate Kconfig
To: Sumit Semwal <sumit.semwal@linaro.org>
Cc: christian.koenig@amd.com, jgg@ziepe.ca, jiri@resnulli.us, 
	hch@infradead.org, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, lkp@intel.com, 
	agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-s390@vger.kernel.org, djbw@kernel.org, thomas.lendacky@amd.com, 
	x86@kernel.org, arnd@linaro.org, benjamin.gaignard@collabora.com, 
	Brian.Starkey@arm.com, jstultz@google.com, mripard@kernel.org, afd@ti.com, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 7:23=E2=80=AFAM Sumit Semwal <sumit.semwal@linaro.o=
rg> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> While system heap and system_cc_shared heap share a lot of code
> and hence the same source file, their users have different needs.
>
> system heap users need it to be a loadable module, while
> system_cc_shared heap users don't.
>
> Building as a loadable module breaks system_cc_shared heap on
> powerpc and s390 due to un-exported set_memory_encrypted /
> set_memory_decrypted functions.
>
> Fix these by reorganising code to put the system_cc_shared heap
> under a new Kconfig symbol, which allows either building both
> into the kernel, or leave encryption up to the consumers of the
> system heap.
>
> Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module=
")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

