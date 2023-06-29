Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5985EB64DD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Jun 2023 20:21:15 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=L8K5AWNr;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QsVG211Q4z3bmm
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Jun 2023 06:21:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=L8K5AWNr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QsVDv1lK7z2xqd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2023 06:20:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=G4aKGQZW2tDX+vXfJyGauKoWl6DfTIBE5I6uDMBxHgE=; b=L8K5AWNrb89HzyB4OAJUBaOZm7
	C6f1gpe9BXwFc5vYRJFo8yEcTkOX3ei8JdPb91W6hJ81BzNcOJIalQL9CMEa7dzBXuQYPUizjP8sF
	zBMiuvee3YtAsP3cZGn2DH2vfExLZ5lqBZmSeIf1EoBgK2W5rke2VezSAC7EJzPHcNFuktYoEDHg4
	yfavK46M4KplZA1479Ni9ZtdmR0OCB2+ql5xyHMv4wPuFPbUepEJappzlcO2SiDoRUnV8eZhX142E
	XLAxPsWfbDaZHX8i/LPnNKvQ8qCDnjn0gM3KiywB87YfWJtu/oYPfG7ulkay/Ik3/UY5x5ArbGJ6M
	jH3+66XA==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qEy7P-0023jo-0n;
	Thu, 29 Jun 2023 20:19:55 +0000
Message-ID: <2192df88-a17b-301d-54ff-310c031b2561@infradead.org>
Date: Thu, 29 Jun 2023 13:19:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] powerpc: Include asm/nmi.c in mobility.c for
 watchdog_hardlockup_set_timeout_pct()
Content-Language: en-US
To: Douglas Anderson <dianders@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20230629124500.1.I55e2f4e7903d686c4484cb23c033c6a9e1a9d4c4@changeid>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230629124500.1.I55e2f4e7903d686c4484cb23c033c6a9e1a9d4c4@changeid>
Content-Type: text/plain; charset=UTF-8
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>, Petr Mladek <pmladek@suse.com>, Jilin Yuan <yuanjilin@cdjrlc.com>, Tom Rix <trix@redhat.com>, Haren Myneni <haren@linux.ibm.com>, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Laurent Dufour <ldufour@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 6/29/23 12:45, Douglas Anderson wrote:
> The powerpc/platforms/pseries/mobility.c calls
> watchdog_hardlockup_set_timeout_pct(), which is declared in
> <asm/nmi.h>. We used to automatically get <asm/nmi.h> included, but
> that changed as of commit 7ca8fe94aa92 ("watchdog/hardlockup: define
> HARDLOCKUP_DETECTOR_ARCH"). Let's add the explicit include.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/r/af19b76d-aa4b-6c88-9cac-eae4b2072497@infradead.org
> Fixes: 7ca8fe94aa92 ("watchdog/hardlockup: define HARDLOCKUP_DETECTOR_ARCH")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> 
>  arch/powerpc/platforms/pseries/mobility.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index cd632ba9ebff..0161226d8fec 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -24,6 +24,7 @@
>  #include <linux/stringify.h>
>  
>  #include <asm/machdep.h>
> +#include <asm/nmi.h>
>  #include <asm/rtas.h>
>  #include "pseries.h"
>  #include "vas.h"	/* vas_migration_handler() */

-- 
~Randy
