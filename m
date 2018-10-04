Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C573AC64EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 06:22:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ABA221470
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 06:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABA221470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QjVk6nkkzF3Bc
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 16:22:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QjK76ckBzF37S
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 16:14:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42QjK73m02z9s8J; Thu,  4 Oct 2018 16:14:35 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 803d690e68f0c5230183f1a42c7d50a41d16e380
In-Reply-To: <fa22576baa70fd0cdf8b3f5af3767116a1c680e7.1534164087.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/mm: Don't report hugepage tables as memory leaks when
 using kmemleak
Message-Id: <42QjK73m02z9s8J@ozlabs.org>
Date: Thu,  4 Oct 2018 16:14:35 +1000 (AEST)
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

On Mon, 2018-08-13 at 13:19:52 UTC, Christophe Leroy wrote:
> When a process allocates a hugepage, the following leak is
> reported by kmemleak. This is a false positive which is
> due to the pointer to the table being stored in the PGD
> as physical memory address and not virtual memory pointer.
> 
> unreferenced object 0xc30f8200 (size 512):
>   comm "mmap", pid 374, jiffies 4872494 (age 627.630s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<e32b68da>] huge_pte_alloc+0xdc/0x1f8
>     [<9e0df1e1>] hugetlb_fault+0x560/0x8f8
>     [<7938ec6c>] follow_hugetlb_page+0x14c/0x44c
>     [<afbdb405>] __get_user_pages+0x1c4/0x3dc
>     [<b8fd7cd9>] __mm_populate+0xac/0x140
>     [<3215421e>] vm_mmap_pgoff+0xb4/0xb8
>     [<c148db69>] ksys_mmap_pgoff+0xcc/0x1fc
>     [<4fcd760f>] ret_from_syscall+0x0/0x38
> 
> See commit a984506c542e2 ("powerpc/mm: Don't report PUDs as
> memory leaks when using kmemleak") for detailed explanation.
> 
> To fix that, this patch tells kmemleak to ignore the allocated
> hugepage table.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/803d690e68f0c5230183f1a42c7d50

cheers
