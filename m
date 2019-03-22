Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F1DC4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 13:31:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8672083D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 13:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="glUXnsMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8672083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Ql133YRKzDqWT
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 00:31:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com;
 envelope-from=daniel.lezcano@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="glUXnsMK"; 
 dkim-atps=neutral
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QkvF0gXwzDqTp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2019 00:26:12 +1100 (AEDT)
Received: by mail-wm1-x342.google.com with SMTP id 4so2165645wmf.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 06:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YUR9BD0OknTRpwxa7omTX6fkLtmusBY0KjBttpuweLE=;
 b=glUXnsMKii9bEJsd3AnwfOBOqdIXHFOFx5dExl4Mk+I2W8ZppOED1boqhtXR8A0CRn
 SoMGbV53PbG4AfKmZQ/ImldKle2BsZWz2EZqTINPFGxIcZuywL4OFB3dvwOydi/BDzPW
 15d3R6uet+l+z+Y4HvYk/tGbWqOcD3HbzfZXsPGY4F89aFOfMPd62DB4G/c96TGx0BDQ
 XJYUL526glwi4kGRbGAmYiqnm85yTbXk9sYr0RoM3KeTdZ8CWRdW2d+C5sM981IZy2bg
 qFBQQUO/jFNxpIvKH01+B+F5NTwVTkJ+mRNul5oWXhWMzkCSQVaQhArQSY+AFGFmBWgu
 iZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YUR9BD0OknTRpwxa7omTX6fkLtmusBY0KjBttpuweLE=;
 b=QvxJkPAIl0IAfTK6gzxOgCQiZCKLhRedv6wgdIPhewVwh4naKsLmu0bkNpPfbFXkM0
 0YtMkQLdY98UtPRD+D81L8yzdCNmlrG6dE/S0490omWBOTSG9QKWn1TvVzJDX7mz/WAn
 oFTSiqbpI6VAgO76pEEpeAIoCdHb90HMxWLW/7ODlCu4dU8uQbwTJ/dq2qMDD13vwVYt
 3/0VdiCCeoKZ7tV+l+Ki8MuzaVTvprSgjgUViKi9wlsuUUAx+uUhtj/BAxep7wCktotM
 V6LidUc7um5BpU7VWQhXV93ZMip7xxPQNuJNMWgKiKdmJFjj3xo9mKwZZHsexaVszHTu
 y6ow==
X-Gm-Message-State: APjAAAV1nNCLKaPn0W32u24wpMbsHYhm1Ljs4la1ypl4EtJJ0izjWdJq
 saS4D5OE9tWiDDw5W6R3OGd34g==
X-Google-Smtp-Source: APXvYqwi0WvccLBM3J2CJUBQR+V2TOQ3nUIFcN6vLmKaJGFAyjNJoPKgU/Rke4qOFsxwyFYLGQX8JA==
X-Received: by 2002:a1c:ef08:: with SMTP id n8mr1936534wmh.85.1553261168923;
 Fri, 22 Mar 2019 06:26:08 -0700 (PDT)
Received: from [192.168.0.41] (205.94.129.77.rev.sfr.net. [77.129.94.205])
 by smtp.googlemail.com with ESMTPSA id b16sm7143988wrq.41.2019.03.22.06.26.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Mar 2019 06:26:08 -0700 (PDT)
Subject: Re: [PATCH 1/2] cpuidle : auto-promotion for cpuidle states
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Abhishek Goel <huntbag@linux.vnet.ibm.com>
References: <20190322072942.8038-1-huntbag@linux.vnet.ibm.com>
 <20190322072942.8038-2-huntbag@linux.vnet.ibm.com>
 <CAJZ5v0gY-theHng=bQQpw-33jHGe++iEigEM5j6Ls7vEuewuSQ@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cfb0076f-0b56-f12c-a736-469a3d11ab83@linaro.org>
Date: Fri, 22 Mar 2019 14:26:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gY-theHng=bQQpw-33jHGe++iEigEM5j6Ls7vEuewuSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 22/03/2019 10:45, Rafael J. Wysocki wrote:
> On Fri, Mar 22, 2019 at 8:31 AM Abhishek Goel
> <huntbag@linux.vnet.ibm.com> wrote:
>>
>> Currently, the cpuidle governors (menu /ladder) determine what idle state
>> an idling CPU should enter into based on heuristics that depend on the
>> idle history on that CPU. Given that no predictive heuristic is perfect,
>> there are cases where the governor predicts a shallow idle state, hoping
>> that the CPU will be busy soon. However, if no new workload is scheduled
>> on that CPU in the near future, the CPU will end up in the shallow state.
>>
>> In case of POWER, this is problematic, when the predicted state in the
>> aforementioned scenario is a lite stop state, as such lite states will
>> inhibit SMT folding, thereby depriving the other threads in the core from
>> using the core resources.
>>
>> To address this, such lite states need to be autopromoted. The cpuidle-
>> core can queue timer to correspond with the residency value of the next
>> available state. Thus leading to auto-promotion to a deeper idle state as
>> soon as possible.
> 
> Isn't the tick stopping avoidance sufficient for that?

I was about to ask the same :)




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

