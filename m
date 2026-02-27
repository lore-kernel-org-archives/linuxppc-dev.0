Return-Path: <linuxppc-dev+bounces-17333-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B116FD4601
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 06:42:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMdzS1bSkz2xLv;
	Fri, 27 Feb 2026 17:42:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772174532;
	cv=none; b=QhgQfiSPq6+F8VYEnBlddP5bqgUTRIjYVEixdlSMilHzacjLuh8gN2qx37sjxQjn/Af1XCMvj3+FC+dwfWfOz1TCcW8TK3lIj4BvZPbtL1fpb0zXLwiIEllYxmyAJoi55+cHTNQGpXQDBoBNaytIJCH8t2NZiGc4t7Y9X3Hd/V/c6uO5j52zrArKJiX27gBcXuD3PJtSX6hQi5z12GioYk8DLdK5k7ON+as0zGdkEvRBVZZGtkqxk+2tmQG0IDjbDZCoPqfpUqNK7tH9ARgSJ0sRbnM06Q7oTPNTFfNovHQ6X7QYEVIzAYku4nXJnhYPPD2SCbzEZZm+S+ZAHBvRZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772174532; c=relaxed/relaxed;
	bh=ZjRSfA1J0fa33N0Re9W0GNS4OAn0Juv79uWe2f7kUiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRjkicslDUM/52BgVWt5ACDSU1LTEJYLB8GNQ31DM/ZG81R0zb+wja8r19DcgrNMhqpRxbFKr/RwkliFqtRH8C4tbmOovpt3iC9S57yZiVHX6d5P560ztBBLNqBTsSndQ3K9XFHeHSUeT7rM9i0CyjpnTt/UQYQkK4kJIsugW4boviLbEhdkZm2NCh/L2IHrFtKp7EncXqWxAXOBfRI9qylJasJPH6DYe3iflMg+AAlf4Jh09MmVTgyx1Z470pOGKu9DdLX7V653GJSt2NLK7ydzOnGuE9b2fS868i+JkMThVHfTHJZ12Su1396o4XU1NuVlV75kGFB3j5epiokMUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vKNKd87k; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vKNKd87k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMdzR0CNGz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 17:42:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9357D60008;
	Fri, 27 Feb 2026 06:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E06DC116C6;
	Fri, 27 Feb 2026 06:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772174528;
	bh=l7o5vW4EQFZ93oUhFFbp3DYvB6UsG9r2GGJLzb9y3sc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vKNKd87k7g9018XjH0D3CkmNwOrKrNd6r7LM1V3s25Qm6Tpromm2h2AyabbuUj4i+
	 Hf/1bvJMM3gmHKUoF1a+3iudR/eskf1QQ9m0hTdphlmbMJZxMJutEnkQdrcqWOqFna
	 mxGhRAdy3nt3hBGmVydrDWS+Yc8IUU0TCL5KUJ3fSU6/5o64tXlJA1R2q+0TbaWZye
	 FEzshG1TBa/UdwaEZK4WZmFr5QWtnGi9k/+qfNkjzMmI8zbuCiGdRDfp++hgB60BzW
	 Wn7Q1zMkDebyVCNaAb3LOtiB8IV/fW6CRHRt75z59MiuV9aYiI13fsIe/TGfNWiq64
	 YvooidiS5oG3w==
Message-ID: <a864b2ed-1a77-4aac-b0e8-d97b4bf8be47@kernel.org>
Date: Fri, 27 Feb 2026 07:42:03 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 1/2] drivers/vfio_pci_core: Change PXD_ORDER check from
 switch case to if/else block
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org, kvm@vger.kernel.org,
 Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>
