Return-Path: <SRS0=nzsQ=23=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B41FC33C8C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jan 2020 23:35:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A9D2072E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jan 2020 23:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A9D2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47sBhF3lV8zDqHS
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jan 2020 10:35:25 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47sBdl6wdrzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2020 10:33:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 47sBdl5tNDz9sR4; Tue,  7 Jan 2020 10:33:15 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 47sBdl5WFVz9sR8; Tue,  7 Jan 2020 10:33:15 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 5eb7cfb3a2b178f3d443301cda0825bb9f475657
In-Reply-To: <20190520102051.12103-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v2] selftests/powerpc: Add a test of bad (out-of-range)
 accesses
Message-Id: <47sBdl5WFVz9sR8@ozlabs.org>
Date: Tue,  7 Jan 2020 10:33:15 +1100 (AEDT)
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-05-20 at 10:20:51 UTC, Michael Ellerman wrote:
> Userspace isn't allowed to access certain address ranges, make sure we
> actually test that to at least some degree.
> 
> This would have caught the recent bug where the SLB fault handler was
> incorrectly called on an out-of-range access when using the Radix MMU.
> It also would have caught the bug we had in get_region_id() where we
> were inserting SLB entries for bad addresses.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/5eb7cfb3a2b178f3d443301cda0825bb9f475657

cheers
