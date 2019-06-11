Return-Path: <SRS0=3S3E=UK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A21FC4321A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2019 09:06:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35EB620657
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2019 09:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EB620657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45NPJ91401zDqby
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2019 19:06:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45NPFk3q8pzDqLV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2019 19:04:26 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5B949Tk006245;
 Tue, 11 Jun 2019 04:04:10 -0500
Message-ID: <2226c252d2dfa7973bcc298d5bf9521d1e3c5827.camel@kernel.crashing.org>
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
Date: Tue, 11 Jun 2019 19:04:09 +1000
In-Reply-To: <20190611075439.GB21815@lst.de>
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
 <73da300c-871c-77ac-8a3a-deac226743ef@lwfinger.net>
 <7697a9d10777b28ae79fdffdde6d0985555f6310.camel@kernel.crashing.org>
 <3ed1ccfe-d7ca-11b9-17b3-303d1ae1bb0f@lwfinger.net>
 <c91ccbddd6a58dbee5705f10ed1d98fb44bd8f8d.camel@kernel.crashing.org>
 <20190611060816.GA20158@lst.de>
 <fdfc817d1dcdc83f5bc45f0ab12cbce0c61e6702.camel@kernel.crashing.org>
 <b30ced162fa96d0ca63b8b9629d6fe9bc5c78746.camel@kernel.crashing.org>
 <20190611075439.GB21815@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
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
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>,
 linuxppc-dev@lists.ozlabs.org, Larry Finger <Larry.Finger@lwfinger.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-06-11 at 09:54 +0200, Christoph Hellwig wrote:
> On Tue, Jun 11, 2019 at 04:59:54PM +1000, Benjamin Herrenschmidt
> wrote:
> > Ah stupid me ... it's dma_set_mask that failed, since it has no
> > idea
> > that the calling driver is limited to lowmem.
> > 
> > That's also why the "wrong" patch worked.
> > 
> > So yes, a ZONE_DMA at 30-bits will work, though it's somewhat
> > overkill.
> 
> Well, according to Larry it doesn't actually work, which is odd.

Oh I assume that's just a glitch in the patch :-)

Cheers,
Ben.


