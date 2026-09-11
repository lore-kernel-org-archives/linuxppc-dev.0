Return-Path: <linuxppc-dev+bounces-27164-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFBAC88E4D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 23:34:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhW952zrCz2yD3;
	Sat, 12 Sep 2026 09:34:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789149288;
	cv=none; b=lWFsUBWgPrf4+tIWTtYHsdCv0Dy/a/YcSJApbJGh0HJQxa0sK0a1v9V0ROoLmhWohGzvEPWYY5WW5peFSYCtKGg51MNZuJz9N2qN5rQ01gPZQ3WOssCDk1vDDP/qMppvcAZW9e07IbxD9DInTK88MIaYcoHlBIZYNhVuiqUzX+KdKzmzq5Y5VKXrpALK2ArgRx7ZsC5lo1/CGDdTRpVEZ+xbOgsUKD+IunR2QuLTYat34UWl6QansVqbjWqO4XVWKFF7GY6x+O/ShPNE2yfefgb4NKu+RM9JzAjPdq/ipVYE1ukZqXHR8GC5k036jnkyNg6pqnneI/cE6crqmGya/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789149288; c=relaxed/relaxed;
	bh=4FwTYwpGmaK+5ispCEK7HH92jJqAfeRrVmWamTSNnqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnYEoA4GBKu6mRACBJAAytHzmIIyXQUWjpzFKOCkxJPvgRmentWXEFA91hwVgLu6CKWqdC5ViJRckUcLSuLJQLnLOUDEnFQnfclslTm55PLXr5vNEMu0jCqxa3sQJSBJWJhaKGtRaGiVu6Mpex1e0rQTLsKkhFPHvC10YOE+HfQOzD+52lWlDNxKlu7wvyMNG86jTouifzmwRNUyFH3pK8/2kdLR+2yqNA4hgMZVgxih2wcvFJo1oqPsiLydvhGFR5+nQAL9LyOrjPNWldntFmsSuguX9C6I5GU7SGVIejWUdOKAptkeVLMNcXAKWrgu3B+zp5iw3X2Fg6gw2YYxJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R/PEF628; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sergeh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R/PEF628;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sergeh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhMd31vRpz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 03:54:47 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 38C99403CD;
	Fri, 11 Sep 2026 17:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E7A1F000FF;
	Fri, 11 Sep 2026 17:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789149283;
	bh=4FwTYwpGmaK+5ispCEK7HH92jJqAfeRrVmWamTSNnqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R/PEF628C82R18CCBiTVgSxDDQxOmmbSQCnHAqmpckaTKvXRHHjbFndk35q0VJwbm
	 kb2jEKyMa0SLgFgUCZjypSy8TU4f91YFYaL79LnYDkmD5YZ7AL7XoikZdUl97oCh3x
	 QlUxYbS81ijVUF5fVhlk944TP7D2LmZtxTQuDrzP5dxAVnzOZPYc7bhPn+cxm0sUWh
	 B4hxxUT5Cc5n6F5+/wjf5RtfTI0VG6FXcU6ZU4ZIB3MMKn1qFBNrVgDZdCZnR5hRoj
	 ktqkGCSA0q7dC/KO31sDOWJ1h+hudAjLc0nPKfhMCyskclXeDI5VaQY7ZPVta2w4Q2
	 g7mHI+jtqwWgA==
Date: Fri, 11 Sep 2026 12:54:37 -0500
From: Serge Hallyn <sergeh@kernel.org>
To: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, ashish.kalra@amd.com,
	michael.roth@amd.com, nsaenz@amazon.com, anelkz@amazon.de,
	James.Bottomley@hansenpartnership.com,
	Melody Wang <huibo.wang@amd.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
	x86@kernel.org, coconut-svsm@lists.linux.dev, joerg.roedel@amd.com
Subject: Re: [PATCH 29/60] kvm: Implement KVM_CREATE_PLANE ioctl
Message-ID: <aqRAXTdtUY_Yt8zJ@shallyn-amd>
References: <20260608144252.351443-1-joro@8bytes.org>
 <20260608144252.351443-30-joro@8bytes.org>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260608144252.351443-30-joro@8bytes.org>

