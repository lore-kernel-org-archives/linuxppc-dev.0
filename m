Return-Path: <linuxppc-dev+bounces-17937-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED965FCA191
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2026 22:49:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVByb6b63z3c8W;
	Tue, 10 Mar 2026 09:49:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773093378;
	cv=none; b=niXmKhdz8RWbZNKZVL7zeUAUt3k64VfBlvgvu/6jn2KrNGVBF3GYsZ1MsYoNStJP0VGCnY0JWdiJD70CYtSsPV4J8sbW8FM67MxejrAJCZU0RFdKQdkbDT/UyUBw5F1WbaUQ1doV0LMgNhlt9SWb8P0kcfShWG2TdyxHzQBrBb7Y+/cVdQCJlxwVZJ+V0CQLl0+XCAr7XrMaJnHfoXcfGHGs5y8Eb24Zs7mENOooE8ec8yS6pHzreFuyAKYnDlb96iL2DIkPEG3GZScx27cBs7ZVTLqSnIwWHVXbOt3vuzT5tewbBaIrktGivzX37smE7Zo+pDvCYvvJ1eP4VY4qZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773093378; c=relaxed/relaxed;
	bh=pNMQxrTvWN57AG9Ak2GM8Z+gnkCL4ATfy4hgapY0eDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6qG9XMZRyBAA3ycCfTXPWVM+tXnMV/cuK2uKRSwRJwqli1Lodyih3CQjj21Q2G4aKeUJo6pFDEbAyYRvPFBT53tYNzHzVM0ofWFNlbyd3npfPOYxaiVl88CzTgFOP7aRtBqLBUObP+dkq2YDxQlYVTOrNgZJOzkiWoEorM79W9mQ8g+AI53ABWR6C2dZudLlgeXvI9Tewi7kTrnoCgedzajPxF86miPqwIwVIlg7+OBo50EC0vxWVDxGzq6qQ1QbOVVgSXnU07CffjwoZApAtHf7zI7cRpnohk1ASztZos9Lhr/LhhTIXrH8br61WPqUmJOPROj9M1+R08ndIvkaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; dkim=pass (2048-bit key; unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm3 header.b=ER0mN4Xi; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=hNj5e+g5; dkim-atps=neutral; spf=pass (client-ip=103.168.172.155; helo=fhigh-a4-smtp.messagingengine.com; envelope-from=alex@shazbot.org; receiver=lists.ozlabs.org) smtp.mailfrom=shazbot.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm3 header.b=ER0mN4Xi;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=hNj5e+g5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=shazbot.org (client-ip=103.168.172.155; helo=fhigh-a4-smtp.messagingengine.com; envelope-from=alex@shazbot.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 570 seconds by postgrey-1.37 at boromir; Tue, 10 Mar 2026 08:56:14 AEDT
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fV9nV5S7sz2xNg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 08:56:14 +1100 (AEDT)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3C5B614001B2;
	Mon,  9 Mar 2026 17:46:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 09 Mar 2026 17:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773092799;
	 x=1773179199; bh=pNMQxrTvWN57AG9Ak2GM8Z+gnkCL4ATfy4hgapY0eDQ=; b=
	ER0mN4Xieq0aEpyr2Y4T9JPq/qIzSDzZDIkU+GqMSDjgULXK3ZojVWaFNMn9dmOc
	Md7lKL96wp9Kg97nrLtmHsGi/KRHvH3/OjGufKJlyD6DdE00qVKKB9dpWr1VR6VT
	T1/WHskbJ9qrLttbzqdJeMLX5uuPcKVA70/2K24ZaUDbSumnapUUPTcaB5Mrdig8
	CsDYMouBWOad8x0jUp9MQzE66clVH2XaSgmqVv8RCOXQ+NqvByGaUc4zihslfyFv
	nhFTOFD2C6Veyhor4rJ2zErXcMHC3FmbyngAH2h9BrvnwEyOP3MguHDosWKXQaIx
	3Yq1UkuNNF+rlhBmWBUUBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773092799; x=
	1773179199; bh=pNMQxrTvWN57AG9Ak2GM8Z+gnkCL4ATfy4hgapY0eDQ=; b=h
	Nj5e+g5qC5e/J3L7YLCaO9TcsNLn1bi2aHDhDaPoZhCNJGZbP8gXZBlAhrCjTAg0
	o+KI9YsoJ25u8kBNfm2uLByS5WFqaOMZUhfUeGbTqNxsyZDSfQEuamqUV0QyuxBS
	dYlOAUsuQyWClnyKv4CgwPcZoKONMerSrxjISVXcUQ5qOcrGDLOwd+HID5F9MgEo
	+ZgNq/NZ19hU1ozRn9CUtyMGjBTBrXK/RoqvLI0eIkpwS+RpQJvMG5CjPK452ALl
	oZ58AXB6xf3poW4XTOTFlsmgo9znMz4B2TiXuE0j4EGyu8F9EJxnUxPbQsndak5t
	vBylqm2jnbGv8MV6OSx4A==
X-ME-Sender: <xms:vj-vaVrdRJpJGFxkQ8JrEYoQbTDle3FI-5BWPgerncvobysh9r5n0g>
    <xme:vj-vaToZ4Ymee86AW9uRr4rzKi3GsJXkJCn4d-vfT39vM7hgBLkRoXPlByeXFzQfv
    emHgWKtdDvOR9rC4hkgx-XKiJjdW9QmrbPNlEJByiOc_Ibehps7>
X-ME-Received: <xmr:vj-vaUYqvQEI-cyHyAiS8Qn4MOMtlq8oNGDo8g7xydIO6NGN7JAYnpKYpyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeetuefgleefhfdvueegffdtffevhfffgfffiedutdetgffhheejtdekfeek
    ieehgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrih
    htvghshhdrlhhishhtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugihpphgt
    qdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdprhgtphhtthhopehmrgguugihse
    hlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheptghhlhgvrhhohieskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpth
    htohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghr
    giesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghlvgigsehshhgriigsohhtrdhorh
    hg
X-ME-Proxy: <xmx:vj-vaR_EwZAnrT2pYrOehA4E935LJ47UYXG7Jat2rB_06a7GwOH3Ng>
    <xmx:vj-vaSkwZu6q2NK-gkaDkYoJypyKav0xrY4CW6KvvOgYLWMN9Ciy2Q>
    <xmx:vj-vaewMIFI-8DzcnX86t6Z0KZNTDE_6G464zTpp5jf5OQDrAHrBHQ>
    <xmx:vj-vaU64UdZ3Z9H6LG_PxcOjZb9fuSjrS1hq00T34k-9sMKHm2HFBQ>
    <xmx:vz-vaRadkRTVmYW3fguCihEDIZVohjG_73koUf7cPmbSiaz3zhUzy02e>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 17:46:38 -0400 (EDT)
Date: Mon, 9 Mar 2026 15:46:37 -0600
From: Alex Williamson <alex@shazbot.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Christophe Leroy <chleroy@kernel.org>,
 linux-mm@kvack.org, kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>,
 alex@shazbot.org
Subject: Re: [PATCH v2 1/2] drivers/vfio_pci_core: Change PXD_ORDER check
 from switch case to if/else block
Message-ID: <20260309154637.3abf76af@shazbot.org>
In-Reply-To: <b155e19993ee1f5584c72050192eb468b31c5029.1773058761.git.ritesh.list@gmail.com>
References: <b155e19993ee1f5584c72050192eb468b31c5029.1773058761.git.ritesh.list@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Subject prefix should be "vfio/pci:".

On Mon,  9 Mar 2026 18:08:37 +0530
"Ritesh Harjani (IBM)" <ritesh.list@gmail.com> wrote:

> Architectures like PowerPC uses runtime defined values for

s/uses/use/

> PMD_ORDER/PUD_ORDER. This is because it can use either RADIX or HASH MMU
> at runtime using kernel cmdline. So the pXd_index_size is not known at
> compile time. Without this fix, when we add huge pfn support on powerpc
> in the next patch, vfio_pci_core driver compilation can fail with the
> following errors.
>=20
>   CC [M]  drivers/vfio/vfio_main.o
>   CC [M]  drivers/vfio/group.o
>   CC [M]  drivers/vfio/container.o
>   CC [M]  drivers/vfio/virqfd.o
>   CC [M]  drivers/vfio/vfio_iommu_spapr_tce.o
>   CC [M]  drivers/vfio/pci/vfio_pci_core.o
>   CC [M]  drivers/vfio/pci/vfio_pci_intrs.o
>   CC [M]  drivers/vfio/pci/vfio_pci_rdwr.o
>   CC [M]  drivers/vfio/pci/vfio_pci_config.o
>   CC [M]  drivers/vfio/pci/vfio_pci.o
>   AR      kernel/built-in.a
> ../drivers/vfio/pci/vfio_pci_core.c: In function =E2=80=98vfio_pci_vmf_in=
sert_pfn=E2=80=99:
> ../drivers/vfio/pci/vfio_pci_core.c:1678:9: error: case label does not re=
duce to an integer constant
>  1678 |         case PMD_ORDER:
>       |         ^~~~
> ../drivers/vfio/pci/vfio_pci_core.c:1682:9: error: case label does not re=
duce to an integer constant
>  1682 |         case PUD_ORDER:
>       |         ^~~~
> make[6]: *** [../scripts/Makefile.build:289: drivers/vfio/pci/vfio_pci_co=
re.o] Error 1
> make[6]: *** Waiting for unfinished jobs....
> make[5]: *** [../scripts/Makefile.build:546: drivers/vfio/pci] Error 2
> make[5]: *** Waiting for unfinished jobs....
> make[4]: *** [../scripts/Makefile.build:546: drivers/vfio] Error 2
> make[3]: *** [../scripts/Makefile.build:546: drivers] Error 2
>=20
> Fixes: f9e54c3a2f5b7 ("vfio/pci: implement huge_fault support")
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
> v1 -> v2:
> 1. addressed review comments from Christophe [1]
> [1]: https://lore.kernel.org/linuxppc-dev/0b8fce7a61561640634317a5e287cdb=
4794715fd.1772170860.git.ritesh.list@gmail.com/
>=20
>  drivers/vfio/pci/vfio_pci_core.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index d43745fe4c84..0967307235b8 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1670,21 +1670,16 @@ vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pc=
i_core_device *vdev,
>  	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
>  		return VM_FAULT_SIGBUS;
>=20
> -	switch (order) {
> -	case 0:
> +	if (!order)
>  		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
> -#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
> -	case PMD_ORDER:
> +
> +	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_PFNMAP) && order =3D=3D PMD_ORD=
ER)
>  		return vmf_insert_pfn_pmd(vmf, pfn, false);
> -#endif
> -#ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
> -	case PUD_ORDER:
> +
> +	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PUD_PFNMAP) && order =3D=3D PUD_ORD=
ER)
>  		return vmf_insert_pfn_pud(vmf, pfn, false);
> -		break;
> -#endif
> -	default:
> -		return VM_FAULT_FALLBACK;
> -	}
> +
> +	return VM_FAULT_FALLBACK;
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_vmf_insert_pfn);

Otherwise LGTM.  This appears to be no change for current use cases, so
I assume this will go in through ppc trees.

Reviewed-by: Alex Williamson <alex@shazbot.org>

