Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC3DC10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:52:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B095A2087B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B095A2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nCNr0ZqlzDqQh
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 00:52:28 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBfH5QprzDqMH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:19:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBfH2Fzgz9sNL; Mon, 22 Apr 2019 00:19:02 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6161a37307f3320808b5a7549593b991500f2656
X-Patchwork-Hint: ignore
In-Reply-To: <20190403060514.26119-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org,
 Christophe Leroy <christophe.leroy@c-s.fr>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/mm: Fix build error with FLATMEM book3s64 config
Message-Id: <44nBfH2Fzgz9sNL@ozlabs.org>
Date: Mon, 22 Apr 2019 00:19:02 +1000 (AEST)
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

On Wed, 2019-04-03 at 06:05:14 UTC, "Aneesh Kumar K.V" wrote:
> The current value of MAX_PHYSMEM_BITS cannot work with 32 bit configs.
> We used to have MAX_PHYSMEM_BITS not defined without SPARSEMEM and 32
> bit configs never expected a value to be set for MAX_PHYSMEM_BITS.
> 
> Dependent code such as zsmalloc derived the right values based on other
> fields. Instead of finding a value that works with different configs,
> use new values only for book3s_64. For 64 bit booke, use the definition
> of MAX_PHYSMEM_BITS as per commit a7df61a0e2b6 ("[PATCH] ppc64: Increase sparsemem defaults")
> That change was done in 2005 and hopefully will work with book3e 64.
> 
> Fixes: 8bc086899816 ("powerpc/mm: Only define MAX_PHYSMEM_BITS in SPARSEMEM configurations")
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6161a37307f3320808b5a7549593b991

cheers
