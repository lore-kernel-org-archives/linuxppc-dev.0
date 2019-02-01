Return-Path: <SRS0=xfkn=QI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAC4C282D8
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 07:07:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D79520869
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 07:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MG8KYwqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D79520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43rSpc64pFzDqgF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 18:07:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=samsung.com
 (client-ip=210.118.77.12; helo=mailout2.w1.samsung.com;
 envelope-from=m.szyprowski@samsung.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=samsung.com header.i=@samsung.com header.b="MG8KYwqA"; 
 dkim-atps=neutral
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43rSmb5ysWzDqft
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2019 18:05:33 +1100 (AEDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190201070524euoutp0271a6927fde2544e0b1b79d9795f82c41~-K5ckQJNA3054830548euoutp02n
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2019 07:05:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190201070524euoutp0271a6927fde2544e0b1b79d9795f82c41~-K5ckQJNA3054830548euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1549004725;
 bh=LhAbpAXv7b/Jn7o325o9y8sGGKskPWyhIXvcBW6qwkw=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=MG8KYwqANB69uO/4zY6Gk0LdoZarp9Cs7FUx70iN6vx6iMthi2rmUrJchyElhuCXI
 ue8GKuQtrC7k9TPz7Ux2mrPclngbw/w4DjABEufGVXjqX6685rZfpqaLnSZ6UVDyku
 xRjOqc9xptqOaOL5mSRoZogADQEPWlwdMa3RE1PM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190201070524eucas1p229ba0acf0035070676f91a8a232641fd~-K5cCzkFj1110511105eucas1p29;
 Fri,  1 Feb 2019 07:05:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 3F.07.04294.4BFE35C5; Fri,  1
 Feb 2019 07:05:24 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20190201070523eucas1p28a8a40b06589f725d1facf7a67f730e1~-K5a6jZqr0928209282eucas1p2_;
 Fri,  1 Feb 2019 07:05:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20190201070522eusmtrp26d172e9535374389e9895d570bce24d3~-K5ar7rc10763207632eusmtrp2r;
 Fri,  1 Feb 2019 07:05:22 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-6e-5c53efb4fa2d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 9F.1D.04128.2BFE35C5; Fri,  1
 Feb 2019 07:05:22 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190201070522eusmtip1cb186b54c52224a98fdf4e190acba454~-K5aKnxyo0176601766eusmtip1H;
 Fri,  1 Feb 2019 07:05:22 +0000 (GMT)
Subject: Re: fix a layering violation in videobuf2 and improve
 dma_map_resource v2
To: Christoph Hellwig <hch@lst.de>, Pawel Osciak <pawel@osciak.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, =?UTF-8?Q?Niklas_S=c3=b6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <774dc557-b690-203f-898f-38755b099068@samsung.com>
Date: Fri, 1 Feb 2019 08:05:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190118113727.3270-1-hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjt9e7e3a1m12n4kJI0QjLKaURdNCTT4NKfoiLIj2zmxUSnsqVl
 RvkRZkstv1CHlIFpWU2by9TUcpnDcpbOaiqCNT/QMgkzy8xyu1r+e895zvOec+AhMbEZX09G
 xZ5mFbGyGAkh5NW1/+zapps6HOI1li6g7957YUeXPfWljWmf+bTW8g6nTY2lBJ1V8win9YXN
 iP41u4DTFdp5O3qwYytdMPmTv2c1Y3rXjTHaqisEU1t+kck3VyLmdfEtxDzpSyEYy9w4wYyZ
 ZgkmR1eFmGnthoPCIOHuCDYmKpFVSP1OCE9dff8Fi9fgZ4tUhXgKKuepkIAEagekaloxFRKS
 YuoOggeGbMSBbwg+jY/wODCNoKWngr+8Mq038rlBJQLN1ZdLqikEprxWwqpypI5AsXHANnCi
 mhF0ZVzDrQCj5hEYbhiRVUVQ3qCaVNk2RJQfjP/us3nwqE2Qasyw8euoECjoauNzGgfoKBm2
 RRdQUujsrLTxGOUGjydLMe7tDP3DN+2sZkDN8GFq5ivOBQ+EhuLRpd6OMGHQLRVyhT8Nywvp
 CC4Xq/kcyELwqLSe4FS+8NzQvfgTuWjhAdWNUo72h/L2Ab6VBsoezJMOXAh7yKsrwjhaBJkZ
 Yk7tDmqD5p9t65se7DqSqFdUU6+oo15RR/3ftwzxqpAzm6CUR7LK7bHsGU+lTK5MiI30PBkn
 16LFe3u1YPhWjxrnw/WIIpFkjahm7lCIGJclKpPkegQkJnEStQ0eDhGLImRJ51hFXJgiIYZV
 6pELyZM4i5JXDQWLqUjZaTaaZeNZxfLUjhSsT0EuvftyiImOtXPhX5NDHds8RJn3049XvR14
 OGQO2BgdvrpHeiz/vCl41N7i5d79LMDHbO/TtPlSmdt31wY31lAbkNJiTKtbE6RP1h3IsuwM
 vt30gy7p3S+4c6K3yUyHtkStPZTbu7cxg9THfezPzbbk5tTnVYZNVO/6MEJEXfA/GijhKU/J
 vLdgCqXsL8NRby1rAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsVy+t/xu7qb3gfHGLS/NrdYufook8WC/dYW
 Z5vesFtsenyN1eLyrjlsFj0btrJaHJq6l9Hi9/d/rBbLNv1hsrh7Usdiytuf7A7cHpevXWT2
 2LSqk81j85J6j8k3ljN6nJ+xkNFj980GNo/Hv16yeTy//J3No2/LKkaPz5vkArii9GyK8ktL
 UhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DK6r79jLljHWjG9
 ayprA+MSli5GTg4JAROJz4fOsncxcnEICSxllNhz+ygbREJG4uS0BlYIW1jiz7UuNoiit4wS
 vS8nM4IkhAVCJGacvc0CkhAR2Msocf/0XbAqZoF/jBLze3cwQrQ0MUosWHsebBabgKFE19su
 sB28AnYSL//eZAexWQRUJBrPtgHFOThEBWIkrp5jhCgRlDg58wnYrZwC+hJnziwHK2cWUJf4
 M+8SM4QtL7H97RwoW1zi1pP5TBMYhWYhaZ+FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtIrTswt
 Ls1L10vOz93ECIzmbcd+bgH6513wIUYBDkYlHt4Nv4JihFgTy4orcw8xSnAwK4nwHrkbHCPE
 m5JYWZValB9fVJqTWnyI0RTot4nMUqLJ+cBEk1cSb2hqaG5haWhubG5sZqEkznveoDJKSCA9
 sSQ1OzW1ILUIpo+Jg1OqgfGmNnP5FrFrlx4dt7ksHT4xLoZPWPHhXyGnJW4OUYJmtWJ2r84v
 ex+iFL1oy8tTSi9Y5gVvdrjf33f9zgSOH6wTf53SfHnjpFf3j470ht6ZDjfWvPeOZp1l4GRx
 sO/PCvU761brpmzYKeb3iC+x+4yEVKfUjX+rOLST35nobX+wyaIzec2DDF4lluKMREMt5qLi
 RAADa/MU/AIAAA==
X-CMS-MailID: 20190201070523eucas1p28a8a40b06589f725d1facf7a67f730e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190118113751epcas2p2d7d678dcf247806a119316aabb4dde21
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190118113751epcas2p2d7d678dcf247806a119316aabb4dde21
References: <CGME20190118113751epcas2p2d7d678dcf247806a119316aabb4dde21@epcas2p2.samsung.com>
 <20190118113727.3270-1-hch@lst.de>
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
Cc: Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi All,

On 2019-01-18 12:37, Christoph Hellwig wrote:
> Hi all,
>
> this series fixes a rather gross layering violation in videobuf2, which
> pokes into arm DMA mapping internals to get a DMA address for memory that
> does not have a page structure, and to do so fixes up the dma_map_resource
> implementation to not provide a somewhat dangerous default and improve
> the error handling.
>
> Changes since v1:
>  - don't apply bus offsets in dma_direct_map_resource

Works fine on older Exynos based boards with IOMMU and CMA disabled.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

