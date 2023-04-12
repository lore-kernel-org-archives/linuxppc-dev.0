Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A02C76196
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Apr 2023 01:23:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Px4hx25xHz3cS4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Apr 2023 11:23:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.a=rsa-sha256 header.s=201702 header.b=EJ6xW+Vi;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Px4gx0gjKz3bg1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2023 11:22:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.a=rsa-sha256 header.s=201702 header.b=EJ6xW+Vi;
	dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Px4gs0Th5z4x84;
	Wed, 12 Apr 2023 11:22:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1681262538;
	bh=XhOrU+QFWcb+CVANp9ratxZSEqdjnqay4In+Rbto5+I=;
	h=Date:From:To:Cc:Subject:From;
	b=EJ6xW+ViyMy/3l95STmnF2XsHDzfs6v3XJ65nsMjXlz2b+cIJ0WZxcbSBghzkNhIY
	 y4WQyMc5T2B014GaSVJuc+yOWKxcAx1WsGrScj/Y4rstQW8SEP+dZTdp65zBkFKCyu
	 koNlBmgtk15pUMQy0aU1+iLuOUA91mssXJgi1i5CxRqMftXOzDLd95DEsO5wdVNLjX
	 TXkbXLE/EH9nKNngCEXxTfTep1uSb7pXTpoFTkkY+BuqC8Iich5gJ8JWeJIlkbKIdG
	 neOj1Bxbs7IT9UnlAC0Pq+xa+lPPflSLbtzcZj7Bp9hZuf/iIkS5EeoQmrWfycJbit
	 Nm/prWt0Jrjqg==
Date: Wed, 12 Apr 2023 11:22:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: linux-next: manual merge of the drm tree with the powerpc tree
Message-ID: <20230412112213.59365041@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/60om+LnrpZ0CbC8sc7Il/5w";
 protocol="application/pgp-signature"; micalg=pgp-sha256
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/60om+LnrpZ0CbC8sc7Il/5w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/display/Kconfig

between commit:

  78f0929884d4 ("powerpc/64: Always build with 128-bit long double")

from the powerpc tree and commit:

  4652ae7a51b7 ("drm/amd/display: Rename DCN config to FP")

from the drm tree.

I fixed it up (I used the powerpc version - with "(PPC64 && ALTIVEC)")
and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be
mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/60om+LnrpZ0CbC8sc7Il/5w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ2B8YACgkQAVBC80lX
0GxzBAf+Lg//lxSU8q+Rc5ntDb5otOp2iFJrWaVe1Q233Y12PERCK4EyuK18LIr4
x1W0O/2YNMfLrOw8ptMSYsSLQIm7Z1NbpotR3w/0mNaR2utwEbKYf4N/sd8R2p1u
mkCAX1apB7e/P54o6fOq12/dj4cEFdnnR83OlULTGEp/JyRyKm2W3sHzrf8Mp1aF
t1BIS7cwYu970Tz+W0U3cVEljay9mdscGOYBdiw3L9+s9D2AWv+ocOboj/7aDZtK
goNTeHu8/h+CQCFc/ulDaBdWk52b/uy+kbSKDNy1rulbNNs7jA+3PxNs/+dOIwsA
qPBJveVZlPWhkQ66ZdZZ9/5LoBr3TQ==
=MaU1
-----END PGP SIGNATURE-----

--Sig_/60om+LnrpZ0CbC8sc7Il/5w--
