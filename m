Return-Path: <SRS0=O2mS=VM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40F6C76190
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 08:46:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EFC52054F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 08:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="p2L8qy60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFC52054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nHFb0hgdzDqQ9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jul 2019 18:46:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="p2L8qy60"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nGxw6XJRzDqT3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2019 18:33:08 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id t132so7351944pgb.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2019 01:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=akvymdxgXwZ4Gkh0YWtLHlMVQ+ba1wF2b4/H3QIPWMU=;
 b=p2L8qy60QB7k6t08eaJEWXoj+MYTbd+17uWWvP3KbKlQre/cCOIhvo2KuXpr1Smknn
 FQLvQXEFAiWY5VnIc4XF9JaiaR4giXJic8/sechNj4y/R2GjKCue0tngg29vDDA//s/9
 ImXwqlezlEb04CrbIqoce8MnlQqL4hFe+RvxYsrcb7V4TerhNcTB08AOzXdTcmZYlf7K
 Bqo11zSO7w26j6xNeeuQ4NdRaMIbRlEcKDbEVtFgKNgRwEbPJfCF0FVAb38onQdBdfVr
 2bBBoqgu4NOfqb94DkxMbWLCP5nRc86DOCjmuM1UI5uhFSDnHNCDwELpL3tTz49WqtUl
 91cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=akvymdxgXwZ4Gkh0YWtLHlMVQ+ba1wF2b4/H3QIPWMU=;
 b=DQMHJCab2hHF4KtoPN0KoNrW1ygIzY16g4VrNn57FvbE7ped+kqj4EQPjgMBFtIpCO
 8KiuJ792fle1uRuI8I9w3b6GwBpVQTvuLOJcp51AEXj4HoFFM7nUtXiXDtn+XmLejhaH
 TMvLamx7cQoxDkqLwv9910u1l8eEIXqqe5vKOfFf/V3lSESMCkYR2GfN3kTN5CpAQIId
 VzSF1UFmI3fTDIgO2AgFTUT3lcprrE8m0WOpGGa2qhUNdUtGJ84KUkRVAe60HyX2BJxq
 uICU9DpkvPA4H9EPXZXP+9+A6wtKQuZ0D/d2N0yTkIPjJAflvtSCr3TsWcSufvkMLEdd
 BqDw==
X-Gm-Message-State: APjAAAXY1wndsU2F3LglSoei/HyM848xLJlJEXAr0brssvp5wRzPr53/
 qaeyNkhjyYJe7BPpAj8+P50=
X-Google-Smtp-Source: APXvYqw1/DIUzsmdQ0Kdr6XI5pI/tuoSPv+KhvD2u+bTr04g+stzjsQXoAhOfkvyPH+bCIYchc6cMw==
X-Received: by 2002:a65:500d:: with SMTP id f13mr25246188pgo.151.1563179585439; 
 Mon, 15 Jul 2019 01:33:05 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id r6sm25253551pjb.22.2019.07.15.01.33.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jul 2019 01:33:04 -0700 (PDT)
Subject: Re: [PATCH kernel v4 2/4] powerpc/iommu: Allow bypass-only for DMA
To: Christoph Hellwig <hch@infradead.org>
References: <20190712094509.56695-1-aik@ozlabs.ru>
 <20190712094509.56695-3-aik@ozlabs.ru> <20190712152044.GA3061@infradead.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <1e9d2b30-015d-130e-4d83-c222f87afdc1@ozlabs.ru>
Date: Mon, 15 Jul 2019 18:33:00 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712152044.GA3061@infradead.org>
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
Cc: Sam Bobroff <sbobroff@linux.ibm.com>,
 Alistair Popple <alistair@popple.id.au>, Oliver O'Halloran <oohall@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 13/07/2019 01:20, Christoph Hellwig wrote:
>> This skips the 32bit DMA setup check if the bypass is can be selected.
> 
> That sentence does not parse.  I think you need to dop the "can be"
> based on the actual patch.


"the 32bit DMA setup check" is
"if (!(tbl = get_iommu_table_base(dev)))".

I can rephrase though.


-- 
Alexey
