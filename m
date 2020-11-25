Return-Path: <SRS0=IR6y=E7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D593C5519F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 12:06:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F7B206E5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 12:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F7B206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ch03X2xW1zDq8g
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 23:06:16 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cgzsc4JNYzDqdT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2020 22:57:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Cgzsc03GSz9sSf; Wed, 25 Nov 2020 22:57:39 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
In-Reply-To: <20201022091115.39568-1-aneesh.kumar@linux.ibm.com>
References: <20201022091115.39568-1-aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] powerpc/mm: move setting pte specific flags to pfn_pmd
Message-Id: <160630539928.2174375.8364129339709602499.b4-ty@ellerman.id.au>
Date: Wed, 25 Nov 2020 22:57:39 +1100 (AEDT)
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
Cc: linux-mm@kvack.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 22 Oct 2020 14:41:15 +0530, Aneesh Kumar K.V wrote:
> powerpc used to set the pte specific flags in set_pte_at().  This is
> different from other architectures. To be consistent with other
> architecture powerpc updated pfn_pte to set _PAGE_PTE with
> commit 379c926d6334 ("powerpc/mm: move setting pte specific flags to pfn_pte")
> 
> The commit didn't do the same w.r.t pfn_pmd because we expect pmd_mkhuge
> to do that. But as per Linus that is a bad rule [1].
> Hence update pfn_pmd to set _PAGE_PTE.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/mm: Move setting PTE specific flags to pfn_pmd()
      https://git.kernel.org/powerpc/c/53f45ecc9cd04b4b963f3040f2a54c3baf03b229

cheers
