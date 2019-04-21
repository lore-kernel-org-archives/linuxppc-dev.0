Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A837EC10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:32:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5643920859
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5643920859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nBy15sXCzDqNg
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 00:32:41 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBdv3sVKzDqMH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:18:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBdv28Ckz9s9h; Mon, 22 Apr 2019 00:18:42 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: bff25143da0d623a1765bf78dbc82044e46da5a4
X-Patchwork-Hint: ignore
In-Reply-To: <20190307144031.52494-1-cai@lca.pw>
To: Qian Cai <cai@lca.pw>, benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2] powerpc: silence unused-but-set-variable warnings
Message-Id: <44nBdv28Ckz9s9h@ozlabs.org>
Date: Mon, 22 Apr 2019 00:18:42 +1000 (AEST)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, Qian Cai <cai@lca.pw>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-03-07 at 14:40:31 UTC, Qian Cai wrote:
> pte_unmap() compiles away on some powerpc platforms, so silence the
> warnings below by making it a static inline function.
> 
> mm/memory.c: In function 'copy_pte_range':
> mm/memory.c:820:24: warning: variable 'orig_dst_pte' set but not used
> [-Wunused-but-set-variable]
> mm/memory.c:820:9: warning: variable 'orig_src_pte' set but not used
> [-Wunused-but-set-variable]
> mm/madvise.c: In function 'madvise_free_pte_range':
> mm/madvise.c:318:9: warning: variable 'orig_pte' set but not used
> [-Wunused-but-set-variable]
> mm/swap_state.c: In function 'swap_ra_info':
> mm/swap_state.c:634:15: warning: variable 'orig_pte' set but not used
> [-Wunused-but-set-variable]
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Qian Cai <cai@lca.pw>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bff25143da0d623a1765bf78dbc82044

cheers
