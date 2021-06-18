Return-Path: <SRS0=hJnm=LM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89259C48BE8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 03:51:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DACD61245
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 03:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DACD61245
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G5lN30xQsz3c8P
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 13:51:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G5lMD5qlLz3bsr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jun 2021 13:50:48 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4G5lMB6d8pz9sT6; Fri, 18 Jun 2021 13:50:46 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210614131440.312360-1-mpe@ellerman.id.au>
References: <20210614131440.312360-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Fix initrd corruption with relative jump labels
Message-Id: <162398820957.1362017.4632272512434360018.b4-ty@ellerman.id.au>
Date: Fri, 18 Jun 2021 13:50:09 +1000
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
Cc: r.bolshakov@yadro.com, a.kovaleva@yadro.com, groug@kaod.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 14 Jun 2021 23:14:40 +1000, Michael Ellerman wrote:
> Commit b0b3b2c78ec0 ("powerpc: Switch to relative jump labels") switched
> us to using relative jump labels. That involves changing the code,
> target and key members in struct jump_entry to be relative to the
> address of the jump_entry, rather than absolute addresses.
> 
> We have two static inlines that create a struct jump_entry,
> arch_static_branch() and arch_static_branch_jump(), as well as an asm
> macro ARCH_STATIC_BRANCH, which is used by the pseries-only hypervisor
> tracing code.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: Fix initrd corruption with relative jump labels
      https://git.kernel.org/powerpc/c/478036c4cd1a16e613a2f883d79c03cf187faacb

cheers
