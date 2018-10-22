Return-Path: <SRS0=Olcr=NC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB02C004D3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 10:12:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4925B20658
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 10:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4925B20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42dsls127GzF35y
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 21:12:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ds1j3C8VzDrTy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 20:39:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42ds1j1xLvz9sD3; Mon, 22 Oct 2018 20:39:53 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42ds1j1lVQz9sDC; Mon, 22 Oct 2018 20:39:53 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 5c6499b7041b43807dfaeda28aa87fc0e62558f7
In-Reply-To: <20181019041334.4945-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/6] powerpc/mm/radix: Fix off-by-one in split mapping logic
Message-Id: <42ds1j1lVQz9sDC@ozlabs.org>
Date: Mon, 22 Oct 2018 20:39:52 +1100 (AEDT)
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
Cc: aneesh.kumar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2018-10-19 at 04:13:29 UTC, Michael Ellerman wrote:
> When we have CONFIG_STRICT_KERNEL_RWX enabled, we try to split the
> kernel linear (1:1) mapping so that the kernel text is in a separate
> page to kernel data, so we can mark the former read-only.
> 
> We could achieve that just by always using 64K pages for the linear
> mapping, but we try to be smarter. Instead we use huge pages when
> possible, and only switch to smaller pages when necessary.
> 
> However we have an off-by-one bug in that logic, which causes us to
> calculate the wrong boundary between text and data.
> 
> For example with the end of the kernel text at 16M we see:
> 
>   radix-mmu: Mapped 0x0000000000000000-0x0000000001200000 with 64.0 KiB pages
>   radix-mmu: Mapped 0x0000000001200000-0x0000000040000000 with 2.00 MiB pages
>   radix-mmu: Mapped 0x0000000040000000-0x0000000100000000 with 1.00 GiB pages
> 
> ie. we mapped from 0 to 18M with 64K pages, even though the boundary
> between text and data is at 16M.
> 
> With the fix we see we're correctly hitting the 16M boundary:
> 
>   radix-mmu: Mapped 0x0000000000000000-0x0000000001000000 with 64.0 KiB pages
>   radix-mmu: Mapped 0x0000000001000000-0x0000000040000000 with 2.00 MiB pages
>   radix-mmu: Mapped 0x0000000040000000-0x0000000100000000 with 1.00 GiB pages
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/5c6499b7041b43807dfaeda28aa87f

cheers
