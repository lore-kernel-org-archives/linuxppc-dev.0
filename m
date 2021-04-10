Return-Path: <SRS0=Z3yz=JH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22661C433ED
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Apr 2021 14:32:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D4F961165
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Apr 2021 14:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4F961165
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FHcs11X6Nz3dFm
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Apr 2021 00:32:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FHcp76Ln1z301x
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Apr 2021 00:29:35 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FHcp664vVz9sWH; Sun, 11 Apr 2021 00:29:34 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Jordan Niethe <jniethe5@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210208032957.1232102-1-jniethe5@gmail.com>
References: <20210208032957.1232102-1-jniethe5@gmail.com>
Subject: Re: [PATCH v3 1/2] powerpc/64s: Fix pte update for kernel memory on
 radix
Message-Id: <161806492436.1467223.15525755051298950000.b4-ty@ellerman.id.au>
Date: Sun, 11 Apr 2021 00:28:44 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: naveen.n.rao@linux.vnet.ibm.com, npiggin@gmail.com, cmr@codefail.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 8 Feb 2021 14:29:56 +1100, Jordan Niethe wrote:
> When adding a pte a ptesync is needed to order the update of the pte
> with subsequent accesses otherwise a spurious fault may be raised.
> 
> radix__set_pte_at() does not do this for performance gains. For
> non-kernel memory this is not an issue as any faults of this kind are
> corrected by the page fault handler.  For kernel memory these faults are
> not handled.  The current solution is that there is a ptesync in
> flush_cache_vmap() which should be called when mapping from the vmalloc
> region.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/64s: Fix pte update for kernel memory on radix
      https://git.kernel.org/powerpc/c/b8b2f37cf632434456182e9002d63cbc4cccc50c
[2/2] selftests/powerpc: Test for spurious kernel memory faults on radix
      https://git.kernel.org/powerpc/c/29e3ea8cbd2958cf237b84652ec236803f2c6202

cheers
