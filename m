Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D93EC433EF
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Oct 2021 06:11:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5632A60EFE
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Oct 2021 06:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5632A60EFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HRF7q4jbrz2ywj
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Oct 2021 17:11:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Q0RJ3AaL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=81.169.146.164;
 helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256
 header.s=strato-dkim-0002 header.b=Q0RJ3AaL; 
 dkim-atps=neutral
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [81.169.146.164])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HRF7305hqz2yYJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Oct 2021 17:11:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1633759847;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
 From:Subject:Sender;
 bh=JVWe11piAfJAdJymevoTxJyW/bmqebDGO4Tn3HRu4b4=;
 b=Q0RJ3AaLtlsUYxULnfHfBH9qDpEuvo7yTdNE0iYvtrjgog/pvh4+8+3tEqCOHBcBaa
 hESf15Um2Ws0E3aXKjhDvFaVu5v4k3VLf/njeI0Qhd9b1/HOlYoJ1s1mTwY3hkXG822A
 7hVFryIvLIAbrOvYRp0EK/HhQkm0xI3Zi/FOJ7JEKoymWd1WIDYMn0SfENkAeStOFMcI
 zPiwK8z2VMP3FUh5TX0BLeMcCC2Wle8dudSP7XJTD/AOw7YYzTFfO9jnpdeE4c2Gy1ww
 TL4FHG/tH7lcWdJKdruYBQ01xnUU3FGOqwhrCFsqElmZ1TXbMNM+fnjAtD7yRn3c33Lt
 NEgg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6Kxrf+5Dj7x4QgaM9fNtIXuaJFHrSAKNftmKoHNgA/QJNkOVJjQPPQ=="
X-RZG-CLASS-ID: mo00
Received: from smtpclient.apple by smtp.strato.de (RZmta 47.33.8 AUTH)
 with ESMTPSA id I00cdex996Ak4d2
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sat, 9 Oct 2021 08:10:46 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Mime-Version: 1.0 (1.0)
Subject: Re: Add Apple M1 support to PASemi i2c driver
Date: Sat, 9 Oct 2021 08:10:45 +0200
Message-Id: <F5C910BA-665C-4744-BAAE-9B3ED80974A0@xenosoft.de>
References: <CAOesGMgnx6P=J--bygw=vcL1b4mQbdACBX+Mwc7BtmEmMtP7KA@mail.gmail.com>
In-Reply-To: <CAOesGMgnx6P=J--bygw=vcL1b4mQbdACBX+Mwc7BtmEmMtP7KA@mail.gmail.com>
To: Olof Johansson <olof@lixom.net>
X-Mailer: iPhone Mail (19A348)
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
Cc: Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
 Darren Stevens <darren@stevens-zone.net>, Arnd Bergmann <arnd@arndb.de>,
 Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Wolfram Sang <wsa@kernel.org>, Paul Mackerras <paulus@samba.org>,
 linux-i2c@vger.kernel.org, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 mohamed.mediouni@caramail.com, Matthew Leaman <matthew@a-eon.biz>,
 Stan Skowronek <stan@corellium.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "R.T.Dickinson" <rtd@a-eon.com>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Olof,

Thank you for the hint.

I think I have found them.

Link: https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3D26610=
4

Mbox: https://patchwork.ozlabs.org/series/266104/mbox/

$ wget -O mbox https://patchwork.ozlabs.org/series/266104/mbox/
$ git am mbox

Thanks,
Christian

On 8. Oct 2021, at 22:47, Olof Johansson <olof@lixom.net> wrote:

=EF=BB=BFChristian,

Self-service available on lore:
https://lore.kernel.org/all/20211008163532.75569-1-sven@svenpeter.dev/

There are links on there to download a whole thread as an mbox if needed.


-Olof

On Fri, Oct 8, 2021 at 1:20 PM Christian Zigotzky
<chzigotzky@xenosoft.de> wrote:

Hi Michael,

Do you have a mbox link for the v2 changes?

I would like to test them on my AmigaOne X1000.

Thanks,
Christian

On 27. Sep 2021, at 09:58, Michael Ellerman <mpe@ellerman.id.au> wrote:

=EF=BB=BFChristian, the whole series is downloadable as a single mbox here:

https://patchwork.ozlabs.org/series/264134/mbox/

Save that to a file and apply with `git am`.

eg:

$ wget -O mbox https://patchwork.ozlabs.org/series/264134/mbox/
$ git am mbox

It applies cleanly on v5.15-rc3.

cheers=

