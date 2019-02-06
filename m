Return-Path: <SRS0=q2Dt=QN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305EAC169C4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 13:48:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596512175B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 13:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="cHulUexP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596512175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43vjSY0xWFzDqQs
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 00:47:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::10; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="cHulUexP"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43vjQB5ZGBzDqQY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 00:45:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549460747;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=1B0x+fHheTpxhqrmIHIXM2dJK3tS381uY73XT9HFqos=;
 b=cHulUexPEDV6sgeU0EmC3diTc2Mm4jxBfIZ8lU48KUQqtVwFN97IBCPhh3rjJRgQEl
 fuGGLITWka7hL4uvKBp4LxuCpRGUCx5xEqYIMOUfiIc6y4cPTe9xBEZ3oyFzTHEBRyV/
 5I/dU7nohC5VAQ+3WrLgRQrn1YPGq2oEEvyzRx2JvfM7g/tIzPPcjf6Wsl2/XqVzRA5h
 DDgQZ+OXXRVZlGoLfVhcYW4eN2UtqV1ZL6SBWSPzi4D5HQWv46Db2ZlmlMCGhP3IV37r
 vfvTca1txtYdUC124yN18iw2mD6gQKDbp9yn8EzRJeAHY5KuPzYSAeHAVcrPj72n/nyw
 DSIg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7ClZjqpXztc6Zcqs1wHF7xyXswVRvQ=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:f029:5369:8d3a:5beb]
 by smtp.strato.de (RZmta 44.9 AUTH) with ESMTPSA id t0203dv16DjYum1
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Wed, 6 Feb 2019 14:45:34 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
To: Christoph Hellwig <hch@lst.de>, Olof Johansson <olof@lixom.net>
References: <6f2d6bc9-696b-2cb1-8a4e-df3da2bd6c0a@xenosoft.de>
 <20190129161411.GA14022@lst.de> <20190129163415.GA14529@lst.de>
 <F4AB3D9A-97EC-45D7-9061-A750D0934C3C@xenosoft.de>
 <96762cd2-65fc-bce5-8c5b-c03bc3baf0a1@xenosoft.de>
 <20190201080456.GA15456@lst.de>
 <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de>
 <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de>
 <20190204075616.GA5408@lst.de>
 <ffbf56ae-c259-47b5-9deb-7fb21fead254@xenosoft.de>
 <20190204123852.GA10428@lst.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de>
Date: Wed, 6 Feb 2019 14:45:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190204123852.GA10428@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
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
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>,
 linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 04 February 2019 at 01:38PM, Christoph Hellwig wrote:
>
> It seems like the pasemi driver fails to set a DMA mask, but seems
> otherwise 64-bit DMA capable.  The old PPC code didn't verify the
> dma mask during the map operations, but the x86-derived generic
> code does.
>
> This patch just sets the DMA mask.
>
> Olof: does this look ok?  The DMA device seems to not directly
> bound by the net driver, but not really used by anything else in tree
> either..
>
> diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethernet/pasemi/pasemi_mac.c
> index d21041554507..d98bd447c536 100644
> --- a/drivers/net/ethernet/pasemi/pasemi_mac.c
> +++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
> @@ -1716,6 +1716,7 @@ pasemi_mac_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   		err = -ENODEV;
>   		goto out;
>   	}
> +	dma_set_mask(&mac->dma_pdev->dev, DMA_BIT_MASK(32));
>   
>   	mac->iob_pdev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa001, NULL);
>   	if (!mac->iob_pdev) {
>
Hello Christoph,

I patched the source code from the Git 'powerpc-dma.6' with your patch 
today. Unfortunately the P.A. Semi Ethernet doesn't work with the 
patched Git kernel.

After that I tried it with the patch applied over the working setup 
again (powerpc/dma: use the dma_direct mapping routines). Unfortunately 
after compiling
and booting, the P.A. Semi Ethernet doesn't work either.

Cheers,
Christian

