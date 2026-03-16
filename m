Return-Path: <linuxppc-dev+bounces-18270-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DC9F53D6D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 15:54:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZKQV5c0Cz2yZc;
	Tue, 17 Mar 2026 02:54:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773676450;
	cv=none; b=FhHopBI7ZP3CD5cUErTBv/h5PSTStdV7JXGZKzfrMk0WGDFWmGzeefIQLG3dL1Bl5Oc0DwG+xdZWoVgCNIVHs3B6VaLUesLpZ1Qe1jMkWL67XIiyqk30yGy7ItIPYPJZ0xhDe6zgwznL6Zt9h3iXeCDL1c/sg4RPY4gH9Y3GY9co0g0VrwUO4pFBFwq8C4e+AhEwQ0bRHUBPs7N1S1xWA+fQhc2e7ksXhugwrQA0w4sRu1nRO+LGG+dOzzo0pSkY26XD8wlP2j+4vdvpVfb9zb00JI44W+cR+LuIsaR4VLW/EQ/WQF1kIyUTgMEPz1NaNHf+Uioi7GJg+LvcX/ITOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773676450; c=relaxed/relaxed;
	bh=gajrVk7uoEU1On9WPcgzzDZTpCY5u+oDs710XScYodc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POJENy55G4KTOPkLZ5lllDiaMP9dOYb2iITrccADzAJu2Z6bkKJedbjb56NC2jO9RVhb+LpoG8a7xWeJ09tzsFeolqLlI21OYoUSB/VJDw79ZwDIyogoozaaxEzo2bVF6zgCkuRpX1CFCBzsdCAYk1K5jIDCyijW4BduMsvh3pkmJUrtcKBT2/swqcp4wpUFU0Fb8iehhNdJhMKrnGecp0zTZTEOirqiRebogpDSPCPk9qCCvlUB6yT0isLlOKBseryN/zxha+rYbw2aYVXGx2R4hstcXiuQMNYnweXvsrcsw7IOolPrAv1SZCOmmtiYwDBHgtJlHpnEjuIWcOkE6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=l62nS8bj; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=nsc@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=l62nS8bj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=nsc@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZKQT4mFtz2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 02:54:09 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1B43E6111B;
	Mon, 16 Mar 2026 15:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A820C19425;
	Mon, 16 Mar 2026 15:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773676445;
	bh=Fl4yHBIFk1UNeJbI0tTKMD0o4Xvj+34JP7razIWIE1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l62nS8bj40q2xeaX1bY/bjkAs1HEHzV1jmVJVz9jY2QpBatlBff1h2zgn1OoICy6g
	 MOyj7JGLTd1CeoKSQELtFrS9RUFs0yipLVoFXKa3r6xbeA4t0jr0Uk1jfCdish7/zz
	 7ZjPqQha29UXFay2YQoQNRasr/QqiC4etLkXdAwBZkFZYWFftXzPZpw9xSFij+Opsl
	 JWpKM3aW8Oq06rB5d5ozNKm++87NmR1KKqFoxn1+UrIcZ0hIYKqw/VQI6O/YV/4d0s
	 xJGnfRuhX6olhVIjn3TdYB1ljTAlHjo7jfyd4mf+Q2ILQuCEM0gzc8Sm+Jg58ra+wj
	 aCpVvgFw/xk1w==
Date: Mon, 16 Mar 2026 16:52:28 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Sathvika Vasireddy <sv@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, nathan@kernel.org,
	masahiroy@kernel.org, kees@kernel.org, naveen@kernel.org,
	jpoimboe@kernel.org, peterz@infradead.org, npiggin@gmail.com,
	maddy@linux.ibm.com, segher@kernel.crashing.org,
	christophe.leroy@csgroup.eu, mingo@kernel.org, mpe@ellerman.id.au
Subject: Re: [RFC PATCH v4 5/6] kbuild: Add objtool integration for PowerPC
 feature fixups
Message-ID: <abgnPNNygOs6EnQc@levanger>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	Sathvika Vasireddy <sv@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	nathan@kernel.org, masahiroy@kernel.org, kees@kernel.org,
	naveen@kernel.org, jpoimboe@kernel.org, peterz@infradead.org,
	npiggin@gmail.com, maddy@linux.ibm.com, segher@kernel.crashing.org,
	christophe.leroy@csgroup.eu, mingo@kernel.org, mpe@ellerman.id.au
References: <20260316062237.30948-1-sv@linux.ibm.com>
 <20260316062237.30948-6-sv@linux.ibm.com>
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
	protocol="application/pgp-signature"; boundary="XN8fyNDuwfLB4hL6"
Content-Disposition: inline
In-Reply-To: <20260316062237.30948-6-sv@linux.ibm.com>


