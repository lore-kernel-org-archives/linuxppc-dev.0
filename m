Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB60C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:18:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95D0420823
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D0420823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445S321VgZzDqQm
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 21:18:06 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445RN62zgQzDqLM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 20:47:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 445RN572ccz9sB8; Fri, 22 Feb 2019 20:47:49 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: fe1ef6bcdb4fca33434256a802a3ed6aacf0bd2f
X-Patchwork-Hint: ignore
In-Reply-To: <20190208143319.11980-1-mark.cave-ayland@ilande.co.uk>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, benh@kernel.crashing.org,
 paulus@samba.org, npiggin@gmail.com, christophe.leroy@c-s.fr,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: fix 32-bit KVM-PR lockup and panic with MacOS guest
Message-Id: <445RN572ccz9sB8@ozlabs.org>
Date: Fri, 22 Feb 2019 20:47:49 +1100 (AEDT)
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

On Fri, 2019-02-08 at 14:33:19 UTC, Mark Cave-Ayland wrote:
> Commit 8792468da5e1 "powerpc: Add the ability to save FPU without giving it up"
> unexpectedly removed the MSR_FE0 and MSR_FE1 bits from the bitmask used to
> update the MSR of the previous thread in __giveup_fpu() causing a KVM-PR MacOS
> guest to lockup and panic the kernel.
> 
> Reinstate these bits to the MSR bitmask to enable MacOS guests to run under
> 32-bit KVM-PR once again without issue.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fe1ef6bcdb4fca33434256a802a3ed6a

cheers
