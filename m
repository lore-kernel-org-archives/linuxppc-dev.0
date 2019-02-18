Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB28C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 19:27:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F34F2177E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 19:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="HVdr+8PU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F34F2177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443DQt2ygyzDqDW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 06:27:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="HVdr+8PU"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443DPD1hPtzDq74
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 06:26:07 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 443DP80q29z9v1rk;
 Mon, 18 Feb 2019 20:26:04 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=HVdr+8PU; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Ak9huYj6gqbH; Mon, 18 Feb 2019 20:26:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 443DP76sLSz9v1rj;
 Mon, 18 Feb 2019 20:26:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550517964; bh=oqYF+VQgq6CeMG9HNoNtGtYjxBFVbq3zUnM5MNh5dNY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=HVdr+8PUXpxR/phvoceFQjDZlKIlLV3OyDT8H/B7o6XG8WInLrfp2WfBECmKwf+SA
 2O2dG5WmeF9Kxh9iy7OP72wknEh2uhJJ+YY0/M0IBZoT+KPYTHqFe0KD2akA0OQLiC
 GQ2hgpzsbr7cL9NESGnOCbRioAwH+JXLHcksN/Hg=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F120F8B7DA;
 Mon, 18 Feb 2019 20:26:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ZNNFoPYs4ngz; Mon, 18 Feb 2019 20:26:03 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 659298B7D8;
 Mon, 18 Feb 2019 20:26:03 +0100 (CET)
Subject: Re: [RFC PATCH 5/5] powerpc: KASAN for 64bit Book3E
To: Daniel Axtens <dja@axtens.net>, aneesh.kumar@linux.ibm.com,
 bsingharora@gmail.com
References: <20190215000441.14323-1-dja@axtens.net>
 <20190215000441.14323-6-dja@axtens.net>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e0373aa9-5035-3d32-2422-a08e52d2a4fb@c-s.fr>
Date: Mon, 18 Feb 2019 20:26:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190215000441.14323-6-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 15/02/2019 à 01:04, Daniel Axtens a écrit :
> Wire up KASAN. Only outline instrumentation is supported.
> 
> The KASAN shadow area is mapped into vmemmap space:
> 0x8000 0400 0000 0000 to 0x8000 0600 0000 0000.
> To do this we require that vmemmap be disabled. (This is the default
> in the kernel config that QorIQ provides for the machine in their
> SDK anyway - they use flat memory.)
> 
> Only the kernel linear mapping (0xc000...) is checked. The vmalloc and
> ioremap areas (also in 0x800...) are all mapped to a zero page. As
> with the Book3S hash series, this requires overriding the memory <->
> shadow mapping.
> 
> Also, as with both previous 64-bit series, early instrumentation is not
> supported.  It would allow us to drop the check_return_arch_not_ready()
> hook in the KASAN core, but it's tricky to get it set up early enough:
> we need it setup before the first call to instrumented code like printk().
> Perhaps in the future.
> 
> Only KASAN_MINIMAL works.
> 
> Lightly tested on e6500. KVM, kexec and xmon have not been tested.
> 
> The test_kasan module fires warnings as expected, except for the
> following tests:
> 
>   - Expected/by design:
> kasan test: memcg_accounted_kmem_cache allocate memcg accounted object
> 
>   - Due to only supporting KASAN_MINIMAL:
> kasan test: kasan_stack_oob out-of-bounds on stack
> kasan test: kasan_global_oob out-of-bounds global variable
> kasan test: kasan_alloca_oob_left out-of-bounds to left on alloca
> kasan test: kasan_alloca_oob_right out-of-bounds to right on alloca
> kasan test: use_after_scope_test use-after-scope on int
> kasan test: use_after_scope_test use-after-scope on array
> 
> Thanks to those who have done the heavy lifting over the past several years:
>   - Christophe's 32 bit series: https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-February/185379.html
>   - Aneesh's Book3S hash series: https://lwn.net/Articles/655642/
>   - Balbir's Book3S radix series: https://patchwork.ozlabs.org/patch/795211/
> 
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> 
> ---
> 
> While useful if you have a book3e device, this is mostly intended
> as a warm-up exercise for reviving Aneesh's series for book3s hash.
> In particular, changes to the kasan core are going to be required
> for hash and radix as well.
> ---
>   arch/powerpc/Kconfig                         |  1 +
>   arch/powerpc/Makefile                        |  2 +
>   arch/powerpc/include/asm/kasan.h             | 77 ++++++++++++++++++--
>   arch/powerpc/include/asm/ppc_asm.h           |  7 ++
>   arch/powerpc/include/asm/string.h            |  7 +-
>   arch/powerpc/lib/mem_64.S                    |  6 +-
>   arch/powerpc/lib/memcmp_64.S                 |  5 +-
>   arch/powerpc/lib/memcpy_64.S                 |  3 +-
>   arch/powerpc/lib/string.S                    | 15 ++--
>   arch/powerpc/mm/Makefile                     |  2 +
>   arch/powerpc/mm/kasan/Makefile               |  1 +
>   arch/powerpc/mm/kasan/kasan_init_book3e_64.c | 53 ++++++++++++++
>   arch/powerpc/purgatory/Makefile              |  3 +
>   arch/powerpc/xmon/Makefile                   |  1 +
>   14 files changed, 164 insertions(+), 19 deletions(-)
>   create mode 100644 arch/powerpc/mm/kasan/kasan_init_book3e_64.c

[snip]

> diff --git a/arch/powerpc/mm/kasan/kasan_init_book3e_64.c b/arch/powerpc/mm/kasan/kasan_init_book3e_64.c
> new file mode 100644
> index 000000000000..93b9afcf1020
> --- /dev/null
> +++ b/arch/powerpc/mm/kasan/kasan_init_book3e_64.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define DISABLE_BRANCH_PROFILING
> +
> +#include <linux/kasan.h>
> +#include <linux/printk.h>
> +#include <linux/memblock.h>
> +#include <linux/sched/task.h>
> +#include <asm/pgalloc.h>
> +
> +DEFINE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
> +EXPORT_SYMBOL(powerpc_kasan_enabled_key);

Why does this symbol need to be exported ?

Christophe

