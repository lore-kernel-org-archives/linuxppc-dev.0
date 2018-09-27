Return-Path: <SRS0=O7I3=MJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6178C004D5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 20:31:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48EBD216FE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 20:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EBD216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42LmfZ0vRbzF37v
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 06:31:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.194; helo=mail-qt1-f194.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LmcJ71pszF37q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 06:29:04 +1000 (AEST)
Received: by mail-qt1-f194.google.com with SMTP id z13-v6so4286608qts.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 13:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E6UolQnHSWw3dtRGNI3HSICE9ylPREuzUc8HPlYIZrI=;
 b=j8SX+K9U0ruYAu31MNwjxduJnkRd0JcgRca6X29SizuwMBmqvXkh4HsP6QDGxE/po4
 GrWe7TgZBbfcTM7e9CGZbJPbcbuDEl5BrOd1PhDFoNNSVc4K60erTdISMtoIffyrCDvl
 VcLGrLcAWslMhvtThMhw2/xuxbUuWkhWuSE3JqimpspSXSYMNP0/IUsPXzAYQ5LUnjQ2
 hNs+x/3FbvFiKdNhD4K1Nu/yrMJiutF1jM0Cc08f1tSXW88l7qFqDBo+PlGMc7hChQ0Y
 eRGKDIOEL8f2suGEnX1V6ZQunYo9g+I6SVNfu6jqDF64znsWb6vNYzdW+v7rqxCHJL2f
 srlQ==
X-Gm-Message-State: ABuFfogb48IGiC9kW8QQq7JlJ2Xk6Udj+gwGJY+Kq2I/wVitTS3xDCIJ
 lDiTdyQYeTjreDRhRiUeCwM=
X-Google-Smtp-Source: ACcGV61beIFVh1HJpa11rVevbxj2UpREfBxHbeyshIqxV9JWiBerAd3SLMGfh/zffrTzEugAplikXg==
X-Received: by 2002:aed:2f27:: with SMTP id
 l36-v6mr10047723qtd.333.1538080142435; 
 Thu, 27 Sep 2018 13:29:02 -0700 (PDT)
Received: from [10.0.0.9] ([177.83.210.7])
 by smtp.gmail.com with ESMTPSA id 192-v6sm1726398qke.3.2018.09.27.13.29.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Sep 2018 13:29:01 -0700 (PDT)
Subject: Re: [RFC PATCH 01/11] powerpc/tm: Reclaim transaction on kernel entry
To: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <1536781219-13938-2-git-send-email-leitao@debian.org>
 <5013d84a59185cd7a1b941e6cc145a1fbfe52f48.camel@neuling.org>
From: Breno Leitao <leitao@debian.org>
Message-ID: <1e00c875-436f-8cae-8d6e-032402486c80@debian.org>
Date: Thu, 27 Sep 2018 17:28:57 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5013d84a59185cd7a1b941e6cc145a1fbfe52f48.camel@neuling.org>
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
Cc: ldufour@linux.vnet.ibm.com, gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
Message-ID: <20180927202857.f0l8TH6t7d5q0g3Dj8JBqRvoDrWwSGpNRoXfU1Hn8B4@z>

Hi Mikey,

On 09/17/2018 10:31 PM, Michael Neuling wrote:
> On Wed, 2018-09-12 at 16:40 -0300, Breno Leitao wrote:
>> This patch creates a macro that will be invoked on all entrance to the
>> kernel, so, in kernel space the transaction will be completely reclaimed
>> and not suspended anymore.
> 
> There are still some calls to tm_reclaim_current() in process.c. Should these
> probably go now, right?

Yes, we shouldn't not call tm_reclaim_current() from anywhere else other than
TM_KERNEL_ENTRY anymore.

That said, I think we can still have some references for tm_reclaim_current()
in some specific checkpoints. Something as:

        if (WARN_ON(MSR_TM_SUSPENDED(mfmsr())))
                tm_reclaim_current(0);

I initially wrote something as BUG_ON(MSR_TM_SUSPENDED(mfmsr()) but
scripts/checkpatch.pl suggested me writing a WARN_ON() and create a recovery
pass, which seems fair.

Anyway, if you think it is not a good strategy, I can get rid of them at v2.

Thank you!
