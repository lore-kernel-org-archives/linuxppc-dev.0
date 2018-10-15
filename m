Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2DBC7113E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 19:33:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F959208D9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 19:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG5xK6o7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F959208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YpWN2Q50zF3Cb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 06:33:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eG5xK6o7";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="eG5xK6o7"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YpS75fVlzF3CT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 06:30:15 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id 23-v6so9627489pgc.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 12:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=txs08WYIQldNuSxsaJcvv7BGm6c3Ca6Y9k3ss7JzIpk=;
 b=eG5xK6o7Qi3i2C02Ow7uOTNgscIeoDf1ygA3c2Wd5NzemriGEcMe2s/ZrOiOTuBh/9
 Q+TR/0y82oz0Yb3hrHgGCH3lXkElwqu2WEJqV0+gg+9SQMvQsf19PGC0W7YuPdd7OuNa
 M1+9LGvoWXufhw33MKagu+9wwHmUNVcyZXiv9IdiYSkkA2rzI0AOJMF9i76pj0g5W55w
 CR3L4VE9wIwaXW2Vv5VSMp0GNl7Rs+0bKKea4eeXKmWk0zHvsWDjABN88I2ipINhq/Xs
 +17WluOtUFsc/ME8FIGO8P5k1BJlfSnJYq94tYiYV4sg7aWU9dpEBVIAdMnHQn++/A7o
 fZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=txs08WYIQldNuSxsaJcvv7BGm6c3Ca6Y9k3ss7JzIpk=;
 b=id/Ac7yHOL5fuDUC84IAr6a34ulfyLZEpRhauO31olG7UwxDpb6passWy8oCXktPQO
 eSvkqtyzjIdjKkblsvTDYo2LV0Mbnd2ARQd9Gmj0GFRkbkNp3b8JjZAvFhp6DUuwF/L8
 9+oRVjWVDrip2u8Q4OeMRItRKcb9PPSZOBsQImwrf9R5eco/QgI8vHR3lD7QF8154WdX
 0UCu2Z+i6cVwJg8OW5L4BgTRcdilHVGNfLCl9FM9S6bTY7jysYqYxXyvSq0cg5HYhHZ2
 Ti9+qlNWzzDNkuCJuvkXbzTk44omfreODE4lsuR/atChZA78tCLKCbOrW+P/E4WtNoCs
 TVyA==
X-Gm-Message-State: ABuFfog0K2b8J/D4wzrz86N3r9m/+jy47BgaZwhCleUcGafkJCR0l0px
 INc7EmzYU9S9MVjU27mJRIY=
X-Google-Smtp-Source: ACcGV61vKAmZkHDZIt5EegVYVDuoF5zWvgrjGdX41VfDHrb/akBxa8lQQqC+xsTkIOOPkyZUzkXrgQ==
X-Received: by 2002:a62:4681:: with SMTP id
 o1-v6mr18721802pfi.108.1539631813699; 
 Mon, 15 Oct 2018 12:30:13 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id c21-v6sm23955309pfe.93.2018.10.15.12.30.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Oct 2018 12:30:13 -0700 (PDT)
Subject: Re: [PATCH v3 13/18] of: overlay: check prevents multiple fragments
 touching same property
From: Frank Rowand <frowand.list@gmail.com>
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
 <e045d69a-7896-3ff1-8472-2f51c2468d7f@gmail.com>
Message-ID: <f7797d5b-7b9c-5279-b388-31c7a01f48d1@gmail.com>
Date: Mon, 15 Oct 2018 12:30:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e045d69a-7896-3ff1-8472-2f51c2468d7f@gmail.com>
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

On 10/14/18 20:21, Frank Rowand wrote:
> On 10/14/18 18:55, Joe Perches wrote:
>> On Sun, 2018-10-14 at 18:52 -0700, Frank Rowand wrote:
>>> On 10/14/18 18:06, Joe Perches wrote:
>>>> On Sun, 2018-10-14 at 17:24 -0700, frowand.list@gmail.com wrote:
>>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>>
>>>>> Add test case of two fragments updating the same property.  After
>>>>> adding the test case, the system hangs at end of boot, after
>>>>> after slub stack dumps from kfree() in crypto modprobe code.
>> []
>>>> I think this is worse performance than before.
>>>>
>>>> This now walks all entries when before it would
>>>> return -EINVAL directly when it found a match.
>>>
>>> Yes, it is worse performance, but that is OK.
>>>
>>> This is a check that is done when a devicetree overlay is applied.
>>> If an error occurs then that means that the overlay was incorrectly
>>> specified.  The file drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
>>> in this patch provides an example of how a bad overlay can be created.
>>>
>>> Once an error was detected, the check could return immediately, or it
>>> could continue to give a complete list of detected errors.  I chose to
>>> give the complete list of detected errors.
>>
>> Swell.  Please describe that in the commit message.
> 
> If a version 4 of the series is created I will update the commit
> message.  As a stand alone item I do not think it is worth a
> new version.

And there will be a version 4, so I will update the commit message.

-Frank
