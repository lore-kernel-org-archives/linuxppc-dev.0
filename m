Return-Path: <SRS0=fll7=U7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08020C06510
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jul 2019 15:21:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCEFC21721
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jul 2019 15:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCEFC21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45dSdW0szGzDqY0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jul 2019 01:21:51 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45dSZw1jzvzDqSw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2019 01:19:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45dSZt5p83z9sNC;
 Wed,  3 Jul 2019 01:19:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Leonardo Bras <leonardo@linux.ibm.com>
Subject: Re: [RFC PATCH] Replaces long number representation by BIT() macro
In-Reply-To: <20190613180227.29558-1-leonardo@linux.ibm.com>
References: <20190613180227.29558-1-leonardo@linux.ibm.com>
Date: Wed, 03 Jul 2019 01:19:34 +1000
Message-ID: <87imskihvd.fsf@concordia.ellerman.id.au>
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
Cc: Leonardo Bras <leonardo@linux.ibm.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Leonardo,

Leonardo Bras <leonardo@linux.ibm.com> writes:
> The main reason of this change is to make these bitmasks more readable.
>
> The macro ASM_CONST() just appends an UL to it's parameter, so it can be
> easily replaced by BIT_MASK, that already uses a UL representation.
>
> ASM_CONST() in this file may behave different if __ASSEMBLY__ is defined,
> as it is used on .S files, just leaving the parameter as is.

Thanks for the patch, but I don't consider this an improvement in
readability.

At boot we print the firmware features, eg:

  firmware_features = 0x00000001c45ffc5f

And it's much easier to match that up to the full constants, than to the
bit numbers.

Similarly in memory or register dumps.

What we could do is switch to the `UL` macro from include/linux/const.h,
rather than using our own ASM_CONST.

cheers

> diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
> index 00bc42d95679..7a5b0cc0bc85 100644
> --- a/arch/powerpc/include/asm/firmware.h
> +++ b/arch/powerpc/include/asm/firmware.h
> @@ -14,46 +14,45 @@
>  
>  #ifdef __KERNEL__
>  
> -#include <asm/asm-const.h>
> -
> +#include <linux/bits.h>
>  /* firmware feature bitmask values */
>  
> -#define FW_FEATURE_PFT		ASM_CONST(0x0000000000000001)
> -#define FW_FEATURE_TCE		ASM_CONST(0x0000000000000002)
> -#define FW_FEATURE_SPRG0	ASM_CONST(0x0000000000000004)
> -#define FW_FEATURE_DABR		ASM_CONST(0x0000000000000008)
> -#define FW_FEATURE_COPY		ASM_CONST(0x0000000000000010)
> -#define FW_FEATURE_ASR		ASM_CONST(0x0000000000000020)
> -#define FW_FEATURE_DEBUG	ASM_CONST(0x0000000000000040)
> -#define FW_FEATURE_TERM		ASM_CONST(0x0000000000000080)
> -#define FW_FEATURE_PERF		ASM_CONST(0x0000000000000100)
> -#define FW_FEATURE_DUMP		ASM_CONST(0x0000000000000200)
> -#define FW_FEATURE_INTERRUPT	ASM_CONST(0x0000000000000400)
> -#define FW_FEATURE_MIGRATE	ASM_CONST(0x0000000000000800)
> -#define FW_FEATURE_PERFMON	ASM_CONST(0x0000000000001000)
> -#define FW_FEATURE_CRQ		ASM_CONST(0x0000000000002000)
> -#define FW_FEATURE_VIO		ASM_CONST(0x0000000000004000)
> -#define FW_FEATURE_RDMA		ASM_CONST(0x0000000000008000)
> -#define FW_FEATURE_LLAN		ASM_CONST(0x0000000000010000)
> -#define FW_FEATURE_BULK_REMOVE	ASM_CONST(0x0000000000020000)
> -#define FW_FEATURE_XDABR	ASM_CONST(0x0000000000040000)
> -#define FW_FEATURE_MULTITCE	ASM_CONST(0x0000000000080000)
> -#define FW_FEATURE_SPLPAR	ASM_CONST(0x0000000000100000)
> -#define FW_FEATURE_LPAR		ASM_CONST(0x0000000000400000)
> -#define FW_FEATURE_PS3_LV1	ASM_CONST(0x0000000000800000)
> -#define FW_FEATURE_HPT_RESIZE	ASM_CONST(0x0000000001000000)
> -#define FW_FEATURE_CMO		ASM_CONST(0x0000000002000000)
> -#define FW_FEATURE_VPHN		ASM_CONST(0x0000000004000000)
> -#define FW_FEATURE_XCMO		ASM_CONST(0x0000000008000000)
> -#define FW_FEATURE_OPAL		ASM_CONST(0x0000000010000000)
> -#define FW_FEATURE_SET_MODE	ASM_CONST(0x0000000040000000)
> -#define FW_FEATURE_BEST_ENERGY	ASM_CONST(0x0000000080000000)
> -#define FW_FEATURE_TYPE1_AFFINITY ASM_CONST(0x0000000100000000)
> -#define FW_FEATURE_PRRN		ASM_CONST(0x0000000200000000)
> -#define FW_FEATURE_DRMEM_V2	ASM_CONST(0x0000000400000000)
> -#define FW_FEATURE_DRC_INFO	ASM_CONST(0x0000000800000000)
> -#define FW_FEATURE_BLOCK_REMOVE ASM_CONST(0x0000001000000000)
> -#define FW_FEATURE_PAPR_SCM 	ASM_CONST(0x0000002000000000)
> +#define FW_FEATURE_PFT		BIT(0)
> +#define FW_FEATURE_TCE		BIT(1)
> +#define FW_FEATURE_SPRG0		BIT(2)
> +#define FW_FEATURE_DABR		BIT(3)
> +#define FW_FEATURE_COPY		BIT(4)
> +#define FW_FEATURE_ASR		BIT(5)
> +#define FW_FEATURE_DEBUG		BIT(6)
> +#define FW_FEATURE_TERM		BIT(7)
> +#define FW_FEATURE_PERF		BIT(8)
> +#define FW_FEATURE_DUMP		BIT(9)
> +#define FW_FEATURE_INTERRUPT	BIT(10)
> +#define FW_FEATURE_MIGRATE	BIT(11)
> +#define FW_FEATURE_PERFMON	BIT(12)
> +#define FW_FEATURE_CRQ		BIT(13)
> +#define FW_FEATURE_VIO		BIT(14)
> +#define FW_FEATURE_RDMA		BIT(15)
> +#define FW_FEATURE_LLAN		BIT(16)
> +#define FW_FEATURE_BULK_REMOVE	BIT(17)
> +#define FW_FEATURE_XDABR		BIT(18)
> +#define FW_FEATURE_MULTITCE	BIT(19)
> +#define FW_FEATURE_SPLPAR	BIT(20)
> +#define FW_FEATURE_LPAR		BIT(22)
> +#define FW_FEATURE_PS3_LV1	BIT(23)
> +#define FW_FEATURE_HPT_RESIZE	BIT(24)
> +#define FW_FEATURE_CMO		BIT(25)
> +#define FW_FEATURE_VPHN		BIT(26)
> +#define FW_FEATURE_XCMO		BIT(27)
> +#define FW_FEATURE_OPAL		BIT(28)
> +#define FW_FEATURE_SET_MODE	BIT(30)
> +#define FW_FEATURE_BEST_ENERGY	BIT(31)
> +#define FW_FEATURE_TYPE1_AFFINITY BIT(32)
> +#define FW_FEATURE_PRRN		BIT(33)
> +#define FW_FEATURE_DRMEM_V2	BIT(34)
> +#define FW_FEATURE_DRC_INFO	BIT(35)
> +#define FW_FEATURE_BLOCK_REMOVE	BIT(36)
> +#define FW_FEATURE_PAPR_SCM	BIT(37)
>  
>  #ifndef __ASSEMBLY__
>  
> -- 
> 2.17.1
