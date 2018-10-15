Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD69CC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 04:14:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7286320652
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 04:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7286320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YQ733LFWzF3BP
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 15:14:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YPqw5PRhzF13h
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 15:01:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42YPqw3Xpqz9sDQ; Mon, 15 Oct 2018 15:01:00 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: aea447141c7e7824b81b49acd1bc785506fba46e
In-Reply-To: <20180917074621.25066-1-joel@jms.id.au>
To: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: Disable -Wbuiltin-requires-header when setjmp is used
Message-Id: <42YPqw3Xpqz9sDQ@ozlabs.org>
Date: Mon, 15 Oct 2018 15:01:00 +1100 (AEDT)
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

On Mon, 2018-09-17 at 07:46:21 UTC, Joel Stanley wrote:
> The powerpc kernel uses setjmp which causes a warning when building with
> clang:
> 
>     CC      arch/powerpc/xmon/xmon.o
>   In file included from arch/powerpc/xmon/xmon.c:51:
>   ./arch/powerpc/include/asm/setjmp.h:15:13: error: declaration of
>   built-in function 'setjmp' requires inclusion of the header <setjmp.h>
>         [-Werror,-Wbuiltin-requires-header]
>   extern long setjmp(long *);
>               ^
>   ./arch/powerpc/include/asm/setjmp.h:16:13: error: declaration of
>   built-in function 'longjmp' requires inclusion of the header <setjmp.h>
>         [-Werror,-Wbuiltin-requires-header]
>   extern void longjmp(long *, long);
>               ^
> 
> This *is* the header and we're not using the built-in setjump but
> rather the one in arch/powerpc/kernel/misc.S. As the compiler warning
> does not make sense, it for the files where setjmp is used.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/aea447141c7e7824b81b49acd1bc78

cheers
