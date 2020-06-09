Return-Path: <SRS0=Er2m=7W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE53C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 05:52:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4D1207F9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 05:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4D1207F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49gzlp2BK7zDqDL
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 15:52:06 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49gzDt0gt0zDqS2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2020 15:28:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49gzDs2zx8z9sTH; Tue,  9 Jun 2020 15:28:44 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <7195fcde7314ccbf7a081b356084a69d421b10d4.1590660977.git.christophe.leroy@csgroup.eu>
References: <7195fcde7314ccbf7a081b356084a69d421b10d4.1590660977.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32: disable KASAN with pages bigger than 16k
Message-Id: <159168035113.1381411.9694012621969820760.b4-ty@ellerman.id.au>
Date: Tue,  9 Jun 2020 15:28:44 +1000 (AEST)
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

On Thu, 28 May 2020 10:17:04 +0000 (UTC), Christophe Leroy wrote:
> Mapping of early shadow area is implemented by using a single static
> page table having all entries pointing to the same early shadow page.
> The shadow area must therefore occupy full PGD entries.
> 
> The shadow area has a size of 128Mbytes starting at 0xf8000000.
> With 4k pages, a PGD entry is 4Mbytes
> With 16k pages, a PGD entry is 64Mbytes
> With 64k pages, a PGD entry is 256Mbytes which is too big.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32: Disable KASAN with pages bigger than 16k
      https://git.kernel.org/powerpc/c/888468ce725a4cd56d72dc7e5096078f7a9251a0

cheers
