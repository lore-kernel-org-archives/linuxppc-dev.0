Return-Path: <SRS0=MZVM=KK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C2AC433B4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 May 2021 22:46:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F8761278
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 May 2021 22:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F8761278
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FjL9B4Yk2z3bxc
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 May 2021 08:46:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FjL8Q2NN6z2xg1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 May 2021 08:45:42 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FjL8P3l5fz9sX1; Sun, 16 May 2021 08:45:41 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: pmenzel@molgen.mpg.de, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <d5e3c8e66bad3725d7d48d0e45c4b7eb7c02631d.1620455671.git.christophe.leroy@csgroup.eu>
References: <d5e3c8e66bad3725d7d48d0e45c4b7eb7c02631d.1620455671.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/legacy_serial: Fix UBSAN:
 array-index-out-of-bounds
Message-Id: <162111863369.1890426.15615918327643788763.b4-ty@ellerman.id.au>
Date: Sun, 16 May 2021 08:43:53 +1000
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

On Sat, 8 May 2021 06:36:21 +0000 (UTC), Christophe Leroy wrote:
> UBSAN complains when a pointer is calculated with invalid
> 'legacy_serial_console' index, allthough the index is verified
> before dereferencing the pointer.
> 
> Fix it by checking 'legacy_serial_console' validity before
> calculating pointers.

Applied to powerpc/fixes.

[1/1] powerpc/legacy_serial: Fix UBSAN: array-index-out-of-bounds
      https://git.kernel.org/powerpc/c/63970f3c37e75997ed86dbdfdc83df35f2152bb1

cheers
