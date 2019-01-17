Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF35C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 00:29:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF515205C9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 00:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF515205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43g4gv60p4zDqjn
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 11:28:59 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43g4f93RjwzDqjl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 11:27:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43g4f9229qz9sD9; Thu, 17 Jan 2019 11:27:29 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: da727097a482a93645ba5beea8d389ebab11fc64
X-Patchwork-Hint: ignore
In-Reply-To: <20190115004745.9996-1-Jason@zx2c4.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, benh@kernel.crashing.org,
 paulus@samba.org, aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: PCI does not require PowerNV
Message-Id: <43g4f9229qz9sD9@ozlabs.org>
Date: Thu, 17 Jan 2019 11:27:29 +1100 (AEDT)
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-01-15 at 00:47:45 UTC, "Jason A. Donenfeld" wrote:
> Commit 0e759bd75285 moved around the declaration of pnv_npu2_init, but
> did not conditionalize it inside of the PCI pSeries driver. This meant
> that CONFIG_PCI && CONFIG_PPC_PSERIES && !CONFIG_PPC_POWERNV resulted
> in:
> 
> powerpc64le-pc-linux-gnu-ld: arch/powerpc/platforms/pseries/pci.o: in function `pSeries_final_fixup':
> pci.c:(.init.text+0x1b0): undefined reference to `pnv_npu2_init'
> 
> This commit therefore wraps that line in an ifdef, so that PCI works
> without PowerNV.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Fixes: 0e759bd75285 ("powerpc/powernv/npu: Move OPAL calls away from context manipulation")
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/da727097a482a93645ba5beea8d389eb

cheers
