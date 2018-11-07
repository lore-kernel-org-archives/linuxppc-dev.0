Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D329C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 15:05:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9232420827
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 15:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgJlK1W6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9232420827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qqVW4YH9zF3Gm
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 02:05:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TgJlK1W6";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="TgJlK1W6"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qqMc5k0ZzF3K3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 01:59:56 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id q19-v6so4977057pll.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Nov 2018 06:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1eaFVBobgO2+QXHP7kWrYOH7nmTnM/w4Kcb/yWpLYbc=;
 b=TgJlK1W6FAVwENeLcqVaQw7vl2JymWUVqmzFdu5+Fsap4ipE1ullBsS6OXSxY8ABX/
 +E63wUubMi+BL9H8bQxVf1F2BL0TZMJhJqfy3enqzZSPjvJ43LAF4+/rZKG/mnjHvNfp
 RlRpj+bVj9OEp981zfH7kI9x1GDdRLn0zxSz8s91vD95hh6d7vN94rALl0N4r4F0fPD5
 0nN3n332EyCaQ+TKcjEs29pILVyM4puIyX0lzIjZAVpUkTXRh7vLCGl44l+WRAh4A0Tt
 8OtDCgVdtqEw0uc4vQnTNXZHu3sfvY6oJbSgQFo5hPJaSWlQ+zh6PWBQtKfgH3XFwgV6
 yVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1eaFVBobgO2+QXHP7kWrYOH7nmTnM/w4Kcb/yWpLYbc=;
 b=tU7YH5CEpWCuyMY/AzEUR4U4A3MUtPW7ySkXLiCTomQBVP59bncMTmUlv6UMv3tyrE
 YwlQccV3DeGmGUd4fTWuyyLgsPn3e1LD76xvFIHabERtW2Ftl+yWyd1BpdtbD/N1yQIn
 DvnNRlO9HgoEvhTxtrVI7QLTzsGGJtX1WPA+nEMLAuS1PfxUrUwfbdkJCVe2Y9ogeN61
 atAnDM3hIGf3E0OaQzZ3Ndduqv4Rimw8KQOblmOHCGVz7Qvkv0FAW+snchiy6xm506n9
 ennfYH4VWaK2U4M5/aFV5PIZykz25TAPX01fj734QJZOEXmsHD2GAcyYVPS9y6cgcw+e
 QexQ==
X-Gm-Message-State: AGRZ1gLoU78qFJC6S/l4A5V5pS8qCjvNRv/80EB0OoQ2cupgh9cFNqCB
 ZzeoThyTfqc38kC+Z9eZaSc=
X-Google-Smtp-Source: AJdET5eA3jOBYhkifsWPUpVzLgYt9L5k9z1cYJimxAQF0YhwLr7XKgZCC4HBO7wvc3jSNCADxelcOA==
X-Received: by 2002:a17:902:443:: with SMTP id
 61-v6mr549370ple.216.1541602795174; 
 Wed, 07 Nov 2018 06:59:55 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id b62-v6sm890605pfa.159.2018.11.07.06.59.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Nov 2018 06:59:54 -0800 (PST)
Subject: Re: [PATCH v6 00/18] of: overlay: validation checks, subsequent fixes
To: Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh+dt@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
 <CAL_JsqJ6fJcqH4+YHrEZRb+8-KFEmL8WSTSE_XSyrtO=2+JQBA@mail.gmail.com>
 <bf1be459-22d7-6b23-7b1f-847dad5e028f@gmail.com>
 <87sh0dqec5.fsf@concordia.ellerman.id.au>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <8d2d4bcb-1349-7bfb-7007-151cb9f19c1b@gmail.com>
Date: Wed, 7 Nov 2018 06:59:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87sh0dqec5.fsf@concordia.ellerman.id.au>
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
Cc: devicetree@vger.kernel.org, Alan Tull <atull@kernel.org>,
 linux-fpga@vger.kernel.org, Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Moritz Fischer <mdf@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/7/18 4:09 AM, Michael Ellerman wrote:
> Frank Rowand <frowand.list@gmail.com> writes:
> 
>> Hi Michael, Ben, Paul,
>>
>> Do you know if anyone has tried this series on PowerPC?
> 
> I have. No obvious breakage.
> 
> My test does a loop of adding and removing multiple CPUs multiple times,
> and in the past that has uncovered refcounting bugs. So I don't think
> we're leaking any with this series applied.
> 
> I used the tracepoint patch to keep an eye on the refcounts :)
> 
>   https://patchwork.ozlabs.org/patch/751602/
> 
> 
> I'm happy for this series to go into linux-next where it should get some
> more testing.
> 
> cheers
> 

Thanks for the reviews and testing.

-Frank
