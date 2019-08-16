Return-Path: <SRS0=SmZj=WM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32699C3A59D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Aug 2019 17:55:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA54120665
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Aug 2019 17:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaAnW7Hy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA54120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4699vQ48GgzDqLR
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Aug 2019 03:54:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=will@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="LaAnW7Hy"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4699NG3sFNzDqPg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Aug 2019 03:31:26 +1000 (AEST)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7983D2086C;
 Fri, 16 Aug 2019 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1565976683;
 bh=7UbpCD1eMEdhuE0pVTSmVthW5ADpKtqL/oqKqCN+HEw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LaAnW7Hy029sRfOJ26P9ooRMDVttHdguTvMjat5nc99EUXzMN+g9WMxOwM1dXJPb5
 bzS+jtNUqmYhQDy0h+E7F6sfWJBaB+AAIxRpe05xEh7d5AcpaSW6E2fETpzfwyN7Jv
 fjwn73EdjqvOR3Xn6IGkIW6zAlcnUI3ffOP7Clmo=
Date: Fri, 16 Aug 2019 18:31:18 +0100
From: Will Deacon <will@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/6] arm64: document the choice of page attributes for
 pgprot_dmacoherent
Message-ID: <20190816173118.4rbbzuogfamfa554@willie-the-truck>
References: <20190816070754.15653-1-hch@lst.de>
 <20190816070754.15653-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816070754.15653-7-hch@lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Cc: Shawn Anastasio <shawn@anastas.io>, linux-m68k@lists.linux-m68k.org,
 Guan Xuetao <gxt@pku.edu.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-mips@vger.kernel.org, iommu@lists.linux-foundation.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paul.burton@mips.com>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christoph,

Thanks for spinning this into a patch.

On Fri, Aug 16, 2019 at 09:07:54AM +0200, Christoph Hellwig wrote:
> Based on an email from Will Deacon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/include/asm/pgtable.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 6700371227d1..6ff221d9a631 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -435,6 +435,14 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
>  	__pgprot_modify(prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_NORMAL_NC) | PTE_PXN | PTE_UXN)
>  #define pgprot_device(prot) \
>  	__pgprot_modify(prot, PTE_ATTRINDX_MASK, PTE_ATTRINDX(MT_DEVICE_nGnRE) | PTE_PXN | PTE_UXN)
> +/*
> + * DMA allocations for non-coherent devices use what the Arm architecture calls
> + * "Normal non-cacheable" memory, which permits speculation, unaligned accesses
> + * and merging of writes.  This is different from "Strongly Ordered" memory
> + * which is intended for MMIO and thus forbids speculation, preserves access
> + * size, requires strict alignment and also forces write responses to come from
> + * the endpoint.
> + */

Mind if I tweak the second sentence to be:

  This is different from "Device-nGnR[nE]" memory which is intended for MMIO
  and thus forbids speculation, preserves access size, requires strict
  alignment and can also force write responses to come from the endpoint.

? It's a small change, but it better fits with the arm64 terminology
("strongly ordered" is no longer used in the architecture).

If you're happy with that, I can make the change and queue this patch
for 5.4.

Thanks,

Will
