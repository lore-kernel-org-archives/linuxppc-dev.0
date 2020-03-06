Return-Path: <SRS0=OxMP=4X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E516FC3F2D1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2020 01:05:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E7F12073B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2020 01:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7F12073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48YTtb5lH9zDqyl
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2020 12:05:11 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48YT3b3kkDzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2020 11:27:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 48YT3Z6P34z9sSZ; Fri,  6 Mar 2020 11:27:54 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48YT3Z34Spz9sSm; Fri,  6 Mar 2020 11:27:54 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 3d13e839e801e081bdece0127c2affa33d0f77cf
In-Reply-To: <20200220115141.2707-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v3 1/5] powerpc: Rename current_stack_pointer() to
 current_stack_frame()
Message-Id: <48YT3Z34Spz9sSm@ozlabs.org>
Date: Fri,  6 Mar 2020 11:27:54 +1100 (AEDT)
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

On Thu, 2020-02-20 at 11:51:37 UTC, Michael Ellerman wrote:
> current_stack_pointer(), which was called __get_SP(), used to just
> return the value in r1.
> 
> But that caused problems in some cases, so it was turned into a
> function in commit bfe9a2cfe91a ("powerpc: Reimplement __get_SP() as a
> function not a define").
> 
> Because it's a function in a separate compilation unit to all its
> callers, it has the effect of causing a stack frame to be created, and
> then returns the address of that frame. This is good in some cases
> like those described in the above commit, but in other cases it's
> overkill, we just need to know what stack page we're on.
> 
> On some other arches current_stack_pointer is just a register global
> giving the stack pointer, and we'd like to do that too. So rename our
> current_stack_pointer() to current_stack_frame() to make that
> possible.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/3d13e839e801e081bdece0127c2affa33d0f77cf

cheers
