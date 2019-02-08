Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC62C169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 13:53:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC68D20869
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 13:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ufdoTLyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC68D20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wxTm4TD2zDqBH
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 00:53:16 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wwLS3Ng8zDqWy
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 00:01:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="ufdoTLyv"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43wwLR5dgwz8tCq
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 00:01:51 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43wwLQ4XFLz9sN9; Sat,  9 Feb 2019 00:01:50 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="ufdoTLyv"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43wwLP4RQvz9sN6
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2019 00:01:49 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43wwLH3F6vz9v0dx;
 Fri,  8 Feb 2019 14:01:43 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=ufdoTLyv; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id m9_AXCmzBVAb; Fri,  8 Feb 2019 14:01:43 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43wwLH1W9zz9ttCB;
 Fri,  8 Feb 2019 14:01:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1549630903; bh=QfSOdxglzNgyuUfkAvFzdLD8RdXfH3oL8mIIbUzUTNI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ufdoTLyvmkzLNLN3G86AnOzWOAv5cxNjbJAh1WDW/Irjk2KaBtB+yd+b/VvRzcSX/
 O5Hq8I1JSTqtZgHCaU801gpxOjwcMABdBmT/yvkUWGoaE/uE5ayMsk0l0xlUArCodz
 DNBUZasBGPE2/jn27kL2/mAcQ0MeEnHF31qeQD68=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 87EA78B8D7;
 Fri,  8 Feb 2019 14:01:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id yLwQWBuXNt51; Fri,  8 Feb 2019 14:01:44 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A55F8B756;
 Fri,  8 Feb 2019 14:01:44 +0100 (CET)
Subject: Re: [PATCH] powerpc: Make PPC_64K_PAGES depend on only 44x or
 PPC_BOOK3S_64
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20190208123416.1051-1-mpe@ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <2fc1837d-af23-751c-d9af-0d0888b26ab4@c-s.fr>
Date: Fri, 8 Feb 2019 13:01:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190208123416.1051-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: oss@buserror.net, aneesh.kumar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 02/08/2019 12:34 PM, Michael Ellerman wrote:
> In commit 7820856a4fcd ("powerpc/mm/book3e/64: Remove unsupported
> 64Kpage size from 64bit booke") we dropped the 64K page size support
> from the 64-bit nohash (Book3E) code.
> 
> But we didn't update the dependencies of the PPC_64K_PAGES option,
> meaning a randconfig can still trigger this code and cause a build
> breakage, eg:
>    arch/powerpc/include/asm/nohash/64/pgtable.h:14:2: error: #error "Page size not supported"
>    arch/powerpc/include/asm/nohash/mmu-book3e.h:275:2: error: #error Unsupported page size
> 
> So remove PPC_BOOK3E_64 from the dependencies. This also means we
> don't need to worry about PPC_FSL_BOOK3E, because that was just trying
> to prevent the PPC_BOOK3E_64=y && PPC_FSL_BOOK3E=y case.

Does it means some cleanup could be done, for instance:

arch/powerpc/include/asm/nohash/64/pgalloc.h:#ifndef CONFIG_PPC_64K_PAGES
arch/powerpc/include/asm/nohash/64/pgalloc.h:#endif /* 
CONFIG_PPC_64K_PAGES */
arch/powerpc/include/asm/nohash/64/pgtable.h:#ifdef CONFIG_PPC_64K_PAGES
arch/powerpc/include/asm/nohash/64/slice.h:#ifdef CONFIG_PPC_64K_PAGES
arch/powerpc/include/asm/nohash/64/slice.h:#else /* CONFIG_PPC_64K_PAGES */
arch/powerpc/include/asm/nohash/64/slice.h:#endif /* 
!CONFIG_PPC_64K_PAGES */
arch/powerpc/include/asm/nohash/pte-book3e.h:#ifdef CONFIG_PPC_64K_PAGES

arch/powerpc/mm/tlb_low_64e.S:#ifdef CONFIG_PPC_64K_PAGES
arch/powerpc/mm/tlb_low_64e.S:#ifndef CONFIG_PPC_64K_PAGES
arch/powerpc/mm/tlb_low_64e.S:#endif /* CONFIG_PPC_64K_PAGES */
arch/powerpc/mm/tlb_low_64e.S:#ifdef CONFIG_PPC_64K_PAGES
arch/powerpc/mm/tlb_low_64e.S:#ifdef CONFIG_PPC_64K_PAGES
arch/powerpc/mm/tlb_low_64e.S:#ifndef CONFIG_PPC_64K_PAGES
arch/powerpc/mm/tlb_low_64e.S:#endif /* CONFIG_PPC_64K_PAGES */
arch/powerpc/mm/tlb_low_64e.S:#ifndef CONFIG_PPC_64K_PAGES
arch/powerpc/mm/tlb_low_64e.S:#endif /* CONFIG_PPC_64K_PAGES */
arch/powerpc/mm/tlb_low_64e.S:#ifndef CONFIG_PPC_64K_PAGES
arch/powerpc/mm/tlb_low_64e.S:#ifdef CONFIG_PPC_64K_PAGES


Christophe

> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   arch/powerpc/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 3f237ffa0649..7a16b8a7b54b 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -694,7 +694,7 @@ config PPC_16K_PAGES
>   
>   config PPC_64K_PAGES
>   	bool "64k page size"
> -	depends on !PPC_FSL_BOOK3E && (44x || PPC_BOOK3S_64 || PPC_BOOK3E_64)
> +	depends on 44x || PPC_BOOK3S_64
>   	select HAVE_ARCH_SOFT_DIRTY if PPC_BOOK3S_64
>   
>   config PPC_256K_PAGES
> 
