Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C199C64EBD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 02:29:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A18562082A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 02:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18562082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q0MP0rmqzF38n
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 12:29:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=popple.id.au
 (client-ip=150.101.137.131; helo=ipmail07.adl2.internode.on.net;
 envelope-from=alistair@popple.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from ipmail07.adl2.internode.on.net (ipmail07.adl2.internode.on.net
 [150.101.137.131])
 by lists.ozlabs.org (Postfix) with ESMTP id 42Q0KK5qqmzF38F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 12:27:17 +1000 (AEST)
Received: from static-82-10.transact.net.au (HELO new-mexico.localnet)
 ([122.99.82.10])
 by ipmail07.adl2.internode.on.net with ESMTP; 03 Oct 2018 11:57:18 +0930
From: Alistair Popple <alistair@popple.id.au>
To: Mark Hairgrove <mhairgrove@nvidia.com>
Subject: Re: [PATCH 2/3] powerpc/powernv/npu: Use size-based ATSD invalidates
Date: Wed, 03 Oct 2018 12:27:14 +1000
Message-ID: <3711069.TlgilHPQgk@new-mexico>
User-Agent: KMail/5.2.3 (Linux/4.17.0-0.bpo.1-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <alpine.DEB.2.00.1810021750110.16676@mdh-linux64-2.nvidia.com>
References: <1538090591-28519-1-git-send-email-mhairgrove@nvidia.com>
 <1843554.67Higpl3JC@new-mexico>
 <alpine.DEB.2.00.1810021750110.16676@mdh-linux64-2.nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Cc: linuxppc-dev@lists.ozlabs.org, Reza Arbab <arbab@us.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> > 
> > We also support 4K page sizes on PPC. If I am not mistaken this means every ATSD
> > would invalidate the entire GPU TLB for a the given PID on those systems. Could
> > we change the above check to `if (size <= PAGE_64K)` to avoid this?
> 
> PPC supports 4K pages but the GPU ATS implementation does not. For that
> reason I didn't bother handling invalidates smaller than 64K. I'll add a
> comment on that.

Interesting, I was not aware of that limitation. Do you know if it is a
SW/driver limitation or a HW limitation?

> I don't know that this requirement is enforced anywhere though. I could
> add a PAGE_SIZE == 64K check to pnv_npu2_init_context if you think it
> would be useful.

Given it's a static kernel build parameter perhaps it makes more sense to do the
check as part of the driver build in a conftest rather than a runtime failure?

> >
> > > +		atsd_start = start;
> > 
> > Which would also require:
> > 
> >       	    atsd_start = ALIGN_DOWN(start, PAGE_64K);
> > 
> > > +		atsd_psize = MMU_PAGE_64K;
> > > +	} else if (ALIGN_DOWN(start, PAGE_2M) == ALIGN_DOWN(end, PAGE_2M)) {
> > 
> > Wouldn't this lead to under invalidation in ranges which happen to cross a 2M
> > boundary? For example invalidating a 128K (ie. 2x64K pages) range with start ==
> > 0x1f0000 and end == 0x210000 would result in an invalidation of the range 0x0 -
> > 0x200000 incorrectly leaving 0x200000 - 0x210000 in the GPU TLB.
> 
> In this example:
> start                         0x1f0000
> size                          0x020000
> end (start + size - 1)        0x20ffff
> ALIGN_DOWN(start, PAGE_2M)    0x000000
> ALIGN_DOWN(end, PAGE_2M)      0x200000
> 
> Since ALIGN_DOWN(start, PAGE_2M) != ALIGN_DOWN(end, PAGE_2M), the
> condition fails and we move to the 1G clause. Then
> ALIGN_DOWN(start, PAGE_1G) == ALIGN_DOWN(end, PAGE_1G) == 0, so we
> invalidate the range [0, 1G).

Oh yeah, sorry that makes sense and looks good to me.

- Alistair


