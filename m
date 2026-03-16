Return-Path: <linuxppc-dev+bounces-18240-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F027BF506C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 12:47:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZFHb4Ls1z2xpn;
	Mon, 16 Mar 2026 23:47:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773665275;
	cv=none; b=ljQ/VRJ+hslyemer9v/7DDblOCA/IPX73AKNcWd2aIO9v3zhdIDyUcuFsHvC2UCWG+GgK87LqnyBaIsvwG3tvLxbaaipdga6oCoBY9TMvchUx230s9Tci48I8b16HkiQ5HxPtAwPMMwIRiw79PfgwDYsqDx/+WICBj3yvv8qSMuLMuv0PS+OmT/aUX70+g37FTTymFvH8HejoHUz6HIvM270uY0gkrGnspszbAiEwtbvzmV41mZm7dfc1Kn61WkJM/evQD7gX5RehPX2wxuPCJtRnYZA998+uZc4T7oPNndAdFcmHPAgZKcwEthb91JJ6S580wYn93U2DG9h0G8FUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773665275; c=relaxed/relaxed;
	bh=6ejYt5CXdn4QwItL4+2YTkxnhxpuLLBew7wWwP5rLLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMDiUbQYnVh7FVYlOYECzX5VG/PZGoh8NnHeMvgFNIXB7VyxGhi4L7jcU1K51/nrg5k/pWNa8jDQH7YfIpxiCBa6GOGxTahr49CVW3fu2VcAXAOTceaes1KnjehLseyGyqbz5AOWC9APzLKe2e4/WNKK71zQ76R05b+Npdue9IF7CtnvEB3GC4zatvITDGYulZYsYfLpY28efyW2pOsdhdCUEa7DC/3ORaRdQK8Iy/QmeNZFr3t4jJk4pGmRjgN7Y5fJIAkMzBWcwKhjLOoDTrxSHVAm6AH3uASn5tswtEke6uxRmYAgS8qJFall/2+6WGnoPsYsSR0YVbqio/H8zw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pKg+pW6o; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nsc@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pKg+pW6o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nsc@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZFHZ4LFqz2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 23:47:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5531141B0B;
	Mon, 16 Mar 2026 12:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A27C19421;
	Mon, 16 Mar 2026 12:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773665271;
	bh=6ejYt5CXdn4QwItL4+2YTkxnhxpuLLBew7wWwP5rLLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKg+pW6o7PPJy2g2+OfqVM8Y88Z5o4U5yImsjdq/WZ87bV24v8ZyBYZJRLv2YNhyO
	 paWIx11abE6L+k1bdyE3qmRJmWPeH+/EUV3g5x9CPUUUiQiZc+J3iHMUtijPYCDqZE
	 Dj5QzspSB45f6DJ8ONtzLXLSHOqB8KxDuGcJowExeyREBa3wW5WGXB0xE8JYG1glQQ
	 M94NDfJpoNJjiDx/9aNjbuNtEi+teqE9sCEVckUIG7y/QDELOtmjnkf4cLID7n76ti
	 IXfQtGBoenzB0LL6gvZNtAZsPIe415FMjpGooC1IcmYFu68gEfQ3RiTOs7+YN4LpTs
	 Ysic6bSQxA6pQ==
Date: Mon, 16 Mar 2026 13:39:47 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	broonie@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masahiro Yamada <masahiroy@kernel.org>, xur@google.com,
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [next-20260313] kernel =?utf-8?Q?build?=
 =?utf-8?Q?_fails_with_=E2=80=9Car=3A_unrecognized_option_'--thin'?=
 =?utf-8?B?4oCd?=
Message-ID: <abf6E7rFDdjNiKcT@levanger>
References: <476507c9-a371-4864-9e87-572c1ecae82d@linux.ibm.com>
 <de14e6d6-fad4-4e9a-8004-66a28db31faa@linux.ibm.com>
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
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p7c/EquZ8SSZofNx"
Content-Disposition: inline
In-Reply-To: <de14e6d6-fad4-4e9a-8004-66a28db31faa@linux.ibm.com>


--p7c/EquZ8SSZofNx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Venkat,

