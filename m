Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F8BC169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:16:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52CED20844
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CED20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wy0h2nZszDqDd
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 01:16:36 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wwMR5jZjzDqWb
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 00:02:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43wwMN58wQz9sNj; Sat,  9 Feb 2019 00:02:40 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: ebb0e13ead2ddc186a80b1b0235deeefc5a1a667
X-Patchwork-Hint: ignore
In-Reply-To: <1548852360-29886-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [V2] powerpc/ptrace: Mitigate potential Spectre v1
Message-Id: <43wwMN58wQz9sNj@ozlabs.org>
Date: Sat,  9 Feb 2019 00:02:40 +1100 (AEDT)
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
Cc: Breno Leitao <leitao@debian.org>, gustavo@embeddedor.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-01-30 at 12:46:00 UTC, Breno Leitao wrote:
> 'regno' is directly controlled by user space, hence leading to a potential
> exploitation of the Spectre variant 1 vulnerability.
> 
> On PTRACE_SETREGS and PTRACE_GETREGS requests, user space passes the
> register number that would be read or written. This register number is
> called 'regno' which is part of the 'addr' syscall parameter.
> 
> This 'regno' value is checked against the maximum pt_regs structure size,
> and then used to dereference it, which matches the initial part of a
> Spectre v1 (and Spectre v1.1) attack. The dereferenced value, then,
> is returned to userspace in the GETREGS case.
> 
> This patch sanitizes 'regno' before using it to dereference pt_reg.
> 
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
> 
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ebb0e13ead2ddc186a80b1b0235deeef

cheers
