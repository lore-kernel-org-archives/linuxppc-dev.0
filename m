Return-Path: <SRS0=Er2m=7W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0415C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 06:26:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9442C20760
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 06:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9442C20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49h0WZ5KwYzDqht
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 16:26:34 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49gzFn6B2WzDqRy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2020 15:29:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 49gzFW2gyJz9sTc; Tue,  9 Jun 2020 15:29:19 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49gzFV5Hpgz9sVD; Tue,  9 Jun 2020 15:29:18 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20200522133318.1681406-1-mpe@ellerman.id.au>
References: <20200522133318.1681406-1-mpe@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc: Add ppc_inst_next()
Message-Id: <159168034076.1381411.1763121153455102377.b4-ty@ellerman.id.au>
Date: Tue,  9 Jun 2020 15:29:18 +1000 (AEST)
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
Cc: christophe.leroy@c-s.fr, jniethe5@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 22 May 2020 23:33:18 +1000, Michael Ellerman wrote:
> In a few places we want to calculate the address of the next
> instruction. Previously that was simple, we just added 4 bytes, or if
> using a u32 * we incremented that pointer by 1.
> 
> But prefixed instructions make it more complicated, we need to advance
> by either 4 or 8 bytes depending on the actual instruction. We also
> can't do pointer arithmetic using struct ppc_inst, because it is
> always 8 bytes in size on 64-bit, even though we might only need to
> advance by 4 bytes.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Add ppc_inst_next()
      https://git.kernel.org/powerpc/c/c5ff46d69c410f7fac173e4fde3eea484b4b4eda

cheers
