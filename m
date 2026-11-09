Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA47C606A337
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LTUKb5a9;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NH/h418u;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LTUKb5a9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNVSw4432z2xjv;
	Tue, 10 Nov 2026 00:08:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794229680;
	cv=none; b=UJiVndyW7BhMrFGoAeGZDtXMSE5CraOpuBKBELLuOWW38qaWilnJyxN/48PCuQZMPEBYizablYhVq0fn5hw7NAhpXZ0p4MwF6d4/fwIOnp3zFRJvqjjs42pEt1pbH2oOPpbXruROzcXe1tjSbLUwNVFO0RL5iLU347X7vZL6T15YKoWx10S2UgQzFieJeB3nKIfIMsPxWBcGJuWDC7834djcVwGyC73c6B19A2lvRy5CrQLA12qhwv1byFUsaIkeZWau4OsY4I+Film8y03Isizp6aJkztZ3pXncYodHOPLjWXerJcJ0iA5D84iK/M71fIRiR0tQ6P8HAnoslS8j6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794229680; c=relaxed/relaxed;
	bh=Ala+oDARam9VyrCVVd83FiqqzQ26GgOylxTttfV+xTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fskObA6t+zAP+92uNosI9HPpNAVCxk1PCBhZgBJHrYb3YcSj6fr5ZqzZXqOaPFVfMUsSsB6srkNmcyppb1S8qubsUWKCLJ2iefEPIO97oVb2/Xl9n+jarnIvrIJJeUVrsSo1d3CV2yPVB45mydZN0NR5ue7L1haJm0j1OGlmsi9grNHBf+LIqeo0rwVEcfeJWTtPyYUbO/I5poEeSjhTk/vrnhQKl1Hov2W5NcaJzoyZHlCP/yopI8SCiVBuz3WkVhixTDFMsnspKk5QzwnnJS2Fz6hySRfQxbxRQYV9GMlGQN5M2biR57qB5e58Yt7+OVvQ4p8dHkHh7UuI7Uq/QA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LTUKb5a9; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NH/h418u; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LTUKb5a9; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LTUKb5a9;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NH/h418u;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LTUKb5a9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Tue, 10 Nov 2026 00:07:59 AEDT
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNVSv59tQz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 00:07:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794229676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ala+oDARam9VyrCVVd83FiqqzQ26GgOylxTttfV+xTA=;
	b=LTUKb5a9Dgd9rjgZBFUq8C8DQl3mZDepoW/ZDExf0CBNm1LucJhp63nhDKnaAdq9O6vxXQ
	hSs0rcwMbqrRtEJP4AuzIqBtivMa1Mghakvz+h9/EweBphFDcTQU2ZsK8CiVt4JOHfzVkB
	qjVTljHY5pNVzg0HqIBvLvBYMvopYJI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794229677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ala+oDARam9VyrCVVd83FiqqzQ26GgOylxTttfV+xTA=;
	b=NH/h418u/eaeYc/qyqf8WegL1izyS1TUeomF9G1tjHWOw3PNZfnrHIV1tSPGv3xrkCyV5g
	zZffKzM25ZEwQ8n54uo78CghQCmwsLdjVqFLIWezqIlSmYi6dfNz+8gk8oOKVLNXIWLaUW
	l7ARKCcF8x2qAbm4NLIaIAa5/vuaW9k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794229676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ala+oDARam9VyrCVVd83FiqqzQ26GgOylxTttfV+xTA=;
	b=LTUKb5a9Dgd9rjgZBFUq8C8DQl3mZDepoW/ZDExf0CBNm1LucJhp63nhDKnaAdq9O6vxXQ
	hSs0rcwMbqrRtEJP4AuzIqBtivMa1Mghakvz+h9/EweBphFDcTQU2ZsK8CiVt4JOHfzVkB
	qjVTljHY5pNVzg0HqIBvLvBYMvopYJI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-g9WUOW_7P7G02ji7LTIkZw-1; Mon, 09 Nov 2026 08:06:48 -0500
