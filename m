Return-Path: <SRS0=bcc2=GX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F46C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Jan 2021 05:47:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25BF2313C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Jan 2021 05:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25BF2313C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DLF0h6MX9zDqxb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Jan 2021 16:47:32 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DLDyc0J0hzDqWR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2021 16:45:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=l8BIBTeW; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4DLDyZ6qHMz9rx6;
 Wed, 20 Jan 2021 16:45:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1611121543;
 bh=ISBNVX3LDUBTyhkPqMavSnFG3QO/ASLTAlab4isvt/Y=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=l8BIBTeW9QzGb/pmvDh762sGhBJD5+xKpauVBQzHEuLYeW1a57zcSmRA3c5HkUsF8
 cGIVRTRmQc302mYniglMXvmn5jRe5I2ysuX431rvSI2y+RHaW+IxX83ibAzgU1hYPG
 7EnecDGKQyy6fJpmuOvkrd4Ew4Vx4Uh71UxXJxEdxDB2tRNH/0yorv66R4LDo6zzTT
 UhrPs4efphD0mLUCwl/4mXQ2p4rOr5GE5ZCJ9MZ/YND0N8p1PHdj5U+P1XcjnrQE52
 2BWJPpD+zyfVF23MzGCp0ZJzvN5+Bh0erX1IcGKC4yNfRVph0A5KIMV3oT/SXUogSc
 kNxWlRd9IWP1A==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/47x: Disable 256k page size
In-Reply-To: <2fed79b1154c872194f98bac4422c23918325e61.1611039590.git.christophe.leroy@csgroup.eu>
References: <2fed79b1154c872194f98bac4422c23918325e61.1611039590.git.christophe.leroy@csgroup.eu>
Date: Wed, 20 Jan 2021 16:45:38 +1100
Message-ID: <87h7ncqhz1.fsf@mpe.ellerman.id.au>
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

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> PPC47x_TLBE_SIZE isn't defined for 256k pages, so
> this size of page shall not be selected for 47x.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: e7f75ad01d59 ("powerpc/47x: Base ppc476 support")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 107bb4319e0e..a685e42d3993 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -772,7 +772,7 @@ config PPC_64K_PAGES
>  
>  config PPC_256K_PAGES
>  	bool "256k page size"
> -	depends on 44x && !STDBINUTILS
> +	depends on 44x && !STDBINUTILS && !PPC_47x

Do we still need this STDBINUTILS thing?

It's pretty gross, and I notice we have zero defconfigs which disable
it, meaning it's only randconfig builds that will ever test 256K pages.

Can we just drop it and say if you enable 256K pages you need to know
what you're doing?

cheers
