Return-Path: <SRS0=6Lu7=PL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11550C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 19:28:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73645217F5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 19:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="J8VHOaO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73645217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Vycq2490zDqMM
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 06:28:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::2; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="J8VHOaO9"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Vyb43lSbzDqHR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 06:26:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1546543593;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=pBQ+DDG+R8lz5PVBZOtvAtHEXP7LzY+0QhXhuCmy5sI=;
 b=J8VHOaO9VBsY/2hRvQ3E+XGY5kgw8gvXM3mqDuhqFpWpqI6Jx9sA1l+Af89Z5ACRQ9
 gPJ0SPSS/zXVaTL8TJaIij63x8100EXgyUwEVP1Wm2W8B8/M+ons0rHLdP3amH5OesPc
 uK1Pvj1zQ6fy9M7KS8PNSOlUeDalxIemc+MbzptYOQyPi3e0g6EfwiIa0H2emKzStQMe
 W6FOE6zAGQt2U4xFdj83N/bT1ebBU71rSMOBsuK9w2dlC9O+TdQ9fbfFBezJwKNNYSuO
 e1aj7WOQa64a2iJFDXw0i40Whr8lUSU71PC8j8ad8iJKmiK4wdP3ys9HCUzl3CxDJqZ3
 XfOQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7R7NWcgjrpgx3EJD7auEH2ABQccQesTkMWARnsp4/2a"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a01:598:80a5:5375:1417:f8b6:a542:2ccf]
 by smtp.strato.de (RZmta 44.9 AUTH) with ESMTPSA id u0679fv03JQGQ7n
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Thu, 3 Jan 2019 20:26:16 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20190103073622.GA24323@lst.de>
Date: Thu, 3 Jan 2019 20:26:15 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
References: <2242B4B2-6311-492E-BFF9-6740E36EC6D4@xenosoft.de>
 <84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de>
 <20181213091021.GA2106@lst.de>
 <835bd119-081e-a5ea-1899-189d439c83d6@xenosoft.de>
 <76bc684a-b4d2-1d26-f18d-f5c9ba65978c@xenosoft.de>
 <20181213112511.GA4574@lst.de>
 <e109de27-f4af-147d-dc0e-067c8bafb29b@xenosoft.de>
 <ad5a5a8a-d232-d523-a6f7-e9377fc3857b@xenosoft.de>
 <e60d6ca3-860c-f01d-8860-c5e022ec7179@xenosoft.de>
 <008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de>
 <20190103073622.GA24323@lst.de>
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

Happy new year for you too. Unfortunately we have some problems with the lat=
est DRM patches. They modified a lot and some graphics cards don=E2=80=99t w=
ork anymore. During the holidays we tried to figure out where the problems a=
re but without any success.

I will try to test your patches next week.

Cheers,
Christian

Sent from my iPhone

> On 3. Jan 2019, at 08:36, Christoph Hellwig <hch@lst.de> wrote:
>=20
> Hi Christian,
>=20
> happy new year and I hope you had a few restful deays off.
>=20
> I've pushed a new tree to:
>=20
>   git://git.infradead.org/users/hch/misc.git powerpc-dma.6
>=20
> Gitweb:
>=20
>   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-=
dma.6
>=20
> Which has been rebased to the latests Linus tree, which has a lot of
> changes, and has also changed the patch split a bit to aid bisection.
>=20
> I think=20
>=20
>   http://git.infradead.org/users/hch/misc.git/commitdiff/c446404b041130fbd=
9d1772d184f24715cf2362f
>=20
> might be a good commit to re-start testing, then bisecting up to the
> last commit using git bisect.
