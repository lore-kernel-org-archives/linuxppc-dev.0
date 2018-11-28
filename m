Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC41C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 15:58:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B4792081B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 15:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="Eaysd+3m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4792081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434lgg4BdnzDqjv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 02:58:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="Eaysd+3m";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::2; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="Eaysd+3m"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434lcb2xHnzDqxf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 02:55:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1543420555;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=7xS2QcB97L9QI4n5R/5DRuYEud3Vh5VKc9tcNvItCtM=;
 b=Eaysd+3mvkeElBj9Qq1Wg83sqYPco7KoN0nyg/bX/yNl/PPGjDuOmrDsI5HWZ/AE+3
 4in0cTumdMc8NIPEiMPW3j7nqvBGX5dCN0fm7quPmqVLUouY5ISZcdwLALPFjR305cXm
 gV/+gTrzRXT8c8Efq93mHfdRBAnzqpR3EPyGx6HWEmikwST9RaiDWpBv8idLm+Kd7oPU
 0IskozewQOrPphKIyz5OgWdmqE2S1KySacxWYfBG6lq8LQG/4CuAvpUf3arUd3kGrddd
 1Cc4zh4inHhLTKs+Dz09udl6YERuOCju7V0ThhFAtQio8ZgayJOm74pWiSp8/+T/ZnxV
 E4+Q==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkIise/x75IsWntOVj9qPtpgydF"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:74d7:2770:613:8ba4]
 by smtp.strato.de (RZmta 44.6 AUTH) with ESMTPSA id 404b20uASFtU7KR
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Wed, 28 Nov 2018 16:55:30 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
To: Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@lst.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de>
 <87zhttfonk.fsf@concordia.ellerman.id.au>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
Date: Wed, 28 Nov 2018 16:55:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <87zhttfonk.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
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
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 28 November 2018 at 12:05PM, Michael Ellerman wrote:
> Nothing specific yet.
>
> I'm a bit worried it might break one of the many old obscure platforms
> we have that aren't well tested.
>
Please don't apply the new DMA mapping code if you don't be sure if it 
works on all supported PowerPC machines. Is the new DMA mapping code 
really necessary? It's not really nice, to rewrote code if the old code 
works perfect. We must not forget, that we work for the end users. Does 
the end user have advantages with this new code? Is it faster? The old 
code works without any problems. I am also worried about this code. How 
can I test this new DMA mapping code?

Thanks

