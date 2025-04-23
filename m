Return-Path: <linuxppc-dev+bounces-7935-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364FAC369CB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Apr 2025 08:53:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZjCYn5q8Fz2ydt;
	Wed, 23 Apr 2025 18:53:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2404:9400:2221:ea00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745398397;
	cv=none; b=e3QtH7lLck1wJPVvow4ppO7IUqhjL6mjRyec/kw9y/0NSZdpxaBlz5zNjWlG+5r1xLMD1ma+DHk3QyZPEimFSuO63K3PpxV6ZQCVRbKa89icD9r5+0ZiBzPyqYMUVUiQnOPzoEZemz8iTkJP5XQIz4pUmo1L3YdQ9pgJkQwMRhVjQ6sZvbZe87jn2hjs1cZhU9cccbfYFBD8s6ekczSKO0rXA+jZid0dNwNiHTGyY+aQbTdlIK9cDpG8xZZnrgUwKKjK6ud0yjk6sF+Xw3SfOTBZZ9hy6FlPVmi/TdepC//YiH3gTWYAv5eeWnmUXzhvpaQRBtDNVQ6wwmZzgIeOng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745398397; c=relaxed/relaxed;
	bh=AONr5Laja4/bxGWO9p3sD5Nbjdmr1ly5yTSyfO28Ygg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfcNz1ru194N+VoLmoEz/y90cBeIe1e/30Yu/11hCZTwX46jwsBCFE10CSTi/84K3rXrGUz7zC7iPW9lyRBxVGz6LU/4FANkGziH6ZkxGcFOxpbkEq4rALu3AQtR7DSIw+UaRLNU/y7JQda27UOWP+SuaV58CEFkCA3brX72i4lnHFbVAAE9yhqzNEt6LzbK/gV18QH2ge3un5NLxHZeS24eHpU9Pxlt+XmeYqMV/SNAFDHs0PtFFhziNMc53VjzsEIXfDrKmA7uqG4NygJegLtcC0ZyVbsu8rnqL+EP3BNn7SFATBfE8dG95L3OADF3sJRbkEr0V27BJyb0jELQ6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; dkim=pass (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.a=rsa-sha256 header.s=202503 header.b=PlBtzy+n; dkim-atps=neutral; spf=pass (client-ip=2404:9400:2221:ea00::3; helo=mail.ozlabs.org; envelope-from=sfr@canb.auug.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.a=rsa-sha256 header.s=202503 header.b=PlBtzy+n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canb.auug.org.au (client-ip=2404:9400:2221:ea00::3; helo=mail.ozlabs.org; envelope-from=sfr@canb.auug.org.au; receiver=lists.ozlabs.org)
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZjCYn27DGz2xjP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2025 18:53:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1745398397;
	bh=AONr5Laja4/bxGWO9p3sD5Nbjdmr1ly5yTSyfO28Ygg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PlBtzy+n1I+F5On3axV2gomhE0qazvPB0vFMcUI6yTiZ4FStpmNSCCbp2TmSeEKdz
	 bJKbZ3eWW2YNn8ltq5q75nBpl0iBeHWQ1aMylFBpuQRj/gQRFnSXpjP/0H4gKLuuQa
	 spTA9RJZXUJ1/5rewqEilChXkRg76JuikdSus1cp2mmQnPdxqX0AxlLY430YgKMXe+
	 qdGuI4Cv2aZLBn9Wl0A3jPR4qdzPCbTwMI5BJPp1eSBWEZyCipsgPt54nepoWg1rQh
	 N7GK/QV1fVtpUpK+c3lPUq91+EIywzh/uP00cUmI5ZtEKPBvOSmtP4XYLW33QIuxlz
	 rvBsRuccQVaHA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZjCYl6Znnz4wbR;
	Wed, 23 Apr 2025 18:53:15 +1000 (AEST)
Date: Wed, 23 Apr 2025 18:53:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: mpe@ellerman.id.au, christophe.leroy@csgroup.eu, npiggin@gmail.com,
 naveen@kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/boot: Fix dash warning
Message-ID: <20250423185315.6732741f@canb.auug.org.au>
In-Reply-To: <20250423082154.30625-1-maddy@linux.ibm.com>
References: <20250423082154.30625-1-maddy@linux.ibm.com>
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
Content-Type: multipart/signed; boundary="Sig_/ZRZ9VoJmpND_sy0/N9neHDP";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ZRZ9VoJmpND_sy0/N9neHDP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Madhavan,

On Wed, 23 Apr 2025 13:51:54 +0530 Madhavan Srinivasan <maddy@linux.ibm.com=
> wrote:
>
> Commit b2accfe7ca5b '("powerpc/boot: Check for ld-option support")' suppr=
essed
> linker warnings, but the expressed used did not go well with POSIX shell =
(dash)
> resulting with this warning
>=20
> arch/powerpc/boot/wrapper: 237: [: 0: unexpected operator
> ld: warning: arch/powerpc/boot/zImage.epapr has a LOAD segment with RWX p=
ermissions
>=20
> Fix the check to handle the reported warning. Patch also fixes
> couple of shellcheck reported errors for the same line.
>=20
> In arch/powerpc/boot/wrapper line 237:
> if [ $(${CROSS}ld -v --no-warn-rwx-segments &>/dev/null; echo $?) -eq 0 ]=
; then
>      ^-- SC2046 (warning): Quote this to prevent word splitting.
>        ^------^ SC2086 (info): Double quote to prevent globbing and word =
splitting.
>                                             ^---------^ SC3020 (warning):=
 In POSIX sh, &> is undefined.
>=20
> Fixes: b2accfe7ca5b '("powerpc/boot: Check for ld-option support")'
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> ---
> Changelog v1:
> - modified the check to use the command exit
>   state instead explicit checking with exit code
>  =20
> Patch applies on top of powerpc/fixes
>=20
>  arch/powerpc/boot/wrapper | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index 267ca6d4d9b3..3d8dc822282a 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -234,7 +234,7 @@ fi
> =20
>  # suppress some warnings in recent ld versions
>  nowarn=3D"-z noexecstack"
> -if [ $(${CROSS}ld -v --no-warn-rwx-segments &>/dev/null; echo $?) -eq 0 =
]; then
> +if "${CROSS}ld" -v --no-warn-rwx-segments >/dev/null 2>&1; then
>  	nowarn=3D"$nowarn --no-warn-rwx-segments"
>  fi

Looks good to me.

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_/ZRZ9VoJmpND_sy0/N9neHDP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmgIqnsACgkQAVBC80lX
0GzqeggAnkS/r0Xh4OWUQWAayNgnwrapAqaT1CctZBQR6SQlTLTSN0lQDDR2k/08
EUiZF3JjmTKgSrFa48bm2cEgAWrjPF7hmkmjn7CUC6aCZtVnZIhz71VFLO7vfD7C
5eUpHf8nYMzS2QwhVOGyuPVuKM28uZFGZu/XbIX5f7g5bCC8/cx9+kE5Lw6zffZ0
tcKT8XWodbDRIcaBFPc36TPoeqh6b2eTRh8IKogJjeO6g8GGof7NjV9kY068UfNU
hSDjg6CPD+uAth/2CpuTXYwuC8VR6p4Sk69G7/aD/ZkLa9mMMehzb+A5RCyc8uwz
s70KFnkDD8Zk0dkWeHm6VBGP04yrGQ==
=NnXB
-----END PGP SIGNATURE-----

--Sig_/ZRZ9VoJmpND_sy0/N9neHDP--

