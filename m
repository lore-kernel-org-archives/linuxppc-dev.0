Return-Path: <SRS0=ljjX=WS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE5AC3A59D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Aug 2019 06:06:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF8B21848
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Aug 2019 06:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="L6ft1CCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF8B21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46DYvQ6XHNzDrHn
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Aug 2019 16:06:42 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46DYmB1ml2zDqQC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2019 16:00:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="L6ft1CCH"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46DYm94dvXz9s00;
 Thu, 22 Aug 2019 16:00:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1566453625;
 bh=VFotkBeoQnghfR8tH06nrgVXHITRs+NJzJpLHEvDidI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=L6ft1CCHZbEPcpYc1MaIaZGnmK/0OHRuaD3UwTqiYMsYPDtLykbR75qGc4Sefsbyp
 h1nnEl9JMD6P04QQDEV5gBUQxGQk4XAa95AFy/znQOzrYYkTEdwR2qhOWQlDoTAgVj
 l7DN1dJ8TQ3lwIaHQnngGcXtL7oRvw15Mhvn98g0tokHJsHv9oMx4x4xofVK4PGgOB
 igGL+u4rxmZ4au+mF+pt7kJty3l7CPW3tm1sTTBeOtF6iqQM/HlsGorhbH80IRypnU
 +0ePvYjC63h8GXt26rf3ZBmh47wPwBSLpZ0VB7wfeGH0OQP4MGROrtT3EeQXsXmBi0
 RTSPxnpfn+qcQ==
Date: Thu, 22 Aug 2019 16:00:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Subject: Re: [linux-next][PPC][bisected c7d8b7][gcc 6.4.1] build error at
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:1471
Message-ID: <20190822155953.79f01e54@canb.auug.org.au>
In-Reply-To: <1566452811.526.7.camel@abdul.in.ibm.com>
References: <1566452811.526.7.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XrmJ+4XahkVTA+0CD=Bp1ls";
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
Cc: rcampbell@nvidia.com, jgg@mellanox.com,
 linux-next <linux-next@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/XrmJ+4XahkVTA+0CD=Bp1ls
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Abdul,

On Thu, 22 Aug 2019 11:16:51 +0530 Abdul Haleem <abdhalee@linux.vnet.ibm.co=
m> wrote:
>
> Today's linux-next kernel 5.3.0-rc5-next-20190820 failed to build on my
> powerpc machine
>=20
> Build errors:
> drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c: In function amdgpu_exit:
> drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:1471:2: error: implicit
> declaration of function mmu_notifier_synchronize
> [-Werror=3Dimplicit-function-declaration]
>   mmu_notifier_synchronize();
>   ^~~~~~~~~~~~~~~~~~~~~~~~=20
> cc1: some warnings being treated as errors
> make[4]: *** [drivers/gpu/drm/amd/amdgpu/amdgpu_drv.o] Error 1
> make[3]: *** [drivers/gpu/drm/amd/amdgpu] Error 2
>=20
> It was introduced with commit c7d8b7 (hmm: use mmu_notifier_get/put for
> 'struct hmm')

This should have been fixed in next-20190821.

--=20
Cheers,
Stephen Rothwell

--Sig_/XrmJ+4XahkVTA+0CD=Bp1ls
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1eL3kACgkQAVBC80lX
0GzB2gf+KEISnntYC1xlRdG6xsqu3zj1kkSNXSw5wvXZfw5GsjNgADkRGD9WO4rw
6QBAuxPbdgnp0EtpspqQ8ZFhPfT41MH/NBKRYFTzDs4r6BilnWVUfa6sLK4RA1u/
RkKoy14dluF2c5QE5bqrUTeHPl9CtAELyD1n82c8gX9sCsLqQbEcc+hFJG+V5FPa
0ceqZhcvCOxtSFMDzZsAbLzZFx+7EYaZRoXrmwtv/ufucmuYxOS/BPRakw1EuFY2
4Pkz1bKht8aaFPkl6G8PMV2NT8L1Q9WVuf6xUrB5pZ7XNMVXKqDj/gBFp/QMGPvj
4ZXWp5MjokdY4SV5OxLliFeBsVOv0g==
=lUpR
-----END PGP SIGNATURE-----

--Sig_/XrmJ+4XahkVTA+0CD=Bp1ls--
