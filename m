Return-Path: <linuxppc-dev+bounces-19240-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E43D6AB19
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 21:58:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmwj14HTsz2xSG;
	Fri, 03 Apr 2026 08:58:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775167109;
	cv=none; b=G2r1oS3OJn99X4dhvnyaxV1be/fZJCs0iEIc0BqWpYZ3DwF959c0yDqQq1kQFlWfcEJcR0THUSxH/tLvW3xRQdrRQBvYlbddArXm0C8BW+9THkMSFSTyjXHCqgMs/5Z5D7/2EN4Zo0g2t5X18Y49rlnzON4Ybp1JBN690DudKxQviEX4HWPB8sokghTp1H2XAT3/k/OA3gkCtSuDNLiD5CqcAE6vFF/oMAloiJsoUQ+6zg/k85hvmPUAdgcUJ3GbOPxn82eWKaI1DwPH1IODrlWr3FYuBohrrmYCMqLLS2NXecLp2+lzOSMmNa7qq4TeCIifqShy6IXLBnF6lOEjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775167109; c=relaxed/relaxed;
	bh=XuToGNZ0fDyV9ckReF7x/iBdAj/35w5vB4q5GhoKJJE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fDCuzWmvhSMP+3Rya0+EN+go4JFiur7EJKnaIootiAiVrSiz9Bd1NOcPXVQ0GCeySJ3GWE8h9XLgcnrJr9gKmEwBGdFCfBFzDdjV/NWBHhYEF9mWB5w7uGmlqtO2oeAZu6t+CdHCeXewhD1PXB0YFBBgXxpMOhVyxh1GlGrYDakepFI7to7Z+q1rf2laShoxvy64A8uLqPfGUYgu1lK5Q0aG9hho/6xZhGGKMiLzyG/c8RQuSqPgXJhenM6QTyuK09EtyK6iLAAzi7jP+6tLnb5E40FFZ1z/MMffTxzqbys1dS3lwBmVpdbsb2mxyhIkRiQpMFBKbQ5sNRy1W0Iolg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KBJzCsq7; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pjw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KBJzCsq7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pjw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmwj04JcGz2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 08:58:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B9BAC403EA;
	Thu,  2 Apr 2026 21:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D96C116C6;
	Thu,  2 Apr 2026 21:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775167106;
	bh=QvUc9vANqYsb1luDp8UYk1f8BqkeVaTMVXLV75eutnQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=KBJzCsq7TNcgHpU+TWPAd3W8YuuJXdgpviR9Ow38UzYp/E+eDMYCQdUq5+04/Mnru
	 vF8yruBgH9Kqoxj3RdUA00tDQnEgnr1qE7AXbmqG7qka9IVu/f1eZKTg86JWT+ETrn
	 TjxI1jdECoYVYFvAydaPvhTr0DLyOkSNS0rHhfEWArmmkmeciwTpFwX+5aQHpstoUl
	 foXfbAlUvknuR2UINHvJ3kK1f5ozCCWUSVy6PFFL3eEN4gpoDz+keSHvFP6Ep2zvPe
	 Ej2doeiB7lotVTyVy6ov80wS5IsFWdnGSH4WR6z1XJ7lBV9TObDwXGWdYhpggyK3MT
	 1b1VbHt8uneOw==
Date: Thu, 2 Apr 2026 15:58:18 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    "David S. Miller" <davem@davemloft.net>, 
    "Michael S. Tsirkin" <mst@redhat.com>, Theodore Ts'o <tytso@mit.edu>, 
    Albert Ou <aou@eecs.berkeley.edu>, Alexander Duyck <alexanderduyck@fb.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Alexandra Winter <wintera@linux.ibm.com>, 
    Andreas Dilger <adilger.kernel@dilger.ca>, 
    Andrew Lunn <andrew+netdev@lunn.ch>, Anna Schumaker <anna@kernel.org>, 
    Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Aswin Karuvally <aswin@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, 
    Carlos Maiolino <cem@kernel.org>, 
    Catalin Marinas <catalin.marinas@arm.com>, Chao Yu <chao@kernel.org>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Christian Brauner <brauner@kernel.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    David Airlie <airlied@gmail.com>, 
    Dominique Martinet <asmadeus@codewreck.org>, 
    Dongsheng Yang <dongsheng.yang@linux.dev>, 
    Eric Dumazet <edumazet@google.com>, 
    Eric Van Hensbergen <ericvh@kernel.org>, 
    Heiko Carstens <hca@linux.ibm.com>, 
    Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@redhat.com>, 
    Jaegeuk Kim <jaegeuk@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
    Jani Nikula <jani.nikula@linux.intel.com>, 
    Janosch Frank <frankja@linux.ibm.com>, Jaroslav Kysela <perex@perex.cz>, 
    Jens Axboe <axboe@kernel.dk>, 
    Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
    Latchesar Ionkov <lucho@ionkov.net>, Linus Walleij <linusw@kernel.org>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, Mark Brown <broonie@kernel.org>, 
    Michael Ellerman <mpe@ellerman.id.au>, Miklos Szeredi <miklos@szeredi.hu>, 
    Namhyung Kim <namhyung@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Paolo Abeni <pabeni@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
    Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
    Rodrigo Vivi <rodrigo.vivi@intel.com>, 
    Sean Christopherson <seanjc@google.com>, Simona Vetter <simona@ffwll.ch>, 
    Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@kernel.org>, 
    Trond Myklebust <trondmy@kernel.org>, 
    Tvrtko Ursulin <tursulin@ursulin.net>, Vasily Gorbik <gor@linux.ibm.com>, 
    Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
    Zheng Gu <cengku@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
    linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
    linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
    linux-s390@vger.kernel.org, linux-block@vger.kernel.org, 
    intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
    dm-devel@lists.linux.dev, netdev@vger.kernel.org, 
    linux-spi@vger.kernel.org, linux-ext4@vger.kernel.org, 
    linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
    linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org, 
    linux-crypto@vger.kernel.org, linux-mm@kvack.org, 
    linux-perf-users@vger.kernel.org, v9fs@lists.linux.dev, 
    virtualization@lists.linux.dev, linux-sound@vger.kernel.org
Subject: Re: [PATCH 8/8] arch: use rest_of_page() macro where appropriate
In-Reply-To: <20260304012717.201797-9-ynorov@nvidia.com>
Message-ID: <ee15482d-22a8-9686-ba64-d216b25d8e68@kernel.org>
References: <20260304012717.201797-1-ynorov@nvidia.com> <20260304012717.201797-9-ynorov@nvidia.com>
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
Content-Type: text/plain; charset=US-ASCII

On Tue, 3 Mar 2026, Yury Norov wrote:

> Switch arch code to using the macro. No functional changes intended.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Acked-by: Paul Walmsley <pjw@kernel.org> # arch/riscv


- Paul

