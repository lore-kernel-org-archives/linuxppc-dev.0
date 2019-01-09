Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECADC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 11:56:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439572075C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 11:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439572075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZSK91K12zDqdv
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 22:56:45 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ZSGd5YLGzDqc9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 22:54:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43ZSGc528tz9sCh;
 Wed,  9 Jan 2019 22:54:32 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH] powerpc/powernv/npu: Allocate enough memory in
 pnv_try_setup_npu_table_group()
In-Reply-To: <20190109102328.GB5476@kadam>
References: <20190109102328.GB5476@kadam>
Date: Wed, 09 Jan 2019 22:54:29 +1100
Message-ID: <87wonerqq2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Mark Hairgrove <mhairgrove@nvidia.com>, kernel-janitors@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Dan Carpenter <dan.carpenter@oracle.com> writes:
> There is a typo so we accidentally allocate enough memory for a pointer
> when we wanted to allocate enough for a struct.
>
> Fixes: 0bd971676e68 ("powerpc/powernv/npu: Add compound IOMMU groups")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  arch/powerpc/platforms/powernv/npu-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, I've applied this to my fixes-test tree.

Alexey can you send me an ack?

cheers

> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index d7f742ed48ba..3f58c7dbd581 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -564,7 +564,7 @@ struct iommu_table_group *pnv_try_setup_npu_table_group(struct pnv_ioda_pe *pe)
>  		}
>  	} else {
>  		/* Create a group for 1 GPU and attached NPUs for POWER8 */
> -		pe->npucomp = kzalloc(sizeof(pe->npucomp), GFP_KERNEL);
> +		pe->npucomp = kzalloc(sizeof(*pe->npucomp), GFP_KERNEL);
>  		table_group = &pe->npucomp->table_group;
>  		table_group->ops = &pnv_npu_peers_ops;
>  		iommu_register_group(table_group, hose->global_number,
> -- 
> 2.17.1
