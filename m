Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB07C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 09:57:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE19219FC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 09:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE19219FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MLWP6W1CzDqT3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 20:57:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MLSQ28vyzDqSZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 20:54:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43MLSQ14bKz9sLt; Sat, 22 Dec 2018 20:54:30 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 374f3f5979f9b28bfb5b5799208d82d08ef518a7
X-Patchwork-Hint: ignore
In-Reply-To: <20181126143504.30996-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org,
 Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/mm/hash: Hand user access of kernel address gracefully
Message-Id: <43MLSQ14bKz9sLt@ozlabs.org>
Date: Sat, 22 Dec 2018 20:54:30 +1100 (AEDT)
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2018-11-26 at 14:35:04 UTC, "Aneesh Kumar K.V" wrote:
> With commit 2865d08dd9ea ("powerpc/mm: Move the DSISR_PROTFAULT sanity check")
> we moved the protection fault access check before vma lookup. That means we
> hit that WARN_ON when user space access a kernel address.  Before the commit
> this was handled by find_vma() not finding vma for the kernel address and
> considering that access as bad area access.
> 
> Avoid the confusing WARN_ON and convert that to a ratelimited printk.
> With the patch we now get
> 
> for load:
> [  187.700294] a.out[5997]: User access of kernel address (c00000000000dea0) - exploit attempt? (uid: 1000)
> [  187.700344] a.out[5997]: segfault (11) at c00000000000dea0 nip 1317c0798 lr 7fff80d6441c code 1 in a.out[1317c0000+10000]
> [  187.700429] a.out[5997]: code: 60000000 60420000 3c4c0002 38427790 4bffff20 3c4c0002 38427784 fbe1fff8
> [  187.700435] a.out[5997]: code: f821ffc1 7c3f0b78 60000000 e9228030 <89290000> 993f002f 60000000 383f0040
> 
> for exec:
> [  225.100903] a.out[6067]: User access of kernel address (c00000000000dea0) - exploit attempt? (uid: 1000)
> [  225.100938] a.out[6067]: segfault (11) at c00000000000dea0 nip c00000000000dea0 lr 129d507b0 code 1
> [  225.100943] a.out[6067]: Bad NIP, not dumping instructions.
> 
> Fixes: 2865d08dd9ea ("powerpc/mm: Move the DSISR_PROTFAULT sanity check")
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Tested-by: Breno Leitao <leitao@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/374f3f5979f9b28bfb5b5799208d82

cheers
