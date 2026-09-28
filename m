Return-Path: <linuxppc-dev+bounces-28367-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C3FC9833E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 05:53:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htVq80rhvz30Vd;
	Mon, 28 Sep 2026 15:53:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790574820;
	cv=none; b=P5FhYipAKW4dr+YwI3mD8HAY1a1XcOQBAR8iQB5e0365qlqMbxW2e2WLIJPjzlGpv73y346LUl0MpKsKZylAVwc24em9TCfeKWghcsnOGJ2gn1AftivIvR5VNiSHWWUKx4A/i/aZq2KOr2pg4y5U+angG94hewiKNSu2q58hgNbLizSsR/hL64M01Y5BKmkTX5nX+7Z3VC5UfpHrhe7m0mOmlA3TuOXn9Q5ORf4++Ou38ntn+HEkxAYXx2qr7coU+15ha8Gl5Y9ohDiODxpSbbM/sTThjkaFDo1ceza0zpYFkkjfXsefWnXsAwfYAdDC+V8FPuNcXtCe/mJ9tAIsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790574820; c=relaxed/relaxed;
	bh=8OzKWCHXZOOd1DMsxhT+yj+4zopcmCme2x/Ty8HYXns=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jDjid27PtWqmbT5XZyjVnu0liNu6OckrzhQEgplFkH17MiNtLc7TT0JhMpEmwydjO9oXUYDzq/h8etznBi6xQvL6vaUejxLsYDnCqvOGlHTS/rNL2WvTFC9PZLKv96Q2B5Usxi0qCbaC7ryoHqSG6bWABkjJ93IcB9K4W4ToA3VECK8Ndt3moaxTG6DQmRi2zXIR5UG5uikuS0ah8vVB5nBL+b5Mq2K6qyEGInN5HgiGIYjS2+PMkHFDLFlbIdB0W0vzR5nGtQEsY8qfoI5TBApZ1WmzxORdm+V691JhoI0voGvBZxJxiJ0DAyU1qgNSVaRkTY8lqr8qwmJQNEb/xA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fcytknhh; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fcytknhh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htVq70zS4z2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 15:53:38 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A4F3F407D8;
	Mon, 28 Sep 2026 05:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2911F000FF;
	Mon, 28 Sep 2026 05:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574815;
	bh=8OzKWCHXZOOd1DMsxhT+yj+4zopcmCme2x/Ty8HYXns=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FcytknhhN4Cy27FqochWi4A7hgRvRB3DMBQv/DpUfSX0Y/RnYIm79IGQcH3uqQsYL
	 RV0sr8phCQY9nrs2veBd3D4sTYbta7LCnUlVx0BRUBSTKsiPS94sVArZD9pHtdD52W
	 XkYSt8DZ2gDGsKP/3OB2kTdLBprvThktHSoxmvvPuU02KecKikB1WlbP8XsWMPOu+Q
	 HP+a/ZvJAhtWj5zJqVq/EDHY0U4b5mwySQYpT68UZFTcc8nuYPY4Ea9JStD3WUymBR
	 /pc26CXy2y3n439l/LrXoHarQ2FfJkjICVZJICMpwtwefUEAxLwZ++NJQSZSWrP7pT
	 kyiHAJ3gMX6+g==
Content-Type: multipart/mixed; boundary="===============5440859186137990361=="
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
Message-Id: <7d7912c1271257cbaf2a35a1ca599dd71407ff370742ad47851cd1b136f27c03@mail.kernel.org>
In-Reply-To: <552225fc257381fb83d282b3040c6ad363246465.1789982239.git.skb99@linux.ibm.com>
References: <552225fc257381fb83d282b3040c6ad363246465.1789982239.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v14 5/5] powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 28 Sep 2026 05:53:34 +0000 (UTC)

--===============5440859186137990361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 8ca36a933c7a..c2717f0d9cdd 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c

[ ... ]

> @@ -1425,10 +1427,12 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
>  	 * 1. Update the address in the long branch stub:
>  	 * If new_addr is out of range, we will have to use the long branch stub, so patch new_addr
>  	 * here. Otherwise, revert to dummy_tramp, but only if we had patched old_addr here.
> +	 *
> +	 * dummy_tramp_addr moved to bottom of long branch stub.
>  	 */

This isn't a bug, but the comment "dummy_tramp_addr moved to bottom of
long branch stub" describes how the layout changed rather than what it
is now. Once merged, readers have nothing "before" to compare against.

The updated diagram above bpf_arch_text_poke() already shows the
.long <branch_addr>/<dummy_tramp> at the end of the long branch stub.

Could the "moved to bottom" note go into the changelog, with the comment
instead saying that dummy_tramp_addr is the last SZL bytes of the JITed
image (so it lives at bpf_func_end - SZL)?

>  	if ((new_addr && !is_offset_in_branch_range(new_addr - ip)) ||
>  	    (old_addr && !is_offset_in_branch_range(old_addr - ip)))
> -		ret = patch_ulong((void *)(bpf_func_end - bpf_jit_long_branch_stub - SZL),
> +		ret = patch_ulong((void *)(bpf_func_end - SZL), /* SZL: dummy_tramp_addr offset */
>  				  (new_addr && !is_offset_in_branch_range(new_addr - ip)) ?
>  				  (unsigned long)new_addr : (unsigned long)dummy_tramp);

The trailing comment "/* SZL: dummy_tramp_addr offset */" could also be
clearer. SZL is the size of the field, and the field sits SZL bytes
before the end of the image. The combination of the expression
bpf_func_end - SZL and the updated diagram already communicate this.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36381917401
--===============5440859186137990361==--

