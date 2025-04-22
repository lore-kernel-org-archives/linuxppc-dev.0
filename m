Return-Path: <linuxppc-dev+bounces-7869-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54763C369AB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Apr 2025 01:47:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZhQ8w3jG6z2yqp;
	Tue, 22 Apr 2025 11:47:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2404:9400:2221:ea00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745286448;
	cv=none; b=YKEq20bWPRwj5rOvDsHnISETuvStjhpw+PVd6B35phwksQNEkuFSeECojqLxMJ1JsMidnL4Wjy3UorD1tHL+ZPspWUyIGrx8xqpC6A7LCgo1gt0Ab8W/zo+BUL4g7MtXDdb/oxHPF4aBvI9IzW+2b69YDTV2ArEzfgGpYDXCQUnTkeWUkuVRXIfP4H6dYOqrWTmnNm8bL6sFDU71oeXlug+zAhHfBbth0d4iQZ2c4C31IFmk/Hl4PmE+aHatE5pa32s6/Pkolj84D2XyoMvoz/O3tKvBhw8r4JJsPU4nu5g4OQClki3ZrVv1lJX6flcVIR0dYeNGvkiG4/zOy438Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745286448; c=relaxed/relaxed;
	bh=jdZT00tIy/ppY9OQh/U5pq3X+9Kj7GiUuE/NV6FD27M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HJxqVgMtVkII1r3sXM2xRWrhD3LpBsus6bzwRrEzv85sNtVWlYn3Pfo8786bRspeJV2gefaSugLhRKJpb/lQhvI90LrOlS9HKswg60rwvEgGDGGzGzhICPUvNOIWqhUcaDT/0JCQWPH7RmNxV7clrb4II025UMdsoLkZ93Z+/sy5NWROcmdzqaaeHUOHKVUQ8oTvrd/6NmuIQGd2vMbR82tG0PgwdpzINPyzxI7QgmSsLH2qwnQD0MkDSvuufia6cPimky+g7vAXIa3UtGKogr1dDNiPl3uyrjTBxRbdzR62qB8zUt8QiMCIK8SmXhC0NP43mk0/StDkq+m1JqUk9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; dkim=pass (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.a=rsa-sha256 header.s=202503 header.b=einY7QyZ; dkim-atps=neutral; spf=pass (client-ip=2404:9400:2221:ea00::3; helo=mail.ozlabs.org; envelope-from=sfr@canb.auug.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.a=rsa-sha256 header.s=202503 header.b=einY7QyZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canb.auug.org.au (client-ip=2404:9400:2221:ea00::3; helo=mail.ozlabs.org; envelope-from=sfr@canb.auug.org.au; receiver=lists.ozlabs.org)
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZhQ8t0t3Fz2yGZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2025 11:47:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1745286441;
	bh=jdZT00tIy/ppY9OQh/U5pq3X+9Kj7GiUuE/NV6FD27M=;
	h=Date:From:To:Cc:Subject:From;
	b=einY7QyZR7hxI/FQZB71dSW066HKMmcpPhCwOrhZZ8qg1Cx03OWI67wgA6rT8ey1V
	 4ZyGcq/yB+24KBUXRiVB12oVC+sA81y/KoPwsecueJ9Weum9uWAnGQbuKPcDebBLlV
	 IUIuXIZF0h6xqHvG6rJTmX3L+MK9vob85DaWdg3GQucZyUlwEnqEFJ766lNlTgj8g0
	 XiSk5Qo/PdAzBxbVy6JtW5vRFPImotutkvg4ZqxsHbeT5sw0QH9NVQdl/RddIvHR8o
	 DZ+Za6LL432tBTgl2zZpYovoOOscg7HXIGC+yf2AOeQNMIv1dcvAXXUdTENr0hE88C
	 DiKeY9VluhJeg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZhQ8n3Svqz4wcy;
	Tue, 22 Apr 2025 11:47:21 +1000 (AEST)
Date: Tue, 22 Apr 2025 11:47:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the powerpc-fixes tree
Message-ID: <20250422114720.480cea29@canb.auug.org.au>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eyciFYFZlkLIGhOs35UBWT7";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/eyciFYFZlkLIGhOs35UBWT7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the powerpc-fixes tree, today's linux-next build
(powerpc_ppc64_defconfig) produced these warnings:

arch/powerpc/boot/wrapper: 237: [: 0: unexpected operator
ld: warning: arch/powerpc/boot/zImage.epapr has a LOAD segment with RWX per=
missions
arch/powerpc/boot/wrapper: 237: [: 0: unexpected operator
ld: warning: arch/powerpc/boot/zImage.pseries has a LOAD segment with RWX p=
ermissions
arch/powerpc/boot/wrapper: 237: [: 0: unexpected operator
ld: warning: arch/powerpc/boot/zImage.pmac has a LOAD segment with RWX perm=
issions
arch/powerpc/boot/wrapper: 237: [: 0: unexpected operator
ld: warning: arch/powerpc/boot/dtbImage.ps3 has a LOAD segment with RWX per=
missions

Introduced by commit

  b2accfe7ca5b ("powerpc/boot: Check for ld-option support")

POSIX shell (in particular dash) does not recognise "&>" - you need to
use ">/dev/null 2>&1".  (My /bin/sh is /bin/dash)

--=20
Cheers,
Stephen Rothwell

--Sig_/eyciFYFZlkLIGhOs35UBWT7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmgG9SgACgkQAVBC80lX
0GxbsQf+JRz/1CUUMq9xsdpOy6RYo8y3F1OTh+LJ90eo9Wza0FEC+N4YXuf8b9xB
LzVIzz7zcjEK4Ca8x7npSY+7d6eeFdQK3uytDqxfQkClwc2/4rcGvZEqQRV2h6Ql
yEbctEcYDjfI2k758CGIPKE8u6FhNhP86iJlQME7eg8npPhrO5W0/zVFX4Ou/3gy
HwdEGy9DdoO/ebY08+aM/sEw3KKKuuuEgNreUNOA5/5HxLaLRKiqs9F9I6ojF1oX
nIaOVdXGe2aM7KPjYyVt5VyGfnpRDIJuJubaUfxycNGWnZKqEr9rMFq8inG6vvHY
zUyO/TF7f7ognDRVgxwtxB5MT4uiTw==
=qq3W
-----END PGP SIGNATURE-----

--Sig_/eyciFYFZlkLIGhOs35UBWT7--

