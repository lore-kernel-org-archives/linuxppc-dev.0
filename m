Return-Path: <SRS0=+cnT=UT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DFBC43613
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 13:56:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0047E20675
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 13:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0047E20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45V3J606b8zDr3l
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 23:56:05 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45V38S5tnKzDr6L
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2019 23:49:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45V38P0wjWz9s5c;
 Thu, 20 Jun 2019 23:49:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christoph Hellwig <hch@lst.de>, paulus@samba.org
Subject: Re: [PATCH] powerpc: enable a 30-bit ZONE_DMA for 32-bit pmac
In-Reply-To: <a5fc355e44fb5edea41274329f7c5d04a8dff6fc.camel@kernel.crashing.org>
References: <20190613082446.18685-1-hch@lst.de>
 <20190619105039.GA10118@lst.de> <87tvcldacn.fsf@concordia.ellerman.id.au>
 <a5fc355e44fb5edea41274329f7c5d04a8dff6fc.camel@kernel.crashing.org>
Date: Thu, 20 Jun 2019 23:49:20 +1000
Message-ID: <87k1dgcqov.fsf@concordia.ellerman.id.au>
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
Cc: aaro.koskinen@iki.fi, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> On Wed, 2019-06-19 at 22:32 +1000, Michael Ellerman wrote:
>> Christoph Hellwig <hch@lst.de> writes:
>> > Any chance this could get picked up to fix the regression?
>> 
>> Was hoping Ben would Ack it. He's still powermac maintainer :)
>> 
>> I guess he OK'ed it in the other thread, will add it to my queue.
>
> Yeah ack. If I had written it myself, I would have made the DMA bits a
> variable and only set it down to 30 if I see that device in the DT
> early on, but I can't be bothered now, if it works, ship it :-)

OK, we can do that next release if someone's motivated.

> Note: The patch affects all ppc32, though I don't think it will cause
> any significant issue on those who don't need it.

Yeah. We could always hide it behind CONFIG_PPC_PMAC if it becomes a problem.

cheers
