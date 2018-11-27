Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2281C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 09:44:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABC6A20817
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 09:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC6A20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433zPt52dGzDqGc
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 20:44:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433ywz1Jy8zDqd2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 20:22:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 433ywy0T3rz9s8r; Tue, 27 Nov 2018 20:22:25 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d456f3529a7a980ca7410c62e9e3496d828858f2
In-Reply-To: <20181106144803.23687-1-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: mark 64-bit PD_HUGE constant as unsigned long
Message-Id: <433ywy0T3rz9s8r@ozlabs.org>
Date: Tue, 27 Nov 2018 20:22:25 +1100 (AEDT)
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
Cc: Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2018-11-06 at 14:48:03 UTC, Daniel Axtens wrote:
> When compiled for 64-bit, the PD_HUGE constant is a 64-bit integer.
> Mark it as an unsigned long.
> 
> This squashes over a thousand sparse warnings on my minimal T4240RDB
> (e6500, ppc64be) config, of the following 2 forms:
> 
> arch/powerpc/include/asm/hugetlb.h:52:49: warning: constant 0x8000000000000000 is so big it is unsigned long
> arch/powerpc/include/asm/nohash/pgtable.h:269:49: warning: constant 0x8000000000000000 is so big it is unsigned long
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d456f3529a7a980ca7410c62e9e349

cheers
