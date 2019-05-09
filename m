Return-Path: <SRS0=tA1z=TJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE797C04AB1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 May 2019 13:10:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 314EA20863
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 May 2019 13:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmC2wxBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314EA20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 450DGY4rFKzDqP4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 May 2019 23:10:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="lmC2wxBO"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 450DCb3bj4zDqQ3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2019 23:07:39 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id p15so1141392pll.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 May 2019 06:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AMDSOHuntpXjwkDROmPwR3CtgdKHjORZGQxYxRCtzlU=;
 b=lmC2wxBOUUxBpARjaZJqsfJzrZMRiR1P3nYQGJS8kJ6P5trMZHbo2STPMZbf4tl/bE
 dDHY2sVyuBYEF0ALB5HW8JzvmbjsV1krfl5dT/zCQ81Q9ixUMiCD1ZPoG418wrmZwDET
 aRhq1VjdW020hplpfYZAxl2YeuxKk5e5Kl1RH9eEEt8e7cL8JDo6qJ7+bjTF9/rB5cK0
 Feqx4lIgWPvr8arTX2zGvBLZFSf5ORhpt/UAsJkbkp4+yXfm6NNwZ5yn02FSS/dQIPR4
 MvdrffaELUToz2lIp6ProF6siAQo+z1QRuHmHzFXhdPofFSgjIhtCujfEiv/gf9G2iq+
 H1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AMDSOHuntpXjwkDROmPwR3CtgdKHjORZGQxYxRCtzlU=;
 b=cUibo53PauGLryjnh++sKwmdZ6qoj003V0WaNmy1fcKIJlx68Z6scAOi8ICyP9OWIA
 Ut/5tYZUSQdDDyhxpdZau/mXun8RIBbruSPOKYIdOmCGTExGP93MzScoGuliBnAR/LCr
 V9eQy0Q/gaMm2ggp2RHwt7t5Bq6kbgrl/tlP1oSqq6hHI317lDaPLDnKlXZe4zSGCk3a
 FBFYOuUjIN2SVv3ewOObnv0M+DHMQpELegXelYXZwHKARkWQIEqbWIZwimlt4GoxHV2x
 UvFZ+PomYoD1dwRgQaAC1VVvnr1TokNZQCgaz0RLqnScIIpw9ZhWdz8sBGwCF+4Jdat5
 7LfA==
X-Gm-Message-State: APjAAAU6JmmLg2+7nR0W0SKaygfWKT3b/zShJgWm7hTBm/1iBx/4A11a
 wFxdrtdaHE3z6RgMZJx7jW4=
X-Google-Smtp-Source: APXvYqxY64yiv1YSXv40+phLLmGiWlKDHIHmA3rCiS28kXRO7hdD/3Py8T04aZ70WemoqMOckVi6AQ==
X-Received: by 2002:a17:902:e091:: with SMTP id
 cb17mr4891085plb.222.1557407255840; 
 Thu, 09 May 2019 06:07:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 5sm5158382pfs.17.2019.05.09.06.07.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 May 2019 06:07:33 -0700 (PDT)
Subject: Re: Build failure in v4.4.y.queue (ppc:allmodconfig)
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190508202642.GA28212@roeck-us.net>
 <20190509065324.GA3864@kroah.com> <20190509114923.696222cb@naga>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e8aa590e-a02f-19de-96df-6728ded7aab3@roeck-us.net>
Date: Thu, 9 May 2019 06:07:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509114923.696222cb@naga>
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
Cc: linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 5/9/19 2:49 AM, Michal Suchánek wrote:
> On Thu, 9 May 2019 08:53:24 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
>> On Wed, May 08, 2019 at 01:26:42PM -0700, Guenter Roeck wrote:
>>> I see multiple instances of:
>>>
>>> arch/powerpc/kernel/exceptions-64s.S:839: Error:
>>> 	attempt to move .org backwards
>>>
>>> in v4.4.y.queue (v4.4.179-143-gc4db218e9451).
>>>
>>> This is due to commit 9b2d4e06d7f1 ("powerpc/64s: Add support for a store
>>> forwarding barrier at kernel entry/exit"), which is part of a large patch
>>> series and can not easily be reverted.
>>>
>>> Guess I'll stop doing ppc:allmodconfig builds in v4.4.y ?
>>
>> Michael, I thought this patch series was supposed to fix ppc issues, not
>> add to them :)
>>
>> Any ideas on what to do here?
> 
> What exact code do you build?
>
$ make ARCH=powerpc CROSS_COMPILE=powerpc64-linux- allmodconfig
$ powerpc64-linux-gcc --version
powerpc64-linux-gcc (GCC) 8.3.0

Guenter
