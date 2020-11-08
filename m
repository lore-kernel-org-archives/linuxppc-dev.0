Return-Path: <SRS0=GXYn=EO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03823C388F9
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2020 10:37:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3940C206ED
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2020 10:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3940C206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CTVtm2zkgzDrPH
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2020 21:37:20 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CTVjx0fWbzDqYk
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Nov 2020 21:29:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CTVjv5lwvz9sTv; Sun,  8 Nov 2020 21:29:39 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <af834e8a0f1fa97bfae65664950f0984a70c4750.1602492856.git.christophe.leroy@csgroup.eu>
References: <af834e8a0f1fa97bfae65664950f0984a70c4750.1602492856.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/2] powerpc/8xx: Always fault when _PAGE_ACCESSED is
 not set
Message-Id: <160483134413.1400561.8432797439436517862.b4-ty@ellerman.id.au>
Date: Sun,  8 Nov 2020 21:29:39 +1100 (AEDT)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 12 Oct 2020 08:54:31 +0000 (UTC), Christophe Leroy wrote:
> The kernel expects pte_young() to work regardless of CONFIG_SWAP.
> 
> Make sure a minor fault is taken to set _PAGE_ACCESSED when it
> is not already set, regardless of the selection of CONFIG_SWAP.
> 
> This adds at least 3 instructions to the TLB miss exception
> handlers fast path. Following patch will reduce this overhead.
> 
> [...]

Applied to powerpc/fixes.

[1/2] powerpc/8xx: Always fault when _PAGE_ACCESSED is not set
      https://git.kernel.org/powerpc/c/29daf869cbab69088fe1755d9dd224e99ba78b56
[2/2] powerpc/8xx: Manage _PAGE_ACCESSED through APG bits in L1 entry
      https://git.kernel.org/powerpc/c/33fe43cfd9b1c20f6f9899b44bf04e91823ff1c9

cheers