On Mon, Mar 16, 2026 at 03:18:50PM +0530, Venkat Rao Bagalkote wrote:
>=20
> On 16/03/26 11:41 am, Venkat Rao Bagalkote wrote:
> > Greetings!!
> >=20
> >=20
> > I am seeing a repeatable build failure in current mainline when
> > generating vmlinux.a.
> >=20
> > The build stops with an error from ar regarding the --thin option.
> >=20
> > This issue is seen on IBM Power11 System.
> >=20
> > Attached is the .config file.
> >=20
> > Also, I see couple of build warnings, before the build fails.
> > Note: These warnings and build failure are not see on 20260312 build.
> >=20
> >=20
> > Warnings:
> >=20
> > In file included from ./include/linux/seqlock.h:20,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ./in=
clude/linux/mmzone.h:17,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ./in=
clude/linux/gfp.h:7,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ./in=
clude/linux/umh.h:4,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ./in=
clude/linux/kmod.h:9,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ./in=
clude/linux/module.h:18,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from driv=
ers/char/nvram.c:34:
> > drivers/char/nvram.c:56:21: warning: =E2=80=98nvram_mutex=E2=80=99 defi=
ned but not used
> > [-Wunused-variable]
> > =C2=A0 =C2=A056 | static DEFINE_MUTEX(nvram_mutex);
> > =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~
> > ./include/linux/mutex.h:87:22: note: in definition of macro
> > =E2=80=98DEFINE_MUTEX=E2=80=99
> > =C2=A0 =C2=A087 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mutex mutexna=
me =3D __MUTEX_INITIALIZER(mutexname)
> >=20
> >=20
> > Below are the failure logs.
> >=20
> >=20
> > ar: unrecognized option '--thin'

Thanks a lot for your report!

We missed, that 'ar --thin' is available since binutils 2.38 (released
02/2022), but Documentation/process/changes.rst still lists binutils
0.30 as build dependency.

I removed the related patch set from kbuild-for-next; we'll discuss
further at https://lore.kernel.org/linux-kbuild/20251028182822.3210436-2-xu=
r@google.com

Kind regards,
Nicolas




> > Usage: ar [emulation options] [-]{dmpqrstx}[abcDfilMNoOPsSTuvV]
> > [--plugin <name>] [member-name] [count] archive-file file...
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0ar -M [<mri-script]
> > =C2=A0commands:
> > =C2=A0 d=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - delete file(s) from=
 the archive
> > =C2=A0 m[ab]=C2=A0 =C2=A0 =C2=A0 =C2=A0 - move file(s) in the archive
> > =C2=A0 p=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - print file(s) found=
 in the archive
> > =C2=A0 q[f]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- quick append file(s) to =
the archive
> > =C2=A0 r[ab][f][u]=C2=A0 - replace existing or insert new file(s) into =
the archive
> > =C2=A0 s=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - act as ranlib
> > =C2=A0 t[O][v]=C2=A0 =C2=A0 =C2=A0 - display contents of the archive
> > =C2=A0 x[o]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- extract file(s) from the=
 archive
> > =C2=A0command specific modifiers:
> > =C2=A0 [a]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - put file(s) after [membe=
r-name]
> > =C2=A0 [b]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - put file(s) before [memb=
er-name] (same as [i])
> > =C2=A0 [D]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - use zero for timestamps =
and uids/gids
> > =C2=A0 [U]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - use actual timestamps an=
d uids/gids (default)
> > =C2=A0 [N]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - use instance [count] of =
name
> > =C2=A0 [f]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - truncate inserted file n=
ames
> > =C2=A0 [P]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - use full path names when=
 matching
> > =C2=A0 [o]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - preserve original dates
> > =C2=A0 [O]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - display offsets of files=
 in the archive
