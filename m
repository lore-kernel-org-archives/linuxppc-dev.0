Return-Path: <linuxppc-dev+bounces-28368-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E21C98328
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 05:53:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htVqB1Y0jz2y1Y;
	Mon, 28 Sep 2026 15:53:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790574822;
	cv=none; b=np2HA0ThJdfqngjddEJ/jAq+HMpwMGSRNgGcYc8N2PcUZK3A6lSILHqYkL6AmCIwQpficH3mdVCWoa3GQiMnngZcn4ghGQj9LsF011nnqPTrYFWIVOmrJ5WvH/pS59LyStgp18idoSq3uxZm57TV77WbqO4hgBp878Q66rGZJEfAParetHF5TnrrENqs80AfxjVLN0r+SgteJb918TyqHGNG7X3uewT6S8KNDqGxTcQPCpgpRHyqoiTx6peO4ch6Yn3DzWIzjP3T8feXsLlFNvsfPrLc0m6m8ci4gn2KlyvNg57Q+nTBY7FvNXyEv/UbzpmiwAk2GDWWOgBVFf2UCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790574822; c=relaxed/relaxed;
	bh=oiaWAk2ChzwSv+/OHxCIuOjma1tWl+GAlbfyo47VIHo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=i/xZI2/6HByQMn22pctwpaRVRS/gOoXInVpNum81CAwRb7L++2rXpCq0eyUQgzHRRCTPxlk4vZhOC1n5zMw+lc8cGwNLRUMMeAABSirgGdy1VpkIZqeJb71a6kqo3VnM1JOcpHe72C5ZFp/luTCHkSyuhUs1frsb4hqqYfhRiMZD99yRJ3LZRWuEWZbz7tnyFJBRIJcF8kpMJzJyYG1qSQLgqBRQ6WuN3eY/yvW6B53VuSUyk18scZsCY3CtBF9kPdPV7oSqpEarZJHLpXWKG86rnw/ePN4dPC4S3KintJClezffxGkImAOdx3yxvfICmnG8LV1zzFzmRKMcHRf6EA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YFgQYIvq; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YFgQYIvq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htVq92P4zz30Wg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 15:53:41 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0974C600E2;
	Mon, 28 Sep 2026 05:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAF61F000FF;
	Mon, 28 Sep 2026 05:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574817;
	bh=oiaWAk2ChzwSv+/OHxCIuOjma1tWl+GAlbfyo47VIHo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YFgQYIvqNH5Y0lPP6y/Ba0aWrLpu4gI1vjh21V1qIY8jRvSF5FUge7FelPatbAqI7
	 b1p1msKmXEEjeb17CELxSOGRjThjBWR94m8KCKCve9VokhW2tybgoTFIzwMIR6UUxk
	 9Xdai2nE/ZG9SDF2NVAuHOXsfpFMH55VJqMoIMkNnMxj7Gv+2ag9WrgjsElI036QyZ
	 fdrYSCtx9iLkD+Aj1GuilZUGtBmJ54h7pSZ1EMMO4Xbc9t9uQFf07SBZ1mKUHQInY/
	 pB238vuX+owGxxE+m2FWdGn4DpY5zDSMjnyizHPIMhu7fWaGHjiB24ZUhSgafx3owT
	 5XqswYVPyXLfQ==
Content-Type: multipart/mixed; boundary="===============1210779320454498450=="
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
Message-Id: <5c4f07d70efb357deef9f256e98298c9ef861831e3ffcfa4bd42fbd9b4b31a5a@mail.kernel.org>
In-Reply-To: <a8257022057cbb71928c960be589e10b89fc0899.1789982239.git.skb99@linux.ibm.com>
References: <a8257022057cbb71928c960be589e10b89fc0899.1789982239.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v14 4/5] powerpc/bpf: fix alignment of long branch trampoline address
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 28 Sep 2026 05:53:36 +0000 (UTC)

--===============1210779320454498450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 6ef500644d23a07941d6ec45def92b9391c03a10
> Author: Abhishek Dubey <adubey@linux.ibm.com>
> Date:   Mon Sep 28 10:43:53 2026 +0530
>
>     powerpc/bpf: fix alignment of long branch trampoline address
>
>     Ensure the dummy trampoline address field present between the OOL stub
>     and the long branch stub is 4/8-byte aligned, for memory compatibility
>     when content loaded to a register.
>
>     Reported-by: Hari Bathini <hbathini@linux.ibm.com>
>     Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
>     Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
>     Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
>     Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
>     Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>

This isn't a bug, but could the changelog say what fails when the slot
is only 4-byte aligned, and briefly explain why sizing with an
unconditional NOP and then conditionally dropping it in the final pass
is safe?

The load-bearing rationale seems to be missing. From the code,
bpf_jit_binary_pack_alloc() only guarantees 4-byte alignment of the
final image, so the SZL-sized slot read by the long branch stub and
rewritten by patch_ulong() from bpf_arch_text_poke() may be only 4-byte
aligned on ppc64, where an 8-byte access is then not guaranteed to be
single-copy atomic against a concurrent patch.

The non-obvious part of the fix is that the NOP is emitted
unconditionally in the sizing pass when image is NULL and conditionally
on the final fimage address in the codegen passes, so the allocated
buffer may have 4 spare bytes while jited_len reflects the actual size.

The phrase "4/8-byte aligned" also blurs that only the 64-bit case needs
the NOP since SZL is 4 on ppc32.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36381917401
--===============1210779320454498450==--

