Return-Path: <SRS0=QDwo=C3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BF5C43464
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2020 06:28:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B04F20DD4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2020 06:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="cNndsfLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B04F20DD4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bt3n42Q5WzDql5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2020 16:28:24 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bt3kt5bgszDqkS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2020 16:26:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=cNndsfLt; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Bt3ks3H7qz9sRK;
 Fri, 18 Sep 2020 16:26:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1600410390;
 bh=66IDvfqYhq/cJ6uDCcpX38A3C0anTkFpn4s2F7mfs2w=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=cNndsfLtGUdLGgOoCrinazk+VMr1KXMXy9dd2TGqt3E9JdBOhBYJ9X5DDzGCzTxw/
 QIBS9Cqga2ubKLdDl76EuVj5250J8LufnfWTYIeNCmT4Jz9rV28Vg5Uin5Bz6v+0nN
 +KmaGQDIox/B7y/w4B5YVcuVN8slvuESXvFFkTWIyHM3we4F+F8Hg1uU57M9LaK9XG
 b6vTgFe5FzONVQJC1b2aDgb3L7MJqhX3VvYWYqsnmy4ivzdESlYSSb4VvSsLjLe+Pq
 ilMpwno0Ic1x6jOw275XLuzCUUyx6rVicKSbOW/lkIof4m14Pp8g0PMDemepiLYQJI
 xLwZlysNogciQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH -next] ide: Fix symbol undeclared warnings
In-Reply-To: <20200917.124445.1786301672047605176.davem@davemloft.net>
References: <20200916092333.77158-1-wangwensheng4@huawei.com>
 <87zh5oobnn.fsf@mpe.ellerman.id.au>
 <20200917.124445.1786301672047605176.davem@davemloft.net>
Date: Fri, 18 Sep 2020 16:26:28 +1000
Message-ID: <87ft7fob1n.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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

David Miller <davem@davemloft.net> writes:
> From: Michael Ellerman <mpe@ellerman.id.au>
> Date: Thu, 17 Sep 2020 22:01:00 +1000
>
>> Wang Wensheng <wangwensheng4@huawei.com> writes:
>>> Build the object file with `C=2` and get the following warnings:
>>> make allmodconfig ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu-
>>> make C=2 drivers/ide/pmac.o ARCH=powerpc64
>>> CROSS_COMPILE=powerpc64-linux-gnu-
>>>
>>> drivers/ide/pmac.c:228:23: warning: symbol 'mdma_timings_33' was not
>>> declared. Should it be static?
>>> drivers/ide/pmac.c:241:23: warning: symbol 'mdma_timings_33k' was not
>>> declared. Should it be static?
>>> drivers/ide/pmac.c:254:23: warning: symbol 'mdma_timings_66' was not
>>> declared. Should it be static?
>>> drivers/ide/pmac.c:272:3: warning: symbol 'kl66_udma_timings' was not
>>> declared. Should it be static?
>>> drivers/ide/pmac.c:1418:12: warning: symbol 'pmac_ide_probe' was not
>>> declared. Should it be static?
>>>
>>> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
>>> ---
>>>  drivers/ide/pmac.c | 10 +++++-----
>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>> 
>> TIL davem maintains IDE?
>> 
>> But I suspect he isn't that interested in this powerpc only driver, so
>> I'll grab this.
>
> I did have it in my queue, but if you want to take it that's fine too :)

That's OK, if you've got it already you take it. Thanks.

cheers
