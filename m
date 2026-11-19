Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B42606A325
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ub3PnRQv;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ub3PnRQv;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ub3PnRQv
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVhbp0HM2z2xLq;
	Fri, 20 Nov 2026 02:05:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795100725;
	cv=none; b=G98OZzp0718IT6WGAMdGtQ6CSeOZNvwQTsBbe7M2cJRSl7cMg1pbMF4+O4d567LHlsp3fIBgh0PTIhzoZPFU5gCS1fo0/hQ8CBLTHMnOM8EU4R757qSOd0p0ZJlA6UdKKBlu7CKO4tyAgWRcnf+2OgfqgsKJZ15KzFQ3YaAJmdYwQp4K6nz1JWfh0FJYh+Olphpt64bpMB7ENf7uj2gI721WpZR5XEW/B2ysGV2hRUvUWwVdEExzHNn4Py7Q83tv4xA6zVtWdfDRV4NpW6XyMH19pM1YvweV4nEVIyLZxbWbzx69I3qntnKwOcjwobHREosAYOjs0zyf+EgPVHs+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795100725; c=relaxed/relaxed;
	bh=cra6Vs20NtPqxX9EfP/IC1RWThkucYohNUCRfJABY3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SPZO0udCo47BcAtb89jsm1wPjzE5fxh9Ahi4YD/bDE9/5cMRgjzF42iqUy1CNR2aPkeCeZ0ERDtRJjqrtlybjvi7V/AidpIvC4ykk0Hmg6K8CuHd3Jc/piDHgk2i03ATA72VDFkQOoAv4RjP7kp9XtrATb3hBqn/7PEbwrnG/IouqfBEPJRysHHMilGXohIHaEBNJyTXLnDdrrsBWqwkTb7zpEmYaDav3S4/cRkAJCxRQUXPsvWmwAxe3rT0+O4A0kjQbVcv78hVeqDnq+09oRCkSjDmd9vw6ZinZ7VFTlycHe4WNGx4cwrh4oXATzGBIY1baQDGz0l7dlN3AQ1sWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ub3PnRQv; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ub3PnRQv; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ub3PnRQv; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ub3PnRQv;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ub3PnRQv;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ub3PnRQv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVhbm3Ttvz2xLF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 02:05:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795100720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cra6Vs20NtPqxX9EfP/IC1RWThkucYohNUCRfJABY3A=;
	b=Ub3PnRQvCR9kMqInRViTMA8RcFS/9o7A7vYiguLkMSlNxpOvs93WSi2o+/m7Xm6rm7BVM9
	st69wofcnqzEZcSM8lMV8nWK6RLTTl/8NDSB7rsoiO8t0/oNTmUeo0jAL92BAc9TWwS0xl
	onvpmtatCSh8gcCxgMc8QaiDbHetRi4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795100720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cra6Vs20NtPqxX9EfP/IC1RWThkucYohNUCRfJABY3A=;
	b=Ub3PnRQvCR9kMqInRViTMA8RcFS/9o7A7vYiguLkMSlNxpOvs93WSi2o+/m7Xm6rm7BVM9
	st69wofcnqzEZcSM8lMV8nWK6RLTTl/8NDSB7rsoiO8t0/oNTmUeo0jAL92BAc9TWwS0xl
	onvpmtatCSh8gcCxgMc8QaiDbHetRi4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795100720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cra6Vs20NtPqxX9EfP/IC1RWThkucYohNUCRfJABY3A=;
	b=Ub3PnRQvCR9kMqInRViTMA8RcFS/9o7A7vYiguLkMSlNxpOvs93WSi2o+/m7Xm6rm7BVM9
	st69wofcnqzEZcSM8lMV8nWK6RLTTl/8NDSB7rsoiO8t0/oNTmUeo0jAL92BAc9TWwS0xl
	onvpmtatCSh8gcCxgMc8QaiDbHetRi4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-lGQbtRdsOOC7dbz_yb96gw-1; Thu, 19 Nov 2026 10:05:14 -0500
X-MC-Unique: lGQbtRdsOOC7dbz_yb96gw-1
X-Mimecast-MFC-AGG-ID: lGQbtRdsOOC7dbz_yb96gw_1795100713
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-490c1867460so1478216f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 07:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795100713; x=1795705513;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cra6Vs20NtPqxX9EfP/IC1RWThkucYohNUCRfJABY3A=;
        b=KKjjE7nuty/hWug8rNaZLqyzxFDxCNDmpUdtDP/vtEFP5qfsrGQhi9eD6hFyJFN1ph
         j8UeoF4pO+ap7FKIxhLKGuZZEpAGx8oRVJcAa219WJ2vqU/uBhGXZ7NQcjbcynnoQs+9
         /IYnRLhjhNjnfkkLW74NGZA9PaPrgSMBa9MZB5r4YuGSC4BmXfky7Rx+oBCqofk7eFNz
         GZzmt6FllAjS9Eso1cDqQZlgeNkaWnidJJI5ay5cqot3Dae5uIQSixcubygr/WXufmTd
         fz8Gu7+QqSFXszPvxlTvy64aTK2XqyqJLT3KF2L8xZnwfUbhmXfqEmjuuCxgIP4ae7PV
         WSmw==
X-Forwarded-Encrypted: i=1; AL+hErFg3r2t4dGWCXR3FA50X1BRKSWF196XK3npipv/R+l0zMzrRQuV9QI9ullgoTnEVJ+oRr9IMO/fnKcg7kw=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z89O0jrpOsyLMsgR6Of5/dzAgc20gn+W4wuD0iLXGg6EbPe174g
	suYSv71+wH3M8y/JE3/iSaSu5mrS2YiNJzxHoxp+UeiC1VBMvxhaO8qVt/skKjgk3O2F7zZaYkB
	CzEVwIDaS8SJ/GBu7S1d/BfsM3Mrqv7viYz3qifdctS2qWnLr0qyBQh0luHrCcg8kJjg=
