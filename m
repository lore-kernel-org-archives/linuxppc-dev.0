Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC843C070C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 03:23:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F15320652
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 03:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLmS7sgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F15320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YP0S0qMGzF38y
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 14:23:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sLmS7sgM";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="sLmS7sgM"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YNxs2rfrzDqh2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 14:21:05 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id l81-v6so8936842pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 20:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4aF6c9JbvpH1PKbxxpCn88IfRAjR/ztFrYMFBZ+rTg0=;
 b=sLmS7sgMLX974RGRayN+6vztFOpfK9eaY5nwvJjCcUM/zoAZccFbVhZPi3nA9GsAqr
 Mf/RxgXy6gd1t3qO5wtEs4ZuKcYo1vW6RHQR89E64uzT91pOwMYIKg4sixIn7eIoyonF
 W9dYfQfQd/2vorn/thyhlPfgWjuZuT5oU7IjRkcJ5Dmkad/ORVGgn+tBifiOj734wan3
 0Oq2ubMggw2SHVLwo0LBt1zPKV3TuSCgJ96uqZytrkES8oco/8Bx5ZEzzbiBTKYGgEcI
 Yce1PVUPj+xBjdK1fytAcXNVAvIAI5OTN9OXXwdujCnZHQAXauUihaJXwUssHvHvWfCx
 5sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4aF6c9JbvpH1PKbxxpCn88IfRAjR/ztFrYMFBZ+rTg0=;
 b=bqC5MXS+8sXbT780bwGCXpLPWkMW7NC6BkdGJK9gAIJnhAPqvH0+mIxpl/AfCvvksQ
 L8d1P+xJtWVfOcZx7gNDkjBO+h2M4AVaBM08iTEiQ0RUxnjirYXG8+Bssp365BQwNKWP
 dwY9REaLm8t35L/LEZcgVcCd2203VtruhRLdPhSWCgCstND1CQSCtYA4xLOLFfxN14H2
 Q6KVijE6/5+nRUQvoqbcH3rwAU6ccuqF8KRBHgQMRhDKsavnK+NDNexlfnT5wrBetblw
 uA7XBo7yTumpjAL0H2Bv9QC/NUP1mYfT1AESjA7pncrmcLCDa9lRJU59N0Nhp+VQXHMV
 iM9g==
X-Gm-Message-State: ABuFfoi8uterUhUmkU4d7O/2hhnoB0R4kMWUchwcSh/FgqBUnJvhhGzb
 fzCuPKAVXRwZJQXrux4ms5c=
X-Google-Smtp-Source: ACcGV63ZaGG/lmONYDZGCa+McbcB5tPxOz0LbLXe/zyr3p9Hc8MXEAiYIN0ry7jutrKFYOpD6ytyVw==
X-Received: by 2002:a65:40c2:: with SMTP id
 u2-v6mr14468908pgp.123.1539573663420; 
 Sun, 14 Oct 2018 20:21:03 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id m15-v6sm15633236pgt.28.2018.10.14.20.21.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 14 Oct 2018 20:21:02 -0700 (PDT)
Subject: Re: [PATCH v3 13/18] of: overlay: check prevents multiple fragments
 touching same property
To: Joe Perches <joe@perches.com>, Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
 <1539563070-12969-14-git-send-email-frowand.list@gmail.com>
 <b6ee53f7e02cc3ea52713ae82402e97d7050cb3e.camel@perches.com>
 <850f0866-1189-5a49-01c5-79caf270abbd@gmail.com>
 <16f48648393366d91e43cd66b3d0a346b1ed29ab.camel@perches.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <e045d69a-7896-3ff1-8472-2f51c2468d7f@gmail.com>
Date: Sun, 14 Oct 2018 20:21:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <16f48648393366d91e43cd66b3d0a346b1ed29ab.camel@perches.com>
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
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/14/18 18:55, Joe Perches wrote:
> On Sun, 2018-10-14 at 18:52 -0700, Frank Rowand wrote:
>> On 10/14/18 18:06, Joe Perches wrote:
>>> On Sun, 2018-10-14 at 17:24 -0700, frowand.list@gmail.com wrote:
>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>
>>>> Add test case of two fragments updating the same property.  After
>>>> adding the test case, the system hangs at end of boot, after
>>>> after slub stack dumps from kfree() in crypto modprobe code.
> []
>>> I think this is worse performance than before.
>>>
>>> This now walks all entries when before it would
>>> return -EINVAL directly when it found a match.
>>
>> Yes, it is worse performance, but that is OK.
>>
>> This is a check that is done when a devicetree overlay is applied.
>> If an error occurs then that means that the overlay was incorrectly
>> specified.  The file drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
>> in this patch provides an example of how a bad overlay can be created.
>>
>> Once an error was detected, the check could return immediately, or it
>> could continue to give a complete list of detected errors.  I chose to
>> give the complete list of detected errors.
> 
> Swell.  Please describe that in the commit message.

If a version 4 of the series is created I will update the commit
message.  As a stand alone item I do not think it is worth a
new version.

-Frank
