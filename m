Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B1D606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 07:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=eCCCiGDt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTtSX6ph0z2y2B;
	Wed, 18 Nov 2026 18:26:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794986780;
	cv=none; b=MKrmWsCn8PswnDiZW22YHDnOg+/3s24nm/CK1iHtiGh3+OJg1hpxRLg84kmSGnyBfU+0pJUzgupC3sMwi8rD+NCf5z+NChiuQ8nlNJM56TMu2Nt113WteyObPgvl8doe4ZJsV4BqQ+6h/qihPvkcUdCZeZ6CSSZuTzpLvc2tVcdcyqEuPhkgfniS1wIGtVszuXTqSl+nvJI59hVArYBa2D1wlKY0F643k2+lrSZNj0jEje3iyu8qaR9r+rxEvrQyPRq3b+hcQlJ3nb7HzJbuQeULInOuB0BFZ+G7p+gESoyorw/PMREFYgw0bS4whwULWh/sts1o0J+aKuZL63XFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794986780; c=relaxed/relaxed;
	bh=BP5uJPFEij5TgQlQa0MnVpdjGYnsN3jkV0Ck605J8vA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lcbKteUA+82mXS6BuhckF47q47AYsW+wpd96wPKAYweQyi1tRGyT9gB4rQWqUnu0ZMb9tlod9ZXQpaMigFO+W5RFS2cQsei4DYSOTYqZDkFzxM9+N1R2ujWPy1s5Hb51Q/MweC36h6Tny1PhNZ8z3xnFBcRy0HzuUHLm9Zii7fr5NpcRyUjz615kg3es0TsYemGG4nl7wDBoII/DZuKUO+z1woYTfsG+rKdZKYS1fM4ZmY7uWBrbwPbu2APJuE2nQ1JJ3A/AnRNYPuv1/mPkPQ9w4ux6Jgi8gkgwfi+ZeZhilX6rGaJk7PyCCiektV1NwxeCED5/AawLazqhWdjAhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=eCCCiGDt; dkim-atps=neutral; spf=pass (client-ip=130.133.4.66; helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de; receiver=lists.ozlabs.org) smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=eCCCiGDt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zedat.fu-berlin.de (client-ip=130.133.4.66; helo=outpost1.zedat.fu-berlin.de; envelope-from=glaubitz@zedat.fu-berlin.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 357 seconds by postgrey-1.37 at boromir; Wed, 18 Nov 2026 18:26:17 AEDT
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTtST1GTyz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 18:26:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=BP5uJPFEij5TgQlQa0MnVpdjGYnsN3jkV0Ck605J8vA=; t=1794986777;
	x=1795591577; b=eCCCiGDtgVvGyB0K0IM+459ExlmIb5vecpWIcj6xrV4LUkm5+PyiDb/Iirlno
	dewEuTe0kbhjTSJaRCHMzSt9umFMLgoSLBaZAXD7ASM8sYplVIxe2zL92JaxsiySJTsfyjp3urSCd
	DYqJrpc/PRltPZGOITkyRFEFFAgL/JX9+bIJQBTzRMUzF1JKpGWJ52JFQZQ5KnWwoJjcFMh+7czQH
	2cPuKpC9SK3KIHyv1BGA2o2I6ieY+QPEeIaoQKAgmaCUEzZ03BpFUv8/ZX4AyscrD3v+3D+3hoLBp
	p1lM7BGnZMQWZu+ldltT6U15tt+DQwOvcJMwX4b8TPJxdIhK/g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xTZxc-00000000Itt-3izf; Wed, 18 Nov 2026 08:20:04 +0100
Received: from p57bd95b5.dip0.t-ipconnect.de ([87.189.149.181] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xTZxc-00000000GfQ-25vy; Wed, 18 Nov 2026 08:20:04 +0100
Message-ID: <88645597bb3aeae8d36a7b5c499a0a6d74b4acc4.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 3/9] sh: sq: Add missing kobject release callback to
 ktype_percpu_entry
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ian Rogers <irogers@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook
 <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman	
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
	 <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, Srish Srinivasan	
 <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, Yoshinori Sato	
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Juergen Gross	
 <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr
 Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers	 <ndesaulniers@google.com>, Viresh
 Kumar <viresh.kumar@linaro.org>, Zhongqiu Han	
 <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,  Zhihao Cheng <chengzhihao1@huawei.com>,
 Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling	
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, 	linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, 	linux-s390@vger.kernel.org,
 gfs2@lists.linux.dev, xen-devel@lists.xenproject.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 18 Nov 2026 08:20:02 +0100
In-Reply-To: <20261108223913.3624571-4-irogers@google.com>
References: <20261108223913.3624571-1-irogers@google.com>
	 <20261108223913.3624571-4-irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ian,

On Sun, 2026-11-08 at 14:39 -0800, Ian Rogers wrote:
> In sq_dev_add(), sq_kobject[cpu] is dynamically allocated with
> kzalloc_obj() and initialized with ktype_percpu_entry. When
> sq_dev_remove() calls kobject_put(kobj), the kobject is never freed
> because ktype_percpu_entry lacks a .release callback.
>=20
> Provide a sq_kobj_release() callback that calls kfree(kobj).
>=20
> Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  arch/sh/kernel/cpu/sh4/sq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
> index 908a8e09113b..f33864958487 100644
> --- a/arch/sh/kernel/cpu/sh4/sq.c
> +++ b/arch/sh/kernel/cpu/sh4/sq.c
> @@ -331,7 +331,13 @@ static const struct sysfs_ops sq_sysfs_ops =3D {
>  =09.store=09=3D sq_sysfs_store,
>  };
> =20
> +static void sq_kobj_release(struct kobject *kobj)
> +{
> +=09kfree(kobj);
> +}
> +
>  static struct kobj_type ktype_percpu_entry =3D {
> +=09.release=09=3D sq_kobj_release,
>  =09.sysfs_ops=09=3D &sq_sysfs_ops,
>  =09.default_groups=09=3D sq_sysfs_groups,
>  };

Looks good to me, thanks!

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

