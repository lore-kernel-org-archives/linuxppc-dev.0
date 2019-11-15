Return-Path: <SRS0=VpUd=ZH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7934CC432C3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Nov 2019 08:03:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B972072D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Nov 2019 08:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WvPEQM25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B972072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47DrT76hCPzF6rF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Nov 2019 19:03:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::243;
 helo=mail-lj1-x243.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="WvPEQM25"; dkim-atps=neutral
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com
 [IPv6:2a00:1450:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47DrQM2tPjzF3FT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2019 19:01:14 +1100 (AEDT)
Received: by mail-lj1-x243.google.com with SMTP id g3so9640142ljl.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2019 00:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=K7AVtvzUjcO1cH7HI4QDDaRMFMqYOvK9VjNlChoFy28=;
 b=WvPEQM25nYZqJtCFviyiD5ljzM/UmkIClduWS5T64tJiWhNJmgokv03NvNrxgyQS+y
 +5ABXTxPcvc7NSKvwma9diqktx6g7QSNjbcBVdIQbuLjNfOH8c/sfbAmpgxGbu3j8NvN
 SWQP/Ey72K1GHGzEJeMzAkIbyO7FCT+amG3Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K7AVtvzUjcO1cH7HI4QDDaRMFMqYOvK9VjNlChoFy28=;
 b=aIz8Fk4fmzKtqLfITXXgdS3SZWeyZQZ5IwSf7TjTEX6OjeWvGE2qfrgk25cwa/aHSp
 S+/q24XaIjecjyT0hLNlVdxQIHa8pDjp9d3zBsuSfW+59NuhfKwuGf7Mvi78JdguzvVr
 aKHd64LkIKMSTIQpkOWxlvxVSGqWF9YntCsmgnFpqSbbcxXDH3/UJpTel2diZkijUhN5
 YHpMSvQb7/OCHMpKM1jNyRfq/0G1f2gFzHOYhQeY4gfv2OdX0TCB8mzuOkwGUwnRvVR0
 7tZNtyjvg5eJv3ZUSxN6J7H3MlXZHaSXLZQxW+Ylo8qUSW+u5xycgptxvC4K1ZXjnuV7
 iUMw==
X-Gm-Message-State: APjAAAVh2TqBuJsssMI9GV0VKfLw5XYyLlxIWYsN5m/NiByUBzoUoLuN
 6dlsZ239vmtxV4f7nkQ3pm1AOsxT5NBDyJKm
X-Google-Smtp-Source: APXvYqzc04JNvBuLcN/d5H0lWI5kqLrC+8YRwhm+xzIsLHtvpNLGSz16bdRnRpDrrXnxVQ4J/enZ6Q==
X-Received: by 2002:a2e:9ecf:: with SMTP id h15mr10034052ljk.173.1573804870160; 
 Fri, 15 Nov 2019 00:01:10 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id a11sm3426309ljm.60.2019.11.15.00.01.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Nov 2019 00:01:09 -0800 (PST)
Subject: Re: [PATCH v4 32/47] serial: ucc_uart: use of_property_read_u32() in
 ucc_uart_probe()
To: Timur Tabi <timur@kernel.org>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
 <20191108130123.6839-33-linux@rasmusvillemoes.dk>
 <CAOZdJXU1ELqQh7TitAJW7bsmnj89wq3opJGVizC2B19nL_3_rQ@mail.gmail.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <9f1a846b-c303-92fa-9620-f492ef940de7@rasmusvillemoes.dk>
Date: Fri, 15 Nov 2019 09:01:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAOZdJXU1ELqQh7TitAJW7bsmnj89wq3opJGVizC2B19nL_3_rQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
Cc: lkml <linux-kernel@vger.kernel.org>, Li Yang <leoyang.li@nxp.com>,
 Scott Wood <oss@buserror.net>, linux-serial@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Qiang Zhao <qiang.zhao@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 14/11/2019 14.57, Timur Tabi wrote:
> On Fri, Nov 8, 2019 at 7:03 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> -       if (*iprop)
>> -               qe_port->port.uartclk = *iprop;
>> +       if (val)
>> +               qe_port->port.uartclk = val;
>>         else {
>>                 /*
>>                  * Older versions of U-Boot do not initialize the brg-frequency
>>                  * property, so in this case we assume the BRG frequency is
>>                  * half the QE bus frequency.
>>                  */
> 
> This bug in older U-Boots is definitely PowerPC-specific, so could you
> change this so that it reports an error on ARM if brg-frequency is
> zero, and displays a warning on PowerPC?
> 

That would be a separate patch, this patch is only concerned with
eliminating the implicit assumption of the host being big-endian. And
there's already been some pushback to adding arch-specific ifdefs (which
I agree with, but as I responded there see as the lesser evil), so
unless there's a very good reason to add that complexity, I'd rather not.

Rasmus
