Return-Path: <linuxppc-dev+bounces-23791-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F30C43602
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 08:39:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwBNf1W18z2yft;
	Wed, 08 Jul 2026 18:39:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:e0a:1040:9780:49:5ff:fe41:d261"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783499986;
	cv=none; b=PrMO5hFrxM+CQR+9xaaIOMhGSx73sq4HSIEkP81VPjT+M4lo7xHcKqnc+B7Bt5hAM7ZTcmHr0PfA5JHvlQCtiSNz8HORsbuiEXqft7MNAUwk+aIEBms/Ey+F1sUNR4DSNa5CBVh+l10oE/FYWcy5aoZPkuWREB6BpA68uxWOCAIq6KPLhgLgEntAbRhMGJsFf8c7Sgb+vN42EEV7TmDuBeC034O5Q9sqJ9Kmt9LXG3kSjIdkMjX8O/Kdr9wPS2NkHRJZZVbpgUCPydXw6EIqtAY3e2YjpCy/XIb3ST5X8iXhop5mktWXKtYYbvstPHRJvLamqwBIWnDd9ayIyyn9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783499986; c=relaxed/relaxed;
	bh=NjCUTuFomBVUuq9/OZodLnAqyRve3CRmHwkhVcUbqIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSZF07QIO6tcDkKJTZmFwOcPbqRS4fleuFAER7HvPIJV4U2gj6XKPcgPkwHBot1sZCjD0Jjc6pcimvGQEU2cIZuXoOXeZO/woOKvTpOdkDZRWG7eZcVyBtdpDW4J+rHN47zA19MtFMZBaeUs+jx4PMdz1veFYeKBQbJ4Mtm8cyevTCJaQaSTNBnZxZAe0/g/BscG82GwUfTGnhP8fQFwbinCGOVm4HhcTlRsXYGWCArY6WCIq8vllPLMFwqYKzbA6aCPa5D+FU8kNmiib7fD7Vgg0OMLmrXl2kMYOa9UhXmODDXkuTF6dhJsElGdJEoz3z+tOyRJxY0N97gLBYLogA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=2a01:e0a:1040:9780:49:5ff:fe41:d261; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=2a01:e0a:1040:9780:49:5ff:fe41:d261; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from luna.linkmauve.fr (unknown [IPv6:2a01:e0a:1040:9780:49:5ff:fe41:d261])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwBNZ47wHz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 18:39:42 +1000 (AEST)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 955D3F40CC8; Wed, 08 Jul 2026 10:39:30 +0200 (CEST)
Date: Wed, 8 Jul 2026 10:39:30 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
	jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org,
	ardb@kernel.org, ojeda@kernel.org, boqun@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
	daniel.almeida@collabora.com, tamird@kernel.org,
	acourbot@nvidia.com, work@onurozkan.dev, nathan@kernel.org,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	fujita.tomonori@gmail.com, joelagnelf@nvidia.com,
	gregkh@linuxfoundation.org, prafulrai522@gmail.com, nsc@kernel.org,
	japo@linux.ibm.com, lina+kernel@asahilina.net, j@jannau.net,
	airlied@gmail.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH V17 4/7] rust/powerpc: Set min rustc version for powerpc
Message-ID: <ak4MwnDwIgdUhK3K@luna>
References: <20260708082454.1254320-1-mkchauras@gmail.com>
 <20260708082454.1254320-5-mkchauras@gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260708082454.1254320-5-mkchauras@gmail.com>
Jabber-ID: linkmauve@linkmauve.fr

Hi,

On Wed, Jul 08, 2026 at 01:54:51PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> Minimum `rustc` version required for powerpc is 1.95 as some critical
> features required for compiling rust code for kernel are not there.
> 
> For example Stable inline asm support which got merged in 1.95.

Didn’t we decide on 1.85.0 with the asm_experimental_arch feature
instead?  And possibly on 64-bit 1.87.0 if it isn’t possible to disable
altivec correctly there?

> 
> Link: https://github.com/rust-lang/rust/pull/147996
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
>  scripts/min-tool-version.sh | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> index 031f2192b390..99bfdcaa3396 100755
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -33,6 +33,8 @@ llvm)
>  rustc)
>  	if [ "$SRCARCH" = "s390" ]; then
>  		echo 1.96.0
> +	elif [ "$ARCH" = powerpc ]; then
> +		echo 1.95.0
>  	else
>  		echo 1.85.0
>  	fi
> -- 
> 2.55.0
> 
> 

-- 
Link Mauve

