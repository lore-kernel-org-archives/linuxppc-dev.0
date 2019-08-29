Return-Path: <SRS0=bIL3=WZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4D6C3A59F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 09:44:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C41233A1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 09:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C41233A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46JyPB2XBtzDrPl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 19:44:14 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46JyM50f59zDrNk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2019 19:42:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46JyM35CvPz9s4Y;
 Thu, 29 Aug 2019 19:42:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] powerpc: use the generic dma coherent remap allocator
In-Reply-To: <20190828142546.GA29960@lst.de>
References: <20190814132230.31874-1-hch@lst.de>
 <20190814132230.31874-2-hch@lst.de> <20190828061023.GB21592@lst.de>
 <87blw9v2ge.fsf@mpe.ellerman.id.au> <20190828142546.GA29960@lst.de>
Date: Thu, 29 Aug 2019 19:42:15 +1000
Message-ID: <87zhjstiiw.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christoph Hellwig <hch@lst.de> writes:
> On Wed, Aug 28, 2019 at 11:34:09PM +1000, Michael Ellerman wrote:
>> Christoph Hellwig <hch@lst.de> writes:
>> > Michael,
>> >
>> > do oyu plan to pick this up?  Otherwise I'd love to pick it up through
>> > the dma-mapping tree as that would avoid one trivial conflict with
>> > another pending patch.
>> 
>> It conflicts a bit with the ioremap changes I already have in next.
>> 
>> And it would be good for it to get some testing on my machines here. So
>> I guess I'd rather it went via the powerpc tree?
>
> Sure, feel free to queue it up through the ppc tree.  I am about to
> queue up a patch to move the dma_atomic_pool_init call to common code,
> so as linux-next / Linus fixup we'll have to eventually remove
> atomic_pool_init() again.

OK.

cheers
