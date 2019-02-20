Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDF2C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 22:49:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EEED2075B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 22:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EEED2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aixah.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444Xpr2VzSzDqNT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 09:49:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=aixah.de
 (client-ip=2a01:488:42:1000:50ed:851d::; helo=wp260.webpack.hosteurope.de;
 envelope-from=aranea@aixah.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=aixah.de
X-Greylist: delayed 2057 seconds by postgrey-1.36 at bilbo;
 Thu, 21 Feb 2019 09:08:09 AEDT
Received: from wp260.webpack.hosteurope.de (wp260.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:851d::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444WvF5YvWzDqGl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 09:08:09 +1100 (AEDT)
Received: from p508bc6f1.dip0.t-ipconnect.de ([80.139.198.241]
 helo=vega.skynet.aixah.de); authenticated
 by wp260.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 id 1gwZUs-00017n-4c; Wed, 20 Feb 2019 22:33:42 +0100
Received: from vega.skynet.aixah.de (localhost [IPv6:::1])
 by vega.skynet.aixah.de (Postfix) with ESMTP id BA014260020
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 22:33:41 +0100 (CET)
Date: Wed, 20 Feb 2019 22:33:39 +0100
From: Luis Ressel <aranea@aixah.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: make modules_prepare doesn't build arch/powerpc/lib/crtsavres.o
Message-ID: <20190220223339.49b64f7c@vega.skynet.aixah.de>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/6KMX5OcZ60ChaOZJtixBd_/"; protocol="application/pgp-signature"
X-bounce-key: webpack.hosteurope.de;aranea@aixah.de;1550700489;51a82845;
X-HE-SMSGID: 1gwZUs-00017n-4c
X-Mailman-Approved-At: Thu, 21 Feb 2019 09:46:29 +1100
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/6KMX5OcZ60ChaOZJtixBd_/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello,

as documented in the top-level Makefile, "make modules_prepare" is
supposed to get a pristine kernel tree into a state that's suitable to
build out-of-tree modules. However, this is not the case for the
powerpc arch, since all modules are linked against
arch/powerpc/lib/crtsavres.o on ppc32 (and ppc64 if binutils is too
old).

A similar problem applies to "make clean" -- it is supposed to retain
all files which are neccessary for module building, but the global
"find . -name '*.o' -delete" it performs drops crtsavres.o.

--=20
Regards,
Luis Ressel

Please CC me when replying; I'm not subscribed to the kernel MLs.

--Sig_/6KMX5OcZ60ChaOZJtixBd_/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEbPzLt4vriSGj7oj2YKkwapaNrTgFAlxtx7MACgkQYKkwapaN
rTjRxA/7BgW1BqweXEc/1n/FykGAyrKw4hbJ4DCuUa7ZjFPpmS0KxmlDnhyGbtgv
rrRwOrefAuk7HsuiJ+YkU8AeCKI6a0UZmDxkytq9bdcxzpVFiBuF3pkMF2MnAere
vMJyjzMS7myp8VNKVDsdEeidCc4JrGZmP11nz8rH2w5ewSXjGrBQTqv7jW0LM5c5
nrybadR6FCjXJnUnzC39nz8xYFRhAWTuhhYyinQbudROJq2jHBJOI0QPAaCGsqOu
Kd/7RXDtc420lOx3JVKwoNdjODH7V/FHgM0sqYv+P74PUGDeSjortxjfjjUAT+3e
7BiyGKHdO89Z71G9w8dReFOSlObioDDqBspuQng42oYBJIbo07KQrXWIa3jf+Kk4
mlZ+wVe1v7zOHJMD5nmPHGHOQIvdi4ztryD+wU6Rqb7MlqcJIL4FFTWtqAHC3kMb
2N6mf22qKDmOUG5fNqF+qKZJAo6O6q69bVLirgxzJ+SdKXV1iDXqqoMKN5dapNJa
RN2SkaS5qyDDmJnQThOb/DM4bCEiJ0oD0RPx0RTJckozpDDG4Zmy22ZwdmcXJYhj
GhSv8b9HxIuxv8qPMVqnLdVE1ebVXdBxqSFcPrnMVX+ZQLfc6Q0bNHN5p+xdAhlh
v9KRNpZzsaXh77o7XYPxjAxQeRao3izCuxv8/HPYafUpV825w6I=
=mtPM
-----END PGP SIGNATURE-----

--Sig_/6KMX5OcZ60ChaOZJtixBd_/--
