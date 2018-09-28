Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9724C43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 03:43:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE8C215E4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 03:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE8C215E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42LyF45Q4DzF3BM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 13:43:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LyC13SjSzF399
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 13:41:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42LyC067Tvz9s3Z;
 Fri, 28 Sep 2018 13:41:16 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: wire up memtest
In-Reply-To: <b3f2074b89ef0e3352fb11b69be30caeaa823fa0.1535360497.git.christophe.leroy@c-s.fr>
References: <b3f2074b89ef0e3352fb11b69be30caeaa823fa0.1535360497.git.christophe.leroy@c-s.fr>
Date: Fri, 28 Sep 2018 13:41:13 +1000
Message-ID: <871s9euw4m.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Add call to early_memtest() so that kernel compiled with
> CONFIG_MEMTEST really perform memtest at startup when requested
> via 'memtest' boot parameter.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/setup-common.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 93fa0c99681e..904b728eb20d 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -33,6 +33,7 @@
>  #include <linux/serial_8250.h>
>  #include <linux/percpu.h>
>  #include <linux/memblock.h>
> +#include <linux/bootmem.h>
>  #include <linux/of_platform.h>
>  #include <linux/hugetlb.h>
>  #include <asm/debugfs.h>
> @@ -917,6 +918,8 @@ void __init setup_arch(char **cmdline_p)
>  	/* Parse memory topology */
>  	mem_topology_setup();
>  
> +	early_memtest(min_low_pfn << PAGE_SHIFT, max_low_pfn << PAGE_SHIFT);

On a ppc64le VM this boils down to early_memtest(0, 0) for me.

I think it's too early, we don't set up max_low_pfn until
initmem_init().

If I move it after initmem_init() then it does something more useful:

early_memtest: # of tests: 17
  0x0000000001450580 - 0x0000000001450800 pattern 4c494e5558726c7a
  0x0000000001450c00 - 0x0000000003600000 pattern 4c494e5558726c7a
  0x00000000047c0000 - 0x000000002fff0000 pattern 4c494e5558726c7a
  0x0000000030000000 - 0x000000003ff24000 pattern 4c494e5558726c7a
  0x000000003fff4000 - 0x000000003fff4c00 pattern 4c494e5558726c7a
  0x000000003fff5000 - 0x000000003fff5300 pattern 4c494e5558726c7a
  0x000000003fff5c00 - 0x000000003fff5f00 pattern 4c494e5558726c7a
  0x000000003fff6800 - 0x000000003fff6b00 pattern 4c494e5558726c7a
  0x000000003fff7400 - 0x000000003fff7700 pattern 4c494e5558726c7a
  0x000000003fff8000 - 0x000000003fff8300 pattern 4c494e5558726c7a
  0x000000003fff8c00 - 0x000000003fff8f00 pattern 4c494e5558726c7a
  0x000000003fff9800 - 0x000000003fff9b00 pattern 4c494e5558726c7a
  0x000000003fffa400 - 0x000000003fffa700 pattern 4c494e5558726c7a
  0x000000003fffb000 - 0x000000003fffb300 pattern 4c494e5558726c7a
  0x000000003fffbc00 - 0x000000003fffbf00 pattern 4c494e5558726c7a
  0x000000003fffc800 - 0x000000003fffcb00 pattern 4c494e5558726c7a
  0x000000003fffd400 - 0x000000003fffd700 pattern 4c494e5558726c7a
  0x000000003fffe000 - 0x000000003fffe100 pattern 4c494e5558726c7a
  0x0000000040000000 - 0x00000000ffc10000 pattern 4c494e5558726c7a
  0x00000000fffa0000 - 0x00000000fffa5b00 pattern 4c494e5558726c7a
  0x0000000100000000 - 0x00000001ffbe0000 pattern 4c494e5558726c7a
  0x00000001fff60000 - 0x00000001fff61b00 pattern 4c494e5558726c7a
  0x00000001fffec000 - 0x00000001fffec4b8 pattern 4c494e5558726c7a
  0x00000001fffec524 - 0x00000001fffec528 pattern 4c494e5558726c7a


cheers
