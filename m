Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A233BC433F5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Sep 2021 14:59:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B0460F6C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Sep 2021 14:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B8B0460F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H9Kwt2xb0z2ybD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Sep 2021 00:59:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HuUVKWhN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=nathan@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HuUVKWhN; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H9Kw76fdGz2xv2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Sep 2021 00:58:31 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0DF860F6B;
 Thu, 16 Sep 2021 14:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631804309;
 bh=AgqdIcDpy91eL8LK1OITNsHLzbyaPNMmq9RB0DZLZQ8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=HuUVKWhN0Cyc3CwcojR+XB+bbOC/LqtJv/hJmtqmtM3VctvEWQLqUSvol9yx3+vxP
 ursQPNIXbL6KAvPrdcxJ/WvldvdmJAEBvlQ3vvNoj5I7eKH1Z6XvsU9PXrzuXEVnPL
 +wUuxZgO8GpkpffycTf1COG/dR8Jkht3YwJDqHhL5Xo/r6thIa3oAy5d0KM5916EG8
 KEGdZGyVc7VZSrcRzy7rVOD9bugyjPV39/0tBW1qrBpoCCMRI4Rk62EBrQMkLhULib
 9Pq0UOJbjh4fPJ6fxnBnt2fEpsBDuvINm3PK7z1Lg4FF70fU90ORMU5SJqLJadmQzA
 BSwdASIONLGXg==
Subject: Re: [PATCH] lib/zlib_inflate/inffast: Check config in C to avoid
 unused function warning
To: Paul Menzel <pmenzel@molgen.mpg.de>,
 Nick Desaulniers <ndesaulniers@google.com>
References: <20210916142210.26722-1-pmenzel@molgen.mpg.de>
From: Nathan Chancellor <nathan@kernel.org>
Message-ID: <decede05-591b-b51c-bd5f-d844b1895e54@kernel.org>
Date: Thu, 16 Sep 2021 07:58:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210916142210.26722-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: llvm@lists.linux.dev, Zhen Lei <thunder.leizhen@huawei.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Paul,

On 9/16/2021 7:22 AM, Paul Menzel wrote:
> Building Linux for ppc64le with Ubuntu clang version 12.0.0-3ubuntu1~21.04.1
> shows the warning below.
> 
>      arch/powerpc/boot/inffast.c:20:1: warning: unused function 'get_unaligned16' [-Wunused-function]
>      get_unaligned16(const unsigned short *p)
>      ^
>      1 warning generated.
> 
> Fix it, by moving the check from the preprocessor to C, so the compiler
> sees the use.
> 
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>   lib/zlib_inflate/inffast.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/lib/zlib_inflate/inffast.c b/lib/zlib_inflate/inffast.c
> index f19c4fbe1be7..444ad3c3ccd3 100644
> --- a/lib/zlib_inflate/inffast.c
> +++ b/lib/zlib_inflate/inffast.c
> @@ -254,11 +254,7 @@ void inflate_fast(z_streamp strm, unsigned start)
>   			sfrom = (unsigned short *)(from);
>   			loops = len >> 1;
>   			do
> -#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> -			    *sout++ = *sfrom++;
> -#else
> -			    *sout++ = get_unaligned16(sfrom++);
> -#endif
> +			    *sout++ = CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS ? *sfrom++ : get_unaligned16(sfrom++);
>   			while (--loops);
>   			out = (unsigned char *)sout;
>   			from = (unsigned char *)sfrom;
> 

Thanks for the patch. This should probably be

IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) ? ...

which matches the rest of the kernel tree, as certain CONFIG_... values 
are not guaranteed to always be defined.

Cheers,
Nathan
