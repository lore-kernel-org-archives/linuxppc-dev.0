Return-Path: <SRS0=ZD8a=WX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4210C3A5A4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Aug 2019 00:34:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49496206BB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Aug 2019 00:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="tySe8v7x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49496206BB
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46HVHx0nvjzDqWh
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Aug 2019 10:34:37 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46HVFQ1VpdzDqNB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2019 10:32:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="tySe8v7x"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 46HVFP6JL1z9sDB; Tue, 27 Aug 2019 10:32:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1566865945; bh=n0WxmvwSK65oIhBS+QjYk4vyDjy+iy/5wXOF3pY69BE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tySe8v7xb2A12sBylV8i+NhlV0mc10CpEDBz0n7H/JCr3kE9j08T0vStfZB5ufA7l
 TH/4ypJDcenroG30bKoL/y8GWQa8dt1j6LtPQB+my1R880OLAdipZCryf7aF3Ms4qE
 T3jVD07yBHleSv2v8cQk31filyT+jRNKK81E8o1427a71xtyoJHzO/WVNX5JJ0Ix66
 nrKpJi4mX/IvmFI/Ix48hY43BIQ6aHzAhQwkxfemOKLCG9l3OeuQtHwomOZCJxTf7v
 TqyoFpRYKQWORL21E2Cz5r8He3OvZ7sy0dS7qk0X2zchu8UyBOFwj2T9nlHaqouE0C
 0ynQ2eD0KPNvQ==
Date: Tue, 27 Aug 2019 10:32:20 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v2 2/4] KVM: PPC: Invalidate multiple TCEs at once
Message-ID: <20190827003220.GA16075@blackberry>
References: <20190826061705.92048-1-aik@ozlabs.ru>
 <20190826061705.92048-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826061705.92048-3-aik@ozlabs.ru>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: kvm@vger.kernel.org, Alistair Popple <alistair@popple.id.au>,
 kvm-ppc@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 26, 2019 at 04:17:03PM +1000, Alexey Kardashevskiy wrote:
> Invalidating a TCE cache entry for each updated TCE is quite expensive.
> This makes use of the new iommu_table_ops::xchg_no_kill()/tce_kill()
> callbacks to bring down the time spent in mapping a huge guest DMA window;
> roughly 20s to 10s for each guest's 100GB of DMA space.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

With the addition of "Book3S" to the patch title,

Acked-by: Paul Mackerras <paulus@ozlabs.org>
