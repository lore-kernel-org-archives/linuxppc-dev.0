Return-Path: <SRS0=J6Sm=EF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B498C4363A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2020 02:37:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DEDB206B5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2020 02:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CfnJcdGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DEDB206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CMmfp3B4KzDqcW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2020 13:37:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.dk (client-ip=2607:f8b0:4864:20::443;
 helo=mail-pf1-x443.google.com; envelope-from=axboe@kernel.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel-dk.20150623.gappssmtp.com
 header.i=@kernel-dk.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=CfnJcdGJ; dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CMmch4MHqzDqVd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2020 13:35:13 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id x13so3980780pfa.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2020 19:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=UXwBfYzI35aElg90LFgmr05lCvBRSC2pyvWhxHjEdr8=;
 b=CfnJcdGJs8SOs7Iyfbon0YokMsTEOdy7wIWJOxFfzMd6bwoNFKamSN4Lu66v75PVtz
 31dW7xoDRk5ZkhX3tl2cXpXRMr0gLtHAIv34Fka11lwU1FjrdRRfmEEsnV0yKw3XIsS1
 T6Uby7R3Xk/Gr94rXiQzHUUkHWQvbgHZivCW2q947NSZkRdyUEit9XOcBjG8+K8ZDBBT
 2tcovlyBjOaQ/tgESu+NMyag26bE8uEgJFn+siexk8Hv/dfmEAMG7Ux1TIi5wq4r6jaU
 NC1pLp4b14LEAkDXARH2Cdq+NcB7VlgL5Y+zf+mKh2c/OTsB5PTO6duNgmz1q2ZcwGYL
 2xUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UXwBfYzI35aElg90LFgmr05lCvBRSC2pyvWhxHjEdr8=;
 b=a2UivNcjVyLV2wCusrf93lKmf24xUIFWqdSnRgvxHDKZXYLWa+oq/HmpYXjJ1BvZjw
 Inup9YEt090+fAQA0rDixfBaZ0clFNEXFD+hCbDCqMTLCc5UtzQYeZTzQrlUtLvInukZ
 3Qf824Dd99ns4akxuj0Mv+DmoaDT7Qz5A2IOVcjFVr0C93bGgpAIHCHtFC9QanyVjHzv
 6s1neFRmL3fbEOaLkumB21YXE/6yfaLzLnRLE2zb0Ajk4WBq9RIsjp7if0sH9bSS9Jtd
 Q36LYNLrHZehvSUBeWb063H1lITr5i63KnkdvSf5WAqWMIaudrSCPZcWTTTjj3AoyJg5
 gtZA==
X-Gm-Message-State: AOAM531Ek5POH89Det83KI4udBncbSMNqHoyJVfan0AMRiXt7lmgUQ2g
 4THYdWBvPckd2urQChCSZ2p89T3D3bidPw==
X-Google-Smtp-Source: ABdhPJwn8T97yctSQxi5OTHQMz+HYgvDmw/sXGa5xNT0uawd//Zq+N5B8cWPcdmjHM1c0eb8XHblqA==
X-Received: by 2002:aa7:9ad7:0:b029:160:948:44a6 with SMTP id
 x23-20020aa79ad70000b0290160094844a6mr7131860pfp.25.1604025311560; 
 Thu, 29 Oct 2020 19:35:11 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id f4sm1245479pjs.8.2020.10.29.19.35.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 19:35:10 -0700 (PDT)
Subject: Re: [PATCH] powerpc: add support for TIF_NOTIFY_SIGNAL
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <7adea1eb-d193-9d31-6244-e8cd5b2084b2@kernel.dk>
 <871rhgwnc1.fsf@mpe.ellerman.id.au>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <724c3821-161b-a82c-a19d-03c7f4fc3741@kernel.dk>
Date: Thu, 29 Oct 2020 20:35:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <871rhgwnc1.fsf@mpe.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/29/20 6:48 PM, Michael Ellerman wrote:
> Jens Axboe <axboe@kernel.dk> writes:
>> Wire up TIF_NOTIFY_SIGNAL handling for powerpc.
>>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>
>> 5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
>> for details:
>>
>> https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe@kernel.dk/
>>
>> As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs,
>> as that will enable a set of cleanups once all of them support it. I'm
>> happy carrying this patch if need be, or it can be funelled through the
>> arch tree. Let me know.
> 
> Happy for you to take it along with the rest of the series.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Great, thanks Michael! Added.

-- 
Jens Axboe

