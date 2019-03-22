Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF24AC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 02:15:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E877D21900
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 02:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="MskbKifU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E877D21900
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QS1V0mdPzDqRL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 13:15:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="MskbKifU"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QRzc6QX4zDqQw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 13:14:04 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id u9so374101pgo.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 19:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=kVol0XgY1GrkrCydApUcrMKadPyzgXmpcAqek0gktrk=;
 b=MskbKifUSht8b1fME/1KZYuBfy63vN8bsNjh+an00L7/R8wRo+f/40rAFgf8QbJGsA
 wMro0YHzanLpcmWq3pTXDPRR5tIRl2AzfVS3Sfvlh5zATMSrsEHJAoSTrhNXk8ZukMKr
 lfWWP4rvtn0C5g4Fi46v9ROOAtzew8UTIhMmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=kVol0XgY1GrkrCydApUcrMKadPyzgXmpcAqek0gktrk=;
 b=UFgPo4NFN/sbXvsQ3zUNgsQniWod1LIi3HZczObMqIZIlpczSkrDdenXHNvp7RO32h
 wLBXzHu0bM9mnk8uR3myHn3PEQJw1dH8b/ww7W0slDx/sTo89DW/+Qd0APC5sjO+P4Z8
 nMhyhtIqzBMV0jFMehMwL/yMHAMJfys7K2vtu3xmcuS4YCxqPN4tn2Ykm9FUX81own5w
 JUh1QyXZpuldzhqni+ddU/SlY13kdnNzTQDuTvMjRTnQCOiGD5t/n6Qyz0o0DeVew0jk
 2Xp8+//HoqyqdrfhLHhoXGLlsL4wGPwW0hwdXh+KUhcF0C6lQEimCA9YdcDJWOc5B+Hx
 Tylg==
X-Gm-Message-State: APjAAAWNJ/xmmL/wBVx0tdajjTJXleZnLGfhzqP3zhR4IfBI+bAZ4gIq
 3hG3jxq1WoG2BYWRu9j2KSip+A==
X-Google-Smtp-Source: APXvYqyQ1gEx28qddl3shtOahh2sg2FVTpyJFIKDaKfdg83i22814iMukCKxByWQ0kNUqadsbVjLlA==
X-Received: by 2002:a65:5184:: with SMTP id h4mr6509337pgq.32.1553220841099;
 Thu, 21 Mar 2019 19:14:01 -0700 (PDT)
Received: from localhost (dip-220-235-49-94.wa.westnet.com.au. [220.235.49.94])
 by smtp.gmail.com with ESMTPSA id i135sm2496266pgd.41.2019.03.21.19.13.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Mar 2019 19:13:59 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: George Spelvin <lkml@sdf.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] arch/powerpc/crypto/crc-vpmsum_test: Use cheaper random
 numbers for self-test
In-Reply-To: <201903211042.x2LAgMp3003053@sdf.org>
References: <201903211042.x2LAgMp3003053@sdf.org>
Date: Fri, 22 Mar 2019 13:13:56 +1100
Message-ID: <87tvfvsljv.fsf@dja-thinkpad.axtens.net>
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
Cc: George Spelvin <lkml@sdf.org>, Paul Mackerras <paulus@samba.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi George,

> This code was filling a 64K buffer from /dev/urandom in order to
> compute a CRC over (on average half of) it by two different methods,
> comparing the CRCs, and repeating.
>
> This is not a remotely security-critical application, so use the far
> faster and cheaper prandom_u32() generator.
>

I've had a quick look at the prandom_u32 generator and I agree that it's
suitable for this. 

> And, while we're at it, only fill as much of the buffer as we plan to use.

This also looks good to me.

Acked-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel

>
> Signed-off-by: George Spelvin <lkml@sdf.org>
> Cc: Daniel Axtens <dja@axtens.net>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/crypto/crc-vpmsum_test.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/crypto/crc-vpmsum_test.c b/arch/powerpc/crypto/crc-vpmsum_test.c
> index 0153a9c6f4af..98ea4f4d3dde 100644
> --- a/arch/powerpc/crypto/crc-vpmsum_test.c
> +++ b/arch/powerpc/crypto/crc-vpmsum_test.c
> @@ -78,16 +78,12 @@ static int __init crc_test_init(void)
>  
>  		pr_info("crc-vpmsum_test begins, %lu iterations\n", iterations);
>  		for (i=0; i<iterations; i++) {
> -			size_t len, offset;
> +			size_t offset = prandom_u32_max(16);
> +			size_t len = prandom_u32_max(MAX_CRC_LENGTH);
>  
> -			get_random_bytes(data, MAX_CRC_LENGTH);
> -			get_random_bytes(&len, sizeof(len));
> -			get_random_bytes(&offset, sizeof(offset));
> -
> -			len %= MAX_CRC_LENGTH;
> -			offset &= 15;
>  			if (len <= offset)
>  				continue;
> +			prandom_bytes(data, len);
>  			len -= offset;
>  
>  			crypto_shash_update(crct10dif_shash, data+offset, len);
> -- 
> 2.20.1
