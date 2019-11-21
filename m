Return-Path: <SRS0=V+RV=ZN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD839C432C0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Nov 2019 08:29:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE7E20718
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Nov 2019 08:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c+FlK1Z+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE7E20718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47JXlh18mjzDqCR
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Nov 2019 19:29:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+b88e8c106c1fb0af7a00+5933+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="c+FlK1Z+"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47JWsQ3nvbzDqyv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2019 18:48:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yUHSd+VEvJlUEZ4r1LMpC7A52dNNWhM/FeOQFOUL7IQ=; b=c+FlK1Z+ReKJMsZbkUMN+QFOW
 j8ak2otf//ZYFJHCl8bC25D6OvAXuWlvFo+L9EM3l+unxvfIzYj5deN9sPtTsxXRBYTr9c4CX2Acc
 Y9pp24aB0S3uar98Gv/U9f6zM2wTKlwR0m4LaWc02XUf9LgdcXPv0I4t+hIq7lXCzM1NuaMc+StAo
 0RBxDMUhDJ+9CCRy5poaJ7jEUfp0ThAG1swfpGM6VcaTxIO/kldVkDAshD6xGj3+ZDBoABDoQ69Dw
 aDcAWk1bBe4DrmGjJlIFOSgi3Ii6hE25saBinCmAlf5X0HZpSm5JQfCnhjxhE0oALha/YU2wHZu/u
 nYIPdFteQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1iXhCx-0001uR-Lj; Thu, 21 Nov 2019 07:48:55 +0000
Date: Wed, 20 Nov 2019 23:48:55 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [Very RFC 06/46] powerpc/iov: Move VF pdev fixup into
 pcibios_fixup_iov()
Message-ID: <20191121074855.GC17209@infradead.org>
References: <20191120012859.23300-1-oohall@gmail.com>
 <20191120012859.23300-7-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120012859.23300-7-oohall@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: alistair@popple.id.au, linuxppc-dev@lists.ozlabs.org,
 s.miroshnichenko@yadro.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 20, 2019 at 12:28:19PM +1100, Oliver O'Halloran wrote:
> Move this out of the PHB's dma_dev_setup() callback and into the
> ppc_md.pcibios_fixup_iov callback. This ensures that the VF PE's
> pdev pointer is always valid for the whole time the device is
> added the bus.
> 
> This isn't strictly required, but it's slightly a slightly more logical
> place to do the fixup and it makes dma_dev_setup a bit simpler.

Ok, this removes the code I commented on earlier, so I take my
comment there back.

> +	if (pdev->is_virtfn) {
> +		/* Fix the VF PE's pdev pointer */
> +		struct pnv_ioda_pe *pe = pnv_ioda_get_pe(pdev);
> +		pe->pdev = pdev;

Maybe add an empty line after the variable declaration?

> @@ -3641,20 +3654,6 @@ void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
>  {
>  	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
>  	struct pnv_phb *phb = hose->private_data;
>  
>  	pnv_pci_ioda_dma_dev_setup(phb, pdev);
>  }

Can you just merge pnv_pci_dma_dev_setup and pnv_pci_ioda_dma_dev_setup
now?

