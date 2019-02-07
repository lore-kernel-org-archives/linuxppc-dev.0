Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888E9C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 04:37:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC8D02175B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 04:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="tig0SVU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8D02175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w5Bl0m5czDqQ3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 15:37:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::11; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="tig0SVU5"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w58J30VFzDqNC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 15:35:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549514106;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=4RCZJtim6FzAWTAE5STy48t7VfnqZ8YM7yrGj0CnzHY=;
 b=tig0SVU54hTPFYK6n3KIEmUsWMsFB0sGTmWMK260DEHKu/ODT/M8+XVv73Qd2rl6ym
 gH4OfYgQ13EX5TLnJOcnHnGGnmUglCEHRW82zQ7cJ1euvRivouD8l+h8rTS5NZXxdAFt
 Up4jL+CMR4Wz1WmKA00TX3YbAPPpL8UNHHsKOPCkMFLI8+xemu8ETR90IrQ88PN4dt3/
 1mhFytpzLPEMKF0kapNIIavSjPacwwa/JoFJg1P/VYATYts15XPly/CSaBVihk+cMaXf
 GmjKMvNvGm17W9F5UAOzf0IdAfu1BAXWMLTpHUEq7SVHTWdT6Gpnp/zVpd4NBHIbJHiq
 NlNA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7NWZ5irpilnQb0empL4BoZuMumiBlihp1rlLmzaQ="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:8181:7b2f:5890:9cb6:8e8:3292]
 by smtp.strato.de (RZmta 44.9 AUTH) with ESMTPSA id t0203dv174Yrxds
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Thu, 7 Feb 2019 05:34:53 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <20190206151655.GA31172@lst.de>
Date: Thu, 7 Feb 2019 05:34:52 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de>
References: <F4AB3D9A-97EC-45D7-9061-A750D0934C3C@xenosoft.de>
 <96762cd2-65fc-bce5-8c5b-c03bc3baf0a1@xenosoft.de>
 <20190201080456.GA15456@lst.de>
 <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de>
 <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de>
 <20190204075616.GA5408@lst.de>
 <ffbf56ae-c259-47b5-9deb-7fb21fead254@xenosoft.de>
 <20190204123852.GA10428@lst.de>
 <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de>
 <20190206151505.GA31065@lst.de> <20190206151655.GA31172@lst.de>
To: Christoph Hellwig <hch@lst.de>
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
 Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christoph,

I also didn=E2=80=99t notice the 32-bit DMA mask in your patch. I have to re=
ad your patches and descriptions carefully in the future. I will test your n=
ew patch at the weekend.

Thanks,
Christian

Sent from my iPhone

> On 6. Feb 2019, at 16:16, Christoph Hellwig <hch@lst.de> wrote:
>=20
>> On Wed, Feb 06, 2019 at 04:15:05PM +0100, Christoph Hellwig wrote:
>> The last good one was 29e7e2287e196f48fe5d2a6e017617723ea979bf
>> ("dma-direct: we might need GFP_DMA for 32-bit dma masks"), if I
>> remember correctly.  powerpc/dma: use the dma_direct mapping routines
>> was the one that you said makes the pasemi ethernet stop working.
>>=20
>> Can you post the dmesg from the failing runs?
>=20
> But I just noticed I sent you a wrong patch - the pasemi ethernet
> should set a 64-bit DMA mask, not 32-bit.  Updated version below,
> 32-bit would just keep the previous status quo.
>=20
> commit 6c8f88045dee35933337b9ce2ea5371eee37073a
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Mon Feb 4 13:38:22 2019 +0100
>=20
>    pasemi WIP
>=20
> diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethern=
et/pasemi/pasemi_mac.c
> index 8a31a02c9f47..2d7d1589490a 100644
> --- a/drivers/net/ethernet/pasemi/pasemi_mac.c
> +++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
> @@ -1716,6 +1716,7 @@ pasemi_mac_probe(struct pci_dev *pdev, const struct p=
ci_device_id *ent)
>        err =3D -ENODEV;
>        goto out;
>    }
> +    dma_set_mask(&mac->dma_pdev->dev, DMA_BIT_MASK(64));
>=20
>    mac->iob_pdev =3D pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa001, NULL);
>    if (!mac->iob_pdev) {
