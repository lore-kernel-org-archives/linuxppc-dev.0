Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EA8C64EBC
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 01:39:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D38A120834
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 01:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38A120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RC8p5lDKzDrPZ
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 11:39:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RC6W4RJNzDrNw
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 11:37:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42RC6W3bXgz9sB7; Fri,  5 Oct 2018 11:37:07 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 242cdad873a75652f97c35aad61270581e0f3a2e
In-Reply-To: <20180921025431.28366-1-joel@jms.id.au>
To: Joel Stanley <joel@jms.id.au>, Krzysztof Kozlowski <krzk@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: lib/xz: Put CRC32_POLY_LE in xz_private.h
Message-Id: <42RC6W3bXgz9sB7@ozlabs.org>
Date: Fri,  5 Oct 2018 11:37:07 +1000 (AEST)
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
Cc: Meelis Roos <mroos@linux.ee>, linuxppc-dev@lists.ozlabs.org,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2018-09-21 at 02:54:31 UTC, Joel Stanley wrote:
> This fixes a regression introduced by faa16bc404d72a5 ("lib: Use
> existing define with polynomial").
> 
> The cleanup added a dependency on include/linux, which broke the PowerPC
> boot wrapper/decompresser when KERNEL_XZ is enabled:
> 
>   BOOTCC  arch/powerpc/boot/decompress.o
>  In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:233,
>                  from arch/powerpc/boot/decompress.c:42:
>  arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:10: fatal error:
>  linux/crc32poly.h: No such file or directory
>   #include <linux/crc32poly.h>
>            ^~~~~~~~~~~~~~~~~~~
> 
> The powerpc decompresser is a hairy corner of the kernel. Even while building
> a 64-bit kernel it needs to build a 32-bit binary and therefore avoid including
> files from include/linux.
> 
> This allows users of the xz library to avoid including headers from
> 'include/linux/' while still achieving the cleanup of the magic number.
> 
> Fixes: faa16bc404d72a5 ("lib: Use existing define with polynomial")
> Reported-by: Meelis Roos <mroos@linux.ee>
> Reported-by: kbuild test robot <lkp@intel.com>
> Suggested-by: Christophe LEROY <christophe.leroy@c-s.fr>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Tested-by: Meelis Roos <mroos@linux.ee>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/242cdad873a75652f97c35aad61270

cheers
