Return-Path: <SRS0=oxDq=34=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22C2C35250
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Feb 2020 07:01:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B77E21775
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Feb 2020 07:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="CpY/kUrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B77E21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48F34G48bszDqjG
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Feb 2020 18:01:34 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48F3251Gz9zDqfC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Feb 2020 17:59:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256
 header.s=strato-dkim-0002 header.b=CpY/kUrA; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 48F3224SvPz8sx5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Feb 2020 17:59:38 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 48F3223yStz9sRX; Sat,  8 Feb 2020 17:59:38 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mo6-p01-ob.smtp.rzone.de (client-ip=2a01:238:20a:202:5301::10;
 helo=mo6-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256
 header.s=strato-dkim-0002 header.b=CpY/kUrA; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 48F31y4JJzz9sP7
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Feb 2020 17:59:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1581145159;
 s=strato-dkim-0002; d=xenosoft.de;
 h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=v1czFyXK2g0A10HYibevY4qX9AIYXqXeki2CibbFqRE=;
 b=CpY/kUrAL/gYG1NiXPwa/zLwy3A/6sDY4zdLHA9CAWUrazZLhqeppbLyXQwYL2vGa9
 mT9zrZOCqeDLxqBbygL+FTaG0iw16aUcRTjeOcO86HMOUHHAOUnRid2hfhMr5r+oQeUX
 TwlbfL4onz5hyF4VqsPdEWafvpMtoLhNnYl5+MI42PkjSBpxle9tdVrosFS7FAuNWzZL
 AMgSduwxSoTv0SjUTh69uVsoM8ufrJx1CLQqjXe/gbDa37LAqmZxA5MFddx29Bc6J1ti
 20GTqgZKd9t4CIf6FyIqwOLL06wo8SnCWTz4ygw2BqHVHqywy0NWiwwp4yOph395asQv
 J4+A==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6Kxrf+5Dj7x4QgaM9fNtIXuaJFHtH13fftKpBh9vXvxFA66d+3MU"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:b49c:9840:730:839a]
 by smtp.strato.de (RZmta 46.1.12 AUTH)
 with ESMTPSA id 40bcf3w186xIhA7
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sat, 8 Feb 2020 07:59:18 +0100 (CET)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Mime-Version: 1.0 (1.0)
Subject: Re: Latest Git kernel: avahi-daemon[2410]: ioctl(): Inappropriate
 ioctl for device
Date: Sat, 8 Feb 2020 07:59:17 +0100
Message-Id: <834D35CA-F0D5-43EC-97B2-2E97B4DA7703@xenosoft.de>
References: <CAK8P3a39L5i4aEbKe9CiW6unbioL=T8GqXC007mXxUu+_j84FA@mail.gmail.com>
In-Reply-To: <CAK8P3a39L5i4aEbKe9CiW6unbioL=T8GqXC007mXxUu+_j84FA@mail.gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
X-Mailer: iPhone Mail (17B111)
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
Cc: DTML <devicetree@vger.kernel.org>, Darren Stevens <darren@stevens-zone.net>,
 mad skateman <madskateman@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@ozlabs.org, "contact@a-eon.com" <contact@a-eon.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Christian Zigotzky <info@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



> On 7. Feb 2020, at 18:08, Arnd Bergmann <arnd@arndb.de> wrote:
>=20
> =EF=BB=BFOn Fri, Feb 7, 2020 at 3:34 PM Christian Zigotzky
> <chzigotzky@xenosoft.de> wrote:
>>=20
>> Hello Arnd,
>>=20
>> We regularly compile and test Linux kernels every day during the merge
>> window. Since Thursday last week we have very high CPU usage because of
>> the avahi daemon on our desktop Linux systems (Ubuntu, Debian etc). The
>> avahi daemon produces a lot of the following log message. This generates
>> high CPU usage.
>>=20
>> Error message: avahi-daemon[2410]: ioctl(): Inappropriate ioctl for devic=
e
>>=20
>> strace /usr/sbin/avahi-daemon:
>>=20
>=20
> Thanks a lot for the detailed analysis, with this I immediately saw
> what went wrong in my
> original commit and I sent you a fix. Please test to ensure that this
> correctly addresses
> the problem.
>=20
>        Arnd

Hi Arnd,

Thanks a lot for your patch! I will test it as soon as possible.

Cheers,
Christian=
