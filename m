Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CDAC00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 18:36:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F63D206B2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 18:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="I90WFM0T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F63D206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QPqj1LsYzF38y
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 04:36:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="I90WFM0T";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nvidia.com
 (client-ip=216.228.121.143; helo=hqemgate14.nvidia.com;
 envelope-from=mhairgrove@nvidia.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="I90WFM0T"; 
 dkim-atps=neutral
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QPmt20wKzF34W
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 04:34:05 +1000 (AEST)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5bb50b960000>; Wed, 03 Oct 2018 11:33:58 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 03 Oct 2018 11:34:00 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 03 Oct 2018 11:34:00 -0700
Received: from mdh-linux64-2.nvidia.com (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Wed, 3 Oct 2018 18:33:59 +0000
Date: Wed, 3 Oct 2018 11:33:50 -0700
From: Mark Hairgrove <mhairgrove@nvidia.com>
To: Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH 2/3] powerpc/powernv/npu: Use size-based ATSD invalidates
In-Reply-To: <3711069.TlgilHPQgk@new-mexico>
Message-ID: <alpine.DEB.2.00.1810031128270.18560@mdh-linux64-2.nvidia.com>
References: <1538090591-28519-1-git-send-email-mhairgrove@nvidia.com>
 <1843554.67Higpl3JC@new-mexico>
 <alpine.DEB.2.00.1810021750110.16676@mdh-linux64-2.nvidia.com>
 <3711069.TlgilHPQgk@new-mexico>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-NVConfidentiality: public
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="US-ASCII"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1538591638; bh=4RBQUt62qOuCzGO49XLyzMv48wbVM6C8T1BNFAV8L6k=;
 h=X-PGP-Universal:Date:From:To:CC:Subject:In-Reply-To:Message-ID:
 References:User-Agent:X-NVConfidentiality:MIME-Version:
 X-Originating-IP:X-ClientProxiedBy:Content-Type;
 b=I90WFM0T1HYmazG5p9eWWZdNud8TvRvk0CDeTKbtU3i0HWora05zj+RhyhIIEtGFh
 OBGf6Uh80MT32zEzr9stVaAbR7VLpjl5RsojdtR9ycRFqhXQgvS10UQeJLnYYRigLu
 6h4xi8Qh3D98Z94hx4tabU8f7dHmstLo+S0Fl/iachcOBHyZlcQp5fnYB9N3+Tt34E
 E4x9ZA2uf4XvO004ADh545zVbZuc6OdLqFqkua8Ol6v8DdNOS4JktGpViE437SpVA5
 +Uiy2dMQ/SO+YyJDyFofwKqHX6F/BLRUVYEsxt9JNMbyavTaV5h9HvwE3VFpNnUTzX
 Nlj3dI9r+/Txg==
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



On Wed, 3 Oct 2018, Alistair Popple wrote:

> > > 
> > > We also support 4K page sizes on PPC. If I am not mistaken this means every ATSD
> > > would invalidate the entire GPU TLB for a the given PID on those systems. Could
> > > we change the above check to `if (size <= PAGE_64K)` to avoid this?
> > 
> > PPC supports 4K pages but the GPU ATS implementation does not. For that
> > reason I didn't bother handling invalidates smaller than 64K. I'll add a
> > comment on that.
> 
> Interesting, I was not aware of that limitation. Do you know if it is a
> SW/driver limitation or a HW limitation?

HW.

> 
> > I don't know that this requirement is enforced anywhere though. I could
> > add a PAGE_SIZE == 64K check to pnv_npu2_init_context if you think it
> > would be useful.
> 
> Given it's a static kernel build parameter perhaps it makes more sense to do the
> check as part of the driver build in a conftest rather than a runtime failure?

Sure, we can do it in the driver. I'll just stick with a comment for the
kernel.
