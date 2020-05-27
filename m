Return-Path: <SRS0=LEFZ=7J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28530C433E4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2020 04:36:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C84FF214D8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2020 04:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="l0pnprYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84FF214D8
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Wyj36Nm8zDqD7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2020 14:36:55 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49WyLk1phvzDqSn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2020 14:21:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=l0pnprYu; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 49WyLj5P5vz9sSw; Wed, 27 May 2020 14:21:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1590553261; bh=himyVK4/uAY65Rhi/04JhPo9XxPhlLv5LE5z8MhKESQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l0pnprYuazQoMipYIrBZciz2+1zEE+BxE6jRcm0kQTRPwNwFkGTOi2YHj2M1JDBEF
 OEb1M2PDC4VLWyOFIP6PEu4BUfg0yERObU1G0M0sSRMw1Nrp8a/P9GEGClYkP9st2H
 5TfUkZe9YPBfWOBjJYI8Ii52W6rF3g+zK45nqg25Zyt2Am7BJ9jpYPsKBeU/iWS07Y
 H2OzXMTxiv+JQfLLSDODG8PhLvKqnXHIkMzaDaWAOdLZ8FTscp5aG2Sh5933tdkT42
 4Gz68BmOH4K9/68SPHTAH8FwecQRqbdFcv+53HXrTm90WqwWk60cv1gUS6QTyi6Xum
 GdX51qdSv9A/w==
Date: Wed, 27 May 2020 14:16:05 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: read ibm,secure-memory nodes
Message-ID: <20200527041605.GC293451@thinks.paulus.ozlabs.org>
References: <20200416162715.45846-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416162715.45846-1-ldufour@linux.ibm.com>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 16, 2020 at 06:27:15PM +0200, Laurent Dufour wrote:
> The newly introduced ibm,secure-memory nodes supersede the
> ibm,uv-firmware's property secure-memory-ranges.
> 
> Firmware will no more expose the secure-memory-ranges property so first
> read the new one and if not found rollback to the older one.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Thanks, applied to my kvm-ppc-next branch.

Paul.
