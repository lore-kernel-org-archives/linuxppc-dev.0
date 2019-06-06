Return-Path: <SRS0=nl2z=UF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F1FC28CC5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 00:56:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C90E2070B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 00:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C90E2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45K6g75WW5zDqgH
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 10:56:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45K6dR4fhgzDqbc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2019 10:55:07 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x560spOn002708;
 Wed, 5 Jun 2019 19:54:53 -0500
Message-ID: <dfe6451c93574b61d4bdde4a05c5f8ccf86b31a0.camel@kernel.crashing.org>
Subject: Re: [BISECTED REGRESSION] b43legacy broken on G4 PowerBook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Christoph Hellwig <hch@lst.de>,
 Christian Zigotzky <chzigotzky@xenosoft.de>, Michael Ellerman
 <mpe@ellerman.id.au>, Larry Finger <Larry.Finger@lwfinger.net>
Date: Thu, 06 Jun 2019 10:54:51 +1000
In-Reply-To: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
References: <20190605225059.GA9953@darkstar.musicnaut.iki.fi>
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
Cc: linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-06-06 at 01:50 +0300, Aaro Koskinen wrote:
> Hi,
> 
> When upgrading from v5.0 -> v5.1 on G4 PowerBook, I noticed WLAN does
> not work anymore:
> 
> [   42.004303] b43legacy-phy0: Loading firmware version 0x127, patch level 14 (2005-04-18 02:36:27)
> [   42.184837] b43legacy-phy0 debug: Chip initialized
> [   42.184873] b43legacy-phy0 ERROR: The machine/kernel does not support the required 30-bit DMA mask
> 
> The same happens with the current mainline.

How much RAM do you have ?

Ben.

> 
> Bisected to:
> 
> 	commit 65a21b71f948406201e4f62e41f06513350ca390
> 	Author: Christoph Hellwig <hch@lst.de>
> 	Date:   Wed Feb 13 08:01:26 2019 +0100
> 
> 	    powerpc/dma: remove dma_nommu_dma_supported
> 
> 	    This function is largely identical to the generic version used
> 	    everywhere else.  Replace it with the generic version.
> 
> 	    Signed-off-by: Christoph Hellwig <hch@lst.de>
> 	    Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> 	    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> A.

