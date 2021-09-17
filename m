Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B760C433F5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Sep 2021 05:17:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2D8610C9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Sep 2021 05:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC2D8610C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H9hzK6SdXz2yg3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Sep 2021 15:17:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H9hyq64zzz2yHJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Sep 2021 15:17:05 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4H9hyk2qq5z9sTc;
 Fri, 17 Sep 2021 07:17:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nv5IhXWb4hJc; Fri, 17 Sep 2021 07:17:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4H9hyk1bp6z9sTX;
 Fri, 17 Sep 2021 07:17:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 186B28B783;
 Fri, 17 Sep 2021 07:17:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id rpsHFshvp2DV; Fri, 17 Sep 2021 07:17:02 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.36])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5D7E38B768;
 Fri, 17 Sep 2021 07:17:01 +0200 (CEST)
Subject: Re: [PATCH] lib/zlib_inflate/inffast: Check config in C to avoid
 unused function warning
To: Paul Menzel <pmenzel@molgen.mpg.de>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>
References: <20210916142210.26722-1-pmenzel@molgen.mpg.de>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <51258322-8665-76f9-c807-76cb56764229@csgroup.eu>
Date: Fri, 17 Sep 2021 07:17:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210916142210.26722-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
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
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Zhen Lei <thunder.leizhen@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 16/09/2021 à 16:22, Paul Menzel a écrit :
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

You can't do that, CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not 
something that have value 0 or 1, it is something which is either 
defined or not. You have to use IS_ENABLED() macro, so it should become 
something like:

	if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
		*sout++ = *sfrom++;
	else
		*sout++ = get_unaligned16(sfrom++);


>   			while (--loops);
>   			out = (unsigned char *)sout;
>   			from = (unsigned char *)sfrom;
> 