> > =C2=A0 [u]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - only replace files that =
are newer than current archive
> > contents
> > =C2=A0generic modifiers:
> > =C2=A0 [c]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - do not warn if the libra=
ry had to be created
> > =C2=A0 [s]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - create an archive index =
(cf. ranlib)
> > =C2=A0 [S]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - do not build a symbol ta=
ble
> > =C2=A0 [T]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - make a thin archive
> > =C2=A0 [v]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - be verbose
> > =C2=A0 [V]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - display the version numb=
er
> > =C2=A0 @<file>=C2=A0 =C2=A0 =C2=A0 - read options from <file>
> > =C2=A0 --target=3DBFDNAME - specify the target object format as BFDNAME
> > =C2=A0 --output=3DDIRNAME - specify the output directory for extraction
> > operations
> > =C2=A0optional:
> > =C2=A0 --plugin <p> - load the specified plugin
> > =C2=A0emulation options:
> > =C2=A0 No emulation specific options
> > ar: supported targets: elf64-powerpcle elf64-powerpc elf32-powerpcle
> > elf32-powerpc aixcoff-rs6000 aixcoff64-rs6000 aix5coff64-rs6000
> > elf64-little elf64-big elf32-little elf32-big ppcboot elf32-spu
> > pe-x86-64 pei-x86-64 pe-bigobj-x86-64 elf64-x86-64 elf64-l1om elf64-k1om
> > pe-i386 pei-i386 elf32-i386 elf32-iamcu elf64-bpfle elf64-bpfbe srec
> > symbolsrec verilog tekhex binary ihex plugin
> > make[2]: *** [scripts/Makefile.vmlinux_a:22: built-in-fixup.a] Error 1
> > make[1]: *** [/root/linux-next/Makefile:1278: vmlinux_a] Error 2
> > make: *** [Makefile:248: __sub-make] Error 2
> >=20
> >=20
>=20
> Git bisect is pointing to below commit as first bad commit.
>=20
>=20
> 4519221849f26a3b0c0dc45b9914a0f9cdc00740 is the first bad commit
> commit 4519221849f26a3b0c0dc45b9914a0f9cdc00740 (HEAD)
> Author: Masahiro Yamada <masahiroy@kernel.org>
> Date:=C2=A0 =C2=A0Tue Oct 28 18:28:21 2025 +0000
>=20
> =C2=A0 =C2=A0 kbuild: move vmlinux.a build rule to scripts/Makefile.vmlin=
ux_a
>=20
> =C2=A0 =C2=A0 Move the build rule for vmlinux.a to a separate file in pre=
paration
> =C2=A0 =C2=A0 for supporting distributed builds with Clang ThinLTO.
>=20
> =C2=A0 =C2=A0 Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> =C2=A0 =C2=A0 Tested-by: Rong Xu <xur@google.com>
> =C2=A0 =C2=A0 Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> =C2=A0 =C2=A0 Tested-by: Nathan Chancellor <nathan@kernel.org>
> =C2=A0 =C2=A0 Link: https://patch.msgid.link/20251028182822.3210436-2-xur=
@google.com
> =C2=A0 =C2=A0 Signed-off-by: Nicolas Schier <nsc@kernel.org>
>=20
> =C2=A0Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 16 ++++++----------
> =C2=A0scripts/Makefile.vmlinux_a | 46
> ++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A02 files changed, 52 insertions(+), 10 deletions(-)
> =C2=A0create mode 100644 scripts/Makefile.vmlinux_a
>=20
>=20
> Git bisect log:
>=20
> git bisect log
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [b84a0ebe421ca56995ff78b66307667b62b3a900] Add linux-next specific
> files for 20260313
> git bisect bad b84a0ebe421ca56995ff78b66307667b62b3a900
> # status: waiting for good commit(s), bad commit known
> # good: [1f318b96cc84d7c2ab792fcc0bfd42a7ca890681] Linux 7.0-rc3
> git bisect good 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
> # bad: [ddc6cc7f66af99528c8a827d4ba835fb650b6446] Merge branch 'main' of
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> git bisect bad ddc6cc7f66af99528c8a827d4ba835fb650b6446
> # bad: [06da2b04b5f2f11952969e813d8dd8f0c7617b79] Merge branch 'for-next'=
 of
