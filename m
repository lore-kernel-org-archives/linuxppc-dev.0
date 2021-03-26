Return-Path: <SRS0=j/g1=IY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55823C433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 14:08:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7BFC619CB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 14:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BFC619CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6P2r0HnSz3c6X
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Mar 2021 01:08:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=Dh7dx+ZZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::829;
 helo=mail-qt1-x829.google.com; envelope-from=danielhb413@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Dh7dx+ZZ; dkim-atps=neutral
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6P2M6GW7z2yhs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Mar 2021 01:08:10 +1100 (AEDT)
Received: by mail-qt1-x829.google.com with SMTP id i19so4270530qtv.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Mar 2021 07:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=vuKxDYahmwdMyoe1S0fSlxX5rMXxNCpigWRyydmBVwA=;
 b=Dh7dx+ZZrD4TNXl0F4eqps4X/KPnNvRsnNQyxhIO07A9C4iV2+CPzsqJntxyz4RxbX
 z154WOwgD2uF28D6E9LPZktW8toyyDLsAufQZsvf8lW/SzN4b7rVNjTo46PPicFH6j8z
 k2c3Nxu1x+u5YE0LqbgxfyWjMHt2wLyPQp5ZvQzZfyP3UE8KgkZ7xZ8jXh9OJ+timAFN
 RxBenxKLzS8UlJ6dgUl0+q0ttz25852phoQqVCVhSRvT2p9z0/14qGM8jfqDvs8votCG
 RpOIPLQ4/dI+SeIxYf3ISQqSd4lt5q2t/Pw1tlHyyYop5xioUx35fdeIswBDXHnM7lt1
 pCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vuKxDYahmwdMyoe1S0fSlxX5rMXxNCpigWRyydmBVwA=;
 b=OgazB+FNHHa2gqdjY9gtcUFgcAzJ+uIVQvs++gLqMk6WIjOx4fdp4uFoSFHTm5vooF
 kY0a5ttCO6yVxow0GSNW4MWWxGWbzOATZjeRgMqdUZHmiBzgtpcMONIoTAV+t4lZ0Rk3
 ruX+g9oRV8ivlTIhozUYNapZPGTXZZsPaNdWFUzeDyOIJrext/hQSs0jZUE36gF4wLa+
 ssvMsb5akzTeDtK3P7uBVUQC7RJNUtW8O3f/pWmI/pMeULICAGTFnXSe6p4zJf1JS1kY
 CcByN93ByW3u+MUhIGmdQZ0ZYihDfg/JqZFQga9KyilF+/Si1j+uOI+Yqyh+3WjyehkT
 u4JQ==
X-Gm-Message-State: AOAM531UOIOYwZbcwnrEQOQkeo0ZybaimPxcCfLP/ylk4vwUXGoljpm2
 RnyqWKTsRlQVtifX1/L981DBLq2g+i0=
X-Google-Smtp-Source: ABdhPJxi5Wgukq5rleYGPQT9oPuKGnqo1X3dfoXXD2gZ4rs68DBjjLcNcZITriaKQnogaJ7daSEHLA==
X-Received: by 2002:ac8:4b58:: with SMTP id e24mr12187488qts.120.1616767685842; 
 Fri, 26 Mar 2021 07:08:05 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c6:3fd7:65e0:e5c6:f4fc:733c?
 ([2804:431:c7c6:3fd7:65e0:e5c6:f4fc:733c])
 by smtp.gmail.com with ESMTPSA id d24sm6461963qkl.49.2021.03.26.07.08.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Mar 2021 07:08:05 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] hotplug-cpu.c: show 'last online CPU' error in
 dlpar_cpu_offline()
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
References: <20210323205056.52768-1-danielhb413@gmail.com>
 <20210323205056.52768-2-danielhb413@gmail.com>
 <871rc28p1w.fsf@linkitivity.dja.id.au>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <b9a6e77c-4319-ff08-493f-43e02388701b@gmail.com>
Date: Fri, 26 Mar 2021 11:08:01 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <871rc28p1w.fsf@linkitivity.dja.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
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

Hey Daniel,

On 3/26/21 2:24 AM, Daniel Axtens wrote:
> Hi Daniel,
> 
> Two small nitpicks:
> 
>> This patch adds a 'last online' check in dlpar_cpu_offline() to catch
>> the 'last online CPU' offline error, eturning a more informative error
>                                         ^--- s/eturning/returning/;
> 
> 
>> +			/* device_offline() will return -EBUSY (via cpu_down())
>> +			 * if there is only one CPU left. Check it here to fail
>> +			 * earlier and with a more informative error message,
>> +			 * while also retaining the cpu_add_remove_lock to be sure
>> +			 * that no CPUs are being online/offlined during this
>> +			 * check. */
> 
> Checkpatch has a small issue with this comment:
> 
> WARNING: Block comments use a trailing */ on a separate line
> #50: FILE: arch/powerpc/platforms/pseries/hotplug-cpu.c:279:
> +			 * check. */
> 
> Apart from that, this patch seems sane to me, but I haven't been able to
> test it.


Thanks for the review, and for letting me know of the existence of
'scripts/checkpatch.pl' to verify the patches before posting. I'll
send a v3.


Thanks,


DHB


> 
> Kind regards,
> Daniel
> 
