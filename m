Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5E5C4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 13:49:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FABF610A1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 13:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2FABF610A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqTmK6ZLQz3f2b
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 23:49:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GqTgq6GZTz3cTj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Aug 2021 23:45:59 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4GqTgq2rJ7z9t14; Wed, 18 Aug 2021 23:45:59 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Jordan Niethe <jniethe5@gmail.com>
In-Reply-To: <20210804013724.514468-1-jniethe5@gmail.com>
References: <20210804013724.514468-1-jniethe5@gmail.com>
Subject: Re: [PATCH] powerpc: Always inline radix_enabled() to fix build
 failure
Message-Id: <162929392409.3619265.15852958754556713429.b4-ty@ellerman.id.au>
Date: Wed, 18 Aug 2021 23:38:44 +1000
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
Cc: erhard_f@mailbox.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 4 Aug 2021 11:37:24 +1000, Jordan Niethe wrote:
> This is the same as commit acdad8fb4a15 ("powerpc: Force inlining of
> mmu_has_feature to fix build failure") but for radix_enabled().  The
> config in the linked bugzilla causes the following build failure:
> 
> LD      .tmp_vmlinux.kallsyms1
> powerpc64-linux-ld: arch/powerpc/mm/pgtable.o: in function `.__ptep_set_access_flags':
> pgtable.c:(.text+0x17c): undefined reference to `.radix__ptep_set_access_flags'
...
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Always inline radix_enabled() to fix build failure
      https://git.kernel.org/powerpc/c/27fd1111051dc218e5b6cb2da5dbb3f342879ff1

cheers
