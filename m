Return-Path: <SRS0=dmdX=PA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782E1C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Oct 2021 15:30:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA2F561074
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Oct 2021 15:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BA2F561074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HTKPF5fZ2z2yTr
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Oct 2021 02:30:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pgxa5ioP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=jarkko@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=pgxa5ioP; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HTKNX3hVnz2y6F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Oct 2021 02:30:04 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C843160F3A;
 Tue, 12 Oct 2021 15:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634052601;
 bh=JpF6An/Riv/dMcUkrhm8JSEkFKJMUWfWjMUX6PwjxwE=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=pgxa5ioPEQcnUN4WhfnouRG3+p0X4c1Fi/dcxyxpGiHcKIBi06OUe7KEFSmwQnEj4
 9CKnSJy3J9R8HsExGL6hXZYoLmQ+sxuj4KL+EPjfyAuG3d13IiqBOrlo2oRzAIULso
 7eZcbjqZAQHghUA65lYc4vOS4QvnxbPN9TqnzCdpZ2F78zYQZ3vA1KBEw6oEPOiXlj
 BirBxvEBgeoRDGprFFcSgTdznJV5JOklg4yzuG54yHVd4/JPB5YLqe4vUo/oXTu9MU
 2SX9eh/7lEHihPPkibIqfDcSq1xls9O6cJkqA/IH7wtdWXeMiD5WDE+PFMWDpceM8l
 8yCsauCyBBbfA==
Message-ID: <31619f2f192a4f1584e458f468422cf6e8f7542f.camel@kernel.org>
Subject: Re: [PATCH] tpm: ibmvtpm: Make use of dma_alloc_coherent()
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cai Huoqing <caihuoqing@baidu.com>
Date: Tue, 12 Oct 2021 18:29:58 +0300
In-Reply-To: <20211010160147.590-1-caihuoqing@baidu.com>
References: <20211010160147.590-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
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
Cc: linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Paul Mackerras <paulus@samba.org>, Peter Huewe <peterhuewe@gmx.de>,
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2021-10-11 at 00:01 +0800, Cai Huoqing wrote:
> Replacing kmalloc/kfree/get_zeroed_page/free_page/dma_map_single/
  ~~~~~~~~~
  Replace

> dma_unmap_single() with dma_alloc_coherent/dma_free_coherent()
> helps to reduce code size, and simplify the code, and coherent
> DMA will not clear the cache every time.
>=20
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

If this does not do functionally anything useful, there's no
reason to apply this.

It is also missing information why the substitution is possible.

Field tested code is better than clean code, i.e. we don not
risk at having possible new regressions just for a bit nicer
layout...

/Jarkko


