Return-Path: <SRS0=Olcr=NC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2CDC67863
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 09:54:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6454D20779
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 09:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6454D20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42dsM454npzDrhS
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 20:54:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42dryD3c13zDrbW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 20:36:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42dryD2q6fz9sDC; Mon, 22 Oct 2018 20:36:52 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b851ba02a6f3075f0f99c60c4bc30a4af80cf428
In-Reply-To: <20180829115656.9878-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [RFC] powerpc/64/module: REL32 relocation range check
Message-Id: <42dryD2q6fz9sDC@ozlabs.org>
Date: Mon, 22 Oct 2018 20:36:51 +1100 (AEDT)
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
Cc: Nicholas Piggin <npiggin@gmail.com>, Alan Modra <amodra@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-08-29 at 11:56:56 UTC, Nicholas Piggin wrote:
> The recent module relocation overflow crash demonstrated that we
> have no range checking on REL32 relative relocations. This patch
> implements a basic check, the same kernel that previously oopsed
> and rebooted now continues with some of these errors when loading
> the module:
> 
>     module_64: x_tables: REL32 527703503449812 out of range!
> 
> Question is whether other relocations (ADDR32, REL16, TOC16, etc.)
> should also have overflow checks.
> ---
>  arch/powerpc/kernel/module_64.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
> index a2636c250b7b..2a2fb656d23b 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -678,7 +678,14 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
>  
>  		case R_PPC64_REL32:
>  			/* 32 bits relative (used by relative exception tables) */
> -			*(u32 *)location = value - (unsigned long)location;
> +			/* Convert value to relative */
> +			value -= (unsigned long)location;
> +			if (value + 0x80000000 > 0xffffffff) {
> +				pr_err("%s: REL32 %li out of range!\n",
> +				       me->name, (long int)value);
> +				return -ENOEXEC;
> +			}
> +			*(u32 *)location = value;
>  			break;
>  
>  		case R_PPC64_TOCSAVE:

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b851ba02a6f3075f0f99c60c4bc30a

cheers
