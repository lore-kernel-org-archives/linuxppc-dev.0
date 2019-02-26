Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CF6C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 03:38:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78DB620652
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 03:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DB620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447l0W4jBHzDqN2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 14:38:51 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447klr6xK3zDqM5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 14:27:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 447klr55Txz9sDb; Tue, 26 Feb 2019 14:27:52 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 447klr31G9z9sLw; Tue, 26 Feb 2019 14:27:52 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: eafd825ed7106ac1ca84d20d8b3b86826f164df9
X-Patchwork-Hint: ignore
In-Reply-To: <20190223122439.24020-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/64: Simplify __secondary_start paca->kstack handling
Message-Id: <447klr31G9z9sLw@ozlabs.org>
Date: Tue, 26 Feb 2019 14:27:52 +1100 (AEDT)
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
Cc: paulus@samba.org, matt@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 2019-02-23 at 12:24:39 UTC, Michael Ellerman wrote:
> In __secondary_start() we load the thread_info of the idle task of the
> secondary CPU from current_set[cpu], and then convert it into a stack
> pointer before storing that back to paca->kstack.
> 
> As pointed out in commit f761622e5943 ("powerpc: Initialise
> paca->kstack before early_setup_secondary") it's important that we
> initialise paca->kstack before calling the MMU setup code, in
> particular slb_initialize(), because it will bolt the SLB entry for
> the kstack into the SLB.
> 
> However we have already setup paca->kstack in cpu_idle_thread_init(),
> since commit 3b5750644b2f ("[POWERPC] Bolt in SLB entry for kernel
> stack on secondary cpus") (May 2008).
> 
> It's also in cpu_idle_thread_init() that we initialise current_set[cpu]
> with the thread_info pointer, so there is no issue of the timing being
> different between the two.
> 
> Therefore the initialisation of paca->kstack in __setup_secondary() is
> completely redundant, so remove it.
> 
> This has the added benefit of removing code that runs in real mode,
> and is therefore restricted by the RMO, and so opens the way for us to
> enable THREAD_INFO_IN_TASK.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/eafd825ed7106ac1ca84d20d8b3b8682

cheers
