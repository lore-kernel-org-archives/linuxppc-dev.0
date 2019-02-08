Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9825C169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 13:56:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E9702146E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 13:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9702146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wxY92zLxzDqKN
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 00:56:13 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wwM90FkJzDqWy
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 00:02:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43wwM74qhBz9sN9; Sat,  9 Feb 2019 00:02:27 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 3376cb91ed908eb0728900894a77d8206574dbcd
X-Patchwork-Hint: ignore
In-Reply-To: <44d3c23aa1c58abb6e1790e68b34e613a7ec6909.1543460917.git.sbobroff@linux.ibm.com>
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/6] powerpc/eeh: Cleanup eeh_pe_clear_frozen_state()
Message-Id: <43wwM74qhBz9sN9@ozlabs.org>
Date: Sat,  9 Feb 2019 00:02:27 +1100 (AEDT)
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

On Thu, 2018-11-29 at 03:16:37 UTC, Sam Bobroff wrote:
> The 'clear_sw_state' parameter for eeh_pe_clear_frozen_state() is
> redundant because it has no effect (except in the rare case of a
> hardware error part way through unfreezing a tree of PEs, where it
> would dangerously allow partial de-isolation before returning
> failure).
> 
> It is passed down to __eeh_pe_clear_frozen_state(), and from there to
> eeh_unfreeze_pe(), where it causes EEH_PE_ISOLATED to be removed
> from the state of each PE during the traversal.  However, when the
> traversal finishes, EEH_PE_ISOLATED is unconditionally removed by a
> call to eeh_pe_state_clear() regardless of the parameter's value.
> 
> So remove the flag and pass false to eeh_unfreeze_pe() (to avoid the
> rare case described above, as it was before the flag was introduced).
> Also, perform the recursion directly in the function and eliminate a
> bit of boilerplate.
> 
> There should be no change in functionality, except as mentioned above.
> 
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3376cb91ed908eb0728900894a77d820

cheers