X-Gm-Gg: AZFdTZeigSe1NHy2e5oBvJIlUX61JfSKrYUXlOC41HTw2ykq9Gsew9zSo9ynCyLTuEB
	yzvjHwYhfdiyHlHfUvO/mHj1tXICbyBiFBJSiTeOKbpAgPlYrMUB7wVttG3qnz/OQh604x3Ri8i
	qGms1Xh8siplLLKv5V/Z3fHbyURuQWpMzwl+yTFIHzkYe7mV2IYdZJrYUsu+N0LlIpi5mJh1Bur
	Evg8smE+qNtzbcjpK+kXqmszx8phxjJEPs0/axPJ2K1hsBAGjakIvsCIPo5uUC/QCUdNM+hCnos
	tlDxp/MJyqVLbitgyo7CsQK6nPlaeaL6YY2ftBk+d0mHCGGG4o5WqG1iO/OxPVS7po8563nxKqx
	zafY2EIrlvB75ev+/IO8/Oosh/wGO4Ymo81fx5nA8Vw==
X-Received: by 2002:a05:6000:2608:b0:4a9:2728:fdfc with SMTP id ffacd0b85a97d-4a92728ff7amr4686371f8f.28.1795100713229;
        Thu, 19 Nov 2026 07:05:13 -0800 (PST)
X-Received: by 2002:a05:6000:2608:b0:4a9:2728:fdfc with SMTP id ffacd0b85a97d-4a92728ff7amr4686266f8f.28.1795100712535;
        Thu, 19 Nov 2026 07:05:12 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1522:6500:ac93:c62:f076:48c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61e53asm61225f8f.59.2026.11.19.07.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:05:11 -0800 (PST)
Date: Thu, 19 Nov 2026 10:05:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Scott Branden <scott.branden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Richard Cochran <richardcochran@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
	linux-sgx@vger.kernel.org, selinux@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 14/14] vhost-vdpa: convert mmap hook to mmap_prepare
Message-ID: <20261119100450-mutt-send-email-mst@kernel.org>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
 <20261105-late-2026-mmap_prepare-v1-14-c56aadfbab8a@kernel.org>
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
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-14-c56aadfbab8a@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: skcv6Lg1E02wIsB7i5XVmiHKR7qWXfUUA4Z38_Bkqyw_1795100713
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 09:05:45PM +0000, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook. The hook
> only validates the request and sets the VMA flags, operations and page
> protection.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>


feel free to merge with rest of this.

> ---
>  drivers/vhost/vdpa.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ff7d90719171..993b2d7c8927 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1573,19 +1573,19 @@ static const struct vm_operations_struct vhost_vdpa_vm_ops = {
>  	.fault = vhost_vdpa_fault,
>  };
>  
> -static int vhost_vdpa_mmap(struct file *file, struct vm_area_struct *vma)
> +static int vhost_vdpa_mmap_prepare(struct vm_area_desc *desc)
>  {
> -	struct vhost_vdpa *v = vma->vm_file->private_data;
> +	struct vhost_vdpa *v = desc->file->private_data;
>  	struct vdpa_device *vdpa = v->vdpa;
>  	const struct vdpa_config_ops *ops = vdpa->config;
>  	struct vdpa_notification_area notify;
> -	unsigned long index = vma->vm_pgoff;
> +	unsigned long index = desc->pgoff;
>  
> -	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
> +	if (vma_desc_size(desc) != PAGE_SIZE)
>  		return -EINVAL;
> -	if ((vma->vm_flags & VM_SHARED) == 0)
> +	if (!vma_desc_test(desc, VMA_SHARED_BIT))
>  		return -EINVAL;
> -	if (vma->vm_flags & VM_READ)
> +	if (vma_desc_test(desc, VMA_READ_BIT))
>  		return -EINVAL;
>  	if (!ops->get_vq_notification)
>  		return -ENOTSUPP;
> @@ -1598,12 +1598,13 @@ static int vhost_vdpa_mmap(struct file *file, struct vm_area_struct *vma)
>  		return -EINVAL;
>  	if (notify.addr & (PAGE_SIZE - 1))
>  		return -EINVAL;
> -	if (vma->vm_end - vma->vm_start != notify.size)
> +	if (vma_desc_size(desc) != notify.size)
>  		return -ENOTSUPP;
>  
> -	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> -	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
> -	vma->vm_ops = &vhost_vdpa_vm_ops;
> +	desc->page_prot = pgprot_noncached(desc->page_prot);
> +	vma_desc_set_flags(desc, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
> +			   VMA_DONTDUMP_BIT);
> +	desc->vm_ops = &vhost_vdpa_vm_ops;
>  	return 0;
>  }
>  #endif /* CONFIG_MMU */
> @@ -1615,7 +1616,7 @@ static const struct file_operations vhost_vdpa_fops = {
>  	.write_iter	= vhost_vdpa_chr_write_iter,
>  	.unlocked_ioctl	= vhost_vdpa_unlocked_ioctl,
>  #ifdef CONFIG_MMU
> -	.mmap		= vhost_vdpa_mmap,
> +	.mmap_prepare	= vhost_vdpa_mmap_prepare,
>  #endif /* CONFIG_MMU */
>  	.compat_ioctl	= compat_ptr_ioctl,
>  };
> 
> -- 
> 2.56.0


