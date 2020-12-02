Return-Path: <SRS0=PqhP=FG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFA4C64E7C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Dec 2020 11:30:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E5320757
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Dec 2020 11:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E5320757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CmGwr29DGzDqZ3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Dec 2020 22:30:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=alien8.de (client-ip=2a01:4f8:190:11c2::b:1457;
 helo=mail.skyhub.de; envelope-from=bp@alien8.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256
 header.s=dkim header.b=HrvlMCQD; dkim-atps=neutral
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CmGqV5wqTzDqDQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2020 22:25:39 +1100 (AEDT)
Received: from zn.tnic (p200300ec2f161b00e186258fb055049e.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f16:1b00:e186:258f:b055:49e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5938E1EC04D6;
 Wed,  2 Dec 2020 12:25:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1606908319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=auyM2v2JUyjcuzu7CPUf133Nl+wA9VC3RsABVwER50A=;
 b=HrvlMCQDSwyBJUvAUrSYUGvqLJKpRoJhr2fJO/O7GryF/KJ/kaNcQ+FZC0owkEvxlRx3ke
 PWcsKYyHABE1dZfvDA6gAKmgs66Y4gaTbr2LP93YxZSHb97QCsPFDwuwuu/4EBGmtIXH7d
 QS5VnEr+bP4cyAALPbsFlCfAJYQllXI=
Date: Wed, 2 Dec 2020 12:25:15 +0100
From: Borislav Petkov <bp@alien8.de>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] EDAC, mv64x60: Fix error return code in
 mv64x60_pci_err_probe()
Message-ID: <20201202112515.GC2951@zn.tnic>
References: <20201124063009.1529-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201124063009.1529-1-bobo.shaobowang@huawei.com>
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
Cc: cj.chengjian@huawei.com, linux-kernel@vger.kernel.org,
 Wang ShaoBo <bobo.shaobowang@huawei.com>, james.morse@arm.com,
 huawei.libin@huawei.com, mchehab@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-edac@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Nov 24, 2020 at 02:30:09PM +0800, Wang ShaoBo wrote:
> Fix to return -ENODEV error code when edac_pci_add_device() failed instaed
> of 0 in mv64x60_pci_err_probe(), as done elsewhere in this function.
> 
> Fixes: 4f4aeeabc061 ("drivers-edac: add marvell mv64x60 driver")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  drivers/edac/mv64x60_edac.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
> index 3c68bb525d5d..456b9ca1fe8d 100644
> --- a/drivers/edac/mv64x60_edac.c
> +++ b/drivers/edac/mv64x60_edac.c
> @@ -168,6 +168,7 @@ static int mv64x60_pci_err_probe(struct platform_device *pdev)
>  
>  	if (edac_pci_add_device(pci, pdata->edac_idx) > 0) {
>  		edac_dbg(3, "failed edac_pci_add_device()\n");
> +		res = -ENODEV;
>  		goto err;
>  	}

That driver depends on MV64X60 and I don't see anything in the tree
enabling it and I can't select it AFAICT:

config MV64X60
        bool
        select PPC_INDIRECT_PCI
        select CHECK_CACHE_COHERENCY

PPC folks, what do we do here?

If not used anymore, I'd love to have one less EDAC driver.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
