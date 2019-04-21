Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F69C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:05:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6643220693
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6643220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nChF2s0RzDq6B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 01:05:49 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBfX1wvnzDqMg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:19:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBfW6zV9z9s5c; Mon, 22 Apr 2019 00:19:15 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 2d4d9b308f8f8dec68f6dbbff18c68ec7c6bd26f
X-Patchwork-Hint: ignore
In-Reply-To: <20190418185658.29751-2-nathanl@linux.ibm.com>
To: Nathan Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/2] powerpc/numa: improve control of topology updates
Message-Id: <44nBfW6zV9z9s5c@ozlabs.org>
Date: Mon, 22 Apr 2019 00:19:15 +1000 (AEST)
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
Cc: srikar.dronamraju@in.ibm.com, mmc@linux.ibm.com, mwb@linux.ibm.com,
 julietk@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-04-18 at 18:56:57 UTC, Nathan Lynch wrote:
> When booted with "topology_updates=no", or when "off" is written to
> /proc/powerpc/topology_updates, NUMA reassignments are inhibited for
> PRRN and VPHN events. However, migration and suspend unconditionally
> re-enable reassignments via start_topology_update(). This is
> incoherent.
> 
> Check the topology_updates_enabled flag in
> start/stop_topology_update() so that callers of those APIs need not be
> aware of whether reassignments are enabled. This allows the
> administrative decision on reassignments to remain in force across
> migrations and suspensions.
> 
> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2d4d9b308f8f8dec68f6dbbff18c68ec

cheers
