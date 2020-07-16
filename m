Return-Path: <SRS0=Exvj=A3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49B3C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 13:22:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE442074B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 13:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE442074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B6w011b1LzDqGT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 23:22:09 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B6vPc2wYQzDqCh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2020 22:55:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4B6vPY4dtwz9sT6; Thu, 16 Jul 2020 22:55:45 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Bharata B Rao <bharata@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200703053608.12884-1-bharata@linux.ibm.com>
References: <20200703053608.12884-1-bharata@linux.ibm.com>
Subject: Re: [PATCH v3 0/3] Off-load TLB invalidations to host for !GTSE
Message-Id: <159490400851.3805857.417883173860793581.b4-ty@ellerman.id.au>
Date: Thu, 16 Jul 2020 22:55:45 +1000 (AEST)
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
Cc: aneesh.kumar@linux.ibm.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 3 Jul 2020 11:06:05 +0530, Bharata B Rao wrote:
> Hypervisor may choose not to enable Guest Translation Shootdown Enable
> (GTSE) option for the guest. When GTSE isn't ON, the guest OS isn't
> permitted to use instructions like tblie and tlbsync directly, but is
> expected to make hypervisor calls to get the TLB flushed.
> 
> This series enables the TLB flush routines in the radix code to
> off-load TLB flushing to hypervisor via the newly proposed hcall
> H_RPT_INVALIDATE.
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/mm: Enable radix GTSE only if supported.
      https://git.kernel.org/powerpc/c/029ab30b4c0a7ec587eece1ec07c3981fdff2bed
[2/3] powerpc/pseries: H_REGISTER_PROC_TBL should ask for GTSE only if enabled
      https://git.kernel.org/powerpc/c/b6c84175078ff022b343b7b0737aeb33001ca90c
[3/3] powerpc/mm/book3s64/radix: Off-load TLB invalidations to host when !GTSE
      https://git.kernel.org/powerpc/c/dd3d9aa5589c52efaec12ffeb84f0f5f8208fbc3

cheers
