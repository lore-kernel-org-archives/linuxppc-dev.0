Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C25C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 14:53:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DFE520693
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 14:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFE520693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fRwb5KxqzDqMN
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 00:53:03 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fRrz0NZ6zDqMN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 00:49:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44fRry40wXz9s4V; Thu, 11 Apr 2019 00:49:54 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44fRry3RDpz9s7T; Thu, 11 Apr 2019 00:49:54 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: cf7cf6977f531acd5dfe55250d0ee8cbbb6f1ae8
X-Patchwork-Hint: ignore
In-Reply-To: <20190409060324.16941-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/mm: Define MAX_PHYSMEM_BITS for all 64-bit configs
Message-Id: <44fRry3RDpz9s7T@ozlabs.org>
Date: Thu, 11 Apr 2019 00:49:54 +1000 (AEST)
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
Cc: hughd@google.com, schwab@linux-m68k.org, aneesh.kumar@linux.vnet.ibm.com,
 ben@decadent.org.uk
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-04-09 at 06:03:24 UTC, Michael Ellerman wrote:
> The recent commit 8bc086899816 ("powerpc/mm: Only define
> MAX_PHYSMEM_BITS in SPARSEMEM configurations") removed our definition
> of MAX_PHYSMEM_BITS when SPARSEMEM is disabled.
> 
> This inadvertently broke some 64-bit FLATMEM using configs with eg:
> 
>   arch/powerpc/include/asm/book3s/64/mmu-hash.h:584:6: error: "MAX_PHYSMEM_BITS" is not defined, evaluates to 0
>    #if (MAX_PHYSMEM_BITS > MAX_EA_BITS_PER_CONTEXT)
>         ^~~~~~~~~~~~~~~~
> 
> Fix it by making sure we define MAX_PHYSMEM_BITS for all 64-bit
> configs regardless of SPARSEMEM.
> 
> Fixes: 8bc086899816 ("powerpc/mm: Only define MAX_PHYSMEM_BITS in SPARSEMEM configurations")
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Reported-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/cf7cf6977f531acd5dfe55250d0ee8cb

cheers
