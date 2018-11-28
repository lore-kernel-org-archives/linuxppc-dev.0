Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F635C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 11:02:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747A220660
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 11:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747A220660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434d664FX4zDqfP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 22:02:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434d3h3R5wzDqfB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 22:00:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 434d3g38sgz9ryk;
 Wed, 28 Nov 2018 22:00:31 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Radu Rendec <radu.rendec@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/1] Fix NULL pointer access in PowerPC MSI teardown code
In-Reply-To: <20181128032048.11665-1-radu.rendec@gmail.com>
References: <20181128032048.11665-1-radu.rendec@gmail.com>
Date: Wed, 28 Nov 2018 22:00:30 +1100
Message-ID: <8736rlh3g1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Alexander Gordeev <agordeev@redhat.com>,
 Radu Rendec <radu.rendec@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Radu,

Radu Rendec <radu.rendec@gmail.com> writes:
> Hi everyone,
>
> It seems there's an unchecked access to a NULL pointer (to a function)
> in the PowerPC MSI teardown code. I found this on kernel 4.9, but the
> code looks identical in the latest 4.20-rc. I don't see any reason why
> this wouldn't happen on recent kernels too.
>
> The PowerPC architecture specific MSI setup and teardown functions are
> in arch/powerpc/kernel/msi.c:
>
>   * arch_setup_msi_irqs() checks pointers for both the setup_msi_irqs
>     and teardown_msi_irqs ops and returns -ENOSYS if either one is NULL.
>
>   * arch_teardown_msi_irqs() calls on the teardown_msi_irqs op pointer
>     without checking it and assumes the function is never called unless
>     arch_setup_msi_irqs() returns successfully.
>
> The assumption in arch_teardown_msi_irqs() is wrong and results in a
> function call on a NULL pointer. An example of how this can happen is
> included in the actual patch header. In my case, it happens when the PCI
> hardware is configured during kernel start-up, because my controller
> doesn't support MSI and the ops are NULL.

What hardware are you on?

> I'm proposing the attached patch to fix the problem. It basically just
> checks the pointer before the function call.

Yeah that patch looks good to me.

I suspect this bug was introduced in:

  6b2fd7efeb88 ("PCI/MSI/PPC: Remove arch_msi_check_device()")

Previously we had that check routine which would run before any of the
MSI setup had been done, and so if there were no MSI ops then we bailed
out early and didn't call teardown.

I guess since then (2014) we haven't tested an MSI capable device on a
system that isn't MSI capable?

cheers
