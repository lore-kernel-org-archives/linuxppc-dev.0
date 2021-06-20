Return-Path: <SRS0=9Gml=LO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D66C48BDF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Jun 2021 21:55:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D9261164
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Jun 2021 21:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D9261164
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G7RKH0YYTz3c06
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jun 2021 07:54:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=GO0EFaiU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=paulus@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=GO0EFaiU; dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G7RJp35rrz302g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jun 2021 07:54:34 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 4G7RJd5wz0z9sVp; Mon, 21 Jun 2021 07:54:25 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4G7RJd5Fwvz9sW6; Mon, 21 Jun 2021 07:54:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1624226065; bh=13I1sADkfWA/3M+TV9QybttdGCvQH4UoozMrg2527as=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GO0EFaiUCRwdZVYueKgnejUaXLNLLshPNCiRaYgcaYFdv59MEln6XBrMBWGQ/CWam
 zfX9JRChN+iFdadqUB+gNBiZoAirVNbqFWu76kZWPvXeWdwHDoektVucHsWSZzDaIG
 IS6A758xNrpg9siSYiwrULYTCTeCnWxCsQ4xb4ALmkbzJq/traQD9UxGN1t8Ip+I32
 z+9H5e5GrDk4/7P3lW3ekULYQ0d0RmJgfpG3QzNbVy0vrtdKiG+4RMMvl+t+kbq5g6
 0z3kfAIsGwNiV6XLWWqurzrqKLS5Tp2CVZJybzkD+ONgKo2/+6vHSi8kECKenRJ1w7
 R9wzAsZwWJRCQ==
Date: Sun, 20 Jun 2021 22:08:58 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 2/9] powerpc: Add Microwatt device tree
Message-ID: <YM8v2ricaCzGi2vv@thinks.paulus.ozlabs.org>
References: <YMwWPcsaWzMlDPqQ@thinks.paulus.ozlabs.org>
 <YMwWkPcXlGDSQ9Q3@thinks.paulus.ozlabs.org>
 <20210619142616.GW5077@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210619142616.GW5077@gate.crashing.org>
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Jun 19, 2021 at 09:26:16AM -0500, Segher Boessenkool wrote:
> On Fri, Jun 18, 2021 at 01:44:16PM +1000, Paul Mackerras wrote:
> > Microwatt currently runs with MSR[HV] = 0,
> 
> That isn't compliant though?  If your implementation does not have LPAR
> it must set MSR[HV]=1 always.

True - but if I actually do that, Linux starts trying to use hrfid
(for example in masked_Hinterrupt), which Microwatt doesn't have.
Something for Nick to fix. :)

Paul.
