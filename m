Return-Path: <SRS0=Sqku=EL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3E5C00A89
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2020 07:41:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB3120936
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2020 07:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB3120936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CRb7h4QkXzDqsW
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2020 18:41:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.218.65; helo=mail-ej1-f65.google.com;
 envelope-from=jirislaby@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CRb5g4NYkzDqjh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2020 18:40:03 +1100 (AEDT)
Received: by mail-ej1-f65.google.com with SMTP id 7so1219096ejm.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2020 23:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/PoaxSQdQ0qc6MtVRWROcDbBKMBfI1ym4uPU4Lv069A=;
 b=qxaDDmWhhmNmlQNwZObsscmTuSQu1uFOK5l47jW7BQqV1ai3yzjnTpL6r4QlyvTN9a
 0Mm6PUYRIQuxb8Ia2VZYMSz26aGtLgzrfurgjZCvEmM2DLZ7tF62hNvmZhGR2scgUoWH
 DJxuIkk+ZrbBQl3VAZLjpi4oiFOmTPa8CvtPPTNSxJN7QCzRE6T7q0Rftnnk4/0tyiMT
 xgnTudNLBG2XfgfH9Df/+WLX3jcXnfl/V1vohUvWuJ0BFSV3GHxdHTe4j5s2tKJOuhsK
 MS52ae6f38ScjfA4mIfaalP6EUYrPkXlTkbXi8dGV+lFSE5Hsw1Vc0jzWEn06RVLo/BO
 gt8A==
X-Gm-Message-State: AOAM531AVPUWmXPf10AR9TQERxeyA5LE6wxnDoUgfwjwHWrvXKY4TfHS
 rJPmSjOj0otY23grQsppS4s=
X-Google-Smtp-Source: ABdhPJwEt20G0n1D11J5pSfi2tvzsZnG0AfTtqEF0ANZdbe1XXAbrjEon+3CwZuTF7sgXsf/suDDWQ==
X-Received: by 2002:a17:906:7844:: with SMTP id
 p4mr1076205ejm.26.1604561998177; 
 Wed, 04 Nov 2020 23:39:58 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
 by smtp.gmail.com with ESMTPSA id s3sm422116ejv.97.2020.11.04.23.39.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 23:39:57 -0800 (PST)
Subject: Re: [PATCH 34/36] tty: serial: pmac_zilog: Make disposable variable
 __always_unused
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Lee Jones <lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-35-lee.jones@linaro.org>
 <445a6440-b4c8-4536-891b-0cefc78e5f57@csgroup.eu>
From: Jiri Slaby <jirislaby@kernel.org>
Message-ID: <e027b620-56f8-7d8b-84ff-54839f94a4c7@kernel.org>
Date: Thu, 5 Nov 2020 08:39:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <445a6440-b4c8-4536-891b-0cefc78e5f57@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-serial@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 05. 11. 20, 8:04, Christophe Leroy wrote:
> 
> 
> Le 04/11/2020 à 20:35, Lee Jones a écrit :
>> Fixes the following W=1 kernel build warning(s):
>>
>>   drivers/tty/serial/pmac_zilog.h:365:58: warning: variable ‘garbage’ 
>> set but not used [-Wunused-but-set-variable]
> 
> Explain how you are fixing this warning.
> 
> Setting  __always_unused is usually not the good solution for fixing 
> this warning, but here I guess this is likely the good solution. But it 
> should be explained why.

Or, why is the "garbage =" needed in the first place? read_zsdata is not 
defined with __warn_unused_result__. And even if it was, would 
(void)!read_zsdata(port) fix it?

>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Jiri Slaby <jirislaby@kernel.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: linux-serial@vger.kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>   drivers/tty/serial/pmac_zilog.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/pmac_zilog.h 
>> b/drivers/tty/serial/pmac_zilog.h
>> index bb874e76810e0..968aec7c1cf82 100644
>> --- a/drivers/tty/serial/pmac_zilog.h
>> +++ b/drivers/tty/serial/pmac_zilog.h
>> @@ -362,7 +362,7 @@ static inline void zssync(struct uart_pmac_port 
>> *port)
>>   /* Misc macros */
>>   #define ZS_CLEARERR(port)    (write_zsreg(port, 0, ERR_RES))
>> -#define ZS_CLEARFIFO(port)   do { volatile unsigned char garbage; \
>> +#define ZS_CLEARFIFO(port)   do { volatile unsigned char 
>> __always_unused garbage; \
>>                        garbage = read_zsdata(port); \
>>                        garbage = read_zsdata(port); \
>>                        garbage = read_zsdata(port); \
>>

thanks,
-- 
js
