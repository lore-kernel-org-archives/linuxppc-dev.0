Return-Path: <SRS0=OEx3=NM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43D3C6786F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 17:02:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184D92081B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 17:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsL5aqC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184D92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42mBMP6DX9zF3G9
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 04:02:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CsL5aqC3";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=eric.dumazet@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="CsL5aqC3"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42mBJf0hMjzF3Mm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Nov 2018 03:59:42 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id q5-v6so5606901pgv.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Nov 2018 09:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uiasgtM/p2VjObQyowWTRMYBJV4UN1vpzjydvWmpilw=;
 b=CsL5aqC3fgiWUT/vnO3c3Iz6dowQUJGH0LtWvq37CQkceZVg7q9lfb2nJokjeut3eg
 uutEzFXPiRF2SuEDNe2tOGJKEA0GpbIi8xfgI3bb5neR91zQr0opxUxOoe0FdWE849nL
 ThYqgTV7KEg6hDd0vXnCAUXj/zZbx3bwxlwqUd8G9+1mw8Hrepwn695WW+cHC11z6UTk
 B/sCZmZHaElfOybrgyjSqI/jzdQLygz8ed7V5A1XiKETD/2kKExaQPTlAuirLMj7Ucv8
 +8bGff0edSwtGLkq56+AGyWh5lVKRWshTvFVXf5FSn1hQOog04TCVgw+d04fvk5y51bK
 PsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uiasgtM/p2VjObQyowWTRMYBJV4UN1vpzjydvWmpilw=;
 b=BXqGBaUkiVGIxvs/ZbCm1Fx+t5HHRLCr1oIWulQuCXFsaBfrUmKxzsWpWH16Uk/5ss
 ErBEsMBslBIanyA5Rao9VK+aND9ZVG9w7xks7hDI5blMz01xrHbFrHp8apIm9MR9kKq1
 GS29Mse9ulUgSLJ9Vs7TqiCqZojXQeSXrZBOv4Z0LPSOmAlvveRwt8wOgZ79xs9pL8Wi
 Hw5fNxFE3HMlKCmDKLkHr/raY85naSMvRP0RRkSOjzmp1B197gjUhu9aNOCdz+2Tyuiq
 F3OB0vGS+CH67SrgL1q8eHhg4afyJVRaPA1Ola8e1BRJYNIdfPfXx6KZx61m8clABfpk
 PIEw==
X-Gm-Message-State: AGRZ1gJz5jsWbyi7t8dvL3iroGuqfl51vujSXirTJ/WrKko4tsLsGIAn
 XNH32Dk1M6LN+ER47bIUXgY=
X-Google-Smtp-Source: AJdET5dZ17VY146v8M8MAXofuxvt+4Be+sC26ENz/XUmO6FhZfoX1HeV6Bo7f7nv+PI/WAq9YyKzJQ==
X-Received: by 2002:a62:9f90:: with SMTP id
 v16-v6mr8498448pfk.207.1541091580382; 
 Thu, 01 Nov 2018 09:59:40 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b?
 ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
 by smtp.gmail.com with ESMTPSA id u62-v6sm53459766pfu.69.2018.11.01.09.59.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Nov 2018 09:59:39 -0700 (PDT)
Subject: Re: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it
 where needed
To: Peter Zijlstra <peterz@infradead.org>,
 Trond Myklebust <trondmy@hammerspace.com>
References: <1541015538-11382-1-git-send-email-linux@roeck-us.net>
 <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
 <20181031220253.GA15505@roeck-us.net>
 <20181031233235.qbedw3pinxcuk7me@pburton-laptop>
 <4e2438a23d2edf03368950a72ec058d1d299c32e.camel@hammerspace.com>
 <20181101131846.biyilr2msonljmij@lakrids.cambridge.arm.com>
 <20181101145926.GE3178@hirez.programming.kicks-ass.net>
 <f38e272f7a96e983549e4281aa9fd02833a4277a.camel@hammerspace.com>
 <20181101163212.GF3159@hirez.programming.kicks-ass.net>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <b0160f4b-b996-b0ee-405a-3d5f1866272e@gmail.com>
Date: Thu, 1 Nov 2018 09:59:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181101163212.GF3159@hirez.programming.kicks-ass.net>
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bfields@fieldses.org" <bfields@fieldses.org>,
 "paulus@samba.org" <paulus@samba.org>, "jhogan@kernel.org" <jhogan@kernel.org>,
 aryabinin@virtuozzo.com, Paul McKenney <paulmck@linux.vnet.ibm.com>,
 "linux@roeck-us.net" <linux@roeck-us.net>, "arnd@arndb.de" <arnd@arndb.de>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>, dvyukov@google.com,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ralf@linux-mips.org" <ralf@linux-mips.org>,
 "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
 "paul.burton@mips.com" <paul.burton@mips.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 11/01/2018 09:32 AM, Peter Zijlstra wrote:

>> Anyhow, if the atomic maintainers are willing to stand up and state for
>> the record that the atomic counters are guaranteed to wrap modulo 2^n
>> just like unsigned integers, then I'm happy to take Paul's patch.
> 
> I myself am certainly relying on it.


Could we get uatomic_t support maybe ?

This reminds me of this sooooo silly patch :/

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=adb03115f4590baa280ddc440a8eff08a6be0cb7

