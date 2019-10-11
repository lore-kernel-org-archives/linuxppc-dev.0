Return-Path: <SRS0=Lxno=YE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D47C47404
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Oct 2019 08:24:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0925021D71
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Oct 2019 08:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0925021D71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46qLbQ4yZHzDqZj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Oct 2019 19:24:34 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46qLXX3jdKzDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2019 19:22:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 46qLXW1hmQz9sP4; Fri, 11 Oct 2019 19:22:03 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 18217da36103c25d87870624dfa569e6b9906a90
In-Reply-To: <20190930101342.36c1afa0@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: linux-next: build failure after merge of the powerpc tree
Message-Id: <46qLXW1hmQz9sP4@ozlabs.org>
Date: Fri, 11 Oct 2019 19:22:03 +1100 (AEDT)
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-09-30 at 00:13:42 UTC, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the powerpc tree, today's linux-next build (powerpc64
> allnoconfig) failed like this:
> 
> arch/powerpc/mm/book3s64/pgtable.c: In function 'flush_partition':
> arch/powerpc/mm/book3s64/pgtable.c:216:3: error: implicit declaration of fu=
> nction 'radix__flush_all_lpid_guest'; did you mean 'radix__flush_all_lpid'?=
>  [-Werror=3Dimplicit-function-declaration]
>   216 |   radix__flush_all_lpid_guest(lpid);
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |   radix__flush_all_lpid
> 
> Caused by commit
> 
>   99161de3a283 ("powerpc/64s/radix: tidy up TLB flushing code")
> 
> radix__flush_all_lpid_guest() is only declared for CONFIG_PPC_RADIX_MMU
> which is not set for this build.
> 
> I am not sure why this did not show up earlier (maybe a Kconfig
> change?).
> 
> I added the following hack for today.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 30 Sep 2019 10:09:17 +1000
> Subject: [PATCH] powerpc/64s/radix: fix for "tidy up TLB flushing code" and
>  !CONFIG_PPC_RADIX_MMU
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Reapplied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/18217da36103c25d87870624dfa569e6b9906a90

cheers
