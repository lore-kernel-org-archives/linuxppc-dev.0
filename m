Return-Path: <SRS0=KYNf=C2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904DCC43461
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 19:46:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 919E021D41
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 19:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919E021D41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BsnXc3SSpzDqW2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2020 05:46:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=davemloft.net
 (client-ip=2620:137:e000::1:9; helo=shards.monkeyblade.net;
 envelope-from=davem@davemloft.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=davemloft.net
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2620:137:e000::1:9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BsnVc3yFLzDqJK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2020 05:44:54 +1000 (AEST)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 7E0491359EF9C;
 Thu, 17 Sep 2020 12:28:01 -0700 (PDT)
Date: Thu, 17 Sep 2020 12:44:45 -0700 (PDT)
Message-Id: <20200917.124445.1786301672047605176.davem@davemloft.net>
To: mpe@ellerman.id.au
Subject: Re: [PATCH -next] ide: Fix symbol undeclared warnings
From: David Miller <davem@davemloft.net>
In-Reply-To: <87zh5oobnn.fsf@mpe.ellerman.id.au>
References: <20200916092333.77158-1-wangwensheng4@huawei.com>
 <87zh5oobnn.fsf@mpe.ellerman.id.au>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [2620:137:e000::1:9]);
 Thu, 17 Sep 2020 12:28:01 -0700 (PDT)
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
Cc: wangwensheng4@huawei.com, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 17 Sep 2020 22:01:00 +1000

> Wang Wensheng <wangwensheng4@huawei.com> writes:
>> Build the object file with `C=2` and get the following warnings:
>> make allmodconfig ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu-
>> make C=2 drivers/ide/pmac.o ARCH=powerpc64
>> CROSS_COMPILE=powerpc64-linux-gnu-
>>
>> drivers/ide/pmac.c:228:23: warning: symbol 'mdma_timings_33' was not
>> declared. Should it be static?
>> drivers/ide/pmac.c:241:23: warning: symbol 'mdma_timings_33k' was not
>> declared. Should it be static?
>> drivers/ide/pmac.c:254:23: warning: symbol 'mdma_timings_66' was not
>> declared. Should it be static?
>> drivers/ide/pmac.c:272:3: warning: symbol 'kl66_udma_timings' was not
>> declared. Should it be static?
>> drivers/ide/pmac.c:1418:12: warning: symbol 'pmac_ide_probe' was not
>> declared. Should it be static?
>>
>> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
>> ---
>>  drivers/ide/pmac.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> TIL davem maintains IDE?
> 
> But I suspect he isn't that interested in this powerpc only driver, so
> I'll grab this.

I did have it in my queue, but if you want to take it that's fine too :)
