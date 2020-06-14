Return-Path: <SRS0=g/Eh=73=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D51C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Jun 2020 07:28:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9FC0206D7
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Jun 2020 07:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9FC0206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49l5g56vZBzDqWQ
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Jun 2020 17:28:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49l5dL1XxkzDqNS
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jun 2020 17:27:13 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 49l5d30V58z9tyQj;
 Sun, 14 Jun 2020 09:27:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id CY8D_aO72Fh8; Sun, 14 Jun 2020 09:27:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 49l5d26ZVvz9tyQh;
 Sun, 14 Jun 2020 09:27:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B511C8B769;
 Sun, 14 Jun 2020 09:27:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id fRjOAdJp24BP; Sun, 14 Jun 2020 09:27:06 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 369968B75F;
 Sun, 14 Jun 2020 09:27:05 +0200 (CEST)
Subject: Re: [PATCH] powerpc/powernv/pci: add ifdef to avoid dead code
To: Greg Thelen <gthelen@google.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Oliver O'Halloran <oohall@gmail.com>
References: <20200614055418.33497-1-gthelen@google.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <37af499e-2b8b-7e78-ed4b-0aaf711fcb38@csgroup.eu>
Date: Sun, 14 Jun 2020 09:26:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200614055418.33497-1-gthelen@google.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

Le 14/06/2020 à 07:54, Greg Thelen a écrit :
> Commit dc3d8f85bb57 ("powerpc/powernv/pci: Re-work bus PE
> configuration") removed a couple pnv_ioda_setup_bus_dma() calls.  The
> only remaining calls are behind CONFIG_IOMMU_API.  Thus builds without
> CONFIG_IOMMU_API see:
>    arch/powerpc/platforms/powernv/pci-ioda.c:1888:13: error: 'pnv_ioda_setup_bus_dma' defined but not used
> 
> Add CONFIG_IOMMU_API ifdef guard to avoid dead code.

I think you should move the function down into the same ifdef as the 
callers instead of adding a new ifdef.

Christophe

> 
> Fixes: dc3d8f85bb57 ("powerpc/powernv/pci: Re-work bus PE configuration")
> Signed-off-by: Greg Thelen <gthelen@google.com>
> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 73a63efcf855..f7762052b7c4 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1885,6 +1885,7 @@ static bool pnv_pci_ioda_iommu_bypass_supported(struct pci_dev *pdev,
>   	return false;
>   }
>   
> +#ifdef CONFIG_IOMMU_API
>   static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
>   {
>   	struct pci_dev *dev;
> @@ -1897,6 +1898,7 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
>   			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
>   	}
>   }
> +#endif
>   
>   static inline __be64 __iomem *pnv_ioda_get_inval_reg(struct pnv_phb *phb,
>   						     bool real_mode)
> 
