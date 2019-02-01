Return-Path: <SRS0=xfkn=QI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99260C282D8
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 16:56:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D433121726
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 16:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="q4ISgXas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D433121726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43rjtl2f7szDqjp
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 03:56:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::12; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="q4ISgXas"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43rjrc3sgwzDqgl
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2019 03:54:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549040090;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=LAbsLwu8sJW7WqnqGFFP5VTZ9qgQ8eLa2wTlFiB3aZY=;
 b=q4ISgXas4ChdNSOE5GdDg4p9muDGmEVv4ZJ2e1LnUVIrATp/37/huEtIyprs6qv350
 vc9tT5kmiivZYi9UriWGBZG5fYLmPsEIWuz2S4MOt/wgXYLpLgpRcyZrCDvzk3dLpJ3S
 Kr+KrRghBPVURGm+W1H/HXdby2VEoOv0kFrJRGX5GeHnUtcQ6fZordaVZUX63XJ4zTgs
 09lJBtvt/CY3UMePXSv/XkWvNktsYR093ad1JwS3l0K1kRUmWeoJdDO7VC7jxhQJkvNx
 5GUliLAIJud1cnYDMDCfeIiCk550Pt577n6CwZMtZM4T+DFly+9cBC8WlJoVpyrQUKGs
 n5cg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7b2dxirpixiJad29NQJbPwl29UVaHJ+MaNaC8Wwcm"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:b001:72d0:7d2b:70c4:d703:bb47]
 by smtp.strato.de (RZmta 44.9 AUTH) with ESMTPSA id t0203dv11GscVPa
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Fri, 1 Feb 2019 17:54:38 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <20190201080456.GA15456@lst.de>
Date: Fri, 1 Feb 2019 17:54:37 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de>
References: <4d8d4854-dac9-a78e-77e5-0455e8ca56c4@xenosoft.de>
 <1dec2fbe-f654-dac7-392a-93a5d20e3602@xenosoft.de>
 <20190128070422.GA2772@lst.de> <20190128162256.GA11737@lst.de>
 <D64B1ED5-46F9-43CF-9B21-FABB2807289B@xenosoft.de>
 <6f2d6bc9-696b-2cb1-8a4e-df3da2bd6c0a@xenosoft.de>
 <20190129161411.GA14022@lst.de> <20190129163415.GA14529@lst.de>
 <F4AB3D9A-97EC-45D7-9061-A750D0934C3C@xenosoft.de>
 <96762cd2-65fc-bce5-8c5b-c03bc3baf0a1@xenosoft.de>
 <20190201080456.GA15456@lst.de>
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

I will try it at the weekend.

Thanks,
Christian

Sent from my iPhone

> On 1. Feb 2019, at 09:04, Christoph Hellwig <hch@lst.de> wrote:
>=20
>> On Thu, Jan 31, 2019 at 01:48:26PM +0100, Christian Zigotzky wrote:
>> Hi Christoph,
>>=20
>> I compiled kernels for the X5000 and X1000 from your branch 'powerpc-dma.=
6'=20
>> today.
>>=20
>> Gitweb:=20
>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-d=
ma.6
>>=20
>> git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a
>>=20
>> The X1000 and X5000 boot but unfortunately the P.A. Semi Ethernet doesn't=
=20
>> work.
>=20
> Oh.  Can you try with just the next one and then two patches applied
> over the working setup?  That is first:
>=20
> http://git.infradead.org/users/hch/misc.git/commitdiff/b50f42f0fe12965ead3=
95c76bcb6a14f00cdf65b
>=20
> then also with:
>=20
> http://git.infradead.org/users/hch/misc.git/commitdiff/21fe52470a483afbb17=
26741118abef8602dde4d
