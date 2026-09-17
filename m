Return-Path: <linuxppc-dev+bounces-27577-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CE4C982D8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 14:31:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlyqL1Zdkz2y2W;
	Fri, 18 Sep 2026 00:31:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:30::10" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789655470;
	cv=pass; b=eTgSOnJmkqf4haqilb6+ZKeW8CX9KZhX2G+U2crwjCqmDflHSxztau0SmVF9YPPKn0ftX/2GMt0ZITRNbqcECAe0n3D+iinjtMJ/lNu+tg4ApBoyMVy4c2XBKGnNxxp40bxDZpfeKHo3fZwuLJDKKXJGHec9+mkVUOwxe8I2/6+2CBJlj3YTuh1zd92tV41yrnXABmtdqzt3K6yM16HdW+UUhQHc8mYomUaIZycoLkwofpWq2FBzpiZskfAYWdk6oJGFPqjDIuA57D+/Iv/arFi3N4yI6+TivX3RQ1TO7/c9Q+eRgVAa8mgvuGBJENZXZOoenx0WEeKA49jvaGk+kg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789655470; c=relaxed/relaxed;
	bh=OL1rW9y9mHZ7kkv/coK63PMmFR1002GsoxxgXvkjsnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUNJslpUja6Ri0izsiHHSTG6q2H/e8ulsUIRKu+Z+zt6g9KR+bXsO9OczwK5WCLkn3x9Jdm7XhfI/qm/XYiGaqTid0adnsnSS1nUSRBZi5it9Ve8cZeffg4zbLqWuEbw62Bw586d4bvt5lcPGAKsUr2MiL97sSfGsYGs4dwtl0Sj5eLEsDKfrRRCv9icsLr5dDvBVJ+lHiT4xjKosbctWxYn/w3dx0nTznrcqVmkvOlqhTtNwAnVB5FPhyYDwZEB+nBCw2xPGbQHg6M/sd8rIRcpkJ94WuvLIkmvz/8lhhLEa8rP4caeYNyNL3i7mw3UuE7FOC6tZkNbjV/lHdKePg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NAlVOeyI; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NAlVOeyI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com [IPv6:2a00:1450:4864:30::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlyqJ3VyVz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 00:31:08 +1000 (AEST)
Received: by mail-wr2-x10.google.com with SMTP id ffacd0b85a97d-482f633cd80so518612f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 07:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789655464; cv=none;
        d=google.com; s=arc-20260327;
        b=n0QO8o0W0we/oek5GO9NY0s7vc3+cpuNzIvGexy+oM6iVTf9B7RzvrKnoC9cpw70RP
         GfHJTLpu+iW5ZOD3tbxVI5VK1kUxxbPMwukJemFh5o6+GCqVMH7Dp0nIj8h2+Y6MDroq
         iM0EEBqUEGQHM8xKjtTIcBrhTj9n+BKyCtnKe0jtKs3Y+9hi34JDFC9jn6DhHEV1QOrV
         VykRJ/bYK/bsEHrXZsnMHgxeQk81/CAPItOQticEJTi/caYDfiXWNe4p7/5HpsGT8+mN
         ZEJqcnEIMpW0spUcOz2DyGrZT2wXtaNSE4+QNSSDmPV/HolphmOUxedtBQE6YQuDMnSR
         G8Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OL1rW9y9mHZ7kkv/coK63PMmFR1002GsoxxgXvkjsnU=;
        fh=rMlS2eAdsyh90Q8fEzHx82aHmq8CTZu5yp1pWJLADTs=;
        b=r+2BYWaRRUFBoOLYC0bj1cqLnJWD+eveDAXheGp0iuZTgUSrxvFosptQ8vAOItxJmF
         E6hfoZo8agGPMKr2RH+kNHKh41aOo79hNlpE+gv8jy6imcb1Df/12IOAKeKHEI7CpDMP
         KVEqXDA7/viwoWs5GcJ4PQaTqpWds/VXKWhsltJc9X/UqY/2LLVQN8w66tLYKYzvgnYv
         7+bnPmaZN+x3k00M5cwK+1hIKOxn4huqr9z7HRur0YXvvmddeCP1HUu8VYY4NUY3Ed+g
         b7F63PM77voNb0cvgfSvTnzSXOnZrxYSODxoymqI0prO3ZQSn1TFQb5sRSf0xdToorcE
         uVbA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789655464; x=1790260264; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OL1rW9y9mHZ7kkv/coK63PMmFR1002GsoxxgXvkjsnU=;
        b=NAlVOeyIkStLYdgCWEcqcaE1T38DH1UL5NMNjImakeQASR8JazPF99opipq81P+cEo
         2efPFMmx/w7hrAmZbUaQH0woQZqeewbHse5q1+xBywoujLRG5kNAB6cv1crmTd7kMN/L
         s3dLGxscgjHQHiLn2dCXfPSzsv7hCBDEvsOVdECqjjdSz2/6gEzVhjn+aLaIFEo4yv5A
         KSieQzVzJIvG3c2GJB+LudJ6awQVK+2ivPemwMuUdpD72JSDDEhV8g6D4MAraUEhf+8i
         T9fIyz+97MFAFf79stpFFhO9KHwjqcxT4fBYBYWm1QbQ+Fv5bkyaCQ5Ex2k8slsUlTpC
         O8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789655464; x=1790260264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OL1rW9y9mHZ7kkv/coK63PMmFR1002GsoxxgXvkjsnU=;
        b=Myo6iVkkpLTNBiKI/tUeaz2CS5jeyH83+XBNtBFbXJZIeWnTg28yDYCX2nKN1cK7gL
         pk70OtOqfNkX/YtRB9eVgXBl1w5S3rZzv7iCfuf282JY4btmYlt1GRTpTvClM9anxN20
         ZRz5+fdHO2W6XAvzng9xLhCXS/c1cWgt8B0RYP2FhNjOvzPHfymoTDigKb+wIUAXgJgn
         wEyG3xTSw46pDCsB9HvPBIyQGLBFA0auYhhm/cWAgfFW3foM/Xg6KHWF4wMznTGCfedk
         KSC0rumu2jsJQDB4rtiQbLA0Q0o2b+n5Mdbf9agWqa0U7Z98myG3IjPP/O0UcrfOPLZw
         fuZw==
X-Forwarded-Encrypted: i=1; AKwUvBywbNd5loGS8RvFLLU0ReAsKOHJd8USyWFgTDMXVi38jO9sdrqfSSatbxalwTI2FNE5PbTYyKw5ZiOxZZM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kvg9ogvd0qRuSoHsE4MacfmpcxZlYq9MBXi4FEtjItQw9JsPht
	+TbnpgjuD2TQHU1+oyquXoDkva07aPIBYD5V2SxcvpMkOyiNqUORnKu3iZ7NusUW/nKbfLi9YMQ
	OGGzfeFk0h83wuhuOQ+v07wIyEU3Zdsw=
X-Gm-Gg: AYBFou1IViH9t0IiSNZGnXIIcywCknAgV5u0vkAXuaddcWXsZ4GgEc+dfttbl2OVBY2
	gUdFdSilaVJPQYHivHanhdE1ZGLaJqLOr7svm2Q0G8aLZaOcUdUI+6Ls35+U7k31jvA5LR+IJzm
	nGiU5wlEJMFZq0fwTd5wIZ9LydJiVJSBm3PorJdiupO5sy4kWcuNajPPhkq4OKfj9w9VbNuwCVT
	WqoVFSgej0Ud16skYJJwKQpE99E3MggToF0Ze4sn/xTEVSK+abvnRm8S8bJijFKRD/SWHWsfTgK
	bq8FHXPXlsIyr9J+jNIs2pVtTfccriQkPw3KVdZau0g2HJlTkfy686mKQvb5tGA6kjA=
X-Received: by 2002:a05:6000:26d2:b0:487:cd:f1ad with SMTP id
 ffacd0b85a97d-4870d03f013mr9657861f8f.45.1789655463783; Thu, 17 Sep 2026
 07:31:03 -0700 (PDT)
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
References: <20260917052933.188679-1-jiangwenxiaomi@gmail.com>
 <493ef264-eab3-4be3-a80e-357f01ae1b37@kernel.org> <c92a1202-1fa6-4cd8-9d82-b46a1b5d8f56@kernel.org>
In-Reply-To: <c92a1202-1fa6-4cd8-9d82-b46a1b5d8f56@kernel.org>
From: Wen Jiang <jiangwenxiaomi@gmail.com>
Date: Thu, 17 Sep 2026 22:30:54 +0800
X-Gm-Features: AcwNN1VjxeYLM2KzGJsJYtKrFkqVeJG4mjk-7CUC4wBfKBcPA0GlNQxygqiRut8
Message-ID: <CAHKocdGWem4xW=vZ03maqtHaRLReYmAWkh0rAj63AW7e1+MjPw@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] mm/vmalloc: Speed up ioremap, vmalloc and vmap
 with contiguous memory
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org, 
	urezki@gmail.com, will@kernel.org, Xueyuan.chen21@gmail.com, 
	ajd@linux.ibm.com, anshuman.khandual@arm.com, baohua@kernel.org, 
	david@kernel.org, dev.jain@arm.com, jiangwen6@xiaomi.com, leo.yan@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, rppt@kernel.org, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Sept 2026 at 21:56, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
>
>
> Le 17/09/2026 =C3=A0 14:17, Christophe Leroy (CS GROUP) a =C3=A9crit :
> > Hi,
> >

Hi Christophe,

Thanks for reviewing,

> > Le 17/09/2026 =C3=A0 07:29, Wen Jiang a =C3=A9crit :
> >> From: Wen Jiang <jiangwen6@xiaomi.com>
> >>
> >> This patchset accelerates ioremap, vmalloc, and vmap when the memory i=
s
> >> physically fully or partially contiguous. Two techniques are used:
> >>
> >> 1. Avoid page table rewalk when setting PTEs/PMDs for multiple memory
> >>     segments
> >> 2. Use batched mappings wherever possible in both vmalloc and ARM64
> >>     layers
> >>
> >> Besides accelerating the mapping path, this also enables large
> >> mappings (PMD and cont-PTE) for vmap, which are currently not
> >> supported.
> >
> > This series doesn't apply. I tried to apply it on top of v7.2, v7.3-rc3
> > and next-20260916
> >
> > Can you tell how to apply it ?
>
>
> Finaly I was able to apply it on top of v7.1
>

Yes. This series was based on v7.1. I'll rebase it onto the mainline
in the next version.
> Christophe

