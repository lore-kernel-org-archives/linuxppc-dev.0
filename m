Return-Path: <SRS0=qxeE=IM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E12C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 10:04:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E04164EC6
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 10:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E04164EC6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DywBH2bmHz2xxr
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 21:04:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4Dyw7B1fhlz3cWs
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Mar 2021 21:01:24 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Dyw774f4Nz9sWW; Sun, 14 Mar 2021 21:01:23 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Greg Kurz <groug@kaod.org>, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20210215094506.1196119-1-groug@kaod.org>
References: <20210215094506.1196119-1-groug@kaod.org>
Subject: Re: [PATCH v2] powerpc/pseries: Don't enforce MSI affinity with kdump
Message-Id: <161571587010.138988.17393630047865691595.b4-ty@ellerman.id.au>
Date: Sun, 14 Mar 2021 21:01:23 +1100 (AEDT)
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
Cc: lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Cédric Le Goater <clg@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 15 Feb 2021 10:45:06 +0100, Greg Kurz wrote:
> Depending on the number of online CPUs in the original kernel, it is
> likely for CPU #0 to be offline in a kdump kernel. The associated IRQs
> in the affinity mappings provided by irq_create_affinity_masks() are
> thus not started by irq_startup(), as per-design with managed IRQs.
> 
> This can be a problem with multi-queue block devices driven by blk-mq :
> such a non-started IRQ is very likely paired with the single queue
> enforced by blk-mq during kdump (see blk_mq_alloc_tag_set()). This
> causes the device to remain silent and likely hangs the guest at
> some point.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/pseries: Don't enforce MSI affinity with kdump
      https://git.kernel.org/powerpc/c/f9619d5e5174867536b7e558683bc4408eab833f

cheers
