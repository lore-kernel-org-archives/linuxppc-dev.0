Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6ADC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 13:39:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1727D20C01
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 13:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1727D20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444Jc26b86zDqDZ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 00:39:14 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444JZ22zy8zDq8B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 00:37:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 444JZ212zBz9s5R;
 Thu, 21 Feb 2019 00:37:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Move page table dump files in a dedicated
 subdirectory
In-Reply-To: <913780421c7b73d731bbbe04c215e29667f7c938.1550492751.git.christophe.leroy@c-s.fr>
References: <913780421c7b73d731bbbe04c215e29667f7c938.1550492751.git.christophe.leroy@c-s.fr>
Date: Thu, 21 Feb 2019 00:37:30 +1100
Message-ID: <87d0nm7f8l.fsf@concordia.ellerman.id.au>
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

> This patch moves the files related to page table dump in a
> dedicated subdirectory.
>
> The purpose is to clean a bit arch/powerpc/mm by regrouping
> multiple files handling a dedicated function.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/Kconfig.debug                                   |  4 ----
>  arch/powerpc/mm/Makefile                                     | 10 +---------
>  arch/powerpc/mm/ptdump/Makefile                              |  9 +++++++++
>  arch/powerpc/mm/{ => ptdump}/dump_bats.c                     |  0
>  arch/powerpc/mm/{ => ptdump}/dump_hashpagetable.c            |  0
>  arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-8xx.c      |  0
>  arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-book3s64.c |  0
>  arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-generic.c  |  0
>  arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables.c          |  0
>  arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables.h          |  0
>  arch/powerpc/mm/{ => ptdump}/dump_sr.c                       |  0
>  11 files changed, 10 insertions(+), 13 deletions(-)
>  create mode 100644 arch/powerpc/mm/ptdump/Makefile
>  rename arch/powerpc/mm/{ => ptdump}/dump_bats.c (100%)
>  rename arch/powerpc/mm/{ => ptdump}/dump_hashpagetable.c (100%)
>  rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-8xx.c (100%)
>  rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-book3s64.c (100%)
>  rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-generic.c (100%)
>  rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables.c (100%)
>  rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables.h (100%)
>  rename arch/powerpc/mm/{ => ptdump}/dump_sr.c (100%)

I'd like to shorten the file names as well, now that they're namespaced
in the ptdump directory, how about:

 arch/powerpc/Kconfig.debug                                             |  4 ----
 arch/powerpc/mm/Makefile                                               | 10 +---------
 arch/powerpc/mm/{dump_linuxpagetables-8xx.c => ptdump/8xx.c}           |  2 +-
 arch/powerpc/mm/ptdump/Makefile                                        |  9 +++++++++
 arch/powerpc/mm/{dump_bats.c => ptdump/bats.c}                         |  0
 arch/powerpc/mm/{dump_linuxpagetables-book3s64.c => ptdump/book3s64.c} |  2 +-
 arch/powerpc/mm/{dump_hashpagetable.c => ptdump/hashpagetable.c}       |  0
 arch/powerpc/mm/{dump_linuxpagetables.c => ptdump/ptdump.c}            |  2 +-
 arch/powerpc/mm/{dump_linuxpagetables.h => ptdump/ptdump.h}            |  0
 arch/powerpc/mm/{dump_sr.c => ptdump/segment_regs.c}                   |  0
 arch/powerpc/mm/{dump_linuxpagetables-generic.c => ptdump/shared.c}    |  2 +-


cheers
