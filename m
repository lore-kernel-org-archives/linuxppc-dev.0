Return-Path: <SRS0=37tr=TD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976E8C43219
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 07:32:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76ED20B7C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 07:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76ED20B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44wP380cnJzDqYJ
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 17:32:04 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44wNKM6RVczDqV3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2019 16:59:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44wNKM0w7sz9sDn; Fri,  3 May 2019 16:59:18 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: be80e758d0c2ec87eceac7676f08c761b4235869
X-Patchwork-Hint: ignore
In-Reply-To: <1554378890-31851-2-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc/perf: Add generic compat mode pmu driver
Message-Id: <44wNKM0w7sz9sDn@ozlabs.org>
Date: Fri,  3 May 2019 16:59:18 +1000 (AEST)
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
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-04-04 at 11:54:50 UTC, Madhavan Srinivasan wrote:
> Most of the power processor generation performance monitoring
> unit (PMU) driver code is bundled in the kernel and one of those
> is enabled/registered based on the oprofile_cpu_type check at
> the boot.
> 
> But things get little tricky incase of "compat" mode boot.
> IBM POWER System Server based processors has a compactibility
> mode feature, which simpily put is, Nth generation processor
> (lets say POWER8) will act and appear in a mode consistent
> with an earlier generation (N-1) processor (that is POWER7).
> And in this "compat" mode boot, kernel modify the
> "oprofile_cpu_type" to be Nth generation (POWER8). If Nth
> generation pmu driver is bundled (POWER8), it gets registered.
> 
> Key dependency here is to have distro support for latest
> processor performance monitoring support. Patch here adds
> a generic "compat-mode" performance monitoring driver to
> be register in absence of powernv platform specific pmu driver.
> 
> Driver supports only "cycles" and "instruction" events.
> "0x0001e" used as event code for "cycles" and "0x00002"
> used as event code for "instruction" events. New file
> called "generic-compat-pmu.c" is created to contain the driver
> specific code. And base raw event code format modeled
> on PPMU_ARCH_207S.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/be80e758d0c2ec87eceac7676f08c761

cheers
