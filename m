Return-Path: <SRS0=aDnU=TC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D506CC43219
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 May 2019 11:39:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 599822081C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 May 2019 11:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599822081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44vtbZ16ZbzDqSv
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 May 2019 21:39:54 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44vtZ42QGPzDqLS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 May 2019 21:38:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44vtZ350X5z9s9T;
 Thu,  2 May 2019 21:38:35 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v1 4/4] powerpc/mm: Move nohash specifics in subdirectory
 mm/nohash
In-Reply-To: <a87606761d285e4f3dee5c2de1e6691f04e429b6.1553853405.git.christophe.leroy@c-s.fr>
References: <cover.1553853405.git.christophe.leroy@c-s.fr>
 <a87606761d285e4f3dee5c2de1e6691f04e429b6.1553853405.git.christophe.leroy@c-s.fr>
Date: Thu, 02 May 2019 21:38:35 +1000
Message-ID: <87r29hxf0k.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Many files in arch/powerpc/mm are only for nohash. This patch
> creates a subdirectory for them.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/mm/Makefile                          | 17 +----------------
>  arch/powerpc/mm/{ => nohash}/40x_mmu.c            |  0
>  arch/powerpc/mm/{ => nohash}/44x_mmu.c            |  0
>  arch/powerpc/mm/{ => nohash}/8xx_mmu.c            |  0
>  arch/powerpc/mm/nohash/Makefile                   | 21 +++++++++++++++++++++
>  arch/powerpc/mm/{ => nohash}/fsl_booke_mmu.c      |  0
>  arch/powerpc/mm/{ => nohash}/hugetlbpage-book3e.c |  0
>  arch/powerpc/mm/{ => nohash}/mmu_context_nohash.c |  0
>  arch/powerpc/mm/{ => nohash}/pgtable-book3e.c     |  0
>  arch/powerpc/mm/{ => nohash}/tlb_low_64e.S        |  0
>  arch/powerpc/mm/{ => nohash}/tlb_nohash.c         |  0
>  arch/powerpc/mm/{ => nohash}/tlb_nohash_low.S     |  0
>  12 files changed, 22 insertions(+), 16 deletions(-)
>  rename arch/powerpc/mm/{ => nohash}/40x_mmu.c (100%)
>  rename arch/powerpc/mm/{ => nohash}/44x_mmu.c (100%)
>  rename arch/powerpc/mm/{ => nohash}/8xx_mmu.c (100%)
>  create mode 100644 arch/powerpc/mm/nohash/Makefile
>  rename arch/powerpc/mm/{ => nohash}/fsl_booke_mmu.c (100%)
>  rename arch/powerpc/mm/{ => nohash}/hugetlbpage-book3e.c (100%)
>  rename arch/powerpc/mm/{ => nohash}/mmu_context_nohash.c (100%)
>  rename arch/powerpc/mm/{ => nohash}/pgtable-book3e.c (100%)
>  rename arch/powerpc/mm/{ => nohash}/tlb_low_64e.S (100%)
>  rename arch/powerpc/mm/{ => nohash}/tlb_nohash.c (100%)
>  rename arch/powerpc/mm/{ => nohash}/tlb_nohash_low.S (100%)

I went with:

  arch/powerpc/mm/{40x_mmu.c => nohash/40x.c}
  arch/powerpc/mm/{44x_mmu.c => nohash/44x.c}
  arch/powerpc/mm/{8xx_mmu.c => nohash/8xx.c}
  arch/powerpc/mm/{hugetlbpage-book3e.c => nohash/book3e_hugetlbpage.c}
  arch/powerpc/mm/{pgtable-book3e.c => nohash/book3e_pgtable.c}
  arch/powerpc/mm/{fsl_booke_mmu.c => nohash/fsl_booke.c}
  arch/powerpc/mm/{mmu_context_nohash.c => nohash/mmu_context.c}
  arch/powerpc/mm/{tlb_nohash.c => nohash/tlb.c}
  arch/powerpc/mm/{tlb_nohash_low.S => nohash/tlb_low.S}
  arch/powerpc/mm/{ => nohash}/tlb_low_64e.S

cheers