References: <0b8fce7a61561640634317a5e287cdb4794715fd.1772170860.git.ritesh.list@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <0b8fce7a61561640634317a5e287cdb4794715fd.1772170860.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/02/2026 à 07:16, Ritesh Harjani (IBM) a écrit :
> Architectures like PowerPC uses runtime defined values for
> PMD_ORDER/PUD_ORDER. This is because it can use either RADIX or HASH MMU
> at runtime using kernel cmdline. So the pXd_index_size is not known at
> compile time. Without this fix, when we add huge pfn support on powerpc
> in the next patch, vfio_pci_core driver compilation can fail with the
> following errors.
> 
>    CC [M]  drivers/vfio/vfio_main.o
>    CC [M]  drivers/vfio/group.o
>    CC [M]  drivers/vfio/container.o
>    CC [M]  drivers/vfio/virqfd.o
>    CC [M]  drivers/vfio/vfio_iommu_spapr_tce.o
>    CC [M]  drivers/vfio/pci/vfio_pci_core.o
>    CC [M]  drivers/vfio/pci/vfio_pci_intrs.o
>    CC [M]  drivers/vfio/pci/vfio_pci_rdwr.o
>    CC [M]  drivers/vfio/pci/vfio_pci_config.o
>    CC [M]  drivers/vfio/pci/vfio_pci.o
>    AR      kernel/built-in.a
> ../drivers/vfio/pci/vfio_pci_core.c: In function ‘vfio_pci_vmf_insert_pfn’:
> ../drivers/vfio/pci/vfio_pci_core.c:1678:9: error: case label does not reduce to an integer constant
>   1678 |         case PMD_ORDER:
>        |         ^~~~
> ../drivers/vfio/pci/vfio_pci_core.c:1682:9: error: case label does not reduce to an integer constant
>   1682 |         case PUD_ORDER:
>        |         ^~~~
> make[6]: *** [../scripts/Makefile.build:289: drivers/vfio/pci/vfio_pci_core.o] Error 1
> make[6]: *** Waiting for unfinished jobs....
> make[5]: *** [../scripts/Makefile.build:546: drivers/vfio/pci] Error 2
> make[5]: *** Waiting for unfinished jobs....
> make[4]: *** [../scripts/Makefile.build:546: drivers/vfio] Error 2
> make[3]: *** [../scripts/Makefile.build:546: drivers] Error 2
> 
> Fixes: f9e54c3a2f5b7 ("vfio/pci: implement huge_fault support")
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>   drivers/vfio/pci/vfio_pci_core.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index d43745fe4c84..5395a6f30904 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1670,21 +1670,20 @@ vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
>   	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
>   		return VM_FAULT_SIGBUS;
> 
> -	switch (order) {
> -	case 0:
> +	if (order == 0) {
>   		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
> +	}

Those braces are unneeded as all legs of the if/else are single lines

>   #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP

ifdef could be replaced by IS_ENABLED() because PxD_ORDER and 
vmf_insert_pfn_xxx() are declared all the time

> -	case PMD_ORDER:
> +	 else if (order == PMD_ORDER) {

'else' is not needed because every 'if' leads to a return statement

>   		return vmf_insert_pfn_pmd(vmf, pfn, false);
> +	 }
>   #endif
>   #ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
> -	case PUD_ORDER:
> +	 else if (order == PUD_ORDER) {
>   		return vmf_insert_pfn_pud(vmf, pfn, false);
> -		break;
> +	 }
>   #endif
> -	default:
> -		return VM_FAULT_FALLBACK;
> -	}
> +	return VM_FAULT_FALLBACK;

So at the end we should get something like:

	if (!order)
		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);

	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_PFNMAP) && order == PMD_ORDER)
		return vmf_insert_pfn_pmd(vmf, pfn, false);

	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PUD_PFNMAP) && order == PMD_ORDER)
		return vmf_insert_pfn_pud(vmf, pfn, false);

	return VM_FAULT_FALLBACK;


>   }
>   EXPORT_SYMBOL_GPL(vfio_pci_vmf_insert_pfn);
> 
> --
> 2.53.0
> 
> 