--XN8fyNDuwfLB4hL6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 11:52:36AM +0530, Sathvika Vasireddy wrote:
> Add build system support for PowerPC feature fixup processing:
>=20
> - Add HAVE_OBJTOOL_FTR_FIXUP config option for architectures that support
>   build-time feature fixup processing
> - Integrate objtool feature fixup processing into vmlinux build
>=20
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
> ---
>  Makefile                 | 7 +++++++
>  scripts/Makefile.lib     | 4 ++--
>  scripts/Makefile.vmlinux | 3 ++-
>  3 files changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 83ed80595378..861f5bec655c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1467,6 +1467,13 @@ ifdef CONFIG_OBJTOOL
>  prepare: tools/objtool
>  endif
> =20
> +# CONFIG_OBJTOOL and CONFIG_HAVE_OBJTOOL_FTR_FIXUP are unrelated, separa=
te
> +# options. It was integrated in objtool in order to borrow the elf parse=
r,
> +# but this is different from how the other objtool commands are used.
> +ifdef CONFIG_HAVE_OBJTOOL_FTR_FIXUP
> +prepare: tools/objtool
> +endif
> +
>  ifdef CONFIG_BPF
>  ifdef CONFIG_DEBUG_INFO_BTF
>  prepare: tools/bpf/resolve_btfids
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index e429d68b8594..c9478c717574 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -179,10 +179,10 @@ cpp_flags      =3D -Wp,-MMD,$(depfile) $(NOSTDINC_F=
LAGS) $(LINUXINCLUDE)     \
> =20
>  ld_flags       =3D $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
> =20
> -ifdef CONFIG_OBJTOOL
> -
>  objtool :=3D $(objtree)/tools/objtool/objtool
> =20
> +ifdef CONFIG_OBJTOOL
> +
>  objtool-args-$(CONFIG_HAVE_JUMP_LABEL_HACK)		+=3D --hacks=3Djump_label
>  objtool-args-$(CONFIG_HAVE_NOINSTR_HACK)		+=3D --hacks=3Dnoinstr
>  objtool-args-$(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)	+=3D --hacks=3Dsky=
lake
> diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
> index fcae1e432d9a..a1bef0638ecb 100644
> --- a/scripts/Makefile.vmlinux
> +++ b/scripts/Makefile.vmlinux
> @@ -65,7 +65,8 @@ ARCH_POSTLINK :=3D $(wildcard $(srctree)/arch/$(SRCARCH=
)/Makefile.postlink)
>  # Final link of vmlinux with optional arch pass after final link
>  cmd_link_vmlinux =3D							\
>  	$< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)" "$@";	\
> -	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
> +	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true);	\
> +	$(if $(CONFIG_HAVE_OBJTOOL_FTR_FIXUP), $(objtool) --ftr-fixup --link $@=
, true)
> =20
>  targets +=3D vmlinux.unstripped .vmlinux.export.o
>  vmlinux.unstripped: scripts/link-vmlinux.sh vmlinux.o .vmlinux.export.o =
$(KBUILD_LDS) FORCE
> --=20
> 2.43.0
>=20

Acked-by: Nicolas Schier <nsc@kernel.org>  # kbuild

--XN8fyNDuwfLB4hL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmm4JzsACgkQB1IKcBYm
EmksSRAAxbcvBBJQN6MUo+acdze5tyvjE+Lwjg0qXNwJqlf341oGEXmIXFIdjdxL
G7iNJtPjYRSWI8RTnRqQuY2URyCr6X5MDMyIMOpPdqlcQ/ug7YeShTtVj/Rd4NY+
8FybJRTumZ1MYPoRgd45gNZcbsNJDg7vs9W6l5OAGaUkr+49S1f4luVI7q6R4CQI
kAPzyebw3LDhnliiNT45mnCHD3bCSg6p49YQ62DdVbSsGLJ6pdLWLOaybh+FPNyP
Xd+ymWx1JC61cJSPjp3gYEMeRbCsfXL6+A2ne3ZPiu8xT32kDu7ko2aSqlPNfLUW
1QtJN28ndG2C8VCgQpqktae2aKpi1ai1HOpDUy/kAvl2IdffCxRoiUHHTHGxlatZ
OAgQyfgYubnsvfQEUG7O8ewd+w8PIlE0155927+lUBXKpjX33wA0e9dTqFK70WAv
UXffgk+fSqd2iOushlZ4nrj6tUgapyjwrQTu2/m6lD/4+PMGyYi4M6aRuazaw8f/
5H4HkYut3RjALkZMgocsSCPofBR+joz3JkAKXcOeSltTrQUGM9FVMDnHe2PWMIXU
M4Es+mUg75uhPvBzQKgVLMXumOAqK/kclqMHIdfVXqMY/FJlkFElBQVbMhKS6BSQ
AbqfPfjhRkJYwBtcAwVg4HuGm4ctdBtDd2gpaklBFS0qrGZVjL0=
=rQsT
-----END PGP SIGNATURE-----

--XN8fyNDuwfLB4hL6--