On Mon, Jun 08, 2026 at 04:42:21PM +0200, Jörg Rödel wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Add a new VM ioctl to create a new plane. It returns a new file
> descriptor which supports per-plane ioctls.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Co-developed-by: Joerg Roedel <joerg.roedel@amd.com>
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> ---
>  include/uapi/linux/kvm.h |  2 ++
>  virt/kvm/kvm_main.c      | 75 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 813f964a6dc1..24e34b8e4819 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1355,6 +1355,8 @@ struct kvm_s390_keyop {
>  #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
>  #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
>  
> +#define KVM_CREATE_PLANE	  _IO(KVMIO, 0xe4)
> +
>  /*
>   * ioctls for vcpu fds
>   */
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 5a0277e2ac7c..03a44ff62f0f 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4843,6 +4843,34 @@ static long kvm_vcpu_compat_ioctl(struct file *filp,
>  }
>  #endif
>  
> +static long kvm_plane_ioctl(struct file *filp, unsigned int ioctl,
> +			    unsigned long arg)
> +{
> +	struct kvm_plane *plane = filp->private_data;
> +
> +	if (plane->kvm->mm != current->mm || plane->kvm->vm_dead)
> +		return -EIO;
> +
> +	switch (ioctl) {
> +	default:
> +		return -ENOTTY;
> +	}
> +}
> +
> +static int kvm_plane_release(struct inode *inode, struct file *filp)
> +{
> +	struct kvm_plane *plane = filp->private_data;
> +
> +	kvm_put_kvm(plane->kvm);
> +	return 0;
> +}
> +
> +static struct file_operations kvm_plane_fops = {
> +	.unlocked_ioctl = kvm_plane_ioctl,
> +	.release = kvm_plane_release,
> +	KVM_COMPAT(kvm_plane_ioctl),
> +};
> +
>  static int kvm_device_mmap(struct file *filp, struct vm_area_struct *vma)
>  {
>  	struct kvm_device *dev = filp->private_data;
> @@ -5288,6 +5316,49 @@ static int kvm_vm_ioctl_get_stats_fd(struct kvm *kvm)
>  	return fd;
>  }
>  
> +static int kvm_vm_ioctl_create_plane(struct kvm *kvm, unsigned id)
> +{
> +	struct kvm_plane *plane;
> +	struct file *file;
> +	int r, fd;
> +
> +	if (id >= kvm_arch_max_planes(kvm) ||
> +	    WARN_ON_ONCE(id >= KVM_MAX_PLANES))
> +		return -EINVAL;
> +
> +	guard(mutex)(&kvm->lock);
> +	if (kvm->planes[id])
> +		return -EEXIST;
> +
> +	fd = get_unused_fd_flags(O_CLOEXEC);
> +	if (fd < 0)
> +		return fd;
> +
> +	plane = kvm_create_plane(kvm, id);
> +	if (!plane) {
> +		r = -ENOMEM;
> +		goto put_fd;
> +	}
> +
> +	kvm_get_kvm(kvm);
> +	file = anon_inode_getfile("kvm-plane", &kvm_plane_fops, plane, O_RDWR);
> +	if (IS_ERR(file)) {
> +		r = PTR_ERR(file);
> +		goto put_kvm;
> +	}
> +
> +	fd_install(fd, file);
> +	return fd;
> +
> +put_kvm:
> +	kvm_put_kvm(kvm);
> +	kvm_destroy_one_plane(plane);

I believe shashiko is right here, and I don't see it changed in a later
patch:  kvm->planes[id] will still point to the now-freed plane.
Probably best if kvm_destroy_one_plane(plane) sets that to NULL itself
after freeing the plane.

> +put_fd:
> +	put_unused_fd(fd);
> +	return r;
> +}
> +
> +
>  #define SANITY_CHECK_MEM_REGION_FIELD(field)					\
>  do {										\
>  	BUILD_BUG_ON(offsetof(struct kvm_userspace_memory_region, field) !=		\
> @@ -5306,6 +5377,9 @@ static long kvm_vm_ioctl(struct file *filp,
>  	if (kvm->mm != current->mm || kvm->vm_dead)
>  		return -EIO;
>  	switch (ioctl) {
> +	case KVM_CREATE_PLANE:
> +		r = kvm_vm_ioctl_create_plane(kvm, arg);
> +		break;
>  	case KVM_CREATE_VCPU:
>  		r = kvm_vm_ioctl_create_vcpu(kvm, arg);
>  		break;
> @@ -6676,6 +6750,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
>  	kvm_chardev_ops.owner = module;
>  	kvm_vm_fops.owner = module;
>  	kvm_vcpu_fops.owner = module;
> +	kvm_plane_fops.owner = module;
>  	kvm_device_fops.owner = module;
>  
>  	kvm_preempt_ops.sched_in = kvm_sched_in;
> -- 
> 2.53.0
> 

