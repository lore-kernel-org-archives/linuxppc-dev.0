Return-Path: <linuxppc-dev+bounces-17714-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93EBEB7ED2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 11:10:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQqhp0jXdz30hq;
	Wed, 04 Mar 2026 22:10:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772622634;
	cv=none; b=OQNTi2rK4xmB5tkxijjZdQl8ISjoAUkZ7WDfRUD6IrgJVFbb9k4kg4cuhNlJXaEXGmVaf6B57Vk5L/IckrHM9MCuqBzZOY6h68qiUvAvfH+q7reVYedXDgKo+M2sEWEP7v9uDsSyXbIRtaMht2Ngv8s+LKvLsIXL+SN3QZbIkojxUnkOkrru37okEoZSOA8g3rmxfcc6T1DMxwMAsXKUGJd3qnzWLluuPNyIMXU0nznii8cii9b1dZVfYOu+5UmHPyg2/frqng4ZuVCScLzMWHqb0hR7X9A8cHqra5Plt/FjY3fIz3ONfs6bJlvjkBFiDhEFk5Ta7R1p7i35ggRQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772622634; c=relaxed/relaxed;
	bh=NqNfQqjBGfmbAJo/aZtHMPo7003kq0HNHUa3oLLM9rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkKyTVN8NZ4oAGUNwGzjsgvBto3WM0pi4Q4zf5X36paNJiDu3J/19SjIItfWec9rTga2tHwU7jCwsRp6oyS05C3LXXs5drWowLXyAMSY2OHs6Osu6KQ6Ap8QCly3GsH/rMH92+wNDm0iwZQ3N16RhDR3MEssv3v90MeiHX60R4GjfzRmi59U3cGsBwXCXBiQYJnctosHNx0gaBtZj6NYmNjVn6XEYjE8jO0cQdvBpQfYEYj310x/qkI620PQB9y/iExjrp6VWGIdYsLD2aSGuMv7FBL0lFcbNhFq6TMD2mZJW0n3/NyWQaUKrPowCDqvEkj1a5+iIj1Iwpzb790d/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KtxESzLT; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KtxESzLT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQqhn24Lfz2yY0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 22:10:33 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C485643B18;
	Wed,  4 Mar 2026 11:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64839C19423;
	Wed,  4 Mar 2026 11:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772622630;
	bh=NqNfQqjBGfmbAJo/aZtHMPo7003kq0HNHUa3oLLM9rE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KtxESzLTRevMkC0RMT3EArDVMk2FhTkCghz7l84S/Sl/uRFMKbvYjBO6WKTPLXZG2
	 hDd+jtXTkQDCPlsNqrRNNBIS69FSEG3kyCqhhWldcKaA7lgmXmclpmibkTkxFDGx05
	 L1mWc9QOtddQl0a6TEhhiss3l8edtqg3iz0dJiofY0wVH+4yeCbYY1MzoD2oPWrjdR
	 EnDw2NjEjLAGM8p4Zym2vHqMmJuBYJNQQtn7Ix1yH9YiSler1bu8kJQI/BP/hsAWKP
	 HCA4EbtIlLqW3pzKVaXGzu0CeEXA+pozdgRHL7CTE7jTeamnzsicmpnlaw5LC2gU+C
	 eQD2mqeeLI41g==
Date: Wed, 4 Mar 2026 11:10:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Anna Schumaker <anna@kernel.org>,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Aswin Karuvally <aswin@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>, Carlos Maiolino <cem@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chao Yu <chao@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ingo Molnar <mingo@redhat.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Jaroslav Kysela <perex@perex.cz>, Jens Axboe <axboe@kernel.dk>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Linus Walleij <linusw@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Namhyung Kim <namhyung@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <pjw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Simona Vetter <simona@ffwll.ch>, Takashi Iwai <tiwai@suse.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, Zheng Gu <cengku@gmail.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-block@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	dm-devel@lists.linux.dev, netdev@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
	v9fs@lists.linux.dev, virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 5/8] spi: use rest_of_page() macro where appropriate
Message-ID: <e731e101-bf06-44d7-ac91-0756c5b8bbc8@sirena.org.uk>
References: <20260304012717.201797-1-ynorov@nvidia.com>
 <20260304012717.201797-6-ynorov@nvidia.com>
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
	protocol="application/pgp-signature"; boundary="MuL6cN1k4g/DbVd2"
Content-Disposition: inline
In-Reply-To: <20260304012717.201797-6-ynorov@nvidia.com>
X-Cookie: Take it easy, we're in a hurry.


--MuL6cN1k4g/DbVd2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 08:27:13PM -0500, Yury Norov wrote:
> Switch SPI code to using the macro. No functional changes intended.
>=20

Acked-by: Mark Brown <broonie@kernel.org>

--MuL6cN1k4g/DbVd2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmoExQACgkQJNaLcl1U
h9CfwQf+I/XcN+BTYZLFcHPKTZ6Gt21+q3GLOzdkgChqzxOybf6b2qD+OHDN55Te
HvnosWIFzWzrD0ZP4eNe1TE0j1djIs+y2hdX6fElOOuJijsn21UWvVZXuuGdENdA
tPZDWrSzxJ8sU12FFYyBJDxsnWysekc1llPy00e37sfeetOZOLaYg/1jnttOl6oU
a3i0DGlMSVCN0pIYah+1R5Vbe35l4DlrcyOoswdwqqqEAzPLr0ysycWbbVmelm0M
U/y3gvpx6ZZBlMMio/3WWZfu3pM/Kwc8nzHkdzsstdqSIsRHEWru1MF5W4E+IcwO
Id51vK66wgwDVauWcfBpUUDez8/oEA==
=1DSJ
-----END PGP SIGNATURE-----

--MuL6cN1k4g/DbVd2--

