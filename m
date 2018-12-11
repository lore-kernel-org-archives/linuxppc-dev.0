Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534D3C07E85
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 18:20:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D5B420851
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 18:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="Q2eLxigy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5B420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DpBm2kXzzDqKG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 05:20:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="Q2eLxigy";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::11; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="Q2eLxigy"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Dp7r3LBdzDqXd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 05:17:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544552243;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=m6l3qXELKbs/O0GRo+MxuQFKSwj02GVfBj4EedOHVpM=;
 b=Q2eLxigyKWszQXOVRG4uuo9L4E1oABaETXSJsbG6SDWDrSzyj4aimtKiQ/o0OhISe3
 oqtEg1WLkesgyPWwJBPdltnLgvNydBe+Im9xGoRpPLWJOKILYNHpT+GIRzy6bvo9pTNo
 TzFqTqTbNd0AhBAsMk0zTwsvwkjCnmWfM5nUOCGblCeKlX5fpnf4SDwHl1ncE3JZkDfK
 S23lbECrC6iQRGgetbcXSew/XbN7slMs618LQhEsVrS0bX6lJnkC8IKCMR2DgX3vbMcD
 sdS7/SpLlnTW0afdIl7etbr3mtVEeB7zsdFwE5wxwHWWZYIyk/PFGFySBCeR3oFmQG5x
 ER2Q==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkGilHp+9VUkHIzm+DEvUK8o5nh4w=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:9412:ea7f:6067:9fc7]
 by smtp.strato.de (RZmta 44.7 AUTH) with ESMTPSA id j074b8uBBIH546U
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Tue, 11 Dec 2018 19:17:05 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Christoph Hellwig <hch@lst.de>
References: <20181129170351.GC27951@lst.de>
 <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
 <20181130105346.GB26765@lst.de>
 <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de>
 <20181130131056.GA5211@lst.de>
 <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de>
 <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de>
 <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de>
 <20181204142426.GA2743@lst.de>
 <ef56d279-f75d-008e-71ba-7068c1b37c48@xenosoft.de>
 <20181205140550.GA27549@lst.de>
 <1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de>
 <5a2ea855-b4b0-e48a-5c3e-c859a8451ca2@xenosoft.de>
 <7B6DDB28-8BF6-4589-84ED-F1D4D13BFED6@xenosoft.de>
 <8a2c4581-0c85-8065-f37e-984755eb31ab@xenosoft.de>
 <424bb228-c9e5-6593-1ab7-5950d9b2bd4e@xenosoft.de>
 <c86d76b4-b199-557e-bc64-4235729c1e72@xenosoft.de>
 <1ecb7692-f3fb-a246-91f9-2db1b9496305@xenosoft.de>
 <6c997c03-e072-97a9-8ae0-38a4363df919@xenosoft.de>
 <4cfb3f26-74e1-db01-b014-759f188bb5a6@xenosoft.de>
Message-ID: <82879d3f-83de-6438-c1d6-49c571dcb671@xenosoft.de>
Date: Tue, 11 Dec 2018 19:17:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <4cfb3f26-74e1-db01-b014-759f188bb5a6@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
 Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Next step: 7decbcfc656805603ab97206b3f816f26cd2cf7d (powerpc/dma: use 
generic direct and swiotlb ops)

git checkout 7decbcfc656805603ab97206b3f816f26cd2cf7d

We have the bad commit! :-) The PASEMI onboard ethernet doesn't work 
with this commit anymore.

Error messages:

[  367.627623] pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0
[  367.627631] pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0
[  367.627639] pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0
[  367.627647] pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0

pci 0000:00:1a.0 = 00:1a.0 DMA controller: PA Semi, Inc PWRficient DMA 
Controller (rev 12)

X5000 (P5020 board): U-Boot loads the kernel and the dtb file. Then the 
kernel starts but it doesn't find any hard disks (partitions). That 
means this is also the bad commit for the P5020 board.

Link to the bad commit: 
http://git.infradead.org/users/hch/misc.git/commit/7decbcfc656805603ab97206b3f816f26cd2cf7d

Link to the Git: 
http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.5

The commit before (977706f9755d2d697aa6f45b4f9f0e07516efeda - 
powerpc/dma: remove dma_nommu_mmap_coherent) works without any problems.

-- Christian


