Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F6EC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 12:04:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A82620875
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 12:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A82620875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RT2S1ywSzF3Sc
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 22:04:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RT0P72lgzF3RF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 22:02:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42RT0P4DZbz9s4s;
 Fri,  5 Oct 2018 22:02:45 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: build failure after merge of the akpm tree
In-Reply-To: <20181005161406.73ef8727@canb.auug.org.au>
References: <20181005161406.73ef8727@canb.auug.org.au>
Date: Fri, 05 Oct 2018 22:02:45 +1000
Message-ID: <87d0sok3dm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi Andrew,
>
> After merging the akpm tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
> arch/powerpc/kernel/setup-common.c:36:10: fatal error: linux/bootmem.h: No such file or directory
>  #include <linux/bootmem.h>
>           ^~~~~~~~~~~~~~~~~
>
> Caused by commit
>
>   49353a51a758 ("mm: remove include/linux/bootmem.h")
>
> interacting with commit
>
>   d90fe2acd9b2 ("powerpc: Wire up memtest")
>
> from the powerpc tree.

Ah fudge, what are the chances we add a new include of bootmem.h just as
Mike's removing bootmem.

> I applied the following patch for today:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 5 Oct 2018 16:09:34 +1000
> Subject: [PATCH] powerpc: fix up for removal of linux/bootmem.h
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/kernel/setup-common.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 2b56d1f30387..93ee3703b42f 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -33,7 +33,6 @@
>  #include <linux/serial_8250.h>
>  #include <linux/percpu.h>
>  #include <linux/memblock.h>
> -#include <linux/bootmem.h>
>  #include <linux/of_platform.h>
>  #include <linux/hugetlb.h>
>  #include <asm/debugfs.h>

I could just apply that to my tree. memblock.h is where early_memtest() is
actually defined anyway.

cheers
