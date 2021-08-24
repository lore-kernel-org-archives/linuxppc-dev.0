Return-Path: <SRS0=KHR7=NP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F13C432BE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 14:41:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51576128A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 14:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A51576128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GvBcg4Vkdz2yWR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Aug 2021 00:41:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=Kle4Ul3D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=2607:f8b0:4864:20::d2a;
 helo=mail-io1-xd2a.google.com; envelope-from=skhan@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=google header.b=Kle4Ul3D; 
 dkim-atps=neutral
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GvBbv6rrcz2xh1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Aug 2021 00:40:26 +1000 (AEST)
Received: by mail-io1-xd2a.google.com with SMTP id b7so26647283iob.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Aug 2021 07:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MlxQ/FXwdBOfX5eLPJCYquGl9l7ouOdRIS8ahpzDdNo=;
 b=Kle4Ul3Djry6em/SvyRGFcj5kbH6ZcsFWrY3XTFBxaevzheGuFx+aHitt121nBM5zm
 WC8LJnCcJDUnzo9AT2N+5Y9mPJ4RgYcRoRhT6PDjT31LMbvNMzJift4T6t0HLgsKM2e/
 XQIlAsDzvJB+HtX0ILdz50Q3dNv3oBrsXf/zU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MlxQ/FXwdBOfX5eLPJCYquGl9l7ouOdRIS8ahpzDdNo=;
 b=hgBLIEbI1vLBVgWAV7V6CkoXgQMXcG5UiNI3bQHJ5BKtjDq49ZyknifY0A3CtZTfe/
 w+cQ7+M4dQTFBx8BoW+kud15NYA7xooEoQ0dlBJ/+YkZ4Oig4EQAFgvM+xqihVdbyZLp
 tSzEl7ZRaL2xKrM5UaznP1eTb39X5DPAB7nkpY9yLxpXk+1v4QQ1MDdRfpTiBAuWJjbp
 B2K4URkc0MzPt7JCrOkUPjFFczRlqwkWXT8qGzZvQTQDc/Si452HI+lwFQ3vfKaPO6jm
 0SEgDqAwM4WvSgatws4uIF+UaakXe4TLhYMwFnRMrOgBdXFf9wd34E9/shMHjgpbcpzn
 yqbg==
X-Gm-Message-State: AOAM5323ohq9HA36IkSlA8pZrPROg94V2tobiuis7J65h6hqxrrSNp1I
 mABFLogdYBAptezV78TWvOpoXA==
X-Google-Smtp-Source: ABdhPJzoFdwhVYDK/nXholA1lAkn+/F3l/iFm8wLNNplf9lVgIfHDTSU79VUNkzsfmoUsBaYq8KWsw==
X-Received: by 2002:a5d:928c:: with SMTP id s12mr31161317iom.151.1629816023338; 
 Tue, 24 Aug 2021 07:40:23 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net.
 [24.9.64.241])
 by smtp.gmail.com with ESMTPSA id k7sm9990002iok.22.2021.08.24.07.40.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Aug 2021 07:40:22 -0700 (PDT)
Subject: Re: [PATCH linux-next] powerpc/tm: remove duplicate include in
 tm-poison.c
To: cgel.zte@gmail.com, mpe@ellerman.id.au
References: <20210805065255.628170-1-yong.yiran@zte.com.cn>
From: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c5e9900b-1c2d-8e72-ad83-a6024b876fd2@linuxfoundation.org>
Date: Tue, 24 Aug 2021 08:40:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210805065255.628170-1-yong.yiran@zte.com.cn>
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
Cc: yong.yiran@zte.com.cn, Zeal Robot <zealci@zte.com.cn>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, paulus@samba.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 8/5/21 12:52 AM, cgel.zte@gmail.com wrote:
> From: yong yiran <yong.yiran@zte.com.cn>
> 
> 'inttypes.h' included in 'tm-poison.c' is duplicated.
> Remove all but the first include of inttypes.h from tm-poison.c.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: yong yiran <yong.yiran@zte.com.cn>
> ---
>   tools/testing/selftests/powerpc/tm/tm-poison.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/powerpc/tm/tm-poison.c b/tools/testing/selftests/powerpc/tm/tm-poison.c
> index 29e5f26af7b9..27c083a03d1f 100644
> --- a/tools/testing/selftests/powerpc/tm/tm-poison.c
> +++ b/tools/testing/selftests/powerpc/tm/tm-poison.c
> @@ -20,7 +20,6 @@
>   #include <sched.h>
>   #include <sys/types.h>
>   #include <signal.h>
> -#include <inttypes.h>
>   
>   #include "tm.h"
>   
> 

We can't accept this patch. The from and Signed-off-by don't match.

thanks,
-- Shuah