> https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
> git bisect bad 06da2b04b5f2f11952969e813d8dd8f0c7617b79
> # good: [85689b69dad24170252dc5be8238de2388e68871] Merge branch
> 'rust-analyzer-next' of https://github.com/Rust-for-Linux/linux.git
> git bisect good 85689b69dad24170252dc5be8238de2388e68871
> # bad: [5457bcbc73733c7268108a2acfc35c6505f3cbf3] Merge branch
> 'for-next/core' of
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
> git bisect bad 5457bcbc73733c7268108a2acfc35c6505f3cbf3
> # good: [5473c1ee6462a5d3543c2b4c7dc6f1aac71eb082] userfaultfd: introduce
> mfill_copy_folio_locked() helper
> git bisect good 5473c1ee6462a5d3543c2b4c7dc6f1aac71eb082
> # good: [d1b4433308592363d133a788f0443d5d63872bdd] CREDITS: simplify the
> end-of-file alphabetical order comment
> git bisect good d1b4433308592363d133a788f0443d5d63872bdd
> # good: [ff28b3bb65c3eafeece9334b908e62c492f341e5] mm/damon/core: allow
> quota goals set zero effective size quota
> git bisect good ff28b3bb65c3eafeece9334b908e62c492f341e5
> # bad: [4f6ad15007039f296611ee76dad9f6ed071e63fb] Merge branch
> 'kbuild-for-next' of
> https://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git
> git bisect bad 4f6ad15007039f296611ee76dad9f6ed071e63fb
> # good: [07bc816c63b94e83dbe311d84b0278e54f6b83db] Merge branch
> 'mm-unstable' of https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect good 07bc816c63b94e83dbe311d84b0278e54f6b83db
> # good: [aad94ba683adc6ff7ff4e29ae48184b42782dd97] kbuild: uapi: provide
> stub includes for some libc headers
> git bisect good aad94ba683adc6ff7ff4e29ae48184b42782dd97
> # good: [0d3fccf68d9873a3c824fb70be0dbb2c4642aa90] kbuild: Use
> '-fms-anonymous-structs' if it is available
> git bisect good 0d3fccf68d9873a3c824fb70be0dbb2c4642aa90
> # bad: [8e786d89efce381609bd7fb9e8d6c52429e8b753] kbuild: distributed bui=
ld
> support for Clang ThinLTO
> git bisect bad 8e786d89efce381609bd7fb9e8d6c52429e8b753
> # bad: [4519221849f26a3b0c0dc45b9914a0f9cdc00740] kbuild: move vmlinux.a
> build rule to scripts/Makefile.vmlinux_a
> git bisect bad 4519221849f26a3b0c0dc45b9914a0f9cdc00740
> # first bad commit: [4519221849f26a3b0c0dc45b9914a0f9cdc00740] kbuild: mo=
ve
> vmlinux.a build rule to scripts/Makefile.vmlinux_a
>=20
>=20
> Regards,
>=20
> Venkat.
>=20
> >=20
> > If you happen to fix this issue, please add below tag.
> >=20
> >=20
> > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> >=20
> >=20
> > Regards,
> >=20
> > Venkat.

--=20
Nicolas

--p7c/EquZ8SSZofNx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmm3+hIACgkQB1IKcBYm
EmnBAQ/9G2QPGXBX5BOlLaikaNJtS2yhtIVd3mavHh1EDNrXkP8sUcipmvYhaDYc
B04N250gtvr4oo5XlmgpglrqBUOLn1ety4EKJD2llFrUCL4XXraSkgfmLw/Pjh75
paZIOEtkP6td8mN4IyVf2h4yknNNLNYcntLs1cdSEVGvXDRFgqBTDazKDCx4pSxf
wtYB75N2rE2lillzdCZmSpZHwEQ+CxucDzL2L+q2xYexRVzLn6lOkdDmxaNpYCHZ
4Id9j57C/LqKOkoV6hapICsh3timDRWYAbtHbWoocF8WxS9feQjhRNz+uxma5m3r
oh/h6cdBa7A4IuTj30fzgOryS/vzSt32wWBccHdOTkUjkhazbkPW6VqkevjQiOXk
TuS9cOwjWv9sT2cda6HfMgtQASUS1eomqMwWTZxUTJZ0G/euwqPLPf/ZWDiWK3ZG
5UJK1c2EQ7Rd6fPqd+hqKKULbrXmmMyji8Aeib7DlynXzhI/CwyaKnQ1egoJVr2P
yj0016AkhcL5Oqy3QiUiTRs9gBineWiJh4Cm40qojgYPMAGVqeEr9l8wTEIjF0yq
FdWn1dpTm4LC7aYRjqLnQeIxAbQnJfFNWPIK/92gp9lrEjFNbTB2sKAELtwPRtaK
bWqI3PcHNsIQfmEybwQFDo3s9dqpPcqZVxxewnb2sli/9VGX7LE=
=2Oow
-----END PGP SIGNATURE-----

--p7c/EquZ8SSZofNx--

