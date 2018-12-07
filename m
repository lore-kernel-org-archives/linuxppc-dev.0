Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED52C07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 13:20:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6C620700
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 13:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6C620700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BCkT3JV3zDqPZ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 00:20:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43BCRR1QKFzDrh6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 00:06:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43BCRQ6ZqDz9s55; Sat,  8 Dec 2018 00:06:58 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b682c8692442711684befe413cf93cf01c5324ea
X-Patchwork-Hint: ignore
In-Reply-To: <20181203230746.27196-1-joel@jms.id.au>
To: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v3] powerpc/math-emu: Update macros from GCC
Message-Id: <43BCRQ6ZqDz9s55@ozlabs.org>
Date: Sat,  8 Dec 2018 00:06:58 +1100 (AEDT)
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
Cc: Nick Desaulniers <ndesaulniers@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2018-12-03 at 23:07:46 UTC, Joel Stanley wrote:
> The add_ssaaaa, sub_ddmmss, umul_ppmm and udiv_qrnnd macros originate
> from GCC's longlong.h which in turn was copied from GMP's longlong.h a
> few decades ago.
> 
> This was found when compiling with clang:
> 
>    arch/powerpc/math-emu/fnmsub.c:46:2: error: invalid use of a cast in a
>    inline asm context requiring an l-value: remove the cast or build with
>    -fheinous-gnu-extensions
>            FP_ADD_D(R, T, B);
>            ^~~~~~~~~~~~~~~~~
>    ...
> 
>    ./arch/powerpc/include/asm/sfp-machine.h:283:27: note: expanded from
>    macro 'sub_ddmmss'
>                   : "=r" ((USItype)(sh)),                                  \
>                           ~~~~~~~~~~^~~
> 
> Segher points out: this was fixed in GCC over 16 years ago
> ( https://gcc.gnu.org/r56600 ), and in GMP (where it comes from)
> presumably before that.
> 
> Update the add_ssaaaa, sub_ddmmss, umul_ppmm and udiv_qrnnd macros to
> the latest GCC version in order to git rid of the invalid casts. These
> were taken as-is from GCC's longlong in order to make future syncs
> obvious. Other parts of sfp-machine.h were left as-is as the file
> contains more features than present in longlong.h.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/260
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b682c8692442711684befe413cf93c

cheers
