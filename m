Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776B2C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 12:48:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296D0213F2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 12:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296D0213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PV8w4G24zDqQY
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 23:48:48 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PV5Q3b2YzDqMq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 23:45:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44PV5P4fv9z9sPJ;
 Wed, 20 Mar 2019 23:45:45 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: Shift overflow warnings in arch/powerpc/boot/addnote.c on 32-bit
 builds
In-Reply-To: <c6ba8992-a3f3-2c99-6d6d-7ee9d41a22c5@ilande.co.uk>
References: <c6ba8992-a3f3-2c99-6d6d-7ee9d41a22c5@ilande.co.uk>
Date: Wed, 20 Mar 2019 23:45:44 +1100
Message-ID: <874l7xzpc7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: paulus@samba.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> Hi all,
>
> Whilst building the latest git master on my G4 I noticed the following sh=
ift overflow
> warnings in the build log for arch/powerpc/boot/addnote.c:
>
>
> arch/powerpc/boot/addnote.c: In function =E2=80=98main=E2=80=99:
> arch/powerpc/boot/addnote.c:75:47: warning: right shift count >=3D width =
of type
> [-Wshift-count-overflow]
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                                                ^~
> arch/powerpc/boot/addnote.c:72:39: note: in definition of macro =E2=80=98=
PUT_16BE=E2=80=99
>  #define PUT_16BE(off, v)(buf[off] =3D ((v) >> 8) & 0xff, \
>                                        ^
> arch/powerpc/boot/addnote.c:75:27: note: in expansion of macro =E2=80=98P=
UT_32BE=E2=80=99
>  #define PUT_64BE(off, v)((PUT_32BE((off), (v) >> 32L), \
>                            ^~~~~~~~
> arch/powerpc/boot/addnote.c:94:50: note: in expansion of macro =E2=80=98P=
UT_64BE=E2=80=99
>  #define PUT_64(off, v)  (e_data =3D=3D ELFDATA2MSB ? PUT_64BE(off, v) : \
>                                                   ^~~~~~~~
> arch/powerpc/boot/addnote.c:183:3: note: in expansion of macro =E2=80=98P=
UT_64=E2=80=99
>    PUT_64(ph + PH_OFFSET, ns);
>    ^~~~~~


I don't think there's any situation in which a 32-bit addnote will be
run against a 64-bit ELF is there?

So I don't think there's an actual bug, but it would be good if we could
make the warning go away.

cheers
