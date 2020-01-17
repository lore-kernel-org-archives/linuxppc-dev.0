Return-Path: <SRS0=8l9v=3G=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35AFC33C9E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jan 2020 03:46:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1312082F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jan 2020 03:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="MRpG3pi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1312082F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47zRnR24mQzDqsK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jan 2020 14:46:35 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47zRkp3FYBzDqlY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2020 14:44:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=MRpG3pi7; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 47zRkn4PZZz9sRd; Fri, 17 Jan 2020 14:44:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1579232657; bh=ltSUYl1RDYBIGn9bPmKjAqMNA4aASu38qTLJ2lZkEmE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MRpG3pi7GFi82Qba6Pzm7uB4nfP9Nr3XKcwo53umfhcl1ylDaP8aSeCiGvQLvrRNH
 9UgQTp523GqjiRHNU3+3yCMjIWcfLD1WiZLF07pUHNnLn/tsgz61WJ5TWluBb48Iev
 Hs7nl4B06xm282BE7/4zRUzj+CuQH4oAIHMKH6Q+zNRlghHbP3dYkMibYMIS54/r/P
 qhOUwkUNS3cIL2DohqyqXf47gYURRje8UIo5txvYuite4BHSqq38N+HBxswvrZVT9P
 WF8rlCMO6t1soIhmpiYHWdE/uEJL7VWuccRAMzb4Ta8Yl1vJyaRV/wBqK+lOR8lqfm
 I9gcUrjyuB5Pg==
Date: Fri, 17 Jan 2020 14:43:54 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Jordan Niethe <jniethe5@gmail.com>
Subject: Re: [PATCH v3] powerpc/mm: Remove kvm radix prefetch workaround for
 Power9 DD2.2
Message-ID: <20200117034354.GA31793@blackberry>
References: <20191206031722.25781-1-jniethe5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206031722.25781-1-jniethe5@gmail.com>
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
Cc: oohall@gmail.com, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Dec 06, 2019 at 02:17:22PM +1100, Jordan Niethe wrote:
> Commit a25bd72badfa ("powerpc/mm/radix: Workaround prefetch issue with
> KVM") introduced a number of workarounds as coming out of a guest with
> the mmu enabled would make the cpu would start running in hypervisor
> state with the PID value from the guest. The cpu will then start
> prefetching for the hypervisor with that PID value.
> 
> In Power9 DD2.2 the cpu behaviour was modified to fix this. When
> accessing Quadrant 0 in hypervisor mode with LPID != 0 prefetching will
> not be performed. This means that we can get rid of the workarounds for
> Power9 DD2.2 and later revisions. Add a new cpu feature
> CPU_FTR_P9_RADIX_PREFETCH_BUG to indicate if the workarounds are needed.
> 
> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>

Acked-by: Paul Mackerras <paulus@ozlabs.org>
