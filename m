Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC5CC07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 15:07:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A69D208E7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 15:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="mfNVrsOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A69D208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BG635qdWzDsXG
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 02:07:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="mfNVrsOK";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::3; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="mfNVrsOK"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43BG300lGJzDsPk
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 02:04:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544195059;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=B89yBndVyqnBFRB3ChSJvKEiBIpiN0+3fBMJx4Olq5g=;
 b=mfNVrsOKcVlDc/1LzoYPsp5AUMUGCOSqUDVSn+ppA/+dYhFdq9jQLjpJbTOeqZyk8z
 sJjGwrBb1qv9EfaEeMAo5rly1QgyTlwJ9H3Cb6ex5o1sHGn+3K9b7RlvCbagEUnha/nJ
 sRM8fS7HhOw9a/iy2/mObCufuFcGatP/6WGVy+DoVED6NoLcdVIECCDeT1KvKBf3P3Hv
 ggCnoq6hY4qLtJbjyDaW64Mk+6kl1s4cSizIVDa/xcdDxpfpn+qW2o0w+tcjeiH2ENaw
 aBBI+vyVTRnNuu6y36iH0nRq2YdK0fZaRyatPED1xsJwTKqZuBPUYBDJZoNe3kZ7jSTH
 r0Xw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr44+gKiZpmhkMNrXaTDU="
X-RZG-CLASS-ID: mo00
Received: from [192.168.178.26] by smtp.strato.de (RZmta 44.6 DYNA|AUTH)
 with ESMTPSA id 404b20uB7F4HtiQ
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Fri, 7 Dec 2018 16:04:17 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 01/34] powerpc: use mm zones more sensibly
From: Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20181207140910.GA23609@lst.de>
Date: Fri, 7 Dec 2018 16:04:16 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <037E87F4-38C7-4E5F-A132-B7BB30E3D69D@xenosoft.de>
References: <20181114082314.8965-1-hch@lst.de>
 <20181114082314.8965-2-hch@lst.de> <20181206140948.GB29741@infradead.org>
 <87sgz9jzsl.fsf@concordia.ellerman.id.au> <20181207140910.GA23609@lst.de>
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
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

I will work at the weekend to figure out where the problematic commit is.

=E2=80=94 Christian

Sent from my iPhone

> On 7. Dec 2018, at 15:09, Christoph Hellwig <hch@lst.de> wrote:
>=20
>> On Fri, Dec 07, 2018 at 11:18:18PM +1100, Michael Ellerman wrote:
>> Christoph Hellwig <hch@infradead.org> writes:
>>=20
>>> Ben / Michael,
>>>=20
>>> can we get this one queued up for 4.21 to prepare for the DMA work later=

>>> on?
>>=20
>> I was hoping the PASEMI / NXP regressions could be solved before
>> merging.
>>=20
>> My p5020ds is booting fine with this series, so I'm not sure why it's
>> causing problems on Christian's machine.
>>=20
>> The last time I turned on my PASEMI board it tripped some breakers, so I
>> need to investigate that before I can help test that.
>>=20
>> I'll see how things look on Monday and either merge the commits you
>> identified or the whole series depending on if there's any more info
>> from Christian.
>=20
> Christian just confirmed everything up to at least
> "powerpc/dma: stop overriding dma_get_required_mask" works for his
> setups.
