Return-Path: <SRS0=IyNZ=UL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56445C31E46
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Jun 2019 05:01:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A9C20866
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Jun 2019 05:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A9C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Nvpb4kPhzDqxd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Jun 2019 15:01:11 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45NvmG3nVlzDqsv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2019 14:59:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45NvmG0rjTz9s9y; Wed, 12 Jun 2019 14:59:10 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6c284228eb356a1ec62a704b4d2329711831eaed
X-Patchwork-Hint: ignore
In-Reply-To: <56efc3b317622d5f607d1f7a35894b194c385492.1559549824.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Aaro Koskinen <aaro.koskinen@iki.fi>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v3] powerpc: fix kexec failure on book3s/32
Message-Id: <45NvmG0rjTz9s9y@ozlabs.org>
Date: Wed, 12 Jun 2019 14:59:10 +1000 (AEST)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-06-03 at 08:20:28 UTC, Christophe Leroy wrote:
> In the old days, _PAGE_EXEC didn't exist on 6xx aka book3s/32.
> Therefore, allthough __mapin_ram_chunk() was already mapping kernel
> text with PAGE_KERNEL_TEXT and the rest with PAGE_KERNEL, the entire
> memory was executable. Part of the memory (first 512kbytes) was
> mapped with BATs instead of page table, but it was also entirely
> mapped as executable.
> 
> In commit 385e89d5b20f ("powerpc/mm: add exec protection on
> powerpc 603"), we started adding exec protection to some 6xx, namely
> the 603, for pages mapped via pagetables.
> 
> Then, in commit 63b2bc619565 ("powerpc/mm/32s: Use BATs for
> STRICT_KERNEL_RWX"), the exec protection was extended to BAT mapped
> memory, so that really only the kernel text could be executed.
> 
> The problem here is that kexec is based on copying some code into
> upper part of memory then executing it from there in order to install
> a fresh new kernel at its definitive location.
> 
> However, the code is position independant and first part of it is
> just there to deactivate the MMU and jump to the second part. So it
> is possible to run this first part inplace instead of running the
> copy. Once the MMU is off, there is no protection anymore and the
> second part of the code will just run as before.
> 
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Fixes: 63b2bc619565 ("powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/6c284228eb356a1ec62a704b4d232971

cheers
