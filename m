Return-Path: <SRS0=B9f/=I5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A5CC433C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 01:12:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0926E619CA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 01:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0926E619CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F97bS4qS3z3dpF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 12:12:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F97XN3TGsz3byk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Mar 2021 12:10:12 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4F97XN0ST7z9sXb; Wed, 31 Mar 2021 12:10:11 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <8038392f38d81f2ad169347efac29146f553b238.1615819955.git.christophe.leroy@csgroup.eu>
References: <8038392f38d81f2ad169347efac29146f553b238.1615819955.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/mm: Remove unneeded #ifdef CONFIG_PPC_MEM_KEYS
Message-Id: <161715297876.226945.6700622335291233560.b4-ty@ellerman.id.au>
Date: Wed, 31 Mar 2021 12:09:38 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 15 Mar 2021 14:52:51 +0000 (UTC), Christophe Leroy wrote:
> In fault.c, #ifdef CONFIG_PPC_MEM_KEYS is not needed because all
> functions are always defined, and arch_vma_access_permitted()
> always returns true when CONFIG_PPC_MEM_KEYS is not defined so
> access_pkey_error() will return false so bad_access_pkey()
> will never be called.
> 
> Include linux/pkeys.h to get a definition of vma_pkeys() for
> bad_access_pkey().

Applied to powerpc/next.

[1/1] powerpc/mm: Remove unneeded #ifdef CONFIG_PPC_MEM_KEYS
      https://git.kernel.org/powerpc/c/98c26a72751ecb2ed247cdfd6cb2385f37195707

cheers
