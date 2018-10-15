Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B80C04AA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 12:58:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03402054F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 12:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRn0XPuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03402054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Ydm43XZ3zF3CF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 23:58:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CRn0XPuq";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=aneeshkumar.opensource@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="CRn0XPuq"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YdhY22j3zF0Rr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 23:55:25 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id f29-v6so9647703pff.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/x9N+jHuRDPh9uNIhuTAZo2ZBNrX1Px7aajGfuqtLnw=;
 b=CRn0XPuqKVSOWeuVV/h1F46pS+jLj0/tNYzlS0gI08/kybMx4OBZL94XpoGF+L9fbG
 hqG2O9jhx2bmDqMLBr404JsgVzUEOhYIC29p537v8t40dr3Ap9k/tb3TegyXXueT7Pu5
 1Mo5zOi6/7jDbi+OxSrkSezFx9JcbNSE1tJc0TeZpApuql2m5Svbx6kJYax8jS5dJtgT
 AlXKAbQCzvBe7UhhW7RqDHaib2fWFsE3quolZs8+3waQVG8HL7ViKZ8ies15IeGK4dO6
 Vb+V/XiuVnRDl2BI8/2cx86C0QzA/uBsKk4AiHZMrg/+fR7Cpbfh3yOcxRA2aqHbuJrG
 oU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/x9N+jHuRDPh9uNIhuTAZo2ZBNrX1Px7aajGfuqtLnw=;
 b=Neo64TNOJ7EK4vDWiPZFbkQlTxox/xPYl1BaJ6/9mUtOGsth/Y9/9GF0NM7BHy8TP/
 Kaz1BxJJ7OA+swLKfb8732EKlpcbn9k01AvyoU9yqkCALgaiOlrgMCzNmvZylJgg57HA
 yf4LN2oLbEus6T9wPzBraI6y9kM1q0By5FlrPob37a1PczLCO59aW1+7kJn9koium3Rl
 HcdoZGMX017WybEM0x0+yeDDGmgXIqlUwpSUUUYZfUpkJ5V6lBvg7Uo7yiOnECMD2ttt
 BQO/aQwPYbwjwJZL9cfBgvMO2Y8cYYRwBYZ7MjpRpzJ4BMtwxN2VRl4nn7c5J/s2Hh0v
 CuDg==
X-Gm-Message-State: ABuFfoje0X/ts0E4/x/kkSrXklBcmWnj06vgYq/ecIwgCpZI+jFjIT7J
 s83bNuFD+fEDyA+ybyNr8mddnUYM
X-Google-Smtp-Source: ACcGV62UkUs//LgIkagv8TQ5boUUlcZ37uQ44p5p9z3dizjUGEx2f7wtMQeIEoa/LR5LhWztFoz+WQ==
X-Received: by 2002:a63:4243:: with SMTP id
 p64-v6mr16232154pga.127.1539608123173; 
 Mon, 15 Oct 2018 05:55:23 -0700 (PDT)
Received: from [192.168.0.123] ([49.207.50.246])
 by smtp.gmail.com with ESMTPSA id s13-v6sm23847975pgs.76.2018.10.15.05.55.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Oct 2018 05:55:22 -0700 (PDT)
From: "Aneesh Kumar K.V" <aneeshkumar.opensource@gmail.com>
X-Google-Original-From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] powerpc/book3s64: fix dump_linuxpagetables "present" flag
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <23d27ae15a7b0389fc26f2265f969c6c69f44009.1539433567.git.christophe.leroy@c-s.fr>
Message-ID: <1efceec5-7748-6aa8-66d4-a7dfcbc44649@linux.ibm.com>
Date: Mon, 15 Oct 2018 18:25:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <23d27ae15a7b0389fc26f2265f969c6c69f44009.1539433567.git.christophe.leroy@c-s.fr>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/15/18 12:07 PM, Christophe Leroy wrote:
> Since commit bd0dbb73e013 ("powerpc/mm/books3s: Add new pte bit to
> mark pte temporarily invalid."), _PAGE_PRESENT doesn't mean exactly
> that a page is present. A page is also considered preset when
> _PAGE_INVALID is set.
> 
> This patch changes the meaning of "present" and adds a status "valid"
> associated to the _PAGE_PRESENT flag.
> 

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Fixes: bd0dbb73e013 ("powerpc/mm/books3s: Add new pte bit to mark pte temporarily invalid.")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/mm/dump_linuxpagetables-book3s64.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/dump_linuxpagetables-book3s64.c b/arch/powerpc/mm/dump_linuxpagetables-book3s64.c
> index a637e612b205..ed6fcf78256e 100644
> --- a/arch/powerpc/mm/dump_linuxpagetables-book3s64.c
> +++ b/arch/powerpc/mm/dump_linuxpagetables-book3s64.c
> @@ -38,8 +38,13 @@ static const struct flag_info flag_array[] = {
>   	}, {
>   		.mask	= _PAGE_PRESENT,
>   		.val	= _PAGE_PRESENT,
> -		.set	= "present",
> -		.clear	= "       ",
> +		.set	= "valid",
> +		.clear	= "     ",
> +	}, {
> +		.mask	= _PAGE_PRESENT | _PAGE_INVALID,
> +		.val	= 0,
> +		.set	= "       ",
> +		.clear	= "present",
>   	}, {
>   		.mask	= H_PAGE_HASHPTE,
>   		.val	= H_PAGE_HASHPTE,
> 

