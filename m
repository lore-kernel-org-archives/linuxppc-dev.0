Return-Path: <SRS0=y999=XO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446EBC3A5A6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Sep 2019 10:40:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC10207FC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Sep 2019 10:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC10207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Ytf66CJJzF4B7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Sep 2019 20:40:14 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46YtKN4ThnzF4XX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2019 20:25:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 46YtKN1ym9z9sPR; Thu, 19 Sep 2019 20:25:44 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 799abe283e5103d48e079149579b4f167c95ea0e
In-Reply-To: <20190903101605.2890-2-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH 01/14] powerpc/eeh: Clean up EEH PEs after recovery
 finishes
Message-Id: <46YtKN1ym9z9sPR@ozlabs.org>
Date: Thu, 19 Sep 2019 20:25:44 +1000 (AEST)
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
Cc: sbobroff@linux.ibm.com, Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-09-03 at 10:15:52 UTC, Oliver O'Halloran wrote:
> When the last device in an eeh_pe is removed the eeh_pe structure itself
> (and any empty parents) are freed since they are no longer needed. This
> results in a crash when a hotplug driver is involved since the following
> may occur:
> 
> 1. Device is suprise removed.
> 2. Driver performs an MMIO, which fails and queues and eeh_event.
> 3. Hotplug driver receives a hotplug interrupt and removes any
>    pci_devs that were under the slot.
> 4. pci_dev is torn down and the eeh_pe is freed.
> 5. The EEH event handler thread processes the eeh_event and crashes
>    since the eeh_pe pointer in the eeh_event structure is no
>    longer valid.
> 
> Crashing is generally considered poor form. Instead of doing that use
> the fact PEs are marked as EEH_PE_INVALID to keep them around until the
> end of the recovery cycle, at which point we can safely prune any empty
> PEs.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/799abe283e5103d48e079149579b4f167c95ea0e

cheers
