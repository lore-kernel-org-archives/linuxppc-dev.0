Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3F0C4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 07:58:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D4960E53
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 07:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E4D4960E53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GgLb94NHlz3cXT
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 17:58:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.221.43; helo=mail-wr1-f43.google.com;
 envelope-from=jirislaby@gmail.com; receiver=<UNKNOWN>)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GgLZn4FnNz30Hk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Aug 2021 17:58:24 +1000 (AEST)
Received: by mail-wr1-f43.google.com with SMTP id b13so5303226wrs.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Aug 2021 00:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SIGf0ZSasBVghsXQSCZ7mW/k5jcYYJAmZYHu4J8Tp/M=;
 b=dh57A85A6AtcrXkN2fojFwEbVRNGh+5rqqBqcCpsbYkaTb54JypXMJH5ziZ5gfkMBx
 8crxjoZuRyWvDVF/zzdWo+FkFsusugdCsAof4vngCL0//BCzFATyqdK2UalkcUHIufX6
 HZ3sg2fEPyhrbwNTtRZGTRyfIdJDAPiC60eNzHNkinHhGb23q73gQ51+hAsPpZx/sL7J
 sSVMpQkoZ6hqD2SQn7di1k83Lg27BOgKR1NnR2DxwTqXab924c97KyHmqf3264EimF5F
 xM1NHPXB7szrkLSzYTbrM7cf4f6kW1dSra4Sy226E+pFDWh6cNYwsz1IP1o1ykhdE7hK
 07ZA==
X-Gm-Message-State: AOAM532GWMmkmdluwmk/kOr39Ra7f8QQ1bWm8JTHjgts/QhKNfN/7msB
 G/zGYBBD+rpDNP5EMABNOgM=
X-Google-Smtp-Source: ABdhPJxN/nX8OJxxlThMzUEDQ0ECk9b9U1Q3X1Uaosdqvsr7YAddOawAhmEhinTnQe8KIgacBYLFiw==
X-Received: by 2002:adf:9e01:: with SMTP id u1mr3659445wre.12.1628150300961;
 Thu, 05 Aug 2021 00:58:20 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
 by smtp.gmail.com with ESMTPSA id c204sm8170816wme.15.2021.08.05.00.58.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Aug 2021 00:58:20 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] tty: hvc: pass DMA capable memory to put_chars()
To: Xianting Tian <xianting.tian@linux.alibaba.com>,
 gregkh@linuxfoundation.org, amit@kernel.org, arnd@arndb.de, osandov@fb.com
References: <20210804025453.93543-1-xianting.tian@linux.alibaba.com>
From: Jiri Slaby <jirislaby@kernel.org>
Message-ID: <0f26a1c3-53e8-9282-69e8-8d81a9cafc59@kernel.org>
Date: Thu, 5 Aug 2021 09:58:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804025453.93543-1-xianting.tian@linux.alibaba.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

On 04. 08. 21, 4:54, Xianting Tian wrote:
> @@ -933,6 +949,16 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
>   	hp->outbuf_size = outbuf_size;
>   	hp->outbuf = &((char *)hp)[ALIGN(sizeof(*hp), sizeof(long))];
>   
> +	/*
> +	 * hvc_con_outbuf is guaranteed to be aligned at least to the
> +	 * size(N_OUTBUF) by kmalloc().
> +	 */
> +	hp->hvc_con_outbuf = kzalloc(N_OUTBUF, GFP_KERNEL);
> +	if (!hp->hvc_con_outbuf)
> +		return ERR_PTR(-ENOMEM);

This leaks hp, right?

BTW your 2 patches are still not threaded, that is hard to follow.

> +
> +	spin_lock_init(&hp->hvc_con_lock);
> +
>   	tty_port_init(&hp->port);
>   	hp->port.ops = &hvc_port_ops;
>   

thanks,
-- 
js
suse labs
