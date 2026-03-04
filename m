Return-Path: <linuxppc-dev+bounces-17656-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B52EDEC02
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 02:49:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQcZs61TQz3bt7;
	Wed, 04 Mar 2026 13:49:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::649"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772592581;
	cv=none; b=alYhB3RaTHsWuKXQ1VJzgrTOjuNMb/P2yAM3oxVCnO14PMo5CdiTFzc+/hvZ1grBV93TI5m0dkgrwl/1qOXN3b+xdoXJjB4+FYzLmEHegsaBv5lfmVO3mbVIFFQvWOIFqTW5TgEJYTpN92GmESESZdrjkjMoo2L+53Z9BH3KgCQo+x69N69rfiZmGaMf8PUIF9dUOM/ARwkT/AdgwiwL2yiv6G4JQpWJpF07Lo8GcA4A45hWcumPlTbb3zZFyI9Go+cinlH4UQ2QcxBVbVoQ+fU/pNfQm4Yu6jrb41fm7WjLGjIjAJSALtV/Xx8fOFx8G2tbGACS5BZXHLyYoDNlXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772592581; c=relaxed/relaxed;
	bh=wlfxAiLCYE9X+ss6Nds/jzCWOjzdQvgrRAY6r5Hx7j0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k7vP8kPNpESKCp+N4rK6zNr0khkzyR4iquCBdckcG7jzaAGg1/YXsyjla4aX4kUQmn72mdFJN0bkF5ORfiqX6vsaRroWSKroRc1R3bhOHN7YUsoUpOfBYfRL5JPBHWpnYkDzOMjRdILurVHBPAqRvcolT0HO7CdTKLPe7j0m1A8EmUkLY0FDGF5qiCPR2VuK8CuUGKEEva0d0UiJyvvQfsu2V/ejtrPRGcH2/2Bzjd00ZVkKotfuUQxcJTeRfFj8yGmOC+xPfXPjRzBjnr5eFwZ4eqoF5lrFbJQ/6tNlGUW37cjkz79gkODEnEGrnnOaduWAq9P0IaKHQ+fzlpARcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=LsQ2GCii; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com; envelope-from=3wz2naqykdo4iuqdzsweewbu.secbydknffs-tulbyiji.epbqri.ehw@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=LsQ2GCii;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--seanjc.bounces.google.com (client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com; envelope-from=3wz2naqykdo4iuqdzsweewbu.secbydknffs-tulbyiji.epbqri.ehw@flex--seanjc.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQcZr4p41z2yLH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 13:49:40 +1100 (AEDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2ae66ee7354so7476975ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Mar 2026 18:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772592578; x=1773197378; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wlfxAiLCYE9X+ss6Nds/jzCWOjzdQvgrRAY6r5Hx7j0=;
        b=LsQ2GCiiKRW40w10UjHVt332JDrcjMZUx0TkjF+PjkM1Qo99Xv4XCuDU3fGaGAd6j4
         /JTgQS8TeGxi6wVoeqHlBQV/i9S/+fjLYiaEMKO4BA1FyFR9Q5wdtO4vbP/RGpcqAq6a
         lEq1CehcYIxYJ4xjILvERlUv74njHmdbTtht7OLLea1+6TP1MD1ZUgpZYTYKMOeDgbDV
         iQHbAa4icFIELARKdIA1qN1ZttnCdTYKppBTJEgtvldcIhi0gO1k29Hfdj7+6+FDoCYG
         V1FeeBRp4RDcrFkfmmgiuXQvawGMPnEHMH4S0l9J1O7po2HTgxXUQ3rWaq6qtP/ch6gI
         i7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772592578; x=1773197378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlfxAiLCYE9X+ss6Nds/jzCWOjzdQvgrRAY6r5Hx7j0=;
        b=aTlErtCJ1PczMKLCTpim9TcRyTy/ts8TnbzyhRrbsoCUjnUyFyeHiHvbg4NSG7UKf6
         eiJsSOpyZJf66r7bE+xSDeya8ETov5D64c1OuPecUbS4FVWUKFfO6wTNkYL9bRitA70E
         92blMFsP+eBwteLdacje8XwXiRrTWPFIOXL7P8eLuEFdDXMtHdRV29e9eF1c1epNm83Y
         8s6BxBM95TFay2p86zQhukRjXbRy/jl9MYay6Sw6aXd4Fc2xx6AplJyoaHspaRk8RiC+
         CDm52Pu659UoyKMuH5BynjPcEv0+tZxQqnBPQ6RNgJKPONgzaQJuLiTd61mqv51SYrs2
         9hTw==
X-Forwarded-Encrypted: i=1; AJvYcCWZuh5+cbMMBW4mWdkRccHcfQw5lMLaVGNfABsqx98QWLPOGac8R46D5aRUKyUZsjJJHSggRlKRuyQmkRQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyPiBu/gKa8E03XrXQm1NQcb3gN6Y4WURQYgDzjB03qzQSlLoFv
	ZOQ6q2Bls/IX9D2bnpLTlPHR2ajUrlqTiNQecNCNc3jowkdLDF7v26o8TAj6dgkVuW7ij//MYGT
	hwFqrSg==
X-Received: from plzv9.prod.google.com ([2002:a17:902:b7c9:b0:2ae:6338:73ca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2446:b0:2ae:483f:b239
 with SMTP id d9443c01a7336-2ae6aaf9469mr6114485ad.30.1772592577810; Tue, 03
 Mar 2026 18:49:37 -0800 (PST)
Date: Tue, 3 Mar 2026 18:49:36 -0800
In-Reply-To: <f8d86743-6231-414d-a5e8-65e867123fea@kernel.dk>
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
Mime-Version: 1.0
References: <20260304012717.201797-1-ynorov@nvidia.com> <20260303182845.250bb2de@kernel.org>
 <f8d86743-6231-414d-a5e8-65e867123fea@kernel.dk>
Message-ID: <aaedwFwXh9QXS3Ju@google.com>
Subject: Re: [PATCH 0/8] mm: globalize rest_of_page() macro
From: Sean Christopherson <seanjc@google.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jakub Kicinski <kuba@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "Theodore Ts'o" <tytso@mit.edu>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexander Duyck <alexanderduyck@fb.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Alexandra Winter <wintera@linux.ibm.com>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Anna Schumaker <anna@kernel.org>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Aswin Karuvally <aswin@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, 
	Carlos Maiolino <cem@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Chao Yu <chao@kernel.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Christian Brauner <brauner@kernel.org>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Airlie <airlied@gmail.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Dongsheng Yang <dongsheng.yang@linux.dev>, Eric Dumazet <edumazet@google.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@redhat.com>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Jaroslav Kysela <perex@perex.cz>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Latchesar Ionkov <lucho@ionkov.net>, 
	Linus Walleij <linusw@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mark Brown <broonie@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Miklos Szeredi <miklos@szeredi.hu>, 
	Namhyung Kim <namhyung@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Abeni <pabeni@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <pjw@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Simona Vetter <simona@ffwll.ch>, Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
	Zheng Gu <cengku@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-block@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	dm-devel@lists.linux.dev, netdev@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-crypto@vger.kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, v9fs@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 03, 2026, Jens Axboe wrote:
> On 3/3/26 7:28 PM, Jakub Kicinski wrote:
> > On Tue,  3 Mar 2026 20:27:08 -0500 Yury Norov wrote:
> >> The net/9p networking driver has a handy macro to calculate the
> >> amount of bytes from a given pointer to the end of page. Move it
> >> to core/mm, and apply tree-wide. No functional changes intended.
> >>
> >> This series was originally introduced as a single patch #07/12 in:
> >>
> >> https://lore.kernel.org/all/20260219181407.290201-1-ynorov@nvidia.com/
> >>
> >> Split it for better granularity and submit separately.
> > 
> > I don't get what the motivation is here. Another helper developers
> > and readers of the code will need to know about just to replace 
> > obvious and easy to comprehend math.
> 
> I fully agree, I had the same thought reading this.

+1 from KVM-land.

