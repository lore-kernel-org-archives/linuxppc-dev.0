Return-Path: <linuxppc-dev+bounces-17654-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B997EDEC02
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 02:28:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQc6t1LDzz30FP;
	Wed, 04 Mar 2026 13:28:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772591334;
	cv=none; b=jfwN6jq/eeiEtuoov6YjdSRrXJYfMum/BXNolPu1KQAeybKS+3XcKxE43PnNlF8l9pgNwH6Ts3yh1w4n98Zi2gqxoIIS7DgsHVexh1PvCiWX3NLg6sTHH7EoSxClWnIDkTuhrz+KFLeVzkF7nzzRXWN0AP/oUZa++liOJwnaQZTI35tcPK+Y8XoaMHvbtBOlBzEiynX8B+8K+E2abcQw6cw6SjBY2ONqeMPvENvCiyZcMd40r83l9XHcN34ZeDh/k7vmOCeFQULKuapMXnoqyE7FkhFu7X3rD+Nh8SUpY0UFjnNNhOmhavhP08sGuh72zKnZVVGKoOZMe7sKqKBY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772591334; c=relaxed/relaxed;
	bh=wKj0ybLQ7OTEX7VYO4UYrqVGHCViOoCZ3KGzAf4cs5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FYUAUtucWiyI5KFWl6HjGU8jVb7BgCjhDJRIBwD7MElU/11USXTIo8+JXbHVkzo931jHXxHXHsFlbcOCz2oCVLoydRr25naYz2UMtuhEuqvZ7+ELW5J61KxziSOAtN7Wl6FKOdSmLNxvDMJjB8i9vgDoYavzw1sz1rYa1kgcMyO0oPWvwTTKEbvGV1ECPkMcEIi3S1rl04kGUK1LYhoSYc7FSLvmmmBHq0qzutMRGx46sDR8csRbAuUiWWjEjySXUxTzVD1KVjGBOiAj9dJoll4FaLaqAAdI1OEJpRfYi7whOLmppWzcZ2vd0jozD7OYsjtftu7hm6fSR0e2RbE3bA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=spjB+qe8; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=spjB+qe8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQc6r4G6pz2yLH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 13:28:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 41CFF43A1B;
	Wed,  4 Mar 2026 02:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB983C116C6;
	Wed,  4 Mar 2026 02:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772591329;
	bh=w0enNDJ6vj/GjKs1g6Qapybf69Y+ysKOpkctiG5RrpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=spjB+qe83UoElqhhSNfGwtYNBZK6rgflA8nN48IzNFPIWPeUr3QRcXVdCtF1NJKnf
	 z5EksqVKhftC9MLC9j/7nGeIaaTR87yGm5Rwd8MxIRtsUMKdsilMMJ3Cd9iakxj8Bd
	 EH9ATACpJVqsf4PLZG7kLZaviIgPJnXRNiYRro7z9N/ZFYixQx9IlT7mTSxw717b7C
	 FtZrlDgcd81FIPR+0JhvBn0boDgv6oQAtRyqPocimgjFVPbqTR/7W2RrWO0jyc8Sw9
	 QZEusDhvc5/gFZA6KC6+NigNLVm6yl1rbhBl2iBivGRlsjsn6q5oZHNnRRI6Qq4pAT
	 NJF9zxNmgNh2w==
Date: Tue, 3 Mar 2026 18:28:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller"
 <davem@davemloft.net>, "Michael S. Tsirkin" <mst@redhat.com>, "Theodore
 Ts'o" <tytso@mit.edu>, Albert Ou <aou@eecs.berkeley.edu>, Alexander Duyck
 <alexanderduyck@fb.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Alexandra Winter
 <wintera@linux.ibm.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Anna Schumaker <anna@kernel.org>, Anton
 Yakovlev <anton.yakovlev@opensynergy.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Aswin Karuvally <aswin@linux.ibm.com>, Borislav Petkov
 <bp@alien8.de>, Carlos Maiolino <cem@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Chao Yu <chao@kernel.org>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Christian Brauner <brauner@kernel.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>, Dominique
 Martinet <asmadeus@codewreck.org>, Dongsheng Yang
 <dongsheng.yang@linux.dev>, Eric Dumazet <edumazet@google.com>, Eric Van
 Hensbergen <ericvh@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@redhat.com>, Jaegeuk
 Kim <jaegeuk@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Janosch Frank <frankja@linux.ibm.com>, Jaroslav Kysela <perex@perex.cz>,
 Jens Axboe <axboe@kernel.dk>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Latchesar Ionkov <lucho@ionkov.net>,
 Linus Walleij <linusw@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Mark Brown <broonie@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Miklos Szeredi <miklos@szeredi.hu>, Namhyung Kim
 <namhyung@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paolo Abeni
 <pabeni@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley
 <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Sean Christopherson <seanjc@google.com>, Simona
 Vetter <simona@ffwll.ch>, Takashi Iwai <tiwai@suse.com>, Thomas Gleixner
 <tglx@kernel.org>, Trond Myklebust <trondmy@kernel.org>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon
 <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, Zheng Gu
 <cengku@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
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
Subject: Re: [PATCH 0/8] mm: globalize rest_of_page() macro
Message-ID: <20260303182845.250bb2de@kernel.org>
In-Reply-To: <20260304012717.201797-1-ynorov@nvidia.com>
References: <20260304012717.201797-1-ynorov@nvidia.com>
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
Content-Transfer-Encoding: 7bit

On Tue,  3 Mar 2026 20:27:08 -0500 Yury Norov wrote:
> The net/9p networking driver has a handy macro to calculate the
> amount of bytes from a given pointer to the end of page. Move it
> to core/mm, and apply tree-wide. No functional changes intended.
> 
> This series was originally introduced as a single patch #07/12 in:
> 
> https://lore.kernel.org/all/20260219181407.290201-1-ynorov@nvidia.com/
> 
> Split it for better granularity and submit separately.

I don't get what the motivation is here. Another helper developers
and readers of the code will need to know about just to replace 
obvious and easy to comprehend math.