X-MC-Unique: g9WUOW_7P7G02ji7LTIkZw-1
X-Mimecast-MFC-AGG-ID: g9WUOW_7P7G02ji7LTIkZw_1794229608
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c4cc4254c25so90477066b.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 05:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794229607; x=1794834407;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ala+oDARam9VyrCVVd83FiqqzQ26GgOylxTttfV+xTA=;
        b=t7X9cKajDN87/BSDR+iYiONzPjks16v/WExKpb5hmv6IemI6XMoeXqjeBZIM5aL4vG
         H/YY2oJ+DQIU+9XmnnpNGSuK5X2MYwHkAyzkKeAUMvyft48N6uQextF5RWW9ZsmxPxlk
         ybuy1uHRTl2KcIDurQT++Z7aEQk7H6QZYM3B14u3zxkJSCCjRcEi7dtTKyzXJ3OdRhLO
         ozfCbzqS3v8occbUf2zas343U03ncx9/9Lz8Oy7drUYk28+9X4CxD/w6BjJ65YlFBMm+
         0ONpMyssLNi5LUVVan3q1pTJMjIusGzkFdXZtAnU3SNw1S8qlu1Jo5bo1Ylcwv0TvuEk
         xMPw==
X-Forwarded-Encrypted: i=1; AL+hErHw4sPTfsekXSftIb+vu8cDy6Ut3aXdGRhiv5eMEY+nEI+nwxtVh5TFGta6bnXinecYie9f04e2z6ZXkCc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/VvAFR6DKZ3yyXCRjNt2A5Yw3n28ZqkyyfkpIKuvWhKUGT9QCN
	2pINZr4u6CkrAENsgH1U4hADFvscd7besztd8EhoKWoVmpQLR+QpHjwe6RjZNbvfOmCMBvS2H6q
	N1lxUxxz+R6LuHLra5IUS2RjTFXLVcgJLXizOAr8H70LCfQF0LSGjeSZs1HsegcnNzrc=
X-Gm-Gg: AYBFou0BAZEZYJiEdGcdIVnZm10wVtV2XNjw0Eu1RdeyeUbWm2oFbOZJmD0LFLYsdau
	Mg9Lw5ZyyJHaQ4mmVhN6m7mL+0U2MuISiuK2uJfgv3OIoqOaqe9Q2Hi0PG62XQ68CEBBWl4oavC
	ZswyCdGGYOH9yNs6DRjB4MXQmwQzFhTXzQi8hejEQyK4WHRov3V3TV230cSCJOgXvw+mlBgmU7C
	j/S2RcJgB+RxUTWMq7kzd79QSqoMEprZ/EJ3NYDPPN2kfnXeR3yZ+9KdcZ8rSlZpRUyhzXHAPCz
	AdvR2/0EQU4bz5WNFx/ooDUziryh6dL2q3VrV29Fj5ih/spcl+N4rhMHT25W8AeOXL/KOPpVAGU
	+/uMs/QZNJPo4EJAv5WRWbzlf1yGSmUkeKCQ1k+Uj
X-Received: by 2002:a17:907:18c3:b0:c25:f7db:4bec with SMTP id a640c23a62f3a-c4d6db5760cmr321582966b.18.1794229607398;
        Mon, 09 Nov 2026 05:06:47 -0800 (PST)
X-Received: by 2002:a17:907:18c3:b0:c25:f7db:4bec with SMTP id a640c23a62f3a-c4d6db5760cmr321574566b.18.1794229606674;
        Mon, 09 Nov 2026 05:06:46 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d69f9384csm168299566b.13.2026.11.09.05.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:06:45 -0800 (PST)
Date: Mon, 9 Nov 2026 08:06:38 -0500
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
Message-ID: <20261109080616-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: lZyNdPWCeJPxrEU0f5eG_VvQLb-R94ZWMkw1w9HwX7w_1794229608
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


Acked-by: Michael S. Tsirkin <mst@redhat.com>

Who's merging this, me?
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


