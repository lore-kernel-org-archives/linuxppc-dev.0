Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACFD606A32C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kuXqBQo9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVDml0wNDz2xQD;
	Thu, 19 Nov 2026 08:11:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795036295;
	cv=none; b=Dx2SXb7O+64D/T+V1ZP8Trih7P9hShT5e+0h/JFRjW7xQzqIxy748iW/x9gVY31u4APYsvw1VOMuXU5dDDzR5o5LaXYlhrZXNV7YiqB4AwA5ribxJ9DgBH7uDYlglYyJ2rmoxl2ImzBBnF2wXcL3anqtM2sWWvF73P+/J7eWzBNtwBwPcWa9dMFUouPxPZKz0dN5bQhE3HOJ5QfsgrEaHa0W+pfJK+jcBbp17LmIiUE3jpJ+cl/023bK3A1ntCvCAILGQ+yOEURzJO8iQ2QYephr85l3NPgc1iUR65tZ9zoaYuwT+Mybwffl522wGl7tBqgFXv8FWDz6MN+fKyix7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795036295; c=relaxed/relaxed;
	bh=fYW7C7ZSeq/hMphn21Jk8+ekBniTzrghgjy5BvzP2bc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=LUAsbNrYajNvBFmx8IO6Jkxjy36nBg8OTZ6NkJaM6PiaYF5sjO0D8RXT1Gth3CKJFjYs+6FvuZfh7SnNAFzQXU8O9rCA06Lp6G/9xLe2B+gKsAFqk5nKEwhqiodwgXuv8Qp2UmaTrk2Mjt0xlljlSfxKV0p0d8x3e1g36MTFzyB8+ekImYwCIzDsv5ixYslfrjMj1dbCXjMh7LPIzfoG9K82qhfWutGmliKWM4DzJvAEpZOQ61Q1xZvLSew9c+K72HF9QAWveYJi2sKn7h8lCW9qNFARPBv/w39fFHwsB3DLXo2QDdAJLmppAU5HNzUmrj4KAlldAs2k3+ORkjBjQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kuXqBQo9; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kuXqBQo9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVDmj5qKmz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 08:11:33 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2624E63DC5;
	Wed, 18 Nov 2026 21:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4625B1F000C4;
	Wed, 18 Nov 2026 21:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795036290;
	bh=fYW7C7ZSeq/hMphn21Jk8+ekBniTzrghgjy5BvzP2bc=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=kuXqBQo9E+h9GfS4TOHEmqgk/yUMmLyRthOV87kyoVvVOAzwMpnvqD7A1XkucwxwG
	 +Vl7bpZlxX0JE1vzCQVuNBvbZMaKuIBAvlXTPAUK/GTa7v0LsXaOQ5W64VpbC1VuJl
	 uqJ8OInlapAXmctcRxyW0008D6Xzwyp9lCFH5W/hdRpNqLETcSMRWepnBuLx7zwxxU
	 Sylw1ch5ITJRoQmWb3zw4zYMMrzwKyJn/UZhs2/85dIxkfhwlxjTdBpT9dCJJryN21
	 FmmGw4YgDxUh6xSvFjYiQgrHT7xeYbJw48awVnPj+qHidKGuRNABBugA/RDx9fw+YY
	 xy76njp+TsmiA==
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 22:11:20 +0100
Message-Id: <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Kees Cook"
 <kees@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>, "Nayna Jain"
 <nayna@linux.ibm.com>, "Srish Srinivasan" <ssrish@linux.ibm.com>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "Yoshinori Sato"
 <ysato@users.sourceforge.jp>, "Rich Felker" <dalias@libc.org>, "John Paul
 Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "Juergen Gross"
 <jgross@suse.com>, "Stefano Stabellini" <sstabellini@kernel.org>,
 "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nick Desaulniers" <ndesaulniers@google.com>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, "Zhongqiu Han"
 <zhongqiu.han@oss.qualcomm.com>, "Alexander Aring" <aahringo@redhat.com>,
 "Felix Kuehling" <felix.kuehling@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Zhihao Cheng" <chengzhihao1@huawei.com>,
 "Sumanth Korikkar" <sumanthk@linux.ibm.com>, "Bill Wendling"
 <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 <driver-core@lists.linux.dev>, <llvm@lists.linux.dev>,
 <linux-hardening@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-sh@vger.kernel.org>, <linux-s390@vger.kernel.org>,
 <gfs2@lists.linux.dev>, <xen-devel@lists.xenproject.org>,
 <linux-mtd@lists.infradead.org>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Ian Rogers" <irogers@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 9/9] kobject: Require explicit initialization of
 struct kobj_type::release
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-10-irogers@google.com>
In-Reply-To: <20261108223913.3624571-10-irogers@google.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun Nov 8, 2026 at 11:39 PM CET, Ian Rogers wrote:
>  static const struct kobj_type cpuregs_kobj_type =3D {
> +	/*
> +	 * Pre-existing: info->kobj is embedded in per-CPU cpu_data;
> +	 * cpuid_cpu_offline() only calls kobject_del().
> +	 */

All of these comments carry a =E2=80=9CPre-existing:=E2=80=9D prefix, but t=
hat doesn=E2=80=99t
distinguish cases with broken lifetime management from those where the stor=
age
remains valid despite the API misuse.

For example:

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_xcp.c
> index ab14079d1c42..0847134a1391 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -797,6 +797,11 @@ static const struct sysfs_ops xcp_cfg_res_sysfs_ops =
=3D {
>  };
> =20
>  static const struct kobj_type xcp_cfg_res_sysfs_ktype =3D {
> +	/*
> +	 * Pre-existing: xcp_res is embedded in struct amdgpu_xcp_cfg
> +	 * rather than freed individually by kobject_put().
> +	 */
> +	.release =3D NULL,

Being embedded in another structure doesn't explain what guarantees that th=
e
enclosing allocation outlives the kobject=E2=80=99s final cleanup.

Could you please drop the =E2=80=9CPre-existing:=E2=80=9D prefix and make t=
hat distinction
explicit? For broken cases, describe the lifetime problem and mark it as ne=
eding
a follow-up fix. For cases where the lifetime is safe, explain what guarant=
ees
that safety, while acknowledging that omitting release() still violates the
documented API contract.

Also, do you plan to follow up on those cases?

Thanks,
Danilo

