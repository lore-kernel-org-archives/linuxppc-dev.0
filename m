Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9252EC282CD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 04:42:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2DD20821
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 04:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="JfpAJ9g+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2DD20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43q9hQ720QzDqTY
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 15:42:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::4; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="JfpAJ9g+"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43q9ff3K5gzDqS9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 15:40:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1548823252;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=wlCPd9t+ai37SuMMWwk22tHj2OiZPFG7JEALF32RN7Q=;
 b=JfpAJ9g+QjrDPNCWKXdOE3WzEIPMAGhy6PFz5/24bmNOt11uF7noDAd2yF+Dtj9UxJ
 DNGhV05ANKSLVcl0CI3CCCd8w9g+LCQHG4b5yKceRklhz2we5uFOawA/i1jzrvxtmvQE
 ffQ0V/rN0Cl3sESnLn4SgXNna2GCYnfveuqZS5OCWT8ugmrKyjGgqNqWYIpKxy95WWdW
 JxVi2ilYHObT4BItYDv+bpvB798qB3eg+VTiZYHO5/JdjZ/2r4oPQrIjTh7LwCxpK2r9
 BguE/Diy+qpKYabCXeLa63DD5qrx8WHHHNGsRW39tyV6dLg2JVIRvG1LJHPjZDxapQGZ
 rmnw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7NWd5irpgkCKCilfXBXJD48yBI66ylK3+2uPIEi8="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:8081:5dd1:48c0:9ec:f37f:30cd]
 by smtp.strato.de (RZmta 44.9 AUTH) with ESMTPSA id t0203dv0U4ebCQ0
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Wed, 30 Jan 2019 05:40:37 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <20190129163415.GA14529@lst.de>
Date: Wed, 30 Jan 2019 05:40:36 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <F4AB3D9A-97EC-45D7-9061-A750D0934C3C@xenosoft.de>
References: <20190119140452.GA25198@lst.de>
 <bfe4adcc-01c1-7b46-f40a-8e020ff77f58@xenosoft.de>
 <8434e281-eb85-51d9-106f-f4faa559e89c@xenosoft.de>
 <4d8d4854-dac9-a78e-77e5-0455e8ca56c4@xenosoft.de>
 <1dec2fbe-f654-dac7-392a-93a5d20e3602@xenosoft.de>
 <20190128070422.GA2772@lst.de> <20190128162256.GA11737@lst.de>
 <D64B1ED5-46F9-43CF-9B21-FABB2807289B@xenosoft.de>
 <6f2d6bc9-696b-2cb1-8a4e-df3da2bd6c0a@xenosoft.de>
 <20190129161411.GA14022@lst.de> <20190129163415.GA14529@lst.de>
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

Thanks a lot for the updates. I will test the full branch tomorrow.

Cheers,
Christian

Sent from my iPhone

> On 29. Jan 2019, at 17:34, Christoph Hellwig <hch@lst.de> wrote:
>=20
>> On Tue, Jan 29, 2019 at 05:14:11PM +0100, Christoph Hellwig wrote:
>>> On Tue, Jan 29, 2019 at 04:03:32PM +0100, Christian Zigotzky wrote:
>>> Hi Christoph,
>>>=20
>>> I compiled kernels for the X5000 and X1000 from your new branch=20
>>> 'powerpc-dma.6-debug.2' today. The kernels boot and the P.A. Semi Ethern=
et=20
>>> works!
>>=20
>> Thanks for testing!  I'll prepare a new series that adds the other
>> patches on top of this one.
>=20
> And that was easier than I thought - we just had a few patches left
> in powerpc-dma.6, so I've rebased that branch on top of
> powerpc-dma.6-debug.2:
>=20
>    git://git.infradead.org/users/hch/misc.git powerpc-dma.6
>=20
> Gitweb:
>=20
>    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc=
-dma.6
>=20
> I hope the other patches are simple enough, so just testing the full
> branch checkout should be fine for now.
