Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AADC4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 01:50:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE34860F5E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 01:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE34860F5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gq9p25GkCz3cQd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 11:50:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=xianting.tian@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gq9nW4L2Fz2yy3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Aug 2021 11:49:46 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394;
 MF=xianting.tian@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0UjaFm7B_1629251367; 
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com
 fp:SMTPD_---0UjaFm7B_1629251367) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 18 Aug 2021 09:49:27 +0800
Subject: Re: [PATCH v7 1/2] tty: hvc: pass DMA capable memory to put_chars()
To: Greg KH <gregkh@linuxfoundation.org>
References: <20210817132300.165014-1-xianting.tian@linux.alibaba.com>
 <20210817132300.165014-2-xianting.tian@linux.alibaba.com>
 <YRvaN0RwW03kkO1O@kroah.com>
From: Xianting TIan <xianting.tian@linux.alibaba.com>
Message-ID: <1a0587cc-97e0-62b7-026e-2ee74ed5089c@linux.alibaba.com>
Date: Wed, 18 Aug 2021 09:49:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YRvaN0RwW03kkO1O@kroah.com>
Content-Type: text/plain; charset=gbk; format=flowed
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
Cc: arnd@arndb.de, amit@kernel.org, jirislaby@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, osandov@fb.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


ÔÚ 2021/8/17 ÏÂÎç11:48, Greg KH Ð´µÀ:
> On Tue, Aug 17, 2021 at 09:22:59PM +0800, Xianting Tian wrote:
>> We tested the patch, it worked normally.
> Who is "we"?
>
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> Like I said before, I need another developer from your company to review
> and sign-off on this patch (and the other one), before I am willing to
> look at it, based on the previous mistakes that have happened here.
thanks, I will add the developer in v8 and also with fix a build 
warning, which I don't meet in my build process.
>
> thanks,
>
> greg k-h
