Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78848EB64DD
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jul 2023 05:59:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QvZy11M1Sz3dnd
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jul 2023 15:59:37 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QvZp75Qb7z3bPZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2023 15:52:47 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvZp748N2z4wy0;
	Mon,  3 Jul 2023 15:52:47 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Rob Herring <robh@kernel.org>
In-Reply-To: <20230609183244.1767325-1-robh@kernel.org>
References: <20230609183244.1767325-1-robh@kernel.org>
Subject: Re: [PATCH] powerpc: fsl_rio: Use of_range_to_resource() for "ranges" parsing
Message-Id: <168836201902.50010.6190167965224825737.b4-ty@ellerman.id.au>
Date: Mon, 03 Jul 2023 15:26:59 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 09 Jun 2023 12:32:44 -0600, Rob Herring wrote:
> "ranges" is a standard property with common parsing functions. Users
> shouldn't be implementing their own parsing of it. Refactor the FSL RapidIO
> "ranges" parsing to use of_range_to_resource() instead.
> 
> One change is the original code would look for "#size-cells" and
> "#address-cells" in the parent node if not found in the port child
> nodes. That is non-standard behavior and not necessary AFAICT. In 2011
> in commit 54986964c13c ("powerpc/85xx: Update SRIO device tree nodes")
> there was an ABI break. The upstream .dts files have been correct since
> at least that point.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: fsl_rio: Use of_range_to_resource() for "ranges" parsing
      https://git.kernel.org/powerpc/c/c4ae1799a5a358388acb610512c68666f8758364

cheers
