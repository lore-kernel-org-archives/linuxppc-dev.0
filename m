Return-Path: <SRS0=y999=XO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD7DC3A5A6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Sep 2019 11:01:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3521C21907
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Sep 2019 11:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3521C21907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Yv722TvDzF50X
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Sep 2019 21:01:50 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46YtKj64DPzF4XZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2019 20:26:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 46YtKh1KwGz9sQq; Thu, 19 Sep 2019 20:26:00 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 46YtKg2dGGz9s4Y; Thu, 19 Sep 2019 20:25:57 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0cb0837f9db1a6ed5b764ef61dd5f1a314b8231a
In-Reply-To: <20190911115746.12433-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH 1/4] powerpc/kvm: Move kvm_tmp into .text, shrink to 64K
Message-Id: <46YtKg2dGGz9s4Y@ozlabs.org>
Date: Thu, 19 Sep 2019 20:25:57 +1000 (AEST)
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
Cc: cai@lca.pw, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-09-11 at 11:57:43 UTC, Michael Ellerman wrote:
> In some configurations of KVM, guests binary patch themselves to
> avoid/reduce trapping into the hypervisor. For some instructions this
> requires replacing one instruction with a sequence of instructions.
> 
> For those cases we need to write the sequence of instructions
> somewhere and then patch the location of the original instruction to
> branch to the sequence. That requires that the location of the
> sequence be within 32MB of the original instruction.
> 
> The current solution for this is that we create a 1MB array in BSS,
> write sequences into there, and then free the remainder of the array.
> 
> This has a few problems:
>  - it confuses kmemleak.
>  - it confuses lockdep.
>  - it requires mapping kvm_tmp executable, which can cause adjacent
>    areas to also be mapped executable if we're using 16M pages for the
>    linear mapping.
>  - the 32MB limit can be exceeded if the kernel is big enough,
>    especially with STRICT_KERNEL_RWX enabled, which then prevents the
>    patching from working at all.
> 
> We can fix all those problems by making kvm_tmp just a region of
> regular .text. However currently it's 1MB in size, and we don't want
> to waste 1MB of text. In practice however I only see ~30KB of kvm_tmp
> being used even for an allyes_config. So shrink kvm_tmp to 64K, which
> ought to be enough for everyone, and move it into .text.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/0cb0837f9db1a6ed5b764ef61dd5f1a314b8231a

cheers
