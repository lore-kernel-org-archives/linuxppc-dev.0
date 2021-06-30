Return-Path: <SRS0=aNTg=LY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07595C11F65
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jun 2021 13:16:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A61F61455
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jun 2021 13:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A61F61455
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GFML860khz3br2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jun 2021 23:16:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GFMK85jgrz2ykR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jun 2021 23:15:24 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4GFMK10pm6z9sVm; Wed, 30 Jun 2021 23:15:16 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <42f4bd12b476942e4d5dc81c0e839d8871b20b1c.1624863319.git.christophe.leroy@csgroup.eu>
References: <42f4bd12b476942e4d5dc81c0e839d8871b20b1c.1624863319.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Fix setup_{kuap/kuep}() on SMP
Message-Id: <162505885576.174506.2852417119553122234.b4-ty@ellerman.id.au>
Date: Wed, 30 Jun 2021 23:14:15 +1000
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

On Mon, 28 Jun 2021 06:56:11 +0000 (UTC), Christophe Leroy wrote:
> On SMP, setup_kup() is also called from start_secondary().
> 
> start_secondary() is not an __init function.
> 
> Remove the __init marker from setup_kuep() and and setup_kuap().

Applied to powerpc/next.

[1/1] powerpc/32s: Fix setup_{kuap/kuep}() on SMP
      https://git.kernel.org/powerpc/c/c89e632658e793fbbdcbfbe80a6c13bbf7203e9b

cheers
