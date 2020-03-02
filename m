Return-Path: <SRS0=k87x=4T=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D8EC3F2D2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2020 06:41:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C36CC2468E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2020 06:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="oSz5S7kY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36CC2468E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48W9Xv27qXzDqgr
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2020 17:41:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.a=rsa-sha256
 header.s=mail header.b=oSz5S7kY; dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48W9Th0LpQzDqf6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Mar 2020 17:39:03 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 48W9TV4TMwz9v0wq;
 Mon,  2 Mar 2020 07:38:54 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=oSz5S7kY; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 7EtWmBgG6SHY; Mon,  2 Mar 2020 07:38:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 48W9TV3Nwbz9v0wj;
 Mon,  2 Mar 2020 07:38:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1583131134; bh=N5Zqhy9GX98vBukvVYdHhi3AGA4xgTdqzzXq0Yk+kDc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=oSz5S7kYIpq/S2GkRvO3/u1ec0jd0jGZ6JphG6qdC3YLxcAjB8Yw7m4bINUjkYJq9
 ansn60dqfjQ2jB3DYikKqHP0jRkiHE4zFkbufuPGle+GYJZinjIVjbCowO2RsYki9A
 hv47Y7d15aosDKuaZJwAMbf51gErEhkoZ32AxjIw=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 027E88B7BC;
 Mon,  2 Mar 2020 07:38:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id cnGJxBH8ofD8; Mon,  2 Mar 2020 07:38:58 +0100 (CET)
Received: from [172.25.230.100] (unknown [172.25.230.100])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BEE338B776;
 Mon,  2 Mar 2020 07:38:58 +0100 (CET)
Subject: Re: [PATCH] powerpc/sysdev: fix compile errors
To: WANG Wenhu <wenhu.wang@vivo.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Allison Randal <allison@lohutok.net>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200302053801.26027-1-wenhu.wang@vivo.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <62251ec1-dd42-6522-dcb2-613838cd5504@c-s.fr>
Date: Mon, 2 Mar 2020 07:38:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302053801.26027-1-wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
Cc: wenhu.pku@gmail.com, trivial@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 02/03/2020 à 06:37, WANG Wenhu a écrit :
> Include linux/io.h into fsl_85xx_cache_sram.c to fix the
> implicit-declaration compile errors when building Cache-Sram.
> 
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c: In function ‘instantiate_cache_sram’:
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:26: error: implicit declaration of function ‘ioremap_coherent’; did you mean ‘bitmap_complement’? [-Werror=implicit-function-declaration]
>    cache_sram->base_virt = ioremap_coherent(cache_sram->base_phys,
>                            ^~~~~~~~~~~~~~~~
>                            bitmap_complement
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:24: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
>    cache_sram->base_virt = ioremap_coherent(cache_sram->base_phys,
>                          ^
> arch/powerpc/sysdev/fsl_85xx_cache_sram.c:123:2: error: implicit declaration of function ‘iounmap’; did you mean ‘roundup’? [-Werror=implicit-function-declaration]
>    iounmap(cache_sram->base_virt);
>    ^~~~~~~
>    roundup
> cc1: all warnings being treated as errors
> 
> Fixed: commit 6db92cc9d07d ("powerpc/85xx: add cache-sram support")
> Signed-off-by: WANG Wenhu <wenhu.wang@vivo.com>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   arch/powerpc/sysdev/fsl_85xx_cache_sram.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> index f6c665dac725..be3aef4229d7 100644
> --- a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> +++ b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
> @@ -17,6 +17,7 @@
>   #include <linux/of_platform.h>
>   #include <asm/pgtable.h>
>   #include <asm/fsl_85xx_cache_sram.h>
> +#include <linux/io.h>
>   
>   #include "fsl_85xx_cache_ctlr.h"
>   
> 
