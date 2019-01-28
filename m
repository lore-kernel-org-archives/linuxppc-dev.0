Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD3AC282CD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 17:51:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7741F2175B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 17:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="pdpi4/zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7741F2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pHHy2JWFzDqPG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 04:51:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::11; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="pdpi4/zp"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pFzV2SndzDqBb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 03:52:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1548694335;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=fYy8sGt7/wpwSK7F/RuYxrqnrtG/2ZYafyDDkfrrFIg=;
 b=pdpi4/zpcm4sKCgptKIWYTBPL8r9hZvvCYtkv0WeGahBff7HzuFBcd+b9Cu9JH3OVC
 lELcLq7Mva/siFQFAWXVa/hyq56K5TssecMyhbHRAA52ZTFhZZ0XLfTT4INJ1tWBZYeQ
 k92LSZhJg5zk7b+IxJO7St5rS2uWrTtJ2tsbCavcITDvdIgJFXtEHv3kgpNlMT2dO96/
 o5ElKnIfXXMUVf7eFs7nIHuQHrtZT6JlrATlOwyV3X36fucrI7AWB5Mn+gtHm+dC2UxO
 wgMWP6So0LGoPpE/j+R5o375rlRkwdKFwbXvX3FEG4nM7XsZrreL41f/GniSeHiimfP6
 cvfg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7NWd5jrozwSMRO89bpVdzWy5IAdgOVLzMC27Nvb91"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:8085:f5ea:1107:97ca:749d:8607]
 by smtp.strato.de (RZmta 44.9 AUTH) with ESMTPSA id t0203dv0SGq43xi
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Mon, 28 Jan 2019 17:52:04 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <20190128162256.GA11737@lst.de>
Date: Mon, 28 Jan 2019 17:52:03 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <D64B1ED5-46F9-43CF-9B21-FABB2807289B@xenosoft.de>
References: <e11e61b1-6468-122e-fc2b-3b3f857186bb@xenosoft.de>
 <f39d4fc6-7e4e-9132-c03f-59f1b52260e0@xenosoft.de>
 <b9e5e081-a3cc-2625-4e08-2d55c2ba224b@xenosoft.de>
 <20190119130222.GA24346@lst.de> <20190119140452.GA25198@lst.de>
 <bfe4adcc-01c1-7b46-f40a-8e020ff77f58@xenosoft.de>
 <8434e281-eb85-51d9-106f-f4faa559e89c@xenosoft.de>
 <4d8d4854-dac9-a78e-77e5-0455e8ca56c4@xenosoft.de>
 <1dec2fbe-f654-dac7-392a-93a5d20e3602@xenosoft.de>
 <20190128070422.GA2772@lst.de> <20190128162256.GA11737@lst.de>
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

Thanks a lot! I will test it tomorrow.

=E2=80=94 Christian

Sent from my iPhone

> On 28. Jan 2019, at 17:22, Christoph Hellwig <hch@lst.de> wrote:
>=20
>> On Mon, Jan 28, 2019 at 08:04:22AM +0100, Christoph Hellwig wrote:
>>> On Sun, Jan 27, 2019 at 02:13:09PM +0100, Christian Zigotzky wrote:
>>> Christoph,
>>>=20
>>> What shall I do next?
>>=20
>> I'll need to figure out what went wrong with the new zone selection
>> on powerpc and give you another branch to test.
>=20
> Can you try the new powerpc-dma.6-debug.2 branch:
>=20
>    git://git.infradead.org/users/hch/misc.git powerpc-dma.6-debug.2
>=20
> Gitweb:
>=20
>    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc=
-dma.6-debug.2

