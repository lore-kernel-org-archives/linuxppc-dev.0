Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E607AC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 21:49:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AEFB2081C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 21:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AEFB2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434vSJ4hm9zDqvn
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 08:49:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434vMj1DFjzDr0k
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 08:45:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 434vMh6zDpz9s0n; Thu, 29 Nov 2018 08:45:20 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 434vMh5YZ4z9s4s; Thu, 29 Nov 2018 08:45:20 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 5564597d51c8ff5b88d95c76255e18b13b760879
In-Reply-To: <20181126220154.GA17244@blackberry>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: Fix COFF zImage booting on old powermacs
Message-Id: <434vMh5YZ4z9s4s@ozlabs.org>
Date: Thu, 29 Nov 2018 08:45:20 +1100 (AEDT)
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2018-11-26 at 22:01:54 UTC, Paul Mackerras wrote:
> Commit 6975a783d7b4 ("powerpc/boot: Allow building the zImage wrapper
> as a relocatable ET_DYN", 2011-04-12) changed the procedure descriptor
> at the start of crt0.S to have a hard-coded start address of 0x500000
> rather than a reference to _zimage_start, presumably because having
> a reference to a symbol introduced a relocation which is awkward to
> handle in a position-independent executable.  Unfortunately, what is
> at 0x500000 in the COFF image is not the first instruction, but the
> procedure descriptor itself, that is, a word containing 0x500000,
> which is not a valid instruction.  Hence, booting a COFF zImage
> results in a "DEFAULT CATCH!, code=FFF00700" message from Open
> Firmware.
> 
> This fixes the problem by (a) putting the procedure descriptor in the
> data section and (b) adding a branch to _zimage_start as the first
> instruction in the program.
> 
> Fixes: 6975a783d7b4 ("powerpc/boot: Allow building the zImage wrapper as a relocatable ET_DYN")
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/5564597d51c8ff5b88d95c76255e18

cheers
