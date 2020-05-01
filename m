Return-Path: <SRS0=sn4m=6P=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47868C4724C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2020 05:38:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E142073E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2020 05:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="jV4U0eoi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E142073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49D1J16kzRzDrPx
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2020 15:38:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mo6-p02-ob.smtp.rzone.de (client-ip=2a01:238:20a:202:5302::12;
 helo=mo6-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256
 header.s=strato-dkim-0002 header.b=jV4U0eoi; 
 dkim-atps=neutral
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5302::12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49D1FX6mGTzDr8t
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2020 15:36:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1588311367;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=hJfQ2R9oyPXbRKp+zZNmmNIpIc89RJkcFkSmzvlkCgw=;
 b=jV4U0eoiCoC0VY1vLvmDpjatj00+GUmt/IXBCNsc1I1DdXT8rrWHxqfihujCxkeuul
 SlLiaByrfctD75EUWmY5Q87cbJnxSKLbLTIvTfxu1wuqZ16wX4h1A7YLzpo7N+QMXmFl
 hkIMzirul9pGJBtoV9lJ0sw81lD9xzwrqybFRVR0EHB2Ncgg5FFNGK0bC8Tq4ofzuuNx
 o/JqVEGtplFFgPB8IdrIIONe3nW5Iwzt2BBFiUAAYA/09LpD0EDyu0cKGXsydpt2qgJM
 x9xT+t5bzF8Pq+Kp+pvD/++TYrTWwxSXUmb+hO/SzzJJjb2zNFhEGMRIwfpKmhXOdO7f
 IT6g==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7b2dxi7ozwXQ+Xo6i0Yv8EnsEhh3gF2nHSBbUFCw1"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:b000:f529:7401:562d:9520:15ed]
 by smtp.strato.de (RZmta 46.6.2 AUTH) with ESMTPSA id I01247w415Zxi5E
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Fri, 1 May 2020 07:35:59 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Mime-Version: 1.0 (1.0)
Subject: Re: Don't initialise ports with no PHY
Date: Fri, 1 May 2020 07:35:58 +0200
Message-Id: <1963BFFC-34FD-4BDC-B277-838FB332D7BF@xenosoft.de>
References: <4f9f12e02c7.744a6d93@auth.smtp.1and1.co.uk>
In-Reply-To: <4f9f12e02c7.744a6d93@auth.smtp.1and1.co.uk>
To: Darren Stevens <darren@stevens-zone.net>
X-Mailer: iPhone Mail (17D50)
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
Cc: Andrew Lunn <andrew@lunn.ch>, linuxppc-dev@lists.ozlabs.org,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 netdev@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


> On 30. Apr 2020, at 23:36, Darren Stevens <darren@stevens-zone.net> wrote:=

>=20
> =EF=BB=BFHello Christian
>=20
>> On 29/04/2020, Christian Zigotzky wrote:
>>=20
>>=20
>>>> On 29. Apr 2020, at 17:22, Andrew Lunn <andrew@lunn.ch> wrote:
>>>=20
>>> ?On Wed, Apr 29, 2020 at 03:55:28PM +0200, Christian Zigotzky wrote:
>>>> Hi Andrew,
>>>>=20
>>>> You can find some dtb and source files in our kernel package.
>>>>=20
>>>> Download: http://www.xenosoft.de/linux-image-5.7-rc3-X1000_X5000.tar.gz=

>>>=20
>>> I have the tarball. Are we talking about
>>>=20
>>>=20
> linux-image-5.7-rc3-X1000_X5000/X5000_and_QEMU_e5500/dtbs/X5000_20/cyrus.e=
th.dtb
>>=20
>>> I don't see any status =3D "disabled"; in the blob. So i would expect
>>> the driver to probe.
>=20
> No, the vendor never added that to them.
>=20
>> Yes, that's correct but maybe Darren uses another dtb file.
>>=20
>> @Darren
>> Which dtb file do you use?
>=20
> My current one attached, including updated cyrus_p5020.dts & p5020si-pre.d=
tsi
> which I'm preparing patches for.
>=20
> Christian, build an unmodified kernel, select board level reset or power o=
ff,
> then both the GPIO drivers.
> Then under LED Support: GPIO connected LED's and triggers -> disk activity=

>=20
> I think you still have a 5020 don't you? I'll look at 5040 later (I'll nee=
d
> someone to test)
>=20
> Regards
> Darren
> <cyrus-dts.zip>

Darren

I use a 5040 currently.

Thanks
Christian


